class ServerConstApis {
  static String baseAPI = 'http://94.141.219.16';
  // static String baseAPI = 'http://10.0.2.2:8000';

///// auth
  static String signUpStep1 = '$baseAPI/api/signup_step1';
  static String signUpStep2 = '$baseAPI/api/signup_step2';
  static String signIn = '$baseAPI/api/login';

  /////Otp
  static String verifyotp = '$baseAPI/api/checkOTP';
  static String sendOtp = '$baseAPI/api/sendOTP';


  ///// interest
  static String getInterest = '$baseAPI/api/interest';
  static String storeUserInterest = '$baseAPI/api/storeUserInterest';
/////////forImages
  static String loadImages = baseAPI;

//// 
  static String followOrganizer = '$baseAPI/api/follow';
  static String unFollowOrganizer = '$baseAPI/api/unfollow';

  ///// home page
  static String getCategoryList = '$baseAPI/api/event_category';
  static String getFeaturedList = '$baseAPI/api/featured_event';
  static String getInyourCityList = '$baseAPI/api/eventsInUserCity';
  static String getJustForYouList = '$baseAPI/api/getJustForYouEvents';
  static String getTrendingList = '$baseAPI/api/trending_event';
  static String getToNightList = '$baseAPI/api/toNight';
  static String getThisWeekList = '$baseAPI/api/thisWeek';
  static String getOrganizerEventList = '$baseAPI/api/organizer_event';
  static String getAccordingCategoryList = '$baseAPI/api/eventAccordingCategory';
  //// event detailes
  static String getEventDetailes = '$baseAPI/api/event';

/////
  static String bookNow = '$baseAPI/api/book';

  //// follow 
  static String followEvent = '$baseAPI/api/event_follow';
  static String unFollowEvent = '$baseAPI/api/event_unfollow';
  
}