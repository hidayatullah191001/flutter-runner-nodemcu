part of 'pages.dart';

class AddPage extends StatefulWidget {
  // String? uidUser;
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final emailController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final usiaController = TextEditingController(text: '');
  final alamatController = TextEditingController(text: '');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    nameController.dispose();
    usiaController.dispose();
    alamatController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background3Color,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              header(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomForms(
                        title: 'Nama Lengkap',
                        icon: Icons.person,
                        hintText: 'Masukkan nama lengkap...',
                        controller: nameController,
                      ),
                      CustomForms(
                        title: 'Email',
                        icon: Icons.email,
                        hintText: 'Masukkan email lengkap...',
                        controller: emailController,
                      ),
                      CustomForms(
                        title: 'Usia',
                        icon: Icons.numbers,
                        hintText: 'Masukkan usia lengkap...',
                        controller: usiaController,
                      ),
                      CustomForms(
                        title: 'Alamat',
                        icon: Icons.location_city,
                        hintText: 'Masukkan alamat lengkap...',
                        controller: alamatController,
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthSuccess) {
                            return CustomButtons(
                              onPressed: () {
                                if (nameController.text.isEmpty ||
                                    emailController.text.isEmpty ||
                                    usiaController.text.isEmpty ||
                                    alamatController.text.isEmpty) {
                                  dangerSnackbar(context,
                                      'Form input tidak boleh kosong!');
                                } else {
                                  context.read<PesertaBloc>().add(
                                        PesertaAdd(
                                          PesertaFormModel(
                                            name: nameController.text,
                                            email: emailController.text,
                                            usia: usiaController.text,
                                            alamat: alamatController.text,
                                          ),
                                          state.user.uid.toString(),
                                        ),
                                      );
                                  Navigator.pop(context);
                                }
                              },
                              title: 'Save Data',
                            );
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: primaryTextColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah Peserta Baru',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Text(
                'Lengkapi form dibawah ini',
                style: subtitleTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
