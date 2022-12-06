/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************
import 'package:flutter/widgets.dart';

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/camera.svg
  String get camera => 'assets/svg/camera.svg';

  /// File path: assets/svg/logo.svg
  String get logo => 'assets/svg/logo.svg';
}

class Assets {
  Assets._();

  static const AssetGenImage appIcon = AssetGenImage('assets/app_icon.png');
  static const AssetGenImage appIcon1 = AssetGenImage('assets/app_icon1.png');
  static const AssetGenImage appIcon2 = AssetGenImage('assets/app_icon2.png');
  static const AssetGenImage appIcon3 = AssetGenImage('assets/app_icon3.png');
  static const AssetGenImage appIcon4 = AssetGenImage('assets/app_icon4.png');
  static const AssetGenImage appIcon5 = AssetGenImage('assets/app_icon5.png');
  static const AssetGenImage appIcon6 = AssetGenImage('assets/app_icon6.png');
  static const AssetGenImage appIcon7 = AssetGenImage('assets/app_icon7.png');
  static const AssetGenImage appIconForeground = AssetGenImage('assets/app_icon_foreground.png');
  static const AssetGenImage apple = AssetGenImage('assets/apple.png');
  static const AssetGenImage background = AssetGenImage('assets/background.png');
  static const AssetGenImage google = AssetGenImage('assets/google.png');
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');
  static const $AssetsSvgGen svg = $AssetsSvgGen();
  static const String thload = 'assets/thload.riv';
  static const String whistle = 'assets/whistle.mp3';
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
