import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistants/request_assistant.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/global/map_key.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/models/directions.dart';
import 'package:users_app/models/user_model.dart';


class AssistantMethods
{
  static Future<String> searchAddressForGeograhicCordinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress="";
    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
    if(requestResponse !="Error Occurred,No Response.")
      {
        humanReadableAddress= requestResponse["results"][0]["formatted_address"]; //gets the response from human readable address
        Directions userPickupAddress = Directions();
        userPickupAddress.locationLatitude = position.latitude;
        userPickupAddress.locationLongitude= position.longitude;
        userPickupAddress.locationName=humanReadableAddress;

        Provider.of<AppInfo>(context, listen: false).updatePickUpLocationAddress(userPickupAddress);

      }
    return humanReadableAddress;
  }

  static void readCurrentOnlineUserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
      {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}