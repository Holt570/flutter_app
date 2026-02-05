import 'package:flutter/material.dart';
import '../addJob.dart';
import '../editJob.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key, required this.title});

  final String title;

  @override
  State<AddJobPage> createState() => AddJobPageState();
}

class AddJobPageState extends State<AddJobPage> {

  void _validateLogin() {
    setState(() {
      
    });
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
          mainAxisAlignment: .center,
          children: [
            Text(
              "RampCheck v0.1",
              style: TextStyle(fontSize:30),
            ),

            SizedBox(height: 30,),

            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
            ),

            SizedBox(height: 15,),

            Container(
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
            ),

            SizedBox(height: 30,),

            SizedBox(
              width: screenWidth * 0.5,
              child: ElevatedButton(
                onPressed: _validateLogin,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 194, 29, 17),
                ), child: Text("Login")),
            ),
            
            
          ],
        ),
      ),
    );
  }
}