library requesthelper;

import "dart:uri";

class RequestHelper {
  static String encodeMap(Map data) {
    return data.keys.map((k) {
      return '${encodeUriComponent(k)}=${encodeUriComponent(data[k])}';
    }).join('&');
  } 
}
