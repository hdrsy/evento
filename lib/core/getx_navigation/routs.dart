import 'package:evento/features/account_type/controller/binding/account_type_binding.dart';
import 'package:evento/features/account_type/view/account_type_screen.dart';
import 'package:evento/features/account_type_inner_screens/account_privacy/view/account_privacy_screen.dart';
import 'package:evento/features/account_type_inner_screens/becom_an_organizer/account_organizer/view/account_organizer_screen.dart';
import 'package:evento/features/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/view/choice_organizer_category_screen.dart';
import 'package:evento/features/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/view/choice_type_screen.dart';
import 'package:evento/features/account_type_inner_screens/switch_to_service_provider/view/switch_to_service_provider_screen.dart';
import 'package:evento/features/auth/steps/controller/binding/steps_binding.dart';
import 'package:evento/features/auth/steps/view/main_steps_screen.dart';
import 'package:evento/features/auth/welcome/binding/welcome_binding.dart';
import 'package:evento/features/auth/welcome/view/welcome_screen.dart';
import 'package:evento/features/booking_detailes/controller/binding/booking_detailes_binding.dart';
import 'package:evento/features/booking_detailes/view/booking_detailes_screen.dart';
import 'package:evento/features/customize_event/date_time/controller/binding/date_time_binding.dart';
import 'package:evento/features/customize_event/date_time/view/date_time_screen.dart';
import 'package:evento/features/customize_event/review/controller/binding/event_review_binding.dart';
import 'package:evento/features/customize_event/review/view/event_review.dart';
import 'package:evento/features/customize_event/serice_according_detailes/controller/binding/service_according_detailes_binding.dart';
import 'package:evento/features/customize_event/serice_according_detailes/view/service_according_detailes_screen.dart';
import 'package:evento/features/customize_event/serivce_according_category/controller/binding/serice_according_category_binding.dart';
import 'package:evento/features/customize_event/serivce_according_category/view/service_according_category_screen.dart';
import 'package:evento/features/customize_event/service_category/controller/binding/service_category_binding.dart';
import 'package:evento/features/customize_event/service_category/view/service_category_screen.dart';
import 'package:evento/features/edit_profile/controller/binding/edit_profile_binding.dart';
import 'package:evento/features/edit_profile/view/edit_profile_screen.dart';
import 'package:evento/features/events/event_detailes/controller/binding/event_detailes_binding.dart';
import 'package:evento/features/events/event_detailes/view/event_detailes_screen.dart';
import 'package:evento/features/events/see_all/controller/binding/see_all_binding.dart';
import 'package:evento/features/events/see_all/view/see_all_screen.dart';
import 'package:evento/features/events/time_line/controller/binding/time_line_binding.dart';
import 'package:evento/features/events/time_line/view/time_line_screen.dart';
import 'package:evento/features/favorite/controller/binding/favorite_binding.dart';
import 'package:evento/features/favorite/view/favorite_screen.dart';
import 'package:evento/features/freinds/controller/binding/freinds_binding.dart';
import 'package:evento/features/freinds/view/freinds_screen.dart';
import 'package:evento/features/gallery/controller/binding/gallery_binding.dart';
import 'package:evento/features/gallery/view/gallery_screen.dart';
import 'package:evento/features/help_center/view/help_center_screen.dart';
import 'package:evento/features/invite_friends/controller/binding/invite_friends_binding.dart';
import 'package:evento/features/invite_friends/view/invite_riends_screen.dart';
import 'package:evento/features/main_bottom_navigation_bar/controller/main_bottom_navigation_binding.dart';
import 'package:evento/features/main_bottom_navigation_bar/view/main_bottom_navigation_widget.dart';
import 'package:evento/features/map/controller/binding/map_binding.dart';
import 'package:evento/features/map/view/map_screen.dart';
import 'package:evento/features/my_booking/controller/binding/my_booking_binding.dart';
import 'package:evento/features/my_booking/view/my_booking_screen.dart';
import 'package:evento/features/my_request/controller/binding/my_request_binding.dart';
import 'package:evento/features/my_request/view/my_request_screen.dart';
import 'package:evento/features/notification/controller/binding/notification_binding.dart';
import 'package:evento/features/notification/view/notification_screen.dart';
import 'package:evento/features/organizer/add_media_in_folder_screen/view/add_media_in_folder_screen.dart';
import 'package:evento/features/organizer/create_profile/controller/binding/organizer_create_profile_binding.dart';
import 'package:evento/features/organizer/create_profile/view/oganizer_create_profile_screen.dart';
import 'package:evento/features/request_status/controller/binding/request_status_binding.dart';
import 'package:evento/features/request_status/view/request_status_screen.dart';
import 'package:get/get.dart';

