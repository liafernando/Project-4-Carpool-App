import 'package:firebase_auth/firebase_auth.dart';
import 'package:users_app/models/direction_details_info.dart';
import 'package:users_app/models/user_model.dart';



final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //online-active drivers Information List
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId="";
String cloudMessagingServerToken = "key=AAAANdkKSpc:APA91bGpw8HnIjnjdI6Dt3yXzRJT0il72Mx4iN1Wunn1Fu63-fg_cTPK4Pz_1EX6Z6BN_SY6HLX23yJsA3zhvFO2m1674wkHnDUMvfIM_mjlKgpF4UCnKGPW_7juFnPOJFvbQ5rjxYUp";
String userDropOffAddress = "";