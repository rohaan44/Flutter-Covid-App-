import 'package:covid_tracker/View/statistics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCasses, totalRecovered, totalDeaths, active, test, todayRecovered, critical;

  DetailsScreen(
      {
      required this.name,
      required this.image,
      required this.active,
      required this.critical,
      required this.test,
      required this.todayRecovered,
      required this.totalCasses,
      required this.totalDeaths,
      required this.totalRecovered
      });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(widget.name,style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold
          )
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
          
          Stack(
            alignment: Alignment.topCenter,
            children: [
              
              Padding(
               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.067),
                child: Card( child: Column(
                  children: [
                    SizedBox(height: 5.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: Column(
                        children: [
                          ReusableRow(title: "Cases", value: widget.totalCasses.toString()),
                          ReusableRow(title: "Recovered", value: widget.totalRecovered.toString()),
                      ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Deaths", value: widget.totalCasses.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Cases", value: widget.active.toString()),
                      ReusableRow(title: "Test", value: widget.test.toString()),
                      ReusableRow(title: "Total Deaths", value: widget.totalDeaths.toString())
                        ],
                      ),
                    ),
                    
                  ],
                 
                ),),
              ),
        
               CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),),
            ]
            ),
        ]),
      ),
    );
  }
}
