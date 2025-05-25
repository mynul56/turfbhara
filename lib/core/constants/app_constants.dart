class AppConstants {
  // App Information
  static const String appName = 'Turf Bhara';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  static const String appDescription = 'A comprehensive futsal turf booking application for Bangladesh market';
  
  // Company Information
  static const String companyName = 'Turf Bhara Ltd.';
  static const String companyEmail = 'support@turfbhara.com';
  static const String companyPhone = '+880-1234-567890';
  static const String companyWebsite = 'https://turfbhara.com';
  
  // API Configuration
  static const String baseUrl = 'https://api.turfbhara.com';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Network Timeout Configuration (in milliseconds)
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String turfsCollection = 'turfs';
  static const String bookingsCollection = 'bookings';
  static const String reviewsCollection = 'reviews';
  static const String paymentsCollection = 'payments';
  static const String notificationsCollection = 'notifications';
  static const String facilitiesCollection = 'facilities';
  static const String slotsCollection = 'slots';
  static const String promocodesCollection = 'promocodes';
  
  // Storage Paths
  static const String userProfileImages = 'user_profiles';
  static const String turfImages = 'turf_images';
  static const String facilityImages = 'facility_images';
  static const String documentImages = 'documents';
  
  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String onboardingKey = 'onboarding_completed';
  static const String notificationKey = 'notifications_enabled';
  static const String locationKey = 'location_enabled';
  static const String biometricKey = 'biometric_enabled';
  static const String searchHistoryKey = 'search_history';
  static const String favoritesTurfsKey = 'favorite_turfs';
  static const String recentBookingsKey = 'recent_bookings';
  
  // Validation Constants
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  static const int maxReviewLength = 1000;
  static const int phoneNumberLength = 11;
  static const String phoneNumberPrefix = '01';
  
  // Booking Constants
  static const int maxAdvanceBookingDays = 30;
  static const int minBookingDurationMinutes = 60;
  static const int maxBookingDurationMinutes = 480; // 8 hours
  static const int slotDurationMinutes = 60;
  static const double minAdvancePaymentPercentage = 20.0;
  static const double maxAdvancePaymentPercentage = 100.0;
  static const int cancellationHours = 24;
  static const int rescheduleHours = 12;
  
  // Payment Constants
  static const double minPaymentAmount = 100.0;
  static const double maxPaymentAmount = 50000.0;
  static const String defaultCurrency = 'BDT';
  static const String currencySymbol = '৳';
  
  // Payment Gateway URLs
  static const String bkashBaseUrl = 'https://checkout.pay.bka.sh';
  static const String nagadBaseUrl = 'https://api.mynagad.com';
  static const String rocketBaseUrl = 'https://rocket.com.bd';
  static const String stripePublishableKey = 'pk_test_...';
  
  // Map Configuration
  static const double defaultLatitude = 23.8103; // Dhaka
  static const double defaultLongitude = 90.4125; // Dhaka
  static const double defaultZoom = 12.0;
  static const double nearbyRadius = 10.0; // km
  static const int maxSearchResults = 50;
  
  // Image Configuration
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int imageQuality = 85;
  static const int thumbnailSize = 300;
  static const List<String> allowedImageFormats = ['jpg', 'jpeg', 'png', 'webp'];
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Cache Configuration
  static const Duration cacheExpiry = Duration(hours: 24);
  static const Duration shortCacheExpiry = Duration(minutes: 30);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB
  
  // Notification Configuration
  static const String fcmTopic = 'all_users';
  static const String bookingReminderTopic = 'booking_reminders';
  static const String promotionsTopic = 'promotions';
  
  // Rating Configuration
  static const double minRating = 1.0;
  static const double maxRating = 5.0;
  static const double defaultRating = 0.0;
  
  // Search Configuration
  static const int maxSearchHistoryItems = 10;
  static const int minSearchQueryLength = 2;
  static const Duration searchDebounceDelay = Duration(milliseconds: 500);
  
  // Social Media Links
  static const String facebookUrl = 'https://facebook.com/turfbhara';
  static const String instagramUrl = 'https://instagram.com/turfbhara';
  static const String twitterUrl = 'https://twitter.com/turfbhara';
  static const String youtubeUrl = 'https://youtube.com/turfbhara';
  static const String linkedinUrl = 'https://linkedin.com/company/turfbhara';
  
  // Support Links
  static const String supportEmail = 'support@turfbhara.com';
  static const String supportPhone = '+880-1234-567890';
  static const String helpCenterUrl = 'https://help.turfbhara.com';
  static const String privacyPolicyUrl = 'https://turfbhara.com/privacy';
  static const String termsOfServiceUrl = 'https://turfbhara.com/terms';
  static const String refundPolicyUrl = 'https://turfbhara.com/refund';
  
  // App Store Links
  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.turfbhara.turf_bhara';
  static const String appStoreUrl = 'https://apps.apple.com/app/turf-bhara/id123456789';
  
  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String serverErrorMessage = 'Server error. Please try again later.';
  static const String timeoutErrorMessage = 'Request timeout. Please try again.';
  
  // Success Messages
  static const String bookingSuccessMessage = 'Booking confirmed successfully!';
  static const String paymentSuccessMessage = 'Payment completed successfully!';
  static const String profileUpdateSuccessMessage = 'Profile updated successfully!';
  static const String reviewSubmitSuccessMessage = 'Review submitted successfully!';
  
  // Feature Flags
  static const bool enableBiometricAuth = true;
  static const bool enablePushNotifications = true;
  static const bool enableLocationServices = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashlytics = true;
  static const bool enableRemoteConfig = true;
  static const bool enableDynamicLinks = true;
  
  // Development Configuration
  static const bool isDebugMode = true;
  static const bool enableLogging = true;
  static const bool enableNetworkLogging = true;
  static const bool enablePerformanceMonitoring = true;
  
  // Regex Patterns
  static const String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^01[3-9]\d{8}$';
  static const String passwordRegex = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';
  static const String nameRegex = r'^[a-zA-Z\s]+$';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String apiDateFormat = 'yyyy-MM-dd';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';
  
  // Business Hours
  static const String businessStartTime = '06:00';
  static const String businessEndTime = '23:00';
  static const List<String> businessDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  
  // Turf Categories
  static const List<String> turfTypes = ['Indoor', 'Outdoor', 'Semi-Indoor'];
  static const List<String> turfSizes = ['5-a-side', '7-a-side', '11-a-side'];
  static const List<String> surfaceTypes = ['Artificial Grass', 'Natural Grass', 'Concrete', 'Rubber'];
  
  // Facilities
  static const List<String> commonFacilities = [
    'Parking',
    'Washroom',
    'Changing Room',
    'Cafeteria',
    'First Aid',
    'Security',
    'WiFi',
    'Air Conditioning',
    'Lighting',
    'Sound System',
    'CCTV',
    'Locker',
    'Shower',
    'Equipment Rental'
  ];
  
  // Districts in Bangladesh
  static const List<String> bangladeshDistricts = [
    'Dhaka', 'Chittagong', 'Sylhet', 'Rajshahi', 'Khulna', 'Barisal', 'Rangpur', 'Mymensingh',
    'Comilla', 'Narayanganj', 'Gazipur', 'Tangail', 'Jamalpur', 'Sherpur', 'Netrokona',
    'Kishoreganj', 'Manikganj', 'Munshiganj', 'Narsingdi', 'Faridpur', 'Gopalganj',
    'Madaripur', 'Rajbari', 'Shariatpur', 'Brahmanbaria', 'Chandpur', 'Lakshmipur',
    'Noakhali', 'Feni', 'Coxs Bazar', 'Bandarban', 'Rangamati', 'Khagrachhari',
    'Bogura', 'Joypurhat', 'Naogaon', 'Natore', 'Nawabganj', 'Pabna', 'Sirajganj',
    'Dinajpur', 'Gaibandha', 'Kurigram', 'Lalmonirhat', 'Nilphamari', 'Panchagarh',
    'Thakurgaon', 'Habiganj', 'Moulvibazar', 'Sunamganj', 'Bagerhat', 'Chuadanga',
    'Jessore', 'Jhenaidah', 'Kushtia', 'Magura', 'Meherpur', 'Narail', 'Satkhira',
    'Barguna', 'Bhola', 'Jhalokati', 'Patuakhali', 'Pirojpur'
  ];
}