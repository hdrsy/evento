class ServerConstApis {
  static String baseAPI = 'https://evento.sy';
  // static String baseAPI = 'http://94.141.219.13:8000';
  // static String baseAPI = 'http://10.0.2.2:8000';
  // static String baseAPI = 'http://127.0.0.1:8000';
  static String baseAPIImage = 'https://evento.sy';
  // static String baseAPI = 'http://192.168.100.7:8000';

///// auth
  static String signUpStep1 = '$baseAPI/api/signup_step1';
  static String signUpStep2 = '$baseAPI/api/signup_step2';
  static String signIn = '$baseAPI/api/login';
  static String logout = '$baseAPI/api/logout';
  static String deteAccount = '$baseAPI/api/user/delete';

  /////Otp
  static String verifyotp = '$baseAPI/api/checkOTP';
  static String sendOtp = '$baseAPI/api/sendOTP';
  ///// forgetPassword
  static String sendCode = '$baseAPI/api/sendCode';
  static String checkCode = '$baseAPI/api/checkCode';
  static String changePasswordForgetten = '$baseAPI/api/changePassword';

  ///// interest
  static String getInterest = '$baseAPI/api/interest';
  static String storeUserInterest = '$baseAPI/api/storeUserInterest';
/////////forImages
  static String loadImages = baseAPI;

////  organizer
  static String followOrganizer = '$baseAPI/api/follow';
  static String unFollowOrganizer = '$baseAPI/api/unfollow';
  static String becomeOrganizer = '$baseAPI/api/become_organizer';
  static String organizerProfile = '$baseAPI/api/organizer_profile';
  static String organizerFollowers = '$baseAPI/api/organizer_followers';
  static String organizationProfile = '$baseAPI/api/organizer/profile';
  static String organizationMyEvents = '$baseAPI/api/organizer/my-events';
  static String organizationUpdateProfile =
      '$baseAPI/api/organizer/updateProfile';
  static String organizationMyEventsBookings =
      '$baseAPI/api/organizer/event-booking';
  ///// service provider

  static String becomeServiceProvider = '$baseAPI/api/become_service_provider';
  static String serviceProfileForUser = '$baseAPI/api/service_provider';
  ///// home page
  static String getCategoryList = '$baseAPI/api/event_category';
  static String getFeaturedList = '$baseAPI/api/featured_event';
  static String getInyourCityList = '$baseAPI/api/eventsInUserCity';
  static String getJustForYouList = '$baseAPI/api/getJustForYouEvents';
  static String getTrendingList = '$baseAPI/api/trending_event';
  static String getToNightList = '$baseAPI/api/toNight';
  static String getThisWeekList = '$baseAPI/api/thisWeek';
  static String getOrganizerEventList = '$baseAPI/api/organizer_event';
  static String getOfferList = '$baseAPI/api/offer_event';
  static String getOrganizerHomeList = '$baseAPI/api/Home-Organizer';
  static String getAccordingCategoryList =
      '$baseAPI/api/eventAccordingCategory';
  //// event detailes
  static String getEventDetailes = '$baseAPI/api/event';
  static String showGoing = '$baseAPI/api/showGoing';

/////
  static String bookNow = '$baseAPI/api/booking/calculate_invoice_amount';
  static String myCoupons = '$baseAPI/api/my_promo_code_booking';

  /////my booking
  static String myCancelledBookings = '$baseAPI/api/my-cancelled-bookings';
  static String myBooking = '$baseAPI/api/my_booking';
  static String getUserBooking = '$baseAPI/api/organizer/getUserBooking';
  static String cancellBooking = '$baseAPI/api/booking/cancel';
  static String reSellTicket = '$baseAPI/api/booking/resell_ticket';

  //// follow
  static String followEvent = '$baseAPI/api/event_follow';
  static String unFollowEvent = '$baseAPI/api/event_unfollow';
  static String myFavoriteEvents = '$baseAPI/api/my_favorite';
  //// reels
  static String getReels = '$baseAPI/api/reels';
  static String showReel = '$baseAPI/api/reels-show';
  static String likeReel = '$baseAPI/api/reels';
  //// notification
  static String getNotification = '$baseAPI/api/notification';
  static String liveNotification = '$baseAPI/api/live_notification';
  //// promoCode
  static String myPromoCode = '$baseAPI/api/my_promo_code';

  //// profile
  static String getprofile = '$baseAPI/api/profile';
  static String changePassword = '$baseAPI/api/user/reset-password';
  static String updateProfile = '$baseAPI/api/user/update';
  static String userChangeType = '$baseAPI/api/change_type';

  //// customiz event
  static String serviceCategory = '$baseAPI/api/service_category';
  static String serviceAccordingCategory =
      '$baseAPI/api/serviceAccordingCategory';
  static String getAllvenue = '$baseAPI/api/venue';
  static String getVenueDetailes = '$baseAPI/api/venue';
  static String sendEventRequest = '$baseAPI/api/sendEventRequest';
  static String myEventRequest = '$baseAPI/api/my_request';
  static String getEventServiceCategory =
      '$baseAPI/api/event_request_categories';

  ///// freinds
  static String freindRequest = '$baseAPI/api/friend-request';
  static String denyRequest = '$baseAPI/api/friend-request/deny';
  static String cancelRequest = '$baseAPI/api/friend-request/cancel';
  static String approveRequest = '$baseAPI/api/friend-request/approve';
  static String myFreinds = '$baseAPI/api/my-friends';
  static String mySentRequests = '$baseAPI/api/my-sent-requests';
  static String myReciviedRequests = '$baseAPI/api/my-received-requests';
  static String freindSearch = '$baseAPI/api/searchFriend';

  /// review
  static String reviewEvent = '$baseAPI/api/event-review';
  static String reviewServiceProvider = '$baseAPI/api/service-provider-review';
  static String reviewVenue = '$baseAPI/api/venue-review';
  static String inviteEvent = '$baseAPI/api/Invite';

  //// filter
  static String filter = '$baseAPI/api/filter';
  static String favoritefilter = '$baseAPI/api/favorite_filter';
  static String eventSearch = '$baseAPI/api/event_search';

  ///// guest
  static String getCategoryListforGuest = '$baseAPI/api/event_category-guest';
  static String getFeaturedListforGuest = '$baseAPI/api/featured_event-guest';
  static String eventSearchforGuest = '$baseAPI/api/event_search-guest';
  static String getTrendingListforGuest = '$baseAPI/api/trending_event-guest';
  static String getToNightListforGuest = '$baseAPI/api/toNight-guest';
  static String getThisWeekListforGuest = '$baseAPI/api/thisWeek-guest';
  static String getOfferListforGuest = '$baseAPI/api/offer_event-guest';
  static String getAccordingCategoryListforGuest =
      '$baseAPI/api/eventAccordingCategory-guest';
  static String getReelsforGuest = '$baseAPI/api/reels-guest';
  static String getEventDetailesforGuest = '$baseAPI/api/event-guest';

  //// payment
  ///
  static String getInvoice = '$baseAPI/api/invoice/create';
  static String confirmPayment = '$baseAPI/api/invoice/confirmPayment';
}
