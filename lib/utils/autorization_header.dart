class AutorizationHeader {
  static Map<String, String> create(String token) =>
      {"Authorization": "Bearer $token"};
}
