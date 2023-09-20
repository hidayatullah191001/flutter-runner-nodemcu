part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text(
              'Selamat Datang',
              style:
                  primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Silahkan masuk untuk melanjutkan',
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
              'Belum punya akun? ',
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/register'),
              child: Text(
                'Daftar disini',
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
            dangerSnackbar(context, 'Email atau password salah!');
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
            )));
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
                    title: 'Email Address',
                    icon: Icons.email,
                    controller: emailController,
                    hintText: 'Your Email Address',
                    marginTop: 70,
                  ),
                  CustomForms(
                    title: 'Password',
                    icon: Icons.password,
                    controller: passwordController,
                    hintText: 'Your Password',
                    obsecureText: true,
                  ),
                  CustomButtons(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        dangerSnackbar(
                            context, 'Email atau password tidak boleh kosong!');
                      } else {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                SignInFormModel(
                                    email: emailController.text,
                                    password: passwordController.text),
                              ),
                            );
                      }
                    },
                    title: 'Sign In',
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
