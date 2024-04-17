import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  final colorList = <Color>[Colors.red, Colors.green, Colors.orange];

  late final AnimationController _contoller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _contoller.dispose();
  }

  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5.h,
          ),
          FutureBuilder(
              future: statsServices.getdatafromapi(),
              builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      controller: _contoller,
                      size: 50.0,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      PieChart(
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          colorList: colorList,
                          chartRadius: 40.w,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartType: ChartType.ring,
                          dataMap: {
                            "Deaths":
                                double.parse(snapshot.data!.deaths.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Infected":
                                double.parse(snapshot.data!.cases.toString())
                          }),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.aspectRatio),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: "Total cases",
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: "Active",
                                  value: snapshot.data!.active.toString()),
                              ReusableRow(
                                  title: "Today Deaths",
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: "Today Recovered",
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Center(
                        child: Container(
                            width: 90.w,
                            height: 5.h,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(11)),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CountriesListScreen(),
                                      ));
                                },
                                child: const Text(
                                  "Track Countries",
                                ))),
                      )
                    ],
                  );
                }
              })
        ],
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
