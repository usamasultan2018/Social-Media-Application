// return formatted data  as a String
import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp){
  // TimeStamp is the object the we retirve from firebase
  DateTime dateTime = timestamp.toDate();
  String year = dateTime.year.toString();
  String month =  dateTime.month.toString();
  String day =  dateTime.day.toString();
  String formattedData =  "$year/$month/$day";
  return formattedData;

}