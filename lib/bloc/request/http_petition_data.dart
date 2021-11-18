import 'dart:convert';

abstract class HttpPetitionData {
  String toJson() {
    return jsonEncode(this);
  }
}
