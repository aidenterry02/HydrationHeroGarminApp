# HydrationHeroGarminApp
# Hydration Hero

A Garmin Connect IQ app that helps you find the nearest water sources and liquor stores.

## Features

- Toggle between water sources and liquor stores
- Real-time distance and direction to nearest location
- Compass-based navigation
- GPS location tracking

## Supported Devices

- Garmin Fenix 7
- Garmin Fenix 7S
- Garmin Fenix 7X

## Building the App

1. Install the Garmin Connect IQ SDK
2. Generate a developer key:
   ```
   monkeyc -k developer_key.der
   ```
3. Build the app:
   ```
   monkeyc -f monkey.jungle -o bin/HydrationHero.prg
   ```

## Project Structure

```
HydrationHero/
├── bin/                    # Build output directory
├── resources/
│   ├── drawables/         # App icons and images
│   ├── strings/           # Localization strings
│   └── manifest.xml       # App manifest
├── source/                # Source code
│   ├── MainApp.mc        # Main application class
│   ├── MainView.mc       # Main view class
│   ├── Utils.mc          # Utility functions
│   └── Locations.mc      # Location data
└── monkey.jungle         # Build configuration
```

## Development

To add new locations, edit the `source/Locations.mc` file and add coordinates to either the `WATER_SOURCES` or `LIQUOR_STORES` arrays. 
