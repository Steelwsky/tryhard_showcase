import 'package:fluttertoast/fluttertoast.dart';
import 'package:tryhard_showcase/app/ui/styles/colors.dart';

Future<void> showServiceToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.backgroundSecondary,
    textColor: AppColors.white,
    fontSize: 16.0,
  );
}
