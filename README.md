# Dog grooming website

## Introduction

A dog grooming website created for Peluquería canina Mimos.

## Features

- Clean Architecture
- Flavors (dev, prod)
- Http client to Api REST ([Dio](https://pub.dev/packages/dio))
- Native launch screen
- App icons configured
- Internationalization translations ([Easy localization](https://pub.dev/packages/easy_localization))
- Routing ([Go Router](https://pub.dev/packages/go_router))
- MVVM pattern with [Cubit](https://pub.dev/packages/flutter_bloc) for state management
- Dependency injection ([Get it](https://pub.dev/packages/get_it) and [Injectable](https://pub.dev/packages/injectable)).

## Environment

The application has three environments and each one has its own configuration file:

- dev: `.env/dev.dart`
- prod: `.env/prod.dart`

## Setup

You can use the following commands to setup the project fast:

- Flutter (recommended): `sh setup.sh`
- FVM: `sh setup.sh fvm`

### Generate code

If you implement a new injectable file, you have to run the following command to generate the necessary code:

`fvm flutter packages pub run build_runner build`

Also, you can configure Android Studio to run this command automatically:

1. On the configuration, add a new "External tool" execution step in the "before launch" section.
2. Configure the execution step as follows:
   1. Name: injectable
   2. Description: Run injects before launch
   3. Program: flutter
   4. Arguments: packages pub run build_runner build
   5. Working directory: $ProjectFileDir$

Is important to note that you have to configure the command for the three flavors.

## Run and build

To run the application in each environment, you can use the following commands:

- dev: `flutter run --flavor dev --dart-define-from-file=.env/dev.json`
- prod: `flutter run --flavor prod --dart-define-from-file=.env/prod.json`

Also, you can configure your IDE to run the application in each environment.
