import 'package:get/get.dart';
import 'package:tida_customer/app/modules/Booking/view/bookings_view.dart';
import 'package:tida_customer/app/modules/Home/bindings/home_binding.dart';
import 'package:tida_customer/app/modules/Home/views/home_view.dart';
import 'package:tida_customer/app/modules/Pinned/bindings/pinned_binding.dart';
import 'package:tida_customer/app/modules/Pinned/views/Pinned_View.dart';
import 'package:tida_customer/app/modules/about_us/bindings/about_us_binding.dart';
import 'package:tida_customer/app/modules/about_us/views/about_us_view.dart';
import 'package:tida_customer/app/modules/academy/bindings/academy_binding.dart';
import 'package:tida_customer/app/modules/academy/bindings/academy_full_details_binding.dart';
import 'package:tida_customer/app/modules/academy/views/academy_full_details_view.dart';
import 'package:tida_customer/app/modules/academy/views/academy_list_view.dart';
import 'package:tida_customer/app/modules/change_password/bindings/change_password_binding.dart';
import 'package:tida_customer/app/modules/change_password/views/change_password_view.dart';
import 'package:tida_customer/app/modules/experience/bindings/experience_details_binding.dart';
import 'package:tida_customer/app/modules/experience/bindings/experience_list_binding.dart';
import 'package:tida_customer/app/modules/experience/views/experience_details_view.dart';
import 'package:tida_customer/app/modules/experience/views/experience_list_view.dart';
import 'package:tida_customer/app/modules/facility/bindings/facility_slots_binding.dart';
import 'package:tida_customer/app/modules/facility/views/facility_slots_view.dart';
import 'package:tida_customer/app/modules/filter_search/bindings/filter_search_binding.dart';
import 'package:tida_customer/app/modules/filter_search/view/filter_view.dart';
import 'package:tida_customer/app/modules/login/bindings/login_bindings.dart';
import 'package:tida_customer/app/modules/login/views/login_view.dart';
import 'package:tida_customer/app/modules/orders/views/order_details.dart';
import 'package:tida_customer/app/modules/profile/bindings/Profile_binding.dart';
import 'package:tida_customer/app/modules/profile/views/profile_view.dart';
import 'package:tida_customer/app/modules/register/bindings/register_binding.dart';
import 'package:tida_customer/app/modules/register/views/register_view.dart';
import 'package:tida_customer/app/modules/search/bindings/Search_binding.dart';
import 'package:tida_customer/app/modules/search/views/search_view.dart';
import 'package:tida_customer/app/modules/settings/bindings/settings_bindings.dart';
import 'package:tida_customer/app/modules/settings/views/settings_view.dart';
import 'package:tida_customer/app/modules/sports/bindings/sports_binding.dart';
import 'package:tida_customer/app/modules/sports/views/sports_view.dart';
import 'package:tida_customer/app/modules/tnc/bindings/tnc_binding.dart';
import 'package:tida_customer/app/modules/tnc/views/tnc_view.dart';
import 'package:tida_customer/app/modules/tournament/bindings/tournament_details_binding.dart';
import 'package:tida_customer/app/modules/tournament/bindings/tournament_list_binding.dart';
import 'package:tida_customer/app/modules/tournament/views/tournament_details_view.dart';
import 'package:tida_customer/app/modules/tournament/views/tournament_list.dart';
import 'package:tida_customer/app/modules/venue/bindings/venue_full_details_binding.dart';
import 'package:tida_customer/app/modules/venue/bindings/venue_list_binding.dart';
import 'package:tida_customer/app/modules/venue/views/venue_full_details_view.dart';
import 'package:tida_customer/app/modules/venue/views/venue_list_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.LOGIN;
  static const LOGIN = Routes.LOGIN;
  static const REGISTER = Routes.REGISTER;
  static const HOME = Routes.HOME;
  static const BOOKEXP = Routes.BOOKEXP;
  static const SPORTS = Routes.SPORTS;
  static const ACADEMY_LIST = Routes.ACADEMY_LIST;
  static const ACADEMY_FULL_DETAILS = Routes.ACADEMY_FULL_DETAILS;
  static const VENUE_FULL_DETAILS = Routes.VENUE_FULL_DETAILS;
  static const VENUE_LIST = Routes.VENUE_LIST;
  static const FACILITY_SLOTS = Routes.FACILITY_SLOTS;
  static const EXPERIENCE_DETAILS = Routes.EXPERIENCE_DETAILS;
  static const EXPERIENCE_LIST = Routes.EXPERIENCE_LIST;
  static const TOURNAMENT_DETAILS = Routes.TOURNAMENT_DETAILS;
  static const TOURNAMENT_LIST = Routes.TOURNAMENT_LIST;
  static const SEARCH_SCREEN = Routes.SEARCH_SCREEN;
  static const FILTER_SCREEN = Routes.FILTER_SCREEN;
  static const PROFILE = Routes.PROFILE;
  static const CHANGE_PASSWORD = Routes.CHANGE_PASSWORD;
  static const ABOUT_US = Routes.ABOUT_US;
  static const FAQ = Routes.FAQ;
  static const TNC = Routes.TNC;
  static const PP = Routes.PP;
  static const SETTINGS = Routes.SETTINGS;
  static const PINNED = Routes.PINNED;
  static const ORDERS = Routes.ORDERS;
  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.BOOKEXP,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPORTS,
      page: () => const SportsView(),
      binding: SportsBinding(),
    ),
    GetPage(
      name: _Paths.ACADEMY_LIST,
      page: () => const AcademyListView(),
      binding: AcademyBinding(),
    ),
    GetPage(
      name: _Paths.ACADEMY_FULL_DETAILS,
      page: () => const AcademyFullDetailsView(),
      binding: AcademyFullDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VENUE_LIST,
      page: () => const VenueListView(),
      binding: VenueListBinding(),
    ),
    GetPage(
      name: _Paths.VENUE_FULL_DETAILS,
      page: () => const VenueFullDetailsView(),
      binding: VenueFullDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FACILITY_SLOTS,
      page: () => const FacilitySlotsView(),
      binding: FacilitySlotsBinding(),
    ),
    GetPage(
      name: _Paths.EXPERIENCE_DETAILS,
      page: () => const ExperienceDetailsView(),
      binding: ExperinceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.EXPERIENCE_LIST,
      page: () => const ExperienceListView(),
      binding: ExperinceListBinding(),
    ),
    GetPage(
      name: _Paths.TOURNAMENT_LIST,
      page: () => const TournamentListView(),
      binding: TournamentListBinding(),
    ),
    GetPage(
      name: _Paths.TOURNAMENT_DETAILS,
      page: () => const TournamentDetailsView(),
      binding: TournamentDetailsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => const FilterSearchView(),
      binding: FilterSearchBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const MyProfile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.PINNED,
      page: () => const PinnedView(),
      binding: PinnedBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => BookingsView(),
      binding: PinnedBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
     GetPage(
      name: _Paths.TNC,
      page: () => const TNCView(),
      binding: TNCBinding(),
    ),
  ];
}
