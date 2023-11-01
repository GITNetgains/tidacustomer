
abstract class ApiInterface {
  static const baseUrl = "https://tidasports.com/secure/api";
  static const notificationServiceUrl = "https://tida-notification-service.onrender.com";
  
  Future postApi({
    String? url,
    Map<String, String>? headers,
    Map? data,
  });
}
