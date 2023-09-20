part of 'widgets.dart';

void dangerSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: alertColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

void successSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: greenColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}
