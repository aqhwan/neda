# idea (v0.1.0)

- simple interface (focus in good ui/ux)

## application functionality

- ahdan (core).
- dates (hedgre dates and islamic events (ead, the white days...))
- thker notifications
- the kebla
- customs adhans + customs providers

# MVP (v0.0.1)

- ahdan (core).

# tech overview

## decisions

- stack: dart (fully)
- storing local sql (sqlite)

## components

```d2
api comp {
	connect to the api provider (change able)

}

user data {
	location
	time_zoon
	method
}


user data -> api comp
api comp -> prayer times stuck: output

prayer times stuck -> db comp -> store it (sqlite)

notification comp -> db comp :fech pryaer times

notification comp -> set notification (with the adhan sound)

settings comp -> user data: location + method

settings comp -> notification comp: adhan

```

### names

- prayer times = day prayer times (5 prayers)
- time_zoon = e.g a month, a year ...
