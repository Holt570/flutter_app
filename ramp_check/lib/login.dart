import 'package:flutter/material.dart';
import '../jobList.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

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
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
                validator: (value){
                  if (value != "TestUser"){
                    return "Invalid username";
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
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
                validator: (value){
                  if (value != "TestPass1"){
                    return "Incorrect password";
                  }
                  return null;
                },
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