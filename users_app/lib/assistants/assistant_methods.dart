import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistants/request_assistant.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/global/map_key.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/directions.dart';
import 'package:users_app/models/user_model.dart';
import 'package:http/http.dart' as http;

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(Position position,
      context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position
        .latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress = "";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, No Response.") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude;
      userPickUpAddress.locationLongitude = position.longitude;
      userPickUpAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updatePickUpLocationAddress(
          userPickUpAddress);
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

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<
      DirectionDetailsInfo?> obtainOriginToDestinationDirectionDetails(
      LatLng origionPosition, LatLng destinationPosition) async
  {
    String urlOriginToDestinationDirectionDetails = "https://maps.googleapis.com/maps/api/directions/json?origin=${origionPosition
        .latitude},${origionPosition
        .longitude}&destination=${destinationPosition
        .latitude},${destinationPosition.longitude}&key=$mapKey";

    var responseDirectionApi = await RequestAssistant.receiveRequest(
        urlOriginToDestinationDirectionDetails);

    if (responseDirectionApi == "Error Occurred, No Response.") {
      return null;
    }

    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    directionDetailsInfo.e_points =
    responseDirectionApi["routes"][0]["overview_polyline"]["points"];

    directionDetailsInfo.distance_text =
    responseDirectionApi["routes"][0]["legs"][0]["distance"]["text"];
    directionDetailsInfo.distance_value =
    responseDirectionApi["routes"][0]["legs"][0]["distance"]["value"];

    directionDetailsInfo.duration_text =
    responseDirectionApi["routes"][0]["legs"][0]["duration"]["text"];
    directionDetailsInfo.duration_value =
    responseDirectionApi["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetailsInfo;
  }


  static sendNotificationToDriverNow(String deviceRegistrationToken,
      String userRideRequestId, context) async
  {
    String destinationAddress = userDropOffAddress;

    //postman sending notification
    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization': cloudMessagingServerToken,
    };

    Map bodyNotification =
    {
      "body": "Destination Address: \n$destinationAddress.",
      "title": "New Trip Request"
    };

    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "rideRequestId": userRideRequestId
    };

    Map officialNotificationFormat =
    {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": deviceRegistrationToken,
    };

    var responseNotification = http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );
  }
}
