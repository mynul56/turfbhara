plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}
android {
    namespace = "com.turfbhara.turf_bhara" // Existing namespace
    compileSdk = flutter.compileSdkVersion // Existing compileSdk

    // Add this line
    ndkVersion = "27.0.12077973" 

    compileOptions { // Existing compileOptions
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions { // Existing kotlinOptions
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.turfbhara.turf_bhara" // Existing applicationId
        minSdk = 23 // Updated minSdk for Firebase compatibility
        targetSdk = flutter.targetSdkVersion // Existing targetSdk
        versionCode = flutter.versionCode // Existing versionCode
        versionName = flutter.versionName // Existing versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Existing signingConfig
        }
    }
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.14.0"))
    
    // Add the dependency for Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")
    
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
