import 'translations_key.dart' as key;

class English {

  Map<String, String> get translations => {

      ///Auth Screens
        /// Login Options Screen

        key.login: 'Login',
        key.or: 'Or',
        key.dontHaveAccount: 'Don\'t have an account? ',
        key.signUp: 'Sign Up',
        key.continueWithEmail: 'Continue With Email',

        /// Email Login Screen
        key.email: 'Email',
        key.password: 'Password',
        key.enterCredentials: 'Enter Credentials',

        /// Sign Up - Screen One
        key.fullName: 'Full Name',
        key.phoneNumber: 'Phone No',
        key.confirmPassword: 'Confirm Password',
        key.personalInfo: 'Personal Info',
        key.statedByAdawat: ' stated by Adawat',
        key.byCheckingBox: 'By checking this box, you agree to the ',

        ///Sign Up - Scree Two
        key.houseOrApartment: 'House / Apartment No',
        key.streetOrFloor: 'Street / Floor',
        key.lane: 'Lane',
        key.area: 'Area',
        key.buildingName: 'Building Name',
        key.nearbyLandmark: 'Nearby Landmark',
        key.noteForServiceman: 'Note For Serviceman',
        key.city: 'City',

        /// Sign Up - Screen Three
        key.cardHolderName: 'Cardholder Name:',
        key.cardNumber: 'Card Number:',
        key.cvcNumber: 'CVC:',
        key.skipAndSignUp: 'Skip & Sign Up',

        /// OTP Verification
        key.otpSent: 'An OTP has been sent on your phone number for verification.',
        key.verify: 'Verify',
        key.verification: 'Verification',
        key.resendCode: 'Resend Code',

      /// Appbar & Drawer
      key.welcome: 'Welcome',
      key.home: 'Home',
      key.booking: 'Booking',
      key.inbox: 'Inbox',
      key.notifications: 'Notification',
      key.settings: 'Settings',
      key.wallet: 'Wallet',
      key.myServices: 'My Services',
      key.aboutUs: 'About Us',
      key.support: 'Support',
      key.termsAndConditions: 'Terms & Conditions',
      key.logout: 'Logout',

      /// Home
      key.nextBooking: 'Next Booking',
      key.totalAmount: 'Total Amount',
      key.newBooking: 'New Booking',
      key.totalJobs: 'Total Jobs',
      key.last60DaysEarning: 'Last 60 Days Earning',

      /// All Categories
      key.allCategories: 'All Categories',

      /// Service Details
      key.serviceDetails: 'Service Details',
      key.price: 'Price',
      key.duration: 'Duration',
      key.rating: 'Rating',
      key.discount: 'Discount',
      key.measuringUnit: 'Measuring Unit',
      key.reviews: 'Reviews',
      key.description: 'Description',
      key.serviceDesc: 'Service Description',
      key.serviceRev: 'Service Reviews',
      key.priceDetails: 'Price Details',
      key.selectServiceTime: 'Select Service Time',
      key.selectServiceDate: 'Select Service Date',

      /// Bookings Listing
      key.completed: 'Completed',
      key.cancelled: 'Cancelled',
      key.otherServices: 'Other Services: ',
      key.cancellationDate: 'Cancellation Date',
      key.viewEReceipt: 'View E-Receipt',
      key.addComments: 'Add comments ...',
      key.bookings: 'Bookings',

      /// Single Booking Details
      key.services: 'Services',
      key.startActivity: 'Start Activity',
      key.totalCost: 'Total Cost',
      key.paymentMethod: 'Payment Method',
      key.customerName: 'Customer Name',
      key.additionalPhoneNo: 'Additional Phone No',
      key.bookingDetails: 'Booking Details',

      /// My Services Listing
      key.searchYourService: 'Search Your Service',
      key.selectedServices: 'Selected Services',

      /// Add New Service
      key.addNewService: 'Add New Service',
      key.searchService: 'Search Service',
      key.noServiceFound: 'No Service Found',

      /// Inbox
      key.searchChatByName: 'Search Chat By Name',
      key.noChatsFound: 'No Chats Found',

      /// Chat
      key.typeSomething: 'Type something...',

      /// Settings
      key.personalDetails: 'Personal Details',
      key.changePassword: 'Change Password',
      key.changePhoneNumber: 'Change Phone Number',
      key.language: 'Language',
      key.proceedWithCaution: 'Proceed with Caution',
      key.accountDeleteCaution: 'This action is permanent. You will lose all the data associated with this account\n\n Are you sure you want to proceed?',

      /// Personal Details
      key.saveAndUpdate: 'Save & Update',
      key.iqamaNo: 'Iqama No',
      key.discard: 'Discard',

      /// Bank Cards listing
      key.searchAccount: 'Search Account',
      key.noBankAccountFound: 'No Bank Account Found',
      key.defaultAccount: 'Default Account',
      key.makeDefaultCard: 'Make Default Card',

      /// Edit or Add Account
      key.editAccount: 'Edit Account',
      key.addAccount: 'Add Account',
      key.deleteAccountCaution: 'Proceed with caution. You won\'t be able to retrieve these account details',

      /// Change Password
      key.createNewPassword: 'Create New Password',
      key.newPasswordDiff: 'New password should be different from the old password',
      key.newPassword: 'New Password',

      /// Change Phone Number
      key.changeNumCaution: 'Changing phone number will require you to enter an OTP, and you shall not be able to use your account until it is verified.\n\nDo you wish to proceed?',
      key.enterNewNum: 'Enter new phone number. New number cannot be the same as old number',
      key.addNewNum: 'Add New Number',

      /// Language
      key.searchLanguage: 'Search Language',
      key.noLanguageFound: 'No Language Found',

      /// Support
      key.faq: 'FAQ',
      key.sendEmail: 'Send Email',
      key.liveChat: 'Live Chat',

      /// About Us
      key.whoAreWe: 'Who are we?',

      /// Terms & Conditions
      key.intro: '1. Introduction',
      key.howContractIsFormed: '2. How the contract is formed between you and Adawat?',

      /// Wallet
      key.requested: 'Requested',
      key.payoutsHistory: 'Payouts History',
      key.amountInWallet: '(Amount in Wallet)',
      key.timeColon: 'Time: ',
      key.amountColon: 'Amount: ',
      key.accountTitleColon: 'Account Title: ',
      key.ibanColon: 'IBAN: ',
      key.requestPayout: 'Request Payout',

      /// Payout Request
      key.payoutRequest: 'Payout Request',
      key.selectAccount: 'Select Account',
      key.amount: 'Amount',
      
        /// Select Account
        key.selectBankAccount: 'Select Bank Account',
      
        /// Amount
        key.maxPayoutAmountColon: 'Max Payout Amount: ',
        key.remainingAmountColon: 'Remaining Amount: ',
        key.request: 'Request',

      /// General
      key.cont: 'Continue',
      key.general: 'General',
      key.deleteAccount: 'Delete Account',
      key.confirm: 'Confirm',
      key.bankAccount: 'Bank Account',
      key.bankName: 'Bank Name',
      key.accountIban: 'Account IBAN',
      key.accountTitle: 'Account Title',
      key.showDetails: 'Show Details',
      key.address: 'Address',
      key.label: 'Label',
      key.pickOnMap: 'Pick On Map',
      key.homeWorkOffice: 'Home, Work, Office etc',
      key.text: 'Text',
      key.phone: 'Phone',
      key.hourOrHours: 'hour(s)',
      key.searchBy: 'Search by',
      key.number: 'Number',
      key.languageCode: 'Language Code',
      key.by: 'By',
      key.yes: 'Yes',
      key.no: 'No',
      key.name: 'Name',
      key.proceed: 'Proceed',
      key.date: 'Date',
      key.scheduled: 'Scheduled',
      key.cancel: 'Cancel',
      key.account: 'Account',
      key.sar: 'SAR',
      key.register: 'Register',
      key.quantity: 'Quantity',
      key.submit: 'Submit',
      key.numberAssociatedWithAddress: 'This phone number shall be associated with this address and serviceman shall use this number to contact',
      key.swipeToDelete: 'Swipe left to delete an item',
      key.swipeToEdit: 'Swipe right to edit an item',
      key.tapToRemoveGuider: '(Tap anywhere on the screen to remove guider)',

      /// Error Messages
      key.enterValidPhoneNo: 'Enter Valid Phone Number',
      key.enterValidEmail: 'Enter Valid Email',
      key.fieldIsRequired: 'Field is Required',
      key.ibanLength: 'Invalid IBAN',
      key.acceptTermsError: 'Accept terms to proceed',
      key.passwordLength: 'Password must be 6 characters long',
      key.passwordNotMatching: 'Passwords do not match',
      key.greaterThanTotal: 'Greater than total',
      key.greaterThanMaxPayout: 'Greater than max payout',
      key.invalidIqamaNo: 'Invalid Iqama No'
  };
}