appRoutes() => [
    GetPage(name: '/', page:()=> WelcomeScreen(),binding:WelcomeBinding() ) ,
    GetPage(name: '/steps', page:()=> MainStepsScreen(),binding:StepsBinding() ) , 
    GetPage(name: '/home', page:()=> MainBottomNavigationBarWidget(),binding:MainBottomNavigationBinding() ) , 
    GetPage(name: '/seeAll', page:()=> const SeeAllScreen(),binding:SeeAllBinding() ) , 
    GetPage(name: '/eventDetailes', page:()=>  EventDetailesScreen(),binding:EventDetailesBinding() ) , 
    GetPage(name: '/eventTimeLine', page:()=> TimeLineScreen(),binding:TimeLineBinding() ) , 
    GetPage(name: '/dateTimeScreen', page:()=> const DateTimeScreen(),binding:DateTimeBinding() ) , 
    GetPage(name: '/ServiceCategoryScreen', page:()=> const ServiceCategoryScreen(),binding:ServiceCategoryBinding() ) , 
    GetPage(name: '/ServiceAccordingCategoryScreen', page:()=> const ServiceAccordingCategoryScreen(),binding:ServiceAccordingCategoryBinding() ) , 
    GetPage(name: '/ServiceAccordingDetailesScreen', page:()=> const ServiceAccordingDetailesScreen(),binding:ServiceAccordingDetailesBinding() ) , 
    GetPage(name: '/GalleryScreen', page:()=> GalleryScreen(),binding:GalleryBinding() ) , 
    GetPage(name: '/EventReviewScreen', page:()=> const EventReviewScreen(),binding:EventReviewBinding() ) , 
    GetPage(name: '/MyBookingScreen', page:()=> const MyBookingScreen(),binding:MyBookingBinding() ) , 
    GetPage(name: '/MyRequestScreen', page:()=> const MyrequestScreen(),binding:MyRequestBinding() ) , 
    GetPage(name: '/RequestStatusScreen', page:()=> const RequestStatusScreen(),binding:RequestStatusBinding() ) , 
    GetPage(name: '/FavoriteScreen', page:()=> const FavoriteScreen(),binding:FavoriteBinding() ) , 
    GetPage(name: '/NotificationScreen', page:()=> const NotificationScreen(),binding:NotificationBinding() ) , 
    GetPage(name: '/FreindsScreen', page:()=> const FreindsScreen(),binding:FreindsBinding() ) , 
    GetPage(name: '/InviteFreindsScreen', page:()=> const InviteFriendsScreen(),binding:InviteFriendsBinding() ) , 
    GetPage(name: '/EditProfileScreen', page:()=> EditProfileScreen(),binding:EditProfileBinding() ) , 
    GetPage(name: '/MapScreen', page:()=> MapScreen(),binding:MapBinding() ) , 
    GetPage(name: '/BookingDetailesScreen', page:()=> const BookingDetailesScreen(),binding:BookingDetailesBinding() ) , 
    GetPage(name: '/OrganizerCreateProfileScreen', page:()=>  OrganizerCreateProfileScreen(),binding:OrganizerCreateProfileBinding() ) , 
    GetPage(name: '/AccountTypeScreen', page:()=> const AccountTypeScreen(),binding:AccountTypeBinding() ) , 
    GetPage(name: '/SwithcToServiceProviderScreen', page:()=>  SwithcToServiceProviderScreen()) , 
    GetPage(name: '/HelpCenterScreen', page:()=> const HelpCenterScreen()) , 
    GetPage(name: '/AccountPrivacyScreen', page:()=>  AccountPrivacyScreen()) , 
    GetPage(name: '/ChoiceTypeScreen', page:()=>  ChoiceTypeScreen()) , 
    GetPage(name: '/AccountOrganizerScreen', page:()=>  AccountOrganizerScreen()) , 
    GetPage(name: '/ChoiceOrganizerCategoryScreen', page:()=>  ChoiceOrganizerCategoryScreen()) , 
    GetPage(name: '/AddMediaInFolderScreen', page:()=>  AddMediaInFolderScreen()) , 
    // GetPage(name: '/vedioReels', page:()=> VedioReels()) , 
    
    
      ];