part of 'pages.dart';

class TesPage extends StatefulWidget {
  final PesertaModel data;
  const TesPage({Key? key, required this.data}) : super(key: key);

  @override
  State<TesPage> createState() => _TesPageState();
}

class _TesPageState extends State<TesPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var data = {};
  final _isHours = true;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  String? hasilHitung;

  @override
  void initState() {
    super.initState();
    getStopwatchStateFromRD();
  }

  getStopwatchStateFromRD() {
    ref.child('Hitung').onValue.listen((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          data = snapshot.value as Map;
        });
      }
    });
  }

  resetStateRD() {
    Map<String, dynamic> newData = {
      'State': '0',
    };
    ref.child('Hitung').set(newData);
  }

  saveData() {
    context.read<TestBloc>().add(
          SimpanTesPeserta(
            TestFormModel(
              hitungMasuk: hasilHitung,
            ),
            widget.data.uid.toString(),
          ),
        );
    Map<String, dynamic> newData = {
      'State': '0',
    };
    ref.child('Hitung').set(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background3Color,
      body: BlocConsumer<TestBloc, TestState>(
        listener: (context, state) {
          if (state is TestFailed) {
            SafeArea(
              child: Center(
                child: Text(state.e, style: primaryTextStyle),
              ),
            );
          }
          if (state is TestSuccess) {
            if (state.check == true) {
              Navigator.pop(context);
            } else {
              AlertDialog(
                title: const Text('Peringatan!'),
                content: const Text('Something went wrong!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            }
          }
        },
        builder: (context, state) {
          if (state is TestLoading) {
            return SafeArea(
              child: Center(
                  child: CircularProgressIndicator(
                color: secondaryColor,
              )),
            );
          }
          return SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  header(context),
                  StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snap) {
                      final value = snap.data!;
                      final displayTime =
                          StopWatchTimer.getDisplayTime(value, hours: _isHours);
                      if (data.isNotEmpty) {
                        if (int.parse(data['State']) == 1) {
                          _stopWatchTimer.onStartTimer();
                        }
                        if (int.parse(data['State']) == 2) {
                          _stopWatchTimer.onStopTimer();
                        }
                        if (int.parse(data['State']) == 0) {
                          _stopWatchTimer.onResetTimer();
                        }
                        hasilHitung = displayTime;
                        return Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 40,
                              ),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage('assets/bg_stopwatch.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                displayTime,
                                style: primaryTextStyle.copyWith(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text('Please Wait');
                      }
                    },
                  ),
                  CustomButtons(
                    onPressed: saveData,
                    title: 'Simpan Hasil Tes',
                  ),
                  CustomButtons(
                    onPressed: resetStateRD,
                    title: 'Reset Tes',
                    marginTop: 15,
                  ),
                ],
              ),
            ),
          );
        },
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
                'Tes Peserta',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Text(
                'Berisi informasi tes peserta',
                style: subtitleTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
