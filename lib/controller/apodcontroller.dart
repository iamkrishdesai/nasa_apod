import 'dart:convert';
import 'package:get/get.dart';
import 'package:nasa_apod/model/apod.dart';
import 'package:http/http.dart' as http;

class Apodcontroller extends GetxController {
  var apodfact = Rxn<Apod>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getapod();
  }

  void getapod() async {
    const String apikey = 'mGNRW1MWda0VXC7TyrSg3qDozgbDyHueh8bBOgd8';
    var today = DateTime.now();
    var formattedDate =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    var response = await http.get(
      Uri.parse(
          'https://api.nasa.gov/planetary/apod?api_key=$apikey&date=$formattedDate'),
    );
    print("response ----------------");
    print(response.body);

    if (response.statusCode == 404) {
      DateTime yesterday = today.subtract(Duration(days: 1));
      formattedDate =
          "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";

      response = await http.get(
        Uri.parse(
            'https://api.nasa.gov/planetary/apod?api_key=$apikey&date=$formattedDate'),
      );
    }

    if (response.statusCode == 200) {
      apodfact.value = Apod.fromjson(jsonDecode(response.body));
      print("${apodfact.value!.explanation}");
    } else {
      print("error while loading data");
    }
  }
}
