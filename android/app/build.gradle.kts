plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// android {
//     namespace = "com.example.sarthi_flutter_project"
//     compileSdk = flutter.compileSdkVersion
//     ndkVersion = flutter.ndkVersion
android {
    namespace = "com.example.sarthi_flutter_project"
    compileSdk = 36
   // ndkVersion = "27.0.12077973"
    
    compileOptions {
        //coreLibraryDesugaringEnabled true
      //  isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
       // coreLibraryDesugaringEnabled true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
      //  applicationId = "com.example.sarthi_flutter_project"
      applicationId = "com.sarthiautism"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
      //  minSdk = flutter.minSdkVersion
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
// ← ADD THIS BLOCK BELOW
dependencies {
   
    //coreLibraryDesugaring("com.android.tools.desugar_jdk_libs:1.1.5")
    //coreLibraryDesugaring("com.android.tools.desugar_jdk_libs:2.0.3")
    implementation(platform("com.google.firebase:firebase-bom:32.7.1"))
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
    implementation("com.google.firebase:firebase-analytics-ktx")
      // for SarthiAutism analytics
}