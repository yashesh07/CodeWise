import 'package:code_wise/Theme/colors.dart';
import 'package:code_wise/models/rating_data.dart';
import 'package:code_wise/models/submissions_data.dart';
import 'package:code_wise/screens/codeforces_handle_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Theme/font_size.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {

  Future<bool> fetchRatingDataPerContest() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cf_handle = preferences.getString('cf_handle') as String;
    RatingData rd = RatingData(cf_handle: cf_handle);
    return rd.updateData();
  }

  Future<bool> fetchSubmissionsData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String cf_handle = preferences.getString('cf_handle') as String;
    SubmissionsData sd = SubmissionsData(cf_handle: cf_handle);
    return sd.updateData();
  }

  late final _tooltipBehavior;
  late final _trackballBehavior;
  late final _tooltipBehavior2;
  late final _trackballBehavior2;
  late final _tooltipBehavior3;
  late final _trackballBehavior3;
  late final _tooltipBehavior4;
  late final _tooltipBehavior5;

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
    _tooltipBehavior3 = TooltipBehavior(enable: true);
    _trackballBehavior3 = TrackballBehavior(
      enable: true,
      tooltipDisplayMode: TrackballDisplayMode.floatAllPoints,
    );
    _tooltipBehavior4 = TooltipBehavior(enable: true);
    _tooltipBehavior5 = TooltipBehavior(enable: true);
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
                            'Error occurred while fetching details. Check your connection and make sure your codeforces ID is correct.'),
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
                            color: CustomTheme.chartColor,
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
                        child: Text('Some unknown error occurred'),
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
                            'Error occurred while fetching details. Check your connection and make sure your codeforces ID is correct.'),
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
                                animationDuration: 3000,
                                name: 'Δ',
                                dataSource: RatingData.ratingList,
                                negativePointsColor:
                                    const Color.fromRGBO(243, 0, 49, 1.0),
                                color: const Color.fromRGBO(35, 222, 94, 1.0),
                                xValueMapper: (RatingDataPerContest data, _) =>
                                    data.index,
                                yValueMapper: (RatingDataPerContest data, _) =>
                                    data.newRating - data.oldRating,)
                          ]);
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occurred'),
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
                  future: fetchSubmissionsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Error occurred while fetching details. Check your connection and make sure your codeforces ID is correct.'),
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      return SfCartesianChart(
                          title: ChartTitle(text: 'Difficulty Level vs No. of problems solved'),
                        tooltipBehavior: _tooltipBehavior3,
                          trackballBehavior: _trackballBehavior3,
                          zoomPanBehavior: ZoomPanBehavior(
                            enablePinching: true,
                            enablePanning: true,
                          ),
                          primaryXAxis: NumericAxis(
                            title: AxisTitle(text: 'Difficulty Level')
                          ),
                          primaryYAxis:
                          NumericAxis(title: AxisTitle(text: 'No. of problems solved')),
                          series: <ChartSeries>[
                            BarSeries<Difficulty, int>(
                              color: Colors.deepOrangeAccent,
                                dataSource: SubmissionsData.difficulty,
                                animationDuration: 3000,
                                xValueMapper: (Difficulty data, _) => data.difficulty,
                                yValueMapper: (Difficulty data, _) => data.count,
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                  textStyle: TextStyle(fontSize: 8)
                                ),
                              enableTooltip: true,
                            )
                          ]
                      );
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occurred'),
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
                  future: fetchSubmissionsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Error occurred while fetching details. Check your connection and make sure your codeforces ID is correct.'),
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      return SfCircularChart(
                          title: ChartTitle(text: 'Submissions Distribution'),
                          tooltipBehavior: _tooltipBehavior4,
                          legend: const Legend(
                            isVisible: true,
                            textStyle: TextStyle(fontSize: 8),
                            position: LegendPosition.bottom,
                            isResponsive: true
                          ),
                          series: <CircularSeries>[
                            PieSeries<Verdict, String>(
                              enableTooltip: true,
                                dataSource: SubmissionsData.verdicts,
                                xValueMapper: (Verdict data, _) => data.status,
                                yValueMapper: (Verdict data, _) => data.count,
                                pointColorMapper:(Verdict data,  _) => data.color,
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                textStyle: TextStyle(fontSize: 6),
                                labelPosition: ChartDataLabelPosition.outside
                              ),
                                explode: true,
                            )
                          ]
                      );
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occurred'),
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
                  future: fetchSubmissionsData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            'Error occurred while fetching details. Check your connection and make sure your codeforces ID is correct.'),
                      );
                    } else if (snapshot.hasData && snapshot.data!) {
                      return SfCircularChart(
                          title: ChartTitle(text: 'Topics Distribution'),
                          tooltipBehavior: _tooltipBehavior5,
                          legend: const Legend(
                              isVisible: true,
                              textStyle: TextStyle(fontSize: 8),
                              position: LegendPosition.bottom,
                              isResponsive: true
                          ),
                          series: <CircularSeries>[
                            DoughnutSeries<Problem, String>(
                                enableTooltip: true,
                                dataSource: SubmissionsData.problems,
                                xValueMapper: (Problem data, _) => data.tag,
                                yValueMapper: (Problem data, _) => data.count,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(fontSize: 6),
                                    labelPosition: ChartDataLabelPosition.outside
                                ),
                                explode: true,
                            )
                          ]
                      );
                    } else {
                      // If no data is available, display a message indicating no contests found
                      return const Center(
                        child: Text('Some unknown error occurred'),
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
