# Rexburg Dancing

Welcome to Rexburg Dancing, a sophisticated cross-platform mobile application crafted to cater to dance enthusiasts who are new to the East Idaho area. Our goal is to provide a seamless experience for users in discovering and engaging with dance venues. The application offers a range of features, including user authentication, venue ratings, song requests, and more.

## Table of Contents

- [Description](#description)
- [Key Features](#key-features)
- [Screenshots](#screenshots)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Contributing](#contributing)

## Description

Rexburg Dancing is an intuitive mobile app designed to assist dance enthusiasts who are new to the area. It facilitates user interactions by providing features such as sign-in, login, password reset, email verification, and detailed information about local dance venues.

## Key Features

- **Venue Discovery:** Be the first to explore dance venues in the area.
- **Rating System:** View ratings assigned by the community for each dance venue.
- **Song Requests:** Users can easily submit song requests to their favorite venues.

## Screenshots

![Login Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/236ba8d9-831a-4044-b8b5-722ef13db8e3)
![Register Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/4cb25083-9b67-4dc9-9e71-3d970b7c4c35)
![Detail Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/5381bb4e-58e9-4fef-a1b6-154e63d3e976)

### Prerequisites

To get started with Rexburg Dancing, make sure you have the following prerequisites:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase Account and Project](https://console.firebase.google.com/)

### Installation

```bash
# Navigate to the main page of the repository
https://github.com/cding2000/Rexburg-Dancing

# Copy the URL for the repository
To clone the repository using HTTPS, click under "HTTPS"

# Open Git Bash

# Change the current working directory to the location where you want the cloned directory.

# Clone the repository
git clone [git@github.com:cding2000/Rexburg-Dancing.git](https://github.com/cding2000/Rexburg-Dancing.git)

# Install dependencies
flutter pub get firebase_core
flutter pub get firebase_auth
flutter pub get cloud_firestore
flutter pub get firebase_analytics
flutter pub get sqflite
flutter pub path_provider
flutter pub path
flutter pub share_plus
flutter pub url_launcher
flutter pub google_fonts
flutter pub flutter_rating_bar
```

## Usage

1. Open the Rexburg Dancing app on your mobile device.
2. Sign in or create a new account to access personalized features.
3. Explore the list of dance venues in the area using the Venue Discovery feature.
4. View and submit ratings for your favorite dance venues.
5. Make song requests to add your favorite tunes to the venue's playlist.
6. Enjoy a seamless and engaging experience with the Rexburg Dancing community!

## Dependencies

- [Flutter](https://flutter.dev/docs/get-started/install): A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

- [Firebase](https://console.firebase.google.com/): A comprehensive platform provided by Google for building and managing mobile and web applications. Rexburg Dancing utilizes the following Firebase packages:

  - `firebase_core`: Essential for initializing and configuring Firebase services.
  - `firebase_auth`: Enables user authentication, including sign-in and password reset functionalities.
  - `cloud_firestore`: A NoSQL database for storing and syncing data in real-time.
  - `firebase_analytics`: Provides analytics services to track user engagement and app performance.

- Other Flutter Packages:

  - `sqflite`: A SQLite database plugin for Flutter, used for local data storage.
  - `path_provider`: A Flutter plugin for finding commonly used locations on the filesystem.
  - `share_plus`: Allows users to share content with other apps.
  - `url_launcher`: Opens URLs in the default web browser.
  - `google_fonts`: Provides a wide variety of fonts from the Google Fonts collection.
  - `flutter_rating_bar`: Implements a simple star rating system for user ratings.

## Contributing

We welcome contributions from the community! If you find a bug, have a feature request, or want to contribute to the development of Rexburg Dancing.



