import 'package:covid_tracker/Services/stats_services.dart';
import 'package:flutter/material.dart';
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
                    setState(() {
                      
                    });
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


                    return _buildCountryList(snapshot.data!,snapshot.data!);
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

  Widget _buildCountryList(List<dynamic> countries,name) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        var countryData = countries[index];
        var name = countries[index]['country'];
        if (searchController.text.isEmpty) {
         return ListTile(
          leading: 
            Image(image: NetworkImage(countryData['countryInfo']['flag'])) ,
          
          title: Text(countryData['country']),
          subtitle: Text('Cases: ${countryData['cases']}'),
        );
        } else if(name.toLowerCase().contains(searchController.text.toLowerCase() )){
          return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(countryData['countryInfo']['flag']),
          ),
          title: Text(countryData['country']),
          subtitle: Text('Cases: ${countryData['cases']}'),
        );
        }
        else{
          return Container();

        }
        
      },
    );
  }
}
