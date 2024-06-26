import 'package:evento/core/shared/controllers/screens/edit_folder.dart/view/edit_folder_screen.dart';
import 'package:evento/features/booking/booking_detailes/controller/binding/booking_detailes_binding.dart';
import 'package:evento/features/booking/booking_detailes_for_my_booking_screen/controller/binding/booking_detailes_binding.dart';
import 'package:evento/features/booking/my_booking/controller/binding/my_booking_binding.dart';
import 'package:evento/features/booking/my_booking/view/my_booking_screen.dart';
import 'package:evento/features/booking/show_single_ticket/view/show_single_ticket_screen.dart';
import 'package:evento/features/events/customize_event/date_time/controller/binding/date_time_binding.dart';
import 'package:evento/features/events/customize_event/date_time/view/date_time_screen.dart';
import 'package:evento/features/events/customize_event/review/controller/binding/event_review_binding.dart';
import 'package:evento/features/events/customize_event/review/view/event_review.dart';
import 'package:evento/features/events/customize_event/serice_according_detailes/controller/binding/service_according_detailes_binding.dart';
import 'package:evento/features/events/customize_event/serice_according_detailes/view/service_according_detailes_screen.dart';
import 'package:evento/features/events/customize_event/serivce_according_category/controller/binding/serice_according_category_binding.dart';
import 'package:evento/features/events/customize_event/serivce_according_category/view/service_according_category_screen.dart';
import 'package:evento/features/events/customize_event/service_category/controller/binding/service_category_binding.dart';
import 'package:evento/features/events/customize_event/service_category/view/service_category_screen.dart';
import 'package:evento/features/events/customize_event/type_to_set_event/view/type_to_set_event_screen.dart';
import 'package:evento/features/events/customize_event/venue/controller/binding/venue_binding.dart';
import 'package:evento/features/events/customize_event/venue/view/venue_screen.dart';
import 'package:evento/features/events/customize_event/venue_detailes/controller/binding/venue_detailes_binding.dart';
import 'package:evento/features/events/customize_event/venue_detailes/view/venue_detailes_screen.dart';
import 'package:evento/features/events/favorite/controller/binding/favorite_binding.dart';
import 'package:evento/features/events/favorite/view/favorite_screen.dart';
import 'package:evento/features/events/my_request/controller/binding/my_request_binding.dart';
import 'package:evento/features/events/my_request/view/my_request_screen.dart';
import 'package:evento/features/events/request_status/controller/binding/request_status_binding.dart';
import 'package:evento/features/events/request_status/view/request_status_screen.dart';
import 'package:evento/features/friends/add_friends/view/add_friends_screen.dart';
import 'package:evento/features/friends/assign_friends/view/assign_friends_screen.dart';
import 'package:evento/features/friends/freinds/controller/binding/freinds_binding.dart';
import 'package:evento/features/friends/freinds/view/freinds_screen.dart';
import 'package:evento/features/friends/going/view/going_screen.dart';
import 'package:evento/features/friends/invite_friends/controller/binding/invite_friends_binding.dart';
import 'package:evento/features/friends/invite_friends/view/invite_riends_screen.dart';
import 'package:evento/features/friends/invite_friends_to_event/view/invite_freinde_to_event_screen.dart';
import 'package:evento/features/gallery/view/show_on_fullscreen.dart';
import 'package:evento/features/organizer/booking_detailes_in_event_for_organizer/controller/binding/booking_detailes_in_event_for_organizer_binding.dart';
import 'package:evento/features/organizer/booking_detailes_in_event_for_organizer/view/booking_detailes_in_event_for_organizer_screen.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/controller/binding/edit_profile_binding.dart';
import 'package:evento/features/organizer/edit_profile_organizer.dart/view/edit_profile_screen.dart';
import 'package:evento/features/organizer/event_request_status_for_organizer/view/event_request_status_for_organizer_screen.dart';
import 'package:evento/features/organizer/my_events_for_organizer/controller/binding/my_events_for_organizer_binding.dart';
import 'package:evento/features/organizer/my_events_for_organizer/view/my_events_for_organizer_screen.dart';
import 'package:evento/features/organizer/organization_profile/controller/binding/ofganization_profile_binding.dart';
import 'package:evento/features/organizer/organization_profile/view/organization_profile_screen.dart';
import 'package:evento/features/organizer/organizer_followers/view/organizer_followers_screen.dart';
import 'package:evento/features/organizer/show_all_booking_in_event_for_orgnaizer/view/show_all_booking_in_event_for_organizer_screen.dart';
import 'package:evento/features/organizer/ticket_in_event_for_organization/view/ticket_in_event_for_organization_screen.dart';
import 'package:evento/features/payment/view/payment_screen.dart';
import 'package:evento/features/reel_pages/show_reel/view/reels_screen.dart';
import 'package:evento/features/service_provider/show_profile_for_user.dart/service_according_detailes_screen.dart';
import 'package:evento/features/venue/venue_detailes/view/venue_detailes_screen.dart';

