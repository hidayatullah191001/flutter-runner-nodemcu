part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'Daftar Akun',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Silahkan isi untuk membuat akun!',
              style: subtitleTextStyle,
            ),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (route) => false),
              child: Text(
                'Masuk disini',
                style: purpleTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background3Color,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            print(state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return SafeArea(
              child: Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ),
            );
          }
          return SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  CustomForms(
                    title: 'Full Name',
                    icon: Icons.person,
                    hintText: 'Your full name',
                    marginTop: 70,
                    controller: nameController,
                  ),
                  CustomForms(
                    title: 'Email Address',
                    icon: Icons.email,
                    hintText: 'Your email address',
                    controller: emailController,
                  ),
                  CustomForms(
                    title: 'Password',
                    icon: Icons.password,
                    hintText: 'Your password',
                    controller: passwordController,
                    obsecureText: true,
                  ),
                  CustomButtons(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        dangerSnackbar(context,
                            'Nama, email atau password tidak boleh kosong!');
                      } else {
                        context.read<AuthBloc>().add(
                              AuthRegister(
                                SignUpFormModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text),
                              ),
                            );
                      }
                    },
                    title: 'Sign Up',
                  ),
                  const Spacer(),
                  footer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
