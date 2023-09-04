#!/bin/bash

## Generate coverage report
PROJECT_ROOT_PATH=$1

PACKAGE_LCOV_INFO_PATH=$PROJECT_ROOT_PATH/test_utils/coverage/lcov_tryhard_showcase.info
PACKAGE_TEST_REPORT_PATH=$PROJECT_ROOT_PATH/test_utils/test_reports/tryhard_showcase_test_report.json

sudo mkdir -p $PROJECT_ROOT_PATH/test_utils/coverage/
flutter test --update-goldens --tags=golden
flutter test \
  --no-pub \
  --machine \
  --coverage \
  --coverage-path $PACKAGE_LCOV_INFO_PATH > $PACKAGE_TEST_REPORT_PATH

escapedPath="$(echo $PROJECT_ROOT_PATH | sed 's/\//\\\//g')"

if [[ "$OSTYPE" =~ ^darwin ]]; then
  gsed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
else
  sed -i "s/^SF:lib/SF:$escapedPath\/lib/g" $PACKAGE_LCOV_INFO_PATH
fi