import '../../features/auth/forget_password_pages/enter_number/view/enter_number_screen.dart';
import '../../features/auth/forget_password_pages/set_new_password/view/set_new_password_screen.dart';
import '../../features/auth/forget_password_pages/verify_forget_password/view/verify_forget_password.dart';
import '../../features/booking/booking_detailes_for_my_booking_screen/view/booking_detailes_screen.dart';
import '../../features/events/event_detailes/view/widgets/see_all_amenitires_screen.dart';
import '../../features/events/see_all_offers/view/see_all_offers_screen.dart';
import '../../features/events/see_all_organizers/view/see_all_organizers_screen.dart';
import '../../features/organizer/organizer_profile/controller/binding/ofganizer_profile_binding.dart';
import '../../features/organizer/organizer_profile/view/organizer_profile_screen.dart';
import '../../features/profile_pages/account_type/controller/binding/account_type_binding.dart';
import '../../features/profile_pages/account_type/view/account_type_screen.dart';
import '../../features/profile_pages/account_type_inner_screens/account_privacy/view/account_privacy_screen.dart';
import '../../features/profile_pages/account_type_inner_screens/becom_an_organizer/account_organizer/view/account_organizer_screen.dart';
import '../../features/profile_pages/account_type_inner_screens/becom_an_organizer/choice_oganizer_category/view/choice_organizer_category_screen.dart';
import '../../features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/anther_screens/choice_service_type/view/choice_type_screen.dart';
import '../../features/profile_pages/account_type_inner_screens/switch_to_service_provider/view/switch_to_service_provider_screen.dart';
import '../../features/auth/steps/controller/binding/steps_binding.dart';
import '../../features/auth/steps/view/main_steps_screen.dart';
import '../../features/auth/welcome/binding/welcome_binding.dart';
import '../../features/auth/welcome/view/welcome_screen.dart';
import '../../features/booking/booking_detailes/view/booking_detailes_screen.dart';
import '../../features/profile_pages/achivment/view/achivment_screen.dart';
import '../../features/profile_pages/change_password/controller/binding/change_password_binding.dart';
import '../../features/profile_pages/change_password/view/change_password_screen.dart';
import '../../features/profile_pages/edit_profile/controller/binding/edit_profile_binding.dart';
import '../../features/profile_pages/edit_profile/view/edit_profile_screen.dart';
import '../../features/events/event_detailes/controller/binding/event_detailes_binding.dart';
import '../../features/events/event_detailes/view/event_detailes_screen.dart';
import '../../features/events/see_all/controller/binding/see_all_binding.dart';
import '../../features/events/see_all/view/see_all_screen.dart';
import '../../features/events/time_line/controller/binding/time_line_binding.dart';
import '../../features/events/time_line/view/time_line_screen.dart';
import '../../features/gallery/controller/binding/gallery_binding.dart';
import '../../features/gallery/view/gallery_screen.dart';
import '../../features/profile_pages/help_center/view/help_center_screen.dart';
import '../../features/main_bottom_navigation_bar/controller/main_bottom_navigation_binding.dart';
import '../../features/main_bottom_navigation_bar/view/main_bottom_navigation_widget.dart';
import '../../features/map/controller/binding/map_binding.dart';
import '../../features/map/view/map_screen.dart';
import '../../features/profile_pages/notification/controller/binding/notification_binding.dart';
import '../../features/profile_pages/notification/view/notification_screen.dart';
import '../../features/organizer/add_media_in_folder_screen/view/add_media_in_folder_screen.dart';
import '../../features/organizer/create_profile/controller/binding/organizer_create_profile_binding.dart';
import '../../features/organizer/create_profile/view/oganizer_create_profile_screen.dart';
import '../../features/see_location_and_dirction/dirction/view/dirction_screen.dart';
import '../../features/see_location_and_dirction/see_location/view/see_location_screen.dart';
import '../../features/service_provider/add_media_in_folder_screen/view/add_media_in_folder_screen.dart';
import '../../features/service_provider/edit_profile_service_provider.dart/controller/binding/edit_profile_binding.dart';
import '../../features/service_provider/edit_profile_service_provider.dart/view/edit_profile_screen.dart';
import '../../features/service_provider/see_all_service_category_profile_page/view/see_all_service_category_screen.dart';
import '../../features/service_provider/service_provider_create_profile/controller/binding/service_provider_create_profile_binding.dart';
import '../../features/service_provider/service_provider_create_profile/view/service_provider_create_profile_screen.dart';
import 'package:get/get.dart';

