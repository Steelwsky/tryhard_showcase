import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tryhard_showcase/gen/assets.gen.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.7,
        child: SvgPicture.asset(
          Assets.svg.logo,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height / 4,
        ),
      ),
    );
  }
}
