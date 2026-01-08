import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neda/lib.dart';

class NedaBottomSheet extends StatelessWidget {
  final ConfigBloc configBloc;
  final SalatTimesCubit salatTimesCubit;

  const NedaBottomSheet({
    required this.configBloc,
    required this.salatTimesCubit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Column(
            spacing: 10,
            children: [
              NedaMenuItimButton(
                title: 'الموقع',
                details: 'تحديث الموقع',
                onPressed: () async {
                  // Store context and ScaffoldMessenger before any async operations
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context);

                  /// go back first so we don't have context issues
                  navigator.pop();

                  /// update the config (location)
                  try {
                    HapticFeedback.lightImpact();

                    scaffoldMessenger.showSnackBar(
                      const SnackBar(content: Text('جاري تحديث الموقع...')),
                    );

                    configBloc.add(UpdateLocationEvent());

                    await Future.delayed(const Duration(seconds: 2));

                    HapticFeedback.lightImpact();

                    scaffoldMessenger.clearSnackBars();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        duration: .new(milliseconds: 100),
                        content: Text('تم تحديث الموقع'),
                      ),
                    );

                    /// update the db with prayer times
                    scaffoldMessenger.clearSnackBars();
                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('جاري تحديث أوقات الصلاة...'),
                      ),
                    );

                    var hapticsTimer = Timer.periodic(
                      const .new(milliseconds: 500),
                      (_) => HapticFeedback.mediumImpact(),
                    );

                    await salatTimesCubit
                        .refresh(config: configBloc.state)
                        .catchError((e) {
                          hapticsTimer.cancel();
                          throw e;
                        });

                    scaffoldMessenger.clearSnackBars();

                    hapticsTimer.cancel();

                    scaffoldMessenger.showSnackBar(
                      const SnackBar(
                        content: Text('تم تحديث أوقات الصلاة بنجاح'),
                      ),
                    );
                  } catch (e) {
                    scaffoldMessenger.clearSnackBars();

                    if (e.toString().contains(
                      'Location service is not enabled',
                    )) {
                      HapticFeedback.heavyImpact();

                      // Show error and ask user to enable location
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: const Text('يرجى تشغيل خدمة الموقع'),
                          action: SnackBarAction(
                            label: 'فتح الإعدادات',
                            onPressed: () async {
                              await configBloc.openLocationSettings();
                            },
                          ),
                        ),
                      );
                      return;
                    } else if (e.toString().contains('No valid location')) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            'خطأ في تحديث أوقات الصلاة: ${e.toString()}',
                          ),
                        ),
                      );
                      return;
                    }

                    // For other errors
                    scaffoldMessenger.showSnackBar(
                      SnackBar(content: Text('خطأ: ${e.toString()}')),
                    );
                    return;
                  }
                },
              ),
              NedaMenuItimButton(
                title: 'الطريقة',
                details: 'تحديث الطريقة',
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('الطريقة'),
                        children: [
                          Form(
                            child: TextFormField(
                              maxLines: 1,
                              minLines: 1,
                              maxLength: 2,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              initialValue: configBloc.state.method.toString(),
                              validator: (input) {
                                var inputAsInt = int.parse(input ?? '0');

                                return inputAsInt > 23 || inputAsInt < 0
                                    ? '0 <= الطريقة <= 23 '
                                    : null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onEditingComplete: () {
                                Form.of(primaryFocus!.context!).save();
                              },
                              onSaved: (input) {
                                configBloc.add(
                                  UpdateMethodEvent(int.parse(input ?? '0')),
                                );
                                salatTimesCubit.refresh(
                                  config: configBloc.state,
                                );
                              },
                              // the save button
                              decoration: const InputDecoration(
                                labelText: '0 - 23',
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
