# FredChartsApp

This repository contains a simple SwiftUI iOS application that allows you to search the [FRED API](https://fred.stlouisfed.org/docs/api/fred/) for economic data series and plot the results using Apple's Charts framework.

## Features

- Search FRED series by keyword.
- Display results in a list and select a series to view details.
- Fetch observations for the selected series and draw a line chart.

## Requirements

- Xcode 15 or later with Swift 5.9+ (iOS 16 target).
- A FRED API key available as an environment variable `FRED_API_KEY` when running the app.

## Building

The project is provided as a Swift Package. You can open the package in Xcode:

```bash
open Package.swift
```

Run the `FredChartsApp` scheme on an iOS simulator or device.

## Notes

The application uses `URLSession` to request data from the FRED API and relies on the `Charts` framework introduced in iOS 16. Ensure your deployment target is at least iOS 16.
