# Rethink DNS Flutter Migration

This project is a migration of the Rethink DNS Android application to Flutter, using a hybrid architecture.

## Architecture

*   **Flutter Frontend**: Handles UI (VPN Toggle, Logs, App List).
*   **Android Native Backend**: Handles VPN Service, Database (Room), and Network Engine (Firestack).
*   **Communication**: MethodChannels and EventChannels via `VpnFlutterBridge`.

## Prerequisites

*   Flutter SDK
*   Android Studio / Android SDK (API 34)
*   JDK 17

## Setup & Run

1.  **Dependencies**:
    Navigate to the project directory:
    ```bash
    cd rethink_flutter
    flutter pub get
    ```

2.  **Android Setup**:
    The Android project relies on the `firestack` library. Ensure you have access to the Maven repositories defined in `android/build.gradle` (or the top-level `build.gradle` if this were a full repo checkout).

    *Note*: This project structure was generated manually. Ensure you have a valid `local.properties` file in `rethink_flutter/android/` pointing to your Android SDK and Flutter SDK if not automatically generated.

3.  **Running the App**:
    ```bash
    flutter run
    ```

## Key Components

*   `lib/main.dart`: Entry point for the Flutter app.
*   `lib/vpn_controller.dart`: Interface to native VPN commands.
*   `android/app/src/main/kotlin/com/celzero/bravedns/service/BraveVPNService.kt`: Ported VPN Service.
*   `android/app/src/main/kotlin/com/celzero/bravedns/service/VpnFlutterBridge.kt`: Bridge between Flutter and Native.

## Features

*   **Start/Stop VPN**: Toggles the native VPN service.
*   **App Blocking**: Toggle blocking status for installed apps (simulated persistence in MVP).
*   **Logs**: View simulated network logs streamed from native.
