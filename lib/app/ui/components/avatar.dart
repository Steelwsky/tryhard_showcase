import 'package:flutter/material.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';
import 'package:tryhard_showcase/gen/assets.gen.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.photo,
    this.size = const Size(140, 140),
    this.shadowSize = 5,
    this.onTap,
  }) : super(key: key);
  final String? photo;
  final Size size;
  final double shadowSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(96),
        border: Border.all(
          width: 2,
          color: AppColors.backgroundPrimary,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: shadowSize,
            spreadRadius: shadowSize,
            color: AppColors.primary,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: InkWell(
          onTap: onTap,
          child: _networkPhoto(
            context,
            photo,
          ),
        ),
      ),
    );
  }

  Widget _networkPhoto(
    BuildContext context,
    String? photo,
  ) {
    if (photo == null) {
      return Image.asset(
        Assets.appIcon.path,
      );
    }
    return Image.network(
      photo,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CircularProgressIndicator(
          strokeWidth: 8,
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
              : null,
        );
      },
    );
  }
}