appRoutes() => [
      GetPage(
          name: '/', page: () => WelcomeScreen(), binding: WelcomeBinding()),
      GetPage(
          name: '/steps',
          page: () => MainStepsScreen(),
          binding: StepsBinding()),
      GetPage(
          name: '/home',
          page: () => MainBottomNavigationBarWidget(),
          binding: MainBottomNavigationBinding()),
      GetPage(
          name: '/seeAll',
          page: () => SeeAllScreen(),
          binding: SeeAllBinding()),
      GetPage(
          name: '/eventDetailes',
          page: () => EventDetailesScreen(),
          binding: EventDetailesBinding()),
      GetPage(
          name: '/eventTimeLine',
          page: () => TimeLineScreen(),
          binding: TimeLineBinding()),
      GetPage(
          name: '/dateTimeScreen',
          page: () => DateTimeScreen(),
          binding: DateTimeBinding()),
      GetPage(
          name: '/ServiceCategoryScreen',
          page: () => ServiceCategoryScreen(),
          binding: ServiceCategoryBinding()),
      GetPage(
          name: '/ServiceAccordingCategoryScreen',
          page: () => ServiceAccordingCategoryScreen(),
          binding: ServiceAccordingCategoryBinding()),
      GetPage(
          name: '/ServiceAccordingDetailesScreen',
          page: () => ServiceAccordingDetailesScreen(),
          binding: ServiceAccordingDetailesBinding()),
      GetPage(
          name: '/EditProfileOrganizerScreen',
          page: () => EditProfileOrganizerScreen(),
          binding: EditProfileOrganizerBinding()),
      GetPage(
          name: '/GalleryScreen',
          page: () => GalleryScreen(),
          binding: GalleryBinding()),
      GetPage(
          name: '/EventReviewScreen',
          page: () => EventReviewScreen(),
          binding: EventReviewBinding()),
      GetPage(
          name: '/MyBookingScreen',
          page: () => MyBookingScreen(),
          binding: MyBookingBinding()),
      GetPage(
          name: '/MyRequestScreen',
          page: () => MyrequestScreen(),
          binding: MyRequestBinding()),
      GetPage(
          name: '/RequestStatusScreen',
          page: () => RequestStatusScreen(),
          binding: RequestStatusBinding()),
      GetPage(
          name: '/FavoriteScreen',
          page: () => FavoriteScreen(),
          binding: FavoriteBinding()),
      GetPage(
          name: '/NotificationScreen',
          page: () => NotificationScreen(),
          binding: NotificationBinding()),
      GetPage(
          name: '/FreindsScreen',
          page: () => FreindsScreen(),
          binding: FreindsBinding()),
      GetPage(
          name: '/InviteFreindsScreen',
          page: () => const InviteFriendsScreen(),
          binding: InviteFriendsBinding()),
      GetPage(
          name: '/EditProfileScreen',
          page: () => EditProfileScreen(),
          binding: EditProfileBinding()),
      GetPage(
        name: '/VenueDetailesForUserScreen',
        page: () => VenueDetailesForUserScreen(),
      ),
      GetPage(
        name: '/TypeToSetEventScreen',
        page: () => TypeToSetEventScreen(),
      ),
      GetPage(
          name: '/EditProfileServiceProviderScreen',
          page: () => EditProfileServiceProviderScreen(),
          binding: EditProfileServiceProviderBinding()),
      GetPage(
          name: '/BookingDetailesForMyBookingScreen',
          page: () => BookingDetailesForMyBookingScreen(),
          binding: BookingDetailesForMyBookingBinding()),
      GetPage(
          name: '/MapScreen', page: () => MapScreen(), binding: MapBinding()),
      GetPage(
          name: '/ServiceAccordingDetailesForUserScreen',
          page: () => ServiceAccordingDetailesForUserScreen()),
      GetPage(
          name: '/BookingDetailesScreen',
          page: () => BookingDetailesScreen(),
          binding: BookingDetailesBinding()),
      GetPage(
          name: '/OrganizerCreateProfileScreen',
          page: () => OrganizerCreateProfileScreen(),
          binding: OrganizerCreateProfileBinding()),
      GetPage(
          name: '/ServiceProviderCreateProfileScreen',
          page: () => ServiceProviderCreateProfileScreen(),
          binding: ServiceProviderCreateProfileBinding()),
      GetPage(
          name: '/AccountTypeScreen',
          page: () => AccountTypeScreen(),
          binding: AccountTypeBinding()),
      GetPage(
          name: '/ChangePasswordScreen',
          page: () => ChangePasswordScreen(),
          binding: ChangePasswordBinding()),
      GetPage(
          name: '/OrganizationProfileScreen',
          page: () => OrganizationProfileScreen(),
          binding: OrganizationProfileBinding()),
      GetPage(
          name: '/OrganizerProfileScreen',
          page: () => OrganizerProfileScreen(),
          binding: OrganizerProfileBinding()),
      GetPage(
          name: '/VenueScreen',
          page: () => VenueScreen(),
          binding: VenueBinding()),
      GetPage(
          name: '/VenueDetailesScreen',
          page: () => VenueDetailesScreen(),
          binding: VenueDetailesBinding()),
      GetPage(
          name: '/SwithcToServiceProviderScreen',
          page: () => SwithcToServiceProviderScreen()),
      GetPage(name: '/HelpCenterScreen', page: () => const HelpCenterScreen()),
      GetPage(
          name: '/InviteFreindsToEventScreen',
          page: () => InviteFreindsToEventScreen()),
      GetPage(name: '/AssignFriendsScreen', page: () => AssignFriendsScreen()),
      GetPage(
          name: '/SeeAllServiceCategoryScreen',
          page: () => SeeAllServiceCategoryScreen()),
      GetPage(name: '/ShowInFullScreen', page: () => ShowInFullScreen()),
      GetPage(
          name: '/EditMediaInFolderScreen',
          page: () => EditMediaInFolderScreen()),
      GetPage(
          name: '/ShowAllBookingInEventForOrganizerScreen',
          page: () => ShowAllBookingInEventForOrganizerScreen()),
      GetPage(
          name: '/EventRequestStatusForOrganizerScreen',
          page: () => EventRequestStatusForOrganizerScreen()),
      GetPage(
          name: '/BookingDetailesInEventForOrganizerScreen',
          page: () => BookingDetailesInEventForOrganizerScreen(),
          binding: BookingDetailesInEventForOrganizerBinding()),
      GetPage(
          name: '/MyEventsForOrganizerScreen',
          page: () => MyEventsForOrganizerScreen(),
          binding: MyEventsForOrganizerBinding()),
      GetPage(
          name: '/SeeAllOrganizersScreen',
          page: () => SeeAllOrganizersScreen()),
      GetPage(name: '/SeeAllOffersScreen', page: () => SeeAllOffersScreen()),
      // GetPage(name: '/PaymentScreen', page: () => PaymentScreen()),
      GetPage(
          name: '/AccountPrivacyScreen', page: () => AccountPrivacyScreen()),
      GetPage(name: '/AchivmentScreen', page: () => AchivmentScreen()),
      GetPage(name: '/ChoiceTypeScreen', page: () => ChoiceTypeScreen()),
      GetPage(name: '/AddFriendsScreen', page: () => AddFriendsScreen()),
      GetPage(
          name: '/SetNewPasswordScreen', page: () => SetNewPasswordScreen()),
      GetPage(name: '/SeeAllAmenities', page: () => SeeAllAmenities()),
      GetPage(name: '/SeeLocation', page: () => SeeLocation()),
      GetPage(name: '/GoingScreen', page: () => GoingScreen()),
      GetPage(name: '/DirctionScreen', page: () => DirctionScreen()),
      GetPage(
          name: '/ShowSingleTicketScreen',
          page: () => ShowSingleTicketScreen()),
      GetPage(
          name: '/OrganizerFollowersScreen',
          page: () => OrganizerFollowersScreen()),
      GetPage(name: '/EnterNumberScreen', page: () => EnterNumberScreen()),
      GetPage(
          name: '/VerifyForgetPasswordScreen',
          page: () => VerifyForgetPasswordScreen()),
      GetPage(
          name: '/AccountOrganizerScreen',
          page: () => AccountOrganizerScreen()),
      GetPage(
          name: '/ChoiceOrganizerCategoryScreen',
          page: () => ChoiceOrganizerCategoryScreen()),
      GetPage(
          name: '/AddMediaInFolderScreen',
          page: () => AddMediaInFolderScreen()),
      GetPage(
          name: '/AddMediaInFolderserviceProviderScreen',
          page: () => AddMediaInFolderserviceProviderScreen()),
      GetPage(
          name: '/TicketsInEventForOrganizerScreen',
          page: () => TicketsInEventForOrganizerScreen()),
      GetPage(
          name: '/PaymentScreenInBooking',
          page: () => PaymentScreenInBooking()),
      // GetPage(name: '/vedioReels', page:()=> VedioReels()) ,
      GetPage(name: '/ShowReelScreen', page: () => ShowReelScreen()),
    ];
