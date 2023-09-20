part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background3Color,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          }
          if (state is AuthFailed) {
            dangerSnackbar(context, state.e);
          }
        },
        builder: (context, state) {
          if (state is AuthSuccess) {
            return SafeArea(
                child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocListener<PesertaBloc, PesertaState>(
                  listener: (context, statePeserta) {
                    if (statePeserta is PesertaSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: greenColor,
                          content: Text('Data berhasil ditambahkan!',
                              style: primaryTextStyle),
                        ),
                      );
                    }
                    if (statePeserta is PesertaDeletedSuccess) {
                      if (statePeserta.check == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: greenColor,
                            content: Text('Data berhasil dihapus!',
                                style: primaryTextStyle),
                          ),
                        );
                      }
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(state.user),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Peserta Terdaftar',
                        style: secondaryTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('peserta')
                              .where('uid_user', isEqualTo: state.user.uid)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                'Something went wrong',
                                style: primaryTextStyle,
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                'Loading...',
                                style: primaryTextStyle,
                              );
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text(
                                  'Data tidak ditemukan',
                                  style: primaryTextStyle,
                                ),
                              );
                            }

                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                PesertaModel peserta = PesertaModel.fromJson(
                                    document.data() as Map<String, dynamic>);
                                return CardPeserta(
                                  data: peserta,
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  )),
            ));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPage(),
          ),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget header(UserModel user) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang',
                style: subtitleTextStyle,
              ),
              Text(
                user.name.toString(),
                style: primaryTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
