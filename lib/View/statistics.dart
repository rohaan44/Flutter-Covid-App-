import 'dart:async';
import 'package:flutter/material.dart';
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

  late final AnimationController _contoller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _contoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          PieChart(
              colorList: colorList,
              chartRadius: 40.w,
              legendOptions: LegendOptions(legendPosition: LegendPosition.left),
              chartType: ChartType.ring,
              dataMap: {"Deaths": 900, "Recovered": 502, "Infected": 600}),
          SizedBox(
            height: 8.h,
          ),
             Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5),
                child: Column(
                  children: [
                    ReusabaleRow(title: "Text", value: "Text"),
                    ReusabaleRow(title: "Text", value: "Text"),
                    ReusabaleRow(title: "Text", value: "Text"),
                  ],
                ),
              )
          ),
          SizedBox(height: 5.h,),
          Center(
            child: Container(
              width: 90.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(11)

              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                onPressed: (){
              
              }, child: const Text("Track Countries",))),
          )
        ],
      )),
    );
  }
}

class ReusabaleRow extends StatelessWidget {
  String title;
  String value;
  ReusabaleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text(title,style: TextStyle(fontSize: 16.sp),), 
      Text(value,style: TextStyle(fontSize: 16.sp)),
      
      ],
    );
  }
}
