import 'package:flutter/material.dart';
import '../addJob.dart';
import '../editJob.dart';
import '../dbFunctions.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key, required this.title});

  final String title;

  @override
  State<JobListPage> createState() => AddJobPageState();
}

class AddJobPageState extends State<JobListPage> {
  List<Map<String, dynamic>> jobs = [];

  @override
  void initState(){
    super.initState();

  }

  void _loadLogs() async{
    final data = await WarehouseApi.getJobs();

    setState(
      () => jobs = data
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            SizedBox(height: 30,),

           Row(
            mainAxisAlignment: .center,
            children: [
              DataTable(
                columns: [DataColumn(label: Text("Job Name")), 
                                  DataColumn(label: Text("Comment")), 
                                  DataColumn(label: Text("Status"))
                                  ], 
                        rows: jobs.map((job){
                          return DataRow(cells: 
                          [
                            DataCell(Text(job["title"])),
                            DataCell(Text(job["comment"])),
                            DataCell(Text(job["status"])),
                          ],);
                        }).toList())
           ],),
           Row(
            mainAxisAlignment: .center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddJobPage(title: "Create Job"))),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 194, 29, 17),
                ), child: Text("Create New Job")
                ),
            ],
            ),
          ],
        ),
      ),
    );
  }
}