part of 'widgets.dart';

class CustomForms extends StatelessWidget {
  double marginTop;
  final String title;
  final IconData icon;
  final TextEditingController? controller;
  final String hintText;
  final bool obsecureText;
  CustomForms({
    Key? key,
    this.marginTop = 20,
    required this.title,
    required this.icon,
    this.controller,
    required this.hintText,
    this.obsecureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: background7Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: secondaryColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                        hintText: hintText,
                        hintStyle: subtitleTextStyle,
                      ),
                      obscureText: obsecureText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
