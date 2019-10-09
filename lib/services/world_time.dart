import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint
  bool isDayTime; // true if it's a day, false if a night

  WorldTime({this.location, this.flag, this.url});



  Future<void> getTime() async {

    try {

      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //print(dateTime);
      //print(offset);

      //create DateTime object

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 19;

      time = DateFormat.jm().format(now);

    }
    catch (e) {

      print('caught error: $e');
      time = 'could not get time data';

    }



  }


}
