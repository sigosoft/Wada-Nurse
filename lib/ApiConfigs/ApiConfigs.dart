// ignore_for_file: file_names

class ApiConfigs {
  static String baseUrl = "https://thewada.com/wada-backend/public/api/nurse/";
  static String Image_URL = "https://thewada.com/wada-backend/public/storage/";
}

class APIEndpoints {
  static const String getCountryCodes = "getCountryCodes";
  static const String getLanguages = "getLanguages";
  static const String register = "nurseRegistration";
  static const String getRegistrationFee = "reg_fee";
  static const String sendRegisterOtp = "send_reg_otp";
  static const String home = "home";
  static const String login = "login";
  static const String shiftDetails = "shiftDetails";
  static const String bookingDetails = "bookingDetails";
  static const String bookingRequests = "bookingRequests";
  static const String pendingBookings = "pendingBookings";
  static const String ongoingBookings = "ongoingBookings";
  static const String completedBookings = "completedBookings";
  static const String sendForgotOtp = "send_forgot_otp";
  static const String verifyForgotOtp = "verify_forgot_otp";
  static const String resetPassword = "resetPassword";
  static const String profile = "profile";
  static const String updateProfile = "updateProfile";
  static const String changePassword = "changePassword";
  static const String notifications = "notifications";
  static const String updateAcceptStatus = "updateAcceptStatus";
  static const String terms = "terms";
  static const String privacyPolicy = "privacy_policy";
  static const String about = "about";
  static const String contactUs = "contact_us";
  static const String faqs = "faqs";
  static const String deleteAccount = "deleteAccount";
  static const String documents = "documents";
  static const String uploadDocuments = "uploadDocuments";
  static const String uploadRegistrationDocuments =
      "uploadRegistrationDocuments";
  static const String settings = "settings";
  static const String logout = "logout";
  static const String checkIn = "checkIn";
  static const String checkOut = "checkOut";

  ////////////////////////////Leaves////////////////////////
  static const String requestLeave = "requestLeave";
  static const String nurseLeaves = "nurseLeaves";

  ////////////////////////////Razorpay////////////////////////
  static const String createOrder = "razor-order";
  static const String checkRegistrationStatus = "checkRegistrationStatus";
}
