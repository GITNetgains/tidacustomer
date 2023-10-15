
abstract class ApiInterface {
  static const baseUrl = "https://tidasports.com/secure/api";
  
  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });
}
