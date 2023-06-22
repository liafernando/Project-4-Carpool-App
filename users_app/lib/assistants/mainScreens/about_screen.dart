import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AboutScreen extends StatefulWidget
{
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}




class _AboutScreenState extends State<AboutScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: ListView(

        children: [

          //image
          Container(
            height: 230,
            child: Center(
              child: Image.asset(
                "images/logo.png",
                width: 260,
              ),
            ),
          ),

          Column(
            children: [


              const Text(
                "NHL Stenden Carpool App",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //about you
              const Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "NHL Stenden Carpool is a rider app which enables student to get "
                    "a ride from drivers to get to school safely and easily."
                    "We hope it does the best for all the students.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              //close
              ElevatedButton(
                onPressed: ()
                {
                  SystemNavigator.pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white54,
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

            ],
          ),

        ],

      ),
    );
  }
}