class Endpoints {
  static const customerlogin = "/Customer_user/login";
  static const customerregister = "/Customer_user/register";
  static const logout = "/partner_user/logout";
  static const forgotpassword = "/partner_user/forgetpassword";
  static const searchApiGetDatanearbyloc = "/Search_api/getDatanearbyloc";
  static const sportApiGetAllData = "/Sport_api/getAllData";
  static const searchApiGetDatabysport = "/Search_api/getAcademybysport";
  static const academyApiGetAllData = "/Academy_api/getAllData";
  static const academyApiGetuserData = "/Academy_api/getuserData";
  static const uploadApiGetmedia = "/Upload_api/getmedia";
  static const facilityApiPayment = "/Facility_api/payment";
  static const orderprocess = "/Order_api/process_order";
  static const responseorder = "/Order_api/response_order";
  static const venueApiGetAllData = "/Venue_api/getAllData";
  static const venueApiGetsingleData = "/Venue_api/getsingleData";
  static const facilityApiGetFacilitySlots = "/Facility_api/getFacilitySlots";
  static const facilityApiFacilityBooking = "/Facility_api/facilityBooking";
  static const experiencetournamentApiGetAllData = "/Experience_api/getAllData";
  static const experienceApiGetsingleitemData = "/Experience_api/getsingleData";
  static const getLikedTournament = "/Like_api/getlike";
  static const likeUnlikeTournament = "/Like_api/insertData";
  static const tournamentApiGetAllData =
      "/Tournament_api/getApprovedData"; //"Tournament_api/getAllData";
  static const tournamentApiGetsingleitemData =
      "/Tournament_api/getsingleitemData";
  static const searchApiGetDatabytext = "/Search_api/getDatabytext";
  static const userApiUpdateProfile = "/Userapi/updateProfile";
  static const DELETE_ACCOUNT = "/Userapi/disableProfile";
  static const CHANGE_PASSWORD = "/partner_user/changepassword";
  static const orderApigGtAllData = "/Order_api/getAllData";
  static const cmsApiGetAllData = "/Cms_api/getAllData";
  static const SAVE_RATING = "/Review_api/insertData";
  static const sendBookingNotification = "/partner_notification";
}
