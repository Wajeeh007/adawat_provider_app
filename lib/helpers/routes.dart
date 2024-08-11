import 'package:adawat_provider_app/screens/auth/email_login/email_login_view.dart';
import 'package:adawat_provider_app/screens/auth/sign_up/screen_one/screen_one_view.dart';
import 'package:adawat_provider_app/screens/bookings_listing/bookings_listing_view.dart';
import 'package:adawat_provider_app/screens/my_services_listing/my_services_listing_view.dart';
import 'package:adawat_provider_app/screens/notifications/notifications_view.dart';
import 'package:get/get.dart';
import '../screens/auth/login_options/login_options_view.dart';
import '../screens/auth/sign_up/screen_three/screen_three_view.dart';
import '../screens/auth/sign_up/screen_two/screen_two_view.dart';
import '../screens/single_booking/single_booking_view.dart';

class AppRoutes {

  static const initRoute = '/';
  static const loginWithEmail = '/loginWithEmail';
  static const signUpScreenOne = '/signUpScreenOne';
  static const signUpScreenTwo = '/signUpScreenTwo';
  static const signUpScreenThree = '/signUpScreenThree';
  static const otpVerification = '/otpVerification';
  static const bottomBar = '/bottomBar';
  static const cart = '/cart';
  static const confirmAddress = '/confirmAddress';
  static const paymentMethod = '/paymentMethod';
  static const orderConfirmation = '/orderConfirmation';
  static const categoriesListing = '/categoriesListing';
  static const categoryServicesList = '/categoryServicesList';
  static const popularServices = '/popularServices';
  static const chat = '/chat';
  static const personalDetails = '/personalDetails';
  static const addressListing = '/addressListing';
  static const bankCardsListing = '/bankCardsListing';
  static const changePassword = '/changePassword';
  static const changePhoneNumber = '/changePhoneNumber';
  static const language = '/language';
  static const support = '/support';
  static const aboutUs = '/aboutUs';
  static const termsAndConditions = '/termsAndConditions';
  static const editOrAddAddress = '/editOrAddAddress';
  static const addBankCard = '/addBankCard';
  static const serviceDetails = '/serviceDetails';
  static const bookingDetails = '/bookingDetails';
  static const notifications = '/notifications';
  static const bookingsList = '/bookingsList';
  static const myServicesListing = '/myServicesListing';

  static final pages = [
    GetPage(name: initRoute, page: () => LoginOptionsView()),
    GetPage(name: loginWithEmail, page: () => EmailLoginView()),
    GetPage(name: signUpScreenOne, page: () => ScreenOneView()),
    GetPage(name: signUpScreenTwo, page: () => ScreenTwoView()),
    GetPage(name: signUpScreenThree, page: () => ScreenThreeView()),
    GetPage(name: bookingsList, page: () => BookingsListingView()),
    GetPage(name: myServicesListing, page: () => MyServicesListingView()),
    // GetPage(name: otpVerification, page: () => OtpVerificationView()),
    // GetPage(name: cart, page: () => CartView()),
    // GetPage(name: confirmAddress, page: () => ConfirmAddressView()),
    // GetPage(name: paymentMethod, page: () => PaymentMethodView()),
    // GetPage(name: orderConfirmation, page: () => const ConfirmationView()),
    // GetPage(name: bottomBar, page: () => const BottomAppbarView()),
    // GetPage(name: categoriesListing, page: () => CategoriesListingView()),
    // GetPage(name: categoryServicesList, page: () => const CategoryServicesListView()),
    // GetPage(name: popularServices, page: () => PopularServicesView()),
    // GetPage(name: chat, page: () => ChatView()),
    // GetPage(name: personalDetails, page: () => PersonalDetailsView()),
    // GetPage(name: addressListing, page: () => AddressListingView()),
    // GetPage(name: editOrAddAddress, page: () => EditOrAddAddressView()),
    // GetPage(name: bankCardsListing, page: () => const BankCardListingView()),
    // GetPage(name: changePassword, page: () => const ChangePasswordView()),
    // GetPage(name: changePhoneNumber, page: () => const ChangePhoneNumberView()),
    // GetPage(name: language, page: () => const LanguageView()),
    // GetPage(name: support, page: () => const SupportView()),
    // GetPage(name: aboutUs, page: () => const AboutUsView()),
    // GetPage(name: termsAndConditions, page: () => const TermsAndConditionsView()),
    // GetPage(name: addBankCard, page: () => AddBankCardView()),
    // GetPage(name: serviceDetails, page: () => ServiceDetailsView()),
    GetPage(name: bookingDetails, page: () => const SingleBookingView()),
    GetPage(name: notifications, page: () => const NotificationsView())
  ];
}