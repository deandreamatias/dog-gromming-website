# Dog grooming website

[![Codeberg](https://img.shields.io/badge/Codeberg-2185D0?logo=Codeberg&logoColor=white)](https://codeberg.org/deandreamatias/dog-gromming-website)
[![Paypal donate](https://img.shields.io/badge/paypal-donate-blue)](https://paypal.me/deandreamatias)

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
   "SEND_EMAIL_FUNCTION_URL": "YOUR_FUNCTION_URL"
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

## Firebase Functions

The contact form email is sent by a Cloud Function (`sendEmail` in `functions/`) that reads its Resend API key from Cloud Secret Manager, so the key is never bundled in the web client.

### One-time setup: create the secret

1. Install and log in to the [Firebase CLI](https://firebase.google.com/docs/cli):
   `firebase login`
2. From the repo root, set the secret value (prompts for input):
   `firebase functions:secrets:set RESEND_API_KEY`
3. Build the functions once before deploying (the CI pipeline deploys the
   prebuilt output, but there is no automatic build predeploy hook):
   `npm --prefix functions run build`
4. The function already references it via the `secrets` option
   (`functions/src/index.ts`), so no code change is needed. Redeploy it once
   for the change to take effect:
   `firebase deploy --only functions`

After deploying, copy the function URL printed by the CLI into
`SEND_EMAIL_FUNCTION_URL` in your `.env/*.json` files.

### Local development with the emulator

Point the emulator at a local secret value instead of Secret Manager:

1. Create `functions/.secret.local` (already gitignored):
   `RESEND_API_KEY=your_key`
2. Start the emulator normally: `firebase emulators:start`

Useful CLI commands: `firebase functions:secrets:access RESEND_API_KEY` to read the value, `firebase functions:secrets:get RESEND_API_KEY` for versions, `firebase functions:secrets:prune` to clean up unreferenced secrets.

For more, see: https://firebase.google.com/docs/functions/config-env#secret-manager
