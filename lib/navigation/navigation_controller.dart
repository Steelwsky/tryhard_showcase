import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tryhard_showcase/navigation/routes.dart';

abstract class NavigationController {
  GlobalKey<NavigatorState> get key;

  void pushNamed(String path);

  void pushWithReplacement(String path);

  void pop();
}

class NavigationControllerImplementation implements NavigationController {
  NavigationControllerImplementation({
    required GlobalKey<NavigatorState> key,
    required ValueListenable<bool> isLogged,
  })  : _key = key,
        _isLogged = isLogged {
    _isLogged.addListener(_autoNavigation);
  }

  final GlobalKey<NavigatorState> _key;

  late final ValueListenable<bool> _isLogged;

  void _autoNavigation() {
    if (_isLogged.value == true) {
      Future.delayed(
        const Duration(milliseconds: 400),
      ).whenComplete(
        () => pushWithReplacement(RoutesNames.home),
      );
    }
    if (_isLogged.value == false) {
      pushWithReplacement(RoutesNames.login);
    }
  }

  @override
  GlobalKey<NavigatorState> get key => _key;

  @override
  void pop() {
    Navigator.of(_key.currentState!.context).pop();
  }

  @override
  void pushNamed(String path) {
    Navigator.of(_key.currentState!.context).pushNamed(path);
  }

  @override
  void pushWithReplacement(String path) {
    Navigator.of(_key.currentState!.context).pushNamedAndRemoveUntil(
      path,
      (_) => false,
    );
  }
}
