# FRED iOS Browser

This project is a simple SwiftUI application that lets you search the [FRED](https://fred.stlouisfed.org/) database and display a chart of a selected series.

## Features
- Search FRED series using the official API.
- Browse results in a list.
- Tap a series to view its observations plotted in an interactive chart.

## Building
Open the project in Xcode:

```bash
open fred_ios.xcodeproj
```

Add your FRED API key in `FredAPI.swift` by replacing `YOUR_API_KEY`.
Run the `fred_ios` scheme on an iOS simulator or device.

### Chart Library
This project uses the [DGCharts](https://github.com/ChartsOrg/Charts) library for interactive line charts.
Add it in Xcode with **File > Add Packages...** and enter the repository URL:

```
https://github.com/ChartsOrg/Charts.git
```

The `LineChart` SwiftUI view wraps `DGCharts`' `LineChartView` to provide pinch-to-zoom and better axis labels.
