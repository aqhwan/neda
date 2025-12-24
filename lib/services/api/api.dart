import 'dart:convert';

import 'package:neda/modele/salat.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:sqlite3/sqlite3.dart' show Row;
import 'package:http/http.dart' as http;
import 'package:time/time.dart';
import 'package:neda/lib.dart';

typedef Date = DateTime;

class PrayerTimesApi {
  late final PrayerTimesApiUrl apiUrl;
  final PrayerTimesTakeMethod takeMethod;

  PrayerTimesApi({
    required String country,
    required String city,
    this.takeMethod = PrayerTimesTakeMethod.yearly,
  }) {
    final Date startDate = Date.now();
    Date endDate;

    switch (takeMethod) {
      case PrayerTimesTakeMethod.monthly:
        endDate = (Date.now() + 30.days);
        break;
      case PrayerTimesTakeMethod.yearly:
        endDate =
            (Date.now() + 334.days); // the max limit are 11 months in the api
        break;
    }

    apiUrl = PrayerTimesApiUrl(
      pathParams: {
        'start': startDate.asStringSeparatedByDash(),
        'end': endDate.asStringSeparatedByDash(),
      },
      queryParams: {'country': country, 'city': city},
    );
  }

  Future<List<Salat>> fetchPrayerTimes() async {
    final response = await http.get(Uri.parse(apiUrl.fullApiUrl));
    if (response.statusCode != 200) {
      throw PrayerTimesApiException.requestFailed(
        response.statusCode,
        response.body,
      );
    }

    List<Salat> salatTimes = [];

    final json = jsonDecode(response.body);
    for (final day in json['data']) {
      salatTimes.add(day as Salat);
    }

    return salatTimes;
  }
}

class PrayerTimesApiException implements Exception {
  final String message;

  PrayerTimesApiException(this.message);

  PrayerTimesApiException.requestFailed(int statusCode, String responseMessage)
    : message =
          'request failed - with status code $statusCode, msg: $responseMessage';
}

class PrayerTimesApiUrl {
  final String protocol = 'https';
  final String host = 'api.aladhan.com';
  final String prefix = 'v1';
  final String path = 'calendarByCity/from/{start}/to/{end}';
  final List<String>? pathParamsNames = ['start', 'end'];
  final List<String>? queryParamsNames = ['country', 'city'];
  late final String fullApiUrl;

  PrayerTimesApiUrl({
    Map<String, String>? pathParams,
    Map<String, String>? queryParams,
  }) {
    String apiUrl = '$protocol://$host/$prefix/$path';
    pathParamsNames?.forEach((paramName) {
      if (pathParams == null || pathParams[paramName] == null) {
        throw PrayerTimesApiUrlException.misingPathParams(paramName);
      }

      apiUrl = apiUrl.replaceAll('{$paramName}', pathParams[paramName]!);
    });

    if (queryParamsNames != null) apiUrl += '?';

    queryParamsNames?.forEach((paramName) {
      if (queryParams == null || queryParams[paramName] == null) {
        throw PrayerTimesApiUrlException.misingQueryParams(paramName);
      }

      if (!apiUrl.endsWith('?')) apiUrl += '&';

      apiUrl += '$paramName=${queryParams[paramName]!}';
    });

    fullApiUrl = apiUrl;
  }
}

class PrayerTimesApiUrlException implements Exception {
  final String message;

  PrayerTimesApiUrlException(this.message);

  PrayerTimesApiUrlException.misingPathParams(String misedParamName)
    : message =
          "mising path param - this url neads path params '$misedParamName' so you have to pass them in the costucter";

  PrayerTimesApiUrlException.misingQueryParams(String misedParamName)
    : message =
          "mising query parame - this url neads query param '$misedParamName' so you have to pass them in the costucter";
}

enum PrayerTimesTakeMethod { monthly, yearly }

extension SalatFromDB on Row {
  Salat asSalat() => Salat(
    date: Date(
      int.parse(this['date'].toString().split('-').last),
      int.parse(this['date'].toString().split('-').first),
      int.parse(this['date'].toString().split('-')[1]),
    ),
    fajr: SalatTimeJson.fromString(this['fajr']),
    sunrise: SalatTimeJson.fromString(this['sunrise']),
    dhuhr: SalatTimeJson.fromString(this['dhuhr']),
    asr: SalatTimeJson.fromString(this['asr']),
    maghrib: SalatTimeJson.fromString(this['maghrib']),
    isha: SalatTimeJson.fromString(this['isha']),
  );
}

extension SalatTimeJson on TimeOfDay {
  static TimeOfDay parseCETFormat(String cetFormat) {
    return TimeOfDay(
      hour: int.parse(cetFormat.substring(0, cetFormat.indexOf(':'))),
      minute: int.parse(
        cetFormat.substring(cetFormat.indexOf(':') + 1, cetFormat.indexOf(' ')),
      ),
    );
  }

  static TimeOfDay fromString(String cetFormat) {
    var indexOfColon = cetFormat.indexOf(':');
    return TimeOfDay(
      hour: int.parse(cetFormat.substring(0, indexOfColon)),
      minute: int.parse(cetFormat.substring(indexOfColon + 1)),
    );
  }
}
