#!/bin/sh
pwd
ls -a
cd Quiz
pwd
xcodebuild test -enableCodeCoverage YES -scheme Quiz -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11' ONLY_ACTIVE_ARCH=NO
