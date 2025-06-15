import SwiftUI
import DGCharts

struct LineChart: UIViewRepresentable {
    var observations: [Observation]

    func makeUIView(context: Context) -> LineChartView {
        let chart = LineChartView()
        chart.pinchZoomEnabled = true
        chart.setScaleEnabled(true)
        chart.dragEnabled = true
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.granularityEnabled = true
        chart.xAxis.labelRotationAngle = -45
        return chart
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let values = observations.enumerated().compactMap { index, obs -> ChartDataEntry? in
            guard let value = Double(obs.value) else { return nil }
            return ChartDataEntry(x: Double(index), y: value)
        }
        let dataSet = LineChartDataSet(entries: values, label: "")
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.lineWidth = 2
        dataSet.setColor(.systemBlue)
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: observations.map { $0.date })
        uiView.xAxis.granularity = 1
    }
}
