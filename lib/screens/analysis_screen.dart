import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/models/rating_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Theme/font_size.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  Future<bool> fetchRatingDataPerContest() async {
    RatingData rd = RatingData(cf_handle: 'yashesh_07');
    return rd.updateData();
  }

  late final _tooltipBehavior;
  late final _trackballBehavior;
  late final _tooltipBehavior2;
  late final _trackballBehavior2;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
    );
    _tooltipBehavior2 = TooltipBehavior(enable: true);
    _trackballBehavior2 = TrackballBehavior(
      enable: true,
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
              color: CustomTheme.secondaryBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Center(
                    child: Text(
                  'Interactive Graphs',
                  style: TextStyle(fontSize: CustomFont.heading),
                )),
              )),
          Expanded(
            child: ListView(
              children: [
                FutureBuilder<bool>(
                  future: fetchRatingDataPerContest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Error occurred while fetching contest details'),
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      return SfCartesianChart(
                        title: ChartTitle(text: 'Rating Graph'),
                        tooltipBehavior: _tooltipBehavior,
                        trackballBehavior: _trackballBehavior,
                        zoomPanBehavior: ZoomPanBehavior(
                          enablePinching: true,
                          enablePanning: true,
                        ),
                        primaryXAxis: NumericAxis(
                          isVisible: false, // Hide the x-axis labels
                        ),
                        primaryYAxis:
                            NumericAxis(title: AxisTitle(text: 'Ratings')),
                        series: <ChartSeries>[
                          LineSeries<RatingDataPerContest, int>(
                            name: 'Rating',
                            enableTooltip: true,
                            yAxisName: 'Ratings',
                            dataSource: RatingData.ratingList,
                            xValueMapper: (RatingDataPerContest data, _) =>
                                data.index,
                            yValueMapper: (RatingDataPerContest data, _) =>
                                data.newRating,
                            markerSettings: const MarkerSettings(
                              isVisible: true,
                              height: 4,
                              width: 4,
                            ),
                          ),
                        ],
                      );
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occured'),
                      );
                    }
                  },
                ),
                Divider(
                  color: CustomTheme.secondaryBackgroundColor,
                  height: 75,
                  thickness: 20,
                  indent: 0,
                  endIndent: 0,
                ),
                FutureBuilder<bool>(
                  future: fetchRatingDataPerContest(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Error occurred while fetching contest details'),
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      return SfCartesianChart(
                          title: ChartTitle(text: 'Δ Rating in each contest'),
                          tooltipBehavior: _tooltipBehavior2,
                          trackballBehavior: _trackballBehavior2,
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePinching: true,
                            enablePanning: true,
                          ),
                          primaryXAxis: NumericAxis(
                            isVisible: false, // Hide the x-axis labels
                          ),
                          primaryYAxis:
                              NumericAxis(title: AxisTitle(text: 'Δ Rating')),
                          series: <ChartSeries>[
                            WaterfallSeries<RatingDataPerContest, int>(
                                name: 'Δ',
                                dataSource: RatingData.ratingList,
                                negativePointsColor:
                                    const Color.fromRGBO(229, 101, 144, 1),
                                color: const Color.fromRGBO(0, 189, 174, 1),
                                xValueMapper: (RatingDataPerContest data, _) =>
                                    data.index,
                                yValueMapper: (RatingDataPerContest data, _) =>
                                    data.newRating - data.oldRating,
                                connectorLineSettings:
                                    WaterfallConnectorLineSettings(width: 2.5))
                          ]);
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occured'),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 75,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
