# Dog grooming website

## Introduction

A dog grooming website created for [Peluquería canina Mimos](https://maps.app.goo.gl/yRpdAmdiYiBv6Pqc9).

## Features

- Clean Architecture
- Flavors (dev, prod)
- Http client to Api REST ([Dio](https://pub.dev/packages/dio))
- Native launch screen
- App icons configured
- Internationalization translations ([Easy localization](https://pub.dev/packages/easy_localization))
- Routing ([Go Router](https://pub.dev/packages/go_router))
- Dependency injection ([Get it](https://pub.dev/packages/get_it) and [Injectable](https://pub.dev/packages/injectable)).

## Environment

The application has three environments and each one has its own configuration file:

- dev: `.env/dev.json`
- prod: `.env/prod.json`

If you want fork this repository, you have to create your own configuration files and replace the values with your own. Example

```json
{
   "PACKAGE_NAME": "com.example.dev",
   "APP_NAME": "App name Dev",
   "ENVIRONMENT": "dev",
   "GOOGLE_MAPS_API_KEY": "YOUR_API_KEY",
   "SENDGRID_API_KEY": "YOUR_API_KEY",
   "SENDGRID_TEMPLATE_ID": "YOUR_TEMPLATE_ID"
}
```

## Setup

You can use the following commands to setup the project fast:

- Flutter: `sh setup.sh`
- FVM: `sh setup.sh fvm`

### Generate code

If you implement a new injectable file, you have to run the following command to generate the necessary code:

`fvm dart run build_runner build`

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
