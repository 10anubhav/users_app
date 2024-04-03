import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String serverKeyFCM = "key=AAAAOWVZe-4:APA91bET4lLNUfn3dO_dNreWgbySmzeLQ1SmilhKP7NQ51wTLRqd9lXSAM3WWuBMIqEJ5Y4o29DJfHkENzBJGM-cu_E3o8ae7UT3TMHG0CVelYjseyUzDgUvZUiJN7Mc0eF03FOT-4rF";


String googleMapKey="AIzaSyAAlObLuVomFEvcVOWhxQou-lxquD0RJ-4";
const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);