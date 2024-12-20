import 'api_config.dart';

class ApiRoutes {
  static final String _baseUrl = ApiConfig.baseURL;

  /// AUTH SERVICE
  static get signup => '$_baseUrl/auth/api/user/signup';
  static get login => '$_baseUrl/auth/api/user/login';
  static get forgotPassword => '$_baseUrl/auth/api/user/forgot-password';
  static get resetPassword => '$_baseUrl/auth/api/user/reset-password';
  static get logout => '$_baseUrl/auth/api/user/logout';
  static get deleteAccount => '$_baseUrl/auth/api/user/deactivate-account';
  static get updateUser => '$_baseUrl/auth/api/user';
  static get verifyEmail => '$_baseUrl/auth/api/user/verify-email';
  static get verifyDisplayName => '$_baseUrl/auth/api/user/verify-display-name';
  static get signUpOTP => '$_baseUrl/auth/api/user/signup-otp';

  /// WALLETS
  static get bankAccountWallet => '$_baseUrl/payment/api/wallet';
  static walletToDefault(String? walletExternalId) => '$_baseUrl/payment/api/wallet/set-default/$walletExternalId';
  static get accountResolution => '$_baseUrl/api-gateway/api/resolve-account-number';

  /// GOOGLE SERVICE
  static String get googleLocation => "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static String get googleLocationDetails => "https://maps.googleapis.com/maps/api/place/details/json";

  /// EXPLORE
  static get exploreSection => '$_baseUrl/vendor/api/homepage/load';
  static seeAllSection(String sectionExternalId) => '$_baseUrl/vendor/api/homepage/see-all/$sectionExternalId';

  /// PRODUCTS
  static String get listProduct => '$_baseUrl/vendor/api/product';
  static String get getProducts => '$_baseUrl/vendor/api/products';
  static String get getBookings => '$_baseUrl/vendor/api/bookings';
  static String requestForItem(String productExternalId) => '$_baseUrl/vendor/api/booking/create/$productExternalId';
  static String deleteProduct(String productExternalId) => '$_baseUrl/vendor/api/product/$productExternalId';
  static String deleteProductPhoto(String productExternalId) => '$_baseUrl/vendor/api/product/delete-image/$productExternalId';
  static String addProductPhoto(String productExternalId) => '$_baseUrl/vendor/api/product/add-image/$productExternalId';
  static String updateProduct(String productExternalId) => '$_baseUrl/vendor/api/product/$productExternalId';
  static String deleteProductPrice(String productExternalId) => '$_baseUrl/vendor/api/product/delete-price/$productExternalId';
  static String getProductsByCategory(String categoryExternalId) => '$_baseUrl/vendor/api/products/category/$categoryExternalId';
  static String getVendorProducts(String? vendorExternalId) => '$_baseUrl/vendor/api/user/products/$vendorExternalId';

  /// BOOKING
  static String requestAcceptance(String bookingExternalId) => '$_baseUrl/vendor/api/booking/confirm/$bookingExternalId';
  static String confirmPickUp(String bookingExternalId) => '$_baseUrl/vendor/api/booking/confirm-pickup/$bookingExternalId';
  static String confirmDropOff(String bookingExternalId) => '$_baseUrl/vendor/api/booking/confirm-dropoff/$bookingExternalId';
  static String sendMessage(String? conversationId) => '$_baseUrl/vendor/api/conversation/send-message/$conversationId';
  static String earlyReturn(String? bookedProductExternalId) => '$_baseUrl/vendor/api/booking/return-early/$bookedProductExternalId';

  /// REVIEWS
  static String createReviews(String bookingProductExternalId) => '$_baseUrl/vendor/api/review/$bookingProductExternalId';

  /// PAYMENTS
  static String get initiatePayment => '$_baseUrl/payment/api/initialize-collection';
  static collectionCallback(String stan) => '$_baseUrl/payment/api/collection/status-check/$stan';

  /// SEARCH
  static String get filter => '$_baseUrl/vendor/api/products/filter';
  static String get searchAll => '$_baseUrl/vendor/api/search';
  static String get searchProducts => '$_baseUrl/vendor/api/search/products';

  /// VERIFICATION
  static String get initializeVerification => '$_baseUrl/auth/api/user/identification/initialize';
  static String get getUserKYC => '$_baseUrl/auth/api/user/identification/getUserKYC';

  /// REVIEW
  static review(String? bookingProductExternalId) => '$_baseUrl/vendor/api/review/$bookingProductExternalId';

  static String getVendorProductsAndReviews(String? userExternalId) => '$_baseUrl/vendor/api/review/vendor-products-reviews/$userExternalId';
  static String getRenterReviews(String? userExternalId) => '$_baseUrl/vendor/api/review/renter-reviews/$userExternalId';
  static String getVendorReviews(String? userExternalId) => '$_baseUrl/vendor/api/review/vendor-reviews/$userExternalId';

  /// user/upload-profile-photo
  static String get addProfileImage => '$_baseUrl/auth/api/user/upload-profile-photo';

  ///!Report
  static String reportBookingWith(String externalId) => "$_baseUrl/vendor/api/report/$externalId";

  ///USER TYPES
  static String get userTypes => "$_baseUrl/auth/api/sys/user-types";
}
