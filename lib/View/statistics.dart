import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  final colorList = <Color>[Colors.red, Colors.green, Colors.orange];
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ResponsiveSizer(
            builder: (context, orientation, screenType) {
              return FutureBuilder<WorldStatsModel>(
                future: statsServices.getdatafromapi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SpinKitFadingCircle(
                      color: Colors.white,
                      controller: _controller,
                      size: 25.sp, // Use responsive sizing for SpinKit size
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final data = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          colorList: colorList,
                          chartRadius:
                              40.w, // Use responsive sizing for chart radius
                          legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left,
                          ),
                          chartType: ChartType.ring,
                          dataMap: {
                            "Deaths": double.parse(data.deaths.toString()),
                            "Recovered":
                                double.parse(data.recovered.toString()),
                            "Infected": double.parse(data.cases.toString()),
                          },
                        ),
                        SizedBox(height: 5.h), // Responsive height
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(3.h), // Responsive padding
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: "Total cases",
                                    value: data.cases.toString()),
                                ReusableRow(
                                    title: "Deaths",
                                    value: data.deaths.toString()),
                                ReusableRow(
                                    title: "Recovered",
                                    value: data.recovered.toString()),
                                ReusableRow(
                                    title: "Active",
                                    value: data.active.toString()),
                                ReusableRow(
                                    title: "Today Deaths",
                                    value: data.todayDeaths.toString()),
                                ReusableRow(
                                    title: "Today Recovered",
                                    value: data.todayRecovered.toString()),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h), // Responsive height
                        Container(
                          width: 90.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .zero, // Set borderRadius to BorderRadius.zero
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 2.h),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CountriesListScreen()),
                              );
                            },
                            child: Text(
                              "TRACK COUNTRIES",
                              style: TextStyle(fontSize: 17.sp),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h), // Responsive padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style:
                GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 15.sp)),
          ),
          Text(value,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 15.sp))),
        ],
      ),
    );
  }
}
