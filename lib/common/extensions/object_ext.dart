import 'dart:convert';
import 'dart:developer';

T? safeCast<T>(object) {
  if (object is T) {
    return object;
  } else {
    log(
      "safeCast error - Try to cast object from ${object.runtimeType} to $T",
    );

    return null;
  }
}

Map<String, dynamic> safeToJson(object) {
  if (object == null) return {};

  try {
    try {
      return object.toMap();
    } catch (e) {
      try {
        return object.toJson();
      } catch (e) {
        final dataJsonStr = jsonEncode(object);
        final dataJson = jsonDecode(dataJsonStr);

        return Map<String, dynamic>.from(dataJson);
      }
    }
  } catch (e) {
    log("safeToJson error: $e");
    return {};
  }
}
