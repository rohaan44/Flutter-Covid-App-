import 'package:covid_tracker/Services/stats_services.dart';
import 'package:covid_tracker/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatsServices statsServices = StatsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 90.w,
                child: TextField(
                  controller: searchController,
                  onChanged: ((value) {
                    setState(() {});
                  }),
                  decoration: InputDecoration(
                    hintText: "Search with Country name",
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.getCountryDataFromApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildShimmerList();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return _buildCountryList(snapshot.data!, snapshot.data!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 5, // Display placeholder shimmer for 5 items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                ),
                title: Container(
                  color: Colors.white,
                  height: 16,
                ),
                subtitle: Container(
                  color: Colors.white,
                  height: 12,
                ),
              ),
              Divider(), // Optional: Adds a divider between list items
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryList(List<dynamic> countries, name) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        var countryData = countries[index];
        var name = countries[index]['country'];
        if (searchController.text.isEmpty) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            name: countries[index]['country'],
                            image: countries[index]["countryInfo"]["flag"],
                            totalCasses: countries[index]["cases"] ?? 0,
                            active: countries[index]["active"] ?? 0,
                            todayRecovered: countries[index]["todayRecovered"] ?? 0,
                            totalRecovered: countries[index]["totalRecovered"] ?? 0,
                            totalDeaths: countries[index]["deaths"] ?? 0,
                            critical: countries[index]["critical"] ?? 0,
                            test: countries[index]["tests"] ?? 0,

                          )));
            },
            child: ListTile(
              leading: Image(
                height: 50,
                width:50,
                  image: NetworkImage(countryData['countryInfo']['flag'])),
              title: Text(countryData['country'],style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600
          )
        )),
              subtitle: Text('Cases: ${countryData['cases']}',style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          )
        )),
            ),
          );
        } else if (name
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          return ListTile(
            leading: Image(
                height: 50,
                width:50,
                  image: NetworkImage(countryData['countryInfo']['flag'])),
            title: Text(countryData['country'],style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600
          )
        )),
            subtitle: Text('Cases: ${countryData['cases']}',style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          )
        )),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
