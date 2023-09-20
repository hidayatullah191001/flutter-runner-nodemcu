part of 'pages.dart';

class DetailPage extends StatefulWidget {
  final PesertaModel data;
  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<List<Map<String, dynamic>>> fetchDataFromFirestore() async {
    final firestore = FirebaseFirestore.instance;
    final querySnapshot = await firestore
        .collection('hitung')
        .where('uid_peserta', isEqualTo: widget.data.uid)
        .get();

    final dataList = querySnapshot.docs.map((document) {
      return document.data() as Map<String, dynamic>;
    }).toList();

    return dataList;
  }

  Future<void> generatePdf(PesertaModel? mydata) async {
    final font = await rootBundle.load("assets/fonts/OpenSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    final pdf = pw.Document();
    final data = await fetchDataFromFirestore();

    // Tambahkan halaman ke PDF
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Hasil Tes ${mydata?.name ?? 'Peserta'}',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: 18,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Nama : ${mydata?.name ?? ''}',
                style: pw.TextStyle(
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Email : ${mydata?.email ?? ''}',
                style: pw.TextStyle(
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Usia : ${mydata?.usia ?? ''}',
                style: pw.TextStyle(
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Alamat : ${mydata?.alamat ?? ''}',
                style: pw.TextStyle(
                  font: ttf,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return pw.Container(
                    width: double.infinity,
                    margin: const pw.EdgeInsets.only(bottom: 5),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          data[index]['created_at'].toString(),
                          style: pw.TextStyle(font: ttf),
                        ),
                        pw.Text(
                          'Jumlah Masuk : ${data[index]['hasil_hitung']}',
                          style: pw.TextStyle(font: ttf),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );

    // Dapatkan direktori dokumen aplikasi
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    final now = new DateTime.now();
    // Simpan PDF ke dalam file
    final fileName = '${mydata?.name}-$now.pdf';
    final file = File('$path/$fileName');
    await file.writeAsBytes(await pdf.save());

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
    }

    if (status.isGranted) {
      String filePath = file.path;
      // Menyalin PDF ke direktori unduhan
      final savePath = await FilePicker.platform.getDirectoryPath() ?? "";
      final newFilePath = '$savePath/${mydata?.name}-$now.pdf';
      File(filePath).copySync(newFilePath);
      successSnackbar(context, 'File PDF berhasil diunduh');
    } else {
      dangerSnackbar(context, 'Izin penyimpanan eksternal ditolak.');
    }
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
        child: BlocListener<TestBloc, TestState>(
          listener: (context, state) {
            if (state is DeleteTestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: greenColor,
                  content:
                      Text('Data berhasil dihapus!', style: primaryTextStyle),
                ),
              );
            }

            if (state is TestSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: greenColor,
                  content:
                      Text('Data berhasil disimpan!', style: primaryTextStyle),
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(context, widget.data),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvTNRxAKdj1QyM_mpJdf0fUxxrvimMB-ADAQ&usqp=CAU',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.data.name.toString(),
                          style: primaryTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: medium,
                          ),
                        ),
                        Text(
                          widget.data.email.toString(),
                          style: subtitleTextStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usia',
                            style: secondaryTextStyle,
                          ),
                          Text(
                            '${widget.data.usia} Tahun',
                            style: primaryTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alamat',
                            style: secondaryTextStyle,
                          ),
                          Text(
                            '${widget.data.alamat}',
                            style: primaryTextStyle.copyWith(
                              fontWeight: medium,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('hitung')
                      .where('uid_peserta', isEqualTo: widget.data.uid)
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                        'Something went wrong',
                        style: primaryTextStyle,
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        TesPesertaModel hitung = TesPesertaModel.fromJson(
                            document.data() as Map<String, dynamic>);
                        return CardsTesPeserta(data: hitung);
                      }).toList(),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                alignment: Alignment.bottomCenter,
                child: CustomButtons(
                  onPressed: () async {
                    final value = Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TesPage(
                          data: widget.data,
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        value;
                      });
                    });
                  },
                  title: 'Lakukan Tes Sekarang',
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget header(BuildContext context, PesertaModel data) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                    'Data Peserta',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'Berisi informasi peserta',
                    style: subtitleTextStyle,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              generatePdf(data);
            },
          )
        ],
      ),
    );
  }
}
