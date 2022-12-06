# TRYHARD app showcase

Repository just shows a small part of TRYHARD app. 

#### Project does not contain keys for the Firebase project. The point is to show the code.

It has two branches:
- master
- bloc


#### If you are interested to check published TRYHARD app you can download it on:
- [Google Play Store](https://play.google.com/store/apps/details?id=com.vadimzadorskii.tryhard)
- [App Store](https://apps.apple.com/us/app/tryhard-workout-calendar/id6443940343)


## About the published app

Published app is designed with:

- Provider;
- ValueNotifiers and ValueListenableBuilders;
- Firebase (Firestore, Auth, Functions, Crashlytics).


## About master branch

Master branch shows a bit of a code to introduce you the way published application was built.
When creating a master branch of this showcase, it was decided to omit Provider. Thus for DI it is just passing repos/controllers inside to a class constructors.
Removing Provider is also simplifies the work with tests.


## About bloc branch

Not so long ago it was decided to refactor the published app to make it more better in terms of code, app structure.
To start with there was a decision to refactor a master branch of the showcase repository at first and then with high probability (please check `Future plans` below) implement it to a published app.
At this moment I have completely refactored a master branch of showcase repository with bloc.

Bloc branch contains same logic and pages but the whole approach to design the app was changed. So it has:
- new app structure;
- flutter_bloc, hydrated_bloc (Used cubits);
- get_it + injectable;
- freezed;
- bloc_test, mocktail, [given_when_then](https://pub.dev/packages/given_when_then) for unit/widget tests;


## Future plans

There are also plans to make this showcase with Riverpod to feel the difference in development.
After that I will switch to published app to apply there a more comfortable approach. 