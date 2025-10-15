# Data Structure

## tables

1. settings options
2. prayers

## schemas

### settings

```d2
settings: {
  shape: sql_table
  id: int {constraint: primary_key}
  value: any
  discretion: string
}
```

### prayers

```d2
prayers: {
  shape: sql_table
  data: string {constraint: primary_key}
  fajr: timestamp
  dhur: timestamp
  asr: timestamp
  magrib: timestamp
  isha: timestamp
}
```

> Note: u can then add filds like night middle, sun times...
