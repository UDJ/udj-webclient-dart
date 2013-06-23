library requesthelper;

//import "dart:uri"; No longer a valid library. New class called Uri made.

class RequestHelper {
  static String encodeMap(Map data) {
    return data.keys.map((k) {
      return '${Uri.encodeComponent(k)}=${Uri.encodeComponent(data[k])}';
    }).join('&');
  } 
}
