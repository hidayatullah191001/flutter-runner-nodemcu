part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background4Color,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
          if (state is AuthFailed) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
        },
        child: Center(
          child: Container(
            width: 155,
            height: 50,
            child: Image(
              image: AssetImage(
                'assets/logo.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
