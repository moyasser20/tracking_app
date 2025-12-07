import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @floweryRiderApp.
  ///
  /// In en, this message translates to:
  /// **'Flowery Rider App'**
  String get floweryRiderApp;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Flowery Rider App'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @versionText.
  ///
  /// In en, this message translates to:
  /// **'v 6.3.0 - (446)'**
  String get versionText;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHintText;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHintText;

  /// No description provided for @emailIsEmptyErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsEmptyErrorMessage;

  /// No description provided for @emailValidationErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get emailValidationErrorMsg;

  /// No description provided for @passwordRequiredErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredErrorMsg;

  /// No description provided for @passwordValidationErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters and include M#12m'**
  String get passwordValidationErrorMsg;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPasswordTextButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgetPasswordTextButton;

  /// No description provided for @continueAsGuestButton.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuestButton;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @invalidPasswordMsg.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get invalidPasswordMsg;

  /// No description provided for @passwordErrorMatchingMsg.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match!'**
  String get passwordErrorMatchingMsg;

  /// No description provided for @updateText.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateText;

  /// No description provided for @logoutAlertMsg.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutAlertMsg;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logoutConfirmTextCenter.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!'**
  String get logoutConfirmTextCenter;

  /// No description provided for @resetPasswordUnderMsg.
  ///
  /// In en, this message translates to:
  /// **'Password must not be empty and must contain at least 6 characters with one uppercase letter and one number'**
  String get resetPasswordUnderMsg;

  /// No description provided for @emailVerificationScreen.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerificationScreen;

  /// No description provided for @emailVerificationScreenUnderMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter the code that was sent to your\nemail address'**
  String get emailVerificationScreenUnderMsg;

  /// No description provided for @codeReceiveMsgError.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get codeReceiveMsgError;

  /// No description provided for @forgetPasswordUnderText.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email associated with\nyour account'**
  String get forgetPasswordUnderText;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgetPassword;

  /// No description provided for @validationEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get validationEmailErrorMessage;

  /// No description provided for @requiredEmailErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get requiredEmailErrorMessage;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @newPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordLabel;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordHint;

  /// No description provided for @wrongPasswordErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Wrong password, try again'**
  String get wrongPasswordErrorMsg;

  /// No description provided for @applicationSub.
  ///
  /// In en, this message translates to:
  /// **'Your application has been\n submitted!'**
  String get applicationSub;

  /// No description provided for @applicationSubMsg.
  ///
  /// In en, this message translates to:
  /// **'Thank you for providing your application,\n we will review your application and will get back to you soon.'**
  String get applicationSubMsg;

  /// No description provided for @codeLengthError.
  ///
  /// In en, this message translates to:
  /// **'Code must be at least 6 digits'**
  String get codeLengthError;

  /// No description provided for @passwordUpdatedSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordUpdatedSuccessMsg;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @applyTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!!'**
  String get welcome;

  /// No description provided for @joinTeam.
  ///
  /// In en, this message translates to:
  /// **'You want to be a delivery man?\nJoin our team'**
  String get joinTeam;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @firstLegalName.
  ///
  /// In en, this message translates to:
  /// **'First legal name'**
  String get firstLegalName;

  /// No description provided for @firstLegalNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter first legal name'**
  String get firstLegalNameHint;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @secondLegalName.
  ///
  /// In en, this message translates to:
  /// **'Second legal name'**
  String get secondLegalName;

  /// No description provided for @secondLegalNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter second legal name'**
  String get secondLegalNameHint;

  /// No description provided for @secondNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Second name is required'**
  String get secondNameRequired;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type'**
  String get vehicleType;

  /// No description provided for @vehicleInfo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle info'**
  String get vehicleInfo;

  /// No description provided for @noVehiclesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No vehicles available'**
  String get noVehiclesAvailable;

  /// No description provided for @vehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle number'**
  String get vehicleNumber;

  /// No description provided for @vehicleNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter vehicle number'**
  String get vehicleNumberHint;

  /// No description provided for @vehicleNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Vehicle number is required'**
  String get vehicleNumberRequired;

  /// No description provided for @vehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Vehicle license'**
  String get vehicleLicense;

  /// No description provided for @vehicleLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'Upload license photo'**
  String get vehicleLicenseHint;

  /// No description provided for @vehicleLicenseRequired.
  ///
  /// In en, this message translates to:
  /// **'Vehicle license image is required'**
  String get vehicleLicenseRequired;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get phoneHint;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get phoneRequired;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID number'**
  String get idNumber;

  /// No description provided for @idNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter national ID number'**
  String get idNumberHint;

  /// No description provided for @idNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'ID number is required'**
  String get idNumberRequired;

  /// No description provided for @idImage.
  ///
  /// In en, this message translates to:
  /// **'ID image'**
  String get idImage;

  /// No description provided for @idImageHint.
  ///
  /// In en, this message translates to:
  /// **'Upload ID image'**
  String get idImageHint;

  /// No description provided for @idImageRequired.
  ///
  /// In en, this message translates to:
  /// **'ID image is required'**
  String get idImageRequired;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinChars.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get passwordMinChars;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileTitle;

  /// No description provided for @profileUpdatedSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessMsg;

  /// No description provided for @errorText.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorText;

  /// No description provided for @profilePhotoUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated successfully'**
  String get profilePhotoUpdatedSuccessfully;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @passwordChangeText.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get passwordChangeText;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumberLabel;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @savedAddresses.
  ///
  /// In en, this message translates to:
  /// **'Saved Addresses'**
  String get savedAddresses;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @versionInfo.
  ///
  /// In en, this message translates to:
  /// **'v 6.3.0 - (446)'**
  String get versionInfo;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @savedAddress.
  ///
  /// In en, this message translates to:
  /// **'Saved Address'**
  String get savedAddress;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageChanged.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageChanged;

  /// No description provided for @noAboutInfoFound.
  ///
  /// In en, this message translates to:
  /// **'No about info found'**
  String get noAboutInfoFound;

  /// No description provided for @notificationDelete.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get notificationDelete;

  /// No description provided for @noTermsFound.
  ///
  /// In en, this message translates to:
  /// **'No terms found'**
  String get noTermsFound;

  /// No description provided for @errorLoadingTerms.
  ///
  /// In en, this message translates to:
  /// **'Error loading terms'**
  String get errorLoadingTerms;

  /// No description provided for @orderRejectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order rejected successfully'**
  String get orderRejectedSuccessfully;

  /// No description provided for @orderAcceptedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order accepted successfully'**
  String get orderAcceptedSuccessfully;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @unknownAddress.
  ///
  /// In en, this message translates to:
  /// **'Unknown Address'**
  String get unknownAddress;

  /// No description provided for @flowerOrder.
  ///
  /// In en, this message translates to:
  /// **'Flower Order'**
  String get flowerOrder;

  /// No description provided for @pickupAddress.
  ///
  /// In en, this message translates to:
  /// **'Pickup address'**
  String get pickupAddress;

  /// No description provided for @userAddress.
  ///
  /// In en, this message translates to:
  /// **'User address'**
  String get userAddress;

  /// No description provided for @floweryStore.
  ///
  /// In en, this message translates to:
  /// **'Flowery Store'**
  String get floweryStore;

  /// No description provided for @sampleAddress.
  ///
  /// In en, this message translates to:
  /// **'20th st, Sheikh Zayed, Giza'**
  String get sampleAddress;

  /// No description provided for @userNameSample.
  ///
  /// In en, this message translates to:
  /// **'Nour Mohamed'**
  String get userNameSample;

  /// No description provided for @orderPrice.
  ///
  /// In en, this message translates to:
  /// **'EGP 3000'**
  String get orderPrice;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you!!'**
  String get thankYou;

  /// No description provided for @orderDeliveredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'The order delivered\nsuccessfully'**
  String get orderDeliveredSuccessfully;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @recentOrder.
  ///
  /// In en, this message translates to:
  /// **'Recent orders'**
  String get recentOrder;

  /// No description provided for @myOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrdersTitle;

  /// No description provided for @inProgressStatus.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressStatus;

  /// No description provided for @completedStatus.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// No description provided for @cancelledStatus.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatus;

  /// No description provided for @noOrdersFound.
  ///
  /// In en, this message translates to:
  /// **'No orders found'**
  String get noOrdersFound;

  /// No description provided for @recentOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Orders'**
  String get recentOrdersTitle;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get pickupLocation;

  /// No description provided for @apartmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get apartmentLabel;

  /// No description provided for @storeLabel.
  ///
  /// In en, this message translates to:
  /// **'Flowery'**
  String get storeLabel;

  /// No description provided for @backButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButtonTooltip;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currency;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @noOrderData.
  ///
  /// In en, this message translates to:
  /// **'No order data'**
  String get noOrderData;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @unknownStatus.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknownStatus;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
