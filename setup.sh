#!/bin/bash

$1 flutter clean && $1 flutter pub get && $1 dart run build_runner build --delete-conflicting-outputs