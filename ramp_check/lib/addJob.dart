import 'dart:collection';

import 'package:flutter/material.dart';
import '../jobList.dart';
import '../dbFunctions.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key, required this.title});

  final String title;

  @override
  State<AddJobPage> createState() => AddJobPageState();
}

class AddJobPageState extends State<AddJobPage> {

  final List<String> statusOptions = [
    'Created',
    'In Progress',
    'Complete',
    'Archived',
  ];

  String selectedStatus = 'Created';

  final jobNameController = TextEditingController();
  final commentController = TextEditingController();

  Future<void> _createNewJob() async {
      String newName = jobNameController.text;
      String newComment = commentController.text;
        if (newName != "" && newComment != "") {

          final log = await WarehouseApi.createLog(
            title: newName,
            comment: newComment,
            status: selectedStatus,
          );

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => JobListPage(title: "Job List")));
        }

        else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create new job'),
        ),
      );
    }
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
            Text(
              "Add New Job",
              style: TextStyle(fontSize:30),
            ),

            SizedBox(height: 30,),

            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TextFormField(
                controller: jobNameController,
                decoration: InputDecoration(
                  labelText: "Job name",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
                validator: (value){
                  if (value == null){
                    return "Missing job name";
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: 15,),

            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TextFormField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: "Comment",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
                validator: (value){
                  if (value == null){
                    return "Missing comment";
                  }
                  return null;
                },
              ),
            ),

            DropdownButton<String>(
              value: selectedStatus, 
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(color: Colors.black45),
          onChanged: (String? newValue) {
            setState(() {
              selectedStatus = newValue!;
            });
          },
          items: statusOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
              ),

            SizedBox(height: 30,),

            SizedBox(
              width: screenWidth * 0.5,
              child: ElevatedButton(
                onPressed: () => _createNewJob,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 194, 29, 17),
                ), child: Text("Create Job")),
            ),
            
            
          ],
        ),
      ),
    );
  }
}