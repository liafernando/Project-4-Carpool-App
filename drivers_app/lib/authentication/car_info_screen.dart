import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/global/global.dart';
import 'package:first_app/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CarInfoScreen extends StatefulWidget
{
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}



class _CarInfoScreenState extends State<CarInfoScreen>
{
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController = TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ["Car","Scooter", "Bike"];
  String? selectedCarType;

  saveCarInfo()
  {
    Map driverCarInfoMap =
    {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
    driversRef.child(currentFirebaseUser!.uid).child("car_details").set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Vehicle Details has been saved, Congratulations.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                const SizedBox(height: 10,),

                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30.0), // Add your desired top margin value here
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Image.asset("images/logo1.png"),
                    ),
                  ),
                ),


                const SizedBox(height: 10,),

                const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child:  Center(
                    child: Text(
                      "Write Car Details",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                TextField(
                  controller: carModelTextEditingController,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    labelText: "Car Model",
                    hintText: "Enter your car model",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextField(
                  controller: carNumberTextEditingController,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    labelText: "Car Number",
                    hintText: "Enter your car number",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextField(
                  controller: carColorTextEditingController,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: const InputDecoration(
                    labelText: "Car Color",
                    hintText: "Enter your Car Color",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),


                DropdownButton(
                  iconSize: 26,
                  dropdownColor: Colors.white,
                  hint:const Text(
                      "Please Choose Vehicle Type"),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                  value: selectedCarType,
                  onChanged: (newValue){
                    setState(() {
                      selectedCarType = newValue.toString();
                    });
                  },
                  items: carTypesList.map((car){
                    return DropdownMenuItem(
                      value: car,
                      child: Text(
                        car,
                        style:const TextStyle(
                            color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: ()
                  {
                    if(carColorTextEditingController.text.isNotEmpty
                        && carNumberTextEditingController.text.isNotEmpty
                        && carModelTextEditingController.text.isNotEmpty && selectedCarType != null)
                    {
                      saveCarInfo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreenAccent,
                  ),
                  child: const Text(
                    "Save Your Vehicle Info",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                    ),
                  ),
                ),

              ],
            ),
          )
      ),
    );
  }
}
