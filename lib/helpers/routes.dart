import 'package:adawat_provider_app/screens/account_settings/account_settings_view.dart';
import 'package:adawat_provider_app/screens/add_service/add_service_view.dart';
import 'package:adawat_provider_app/screens/appbar_and_drawer/appbar_and_drawer_view.dart';
import 'package:adawat_provider_app/screens/auth/email_login/email_login_view.dart';
import 'package:adawat_provider_app/screens/auth/sign_up/screen_one/screen_one_view.dart';
import 'package:adawat_provider_app/screens/bank_accounts/bank_accounts_listing/bank_accounts_listing_view.dart';
import 'package:adawat_provider_app/screens/bank_accounts/edit_or_add_account/edit_or_add_account_view.dart';
import 'package:adawat_provider_app/screens/bookings_listing/bookings_listing_view.dart';
import 'package:adawat_provider_app/screens/inbox/inbox_view.dart';
import 'package:adawat_provider_app/screens/my_services_listing/my_services_listing_view.dart';
import 'package:adawat_provider_app/screens/notifications/notifications_view.dart';
import 'package:adawat_provider_app/screens/payout_request/amount/amount_view.dart';
import 'package:adawat_provider_app/screens/wallet/wallet_view.dart';
import 'package:get/get.dart';
import '../screens/about_us/about_us_view.dart';
import '../screens/auth/login_options/login_options_view.dart';
import '../screens/auth/sign_up/screen_three/screen_three_view.dart';
import '../screens/auth/sign_up/screen_two/screen_two_view.dart';
import '../screens/change_password/change_password_view.dart';
import '../screens/change_phone_number/change_phone_number_view.dart';
import '../screens/chat/chat_view.dart';
import '../screens/language/language_view.dart';
import '../screens/payout_request/select_account/select_account_view.dart';
import '../screens/personal_details/personal_details_view.dart';
import '../screens/single_booking/single_booking_view.dart';
import '../screens/support/support_view.dart';
import '../screens/terms_&_conditions/terms_and_conditions_view.dart';

class AppRoutes {

  static const initRoute = '/';
  static const loginWithEmail = '/loginWithEmail';
  static const signUpScreenOne = '/signUpScreenOne';
  static const signUpScreenTwo = '/signUpScreenTwo';
  static const signUpScreenThree = '/signUpScreenThree';
  static const otpVerification = '/otpVerification';
  static const appBarAndDrawer = '/appBarAndDrawer';
  static const chat = '/chat';
  static const personalDetails = '/personalDetails';
  static const addressListing = '/addressListing';
  static const bankAccountsListing = '/bankCardsListing';
  static const changePassword = '/changePassword';
  static const changePhoneNumber = '/changePhoneNumber';
  static const language = '/language';
  static const support = '/support';
  static const aboutUs = '/aboutUs';
  static const termsAndConditions = '/termsAndConditions';
  static const editOrAddAccount = '/editOrAddAddress';
  static const serviceDetails = '/serviceDetails';
  static const bookingDetails = '/bookingDetails';
  static const notifications = '/notifications';
  static const bookingsList = '/bookingsList';
  static const myServicesListing = '/myServicesListing';
  static const addService = '/addService';
  static const inbox = '/inbox';
  static const accountSettings = '/accountSettings';
  static const wallet = '/wallet';
  static const selectAccount = '/payoutRequest';
  static const amount = '/amount';

  static final pages = [
    GetPage(name: initRoute, page: () => LoginOptionsView()),
    GetPage(name: loginWithEmail, page: () => EmailLoginView()),
    GetPage(name: signUpScreenOne, page: () => ScreenOneView()),
    GetPage(name: signUpScreenTwo, page: () => ScreenTwoView()),
    GetPage(name: signUpScreenThree, page: () => ScreenThreeView()),
    GetPage(name: appBarAndDrawer, page: () => const AppbarAndDrawerView()),
    GetPage(name: bookingsList, page: () => BookingsListingView()),
    GetPage(name: myServicesListing, page: () => MyServicesListingView()),
    GetPage(name: addService, page: () => AddServiceView()),
    // GetPage(name: otpVerification, page: () => OtpVerificationView()),
    GetPage(name: chat, page: () => ChatView()),
    GetPage(name: personalDetails, page: () => PersonalDetailsView()),
    GetPage(name: editOrAddAccount, page: () => EditOrAddAccountView()),
    GetPage(name: bankAccountsListing, page: () => BankAccountsListingView()),
    GetPage(name: changePassword, page: () => ChangePasswordView()),
    GetPage(name: changePhoneNumber, page: () => ChangePhoneNumberView()),
    GetPage(name: language, page: () => const LanguageView()),
    GetPage(name: support, page: () => const SupportView()),
    GetPage(name: aboutUs, page: () => const AboutUsView()),
    GetPage(name: termsAndConditions, page: () => const TermsAndConditionsView()),
    GetPage(name: bookingDetails, page: () => SingleBookingView()),
    GetPage(name: notifications, page: () => const NotificationsView()),
    GetPage(name: inbox, page: () => InboxView()),
    GetPage(name: accountSettings, page: () => AccountSettingsView()),
    GetPage(name: wallet, page: () => WalletView()),
    GetPage(name: selectAccount, page: () => SelectAccountView()),
    GetPage(name: amount, page: () => AmountView()),
  ];
}