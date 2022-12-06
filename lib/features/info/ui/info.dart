import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryhard_showcase/app/constants/keys.dart';
import 'package:tryhard_showcase/app/navigation/routes.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        key: kInfoScreen,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('This is just simple screen page.'),
          TextButton(
            onPressed: () => context.push(RoutePaths.innerPage),
            child: const Text('Go to inner page'),
          ),
        ],
      ),
    );
  }
}
