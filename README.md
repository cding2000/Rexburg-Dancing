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

### Login Page

![Login Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/236ba8d9-831a-4044-b8b5-722ef13db8e3 "Login Page")

The login page is the first screen users encounter when opening the Rexburg Dancing app. It provides a secure and user-friendly interface for authentication.

### Register Page
![Register Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/4cb25083-9b67-4dc9-9e71-3d970b7c4c35 "Register Page")

New users can easily create an account using the Register Page. The registration process is straightforward, ensuring a smooth onboarding experience.

### Email Verify Page
![Email Verify](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/610320bd-b13a-4671-be5d-94f979a19d4b.png)

New users can verify their account using the Email Verfiy Page. 

### Profile Page
![Profile Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/496efb19-bef0-4374-8c91-474ea80f43ce.png)

The Profile Page allows users to manage their account settings and view personalized information.

### Detail Page
![Detail Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/5381bb4e-58e9-4fef-a1b6-154e63d3e976 "Detail Page")

The Detail Page provides comprehensive information about a selected dance venue. Users can explore ratings, reviews, and additional details to make informed decisions about their dancing experience.

### Comment Page
![Comment Page](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/715dc073-f601-48d2-b773-bf1d6b9e114b.png)

The Comment Page allows users to share their thoughts and feedback about a specific dance venue.

### Song Request
![Song Request](https://github.com/cding2000/Rexburg-Dancing/assets/82928785/e1ea3c82-1c83-46d0-9368-91da06a2d16a.png)

Users can submit song requests to influence the playlist at their favorite dance venues.


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
flutter pub get path_provider
flutter pub get path
flutter pub get share_plus
flutter pub get url_launcher
flutter pub get google_fonts
flutter pub get flutter_rating_bar
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



