part of 'widgets.dart';

class CustomButtons extends StatelessWidget {
  void Function()? onPressed;
  final String title;
  double marginTop;
  CustomButtons({
    Key? key,
    required this.onPressed,
    required this.title,
    this.marginTop = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(top: marginTop),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
