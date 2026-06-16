plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.temp"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.13113456"


    signingConfigs {
        create("release") {
            storeFile = file("../../fire_alert_keystore.jks") // path to your .jks
            storePassword = "12345678"
            keyAlias = "fire_alert_key"
            keyPassword = "12345678"
        }
    }

    defaultConfig {
        applicationId = "com.example.temp"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            // ✅ Kotlin DSL uses isMinifyEnabled, not minifyEnabled
            isMinifyEnabled = true
            // ✅ Kotlin DSL uses isShrinkResources, not shrinkResources
            isShrinkResources = true
            // ✅ proguardFiles() is a function call with parentheses in Kotlin DSL
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:34.1.0"))
    implementation("com.google.firebase:firebase-messaging:23.4.1")
}