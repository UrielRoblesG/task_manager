class AutorizationHeader {
  static Map<String, String> create(
          {required String token, String contentType = 'application/json'}) =>
      {"Authorization": "Bearer $token", "Content-Type": contentType};
}
