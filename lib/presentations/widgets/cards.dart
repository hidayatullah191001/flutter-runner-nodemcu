part of 'widgets.dart';

class CardPeserta extends StatefulWidget {
  final PesertaModel data;
  const CardPeserta({Key? key, required this.data}) : super(key: key);

  @override
  State<CardPeserta> createState() => _CardPesertaState();
}

class _CardPesertaState extends State<CardPeserta> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(widget.data.uid.toString()),
      onDismissed: (direction) {
        context.read<PesertaBloc>().add(
              PesertaDelete(
                widget.data.uid.toString(),
              ),
            );
      },
      background: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: alertColor,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Hapus data', style: primaryTextStyle),
            const SizedBox(
              width: 5,
            ),
            Icon(Icons.delete, color: primaryTextColor),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(data: widget.data),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          margin: const EdgeInsets.only(
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: background4Color,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.name.toString(),
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
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
      ),
    );
  }
}

class CardsTesPeserta extends StatelessWidget {
  final TesPesertaModel data;
  const CardsTesPeserta({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(data.uid.toString()),
      onDismissed: (direction) {
        context.read<TestBloc>().add(
              DeleteTestPeserta(
                data.uid.toString(),
              ),
            );
      },
      background: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: alertColor,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Hapus data', style: primaryTextStyle),
            const SizedBox(
              width: 5,
            ),
            Icon(Icons.delete, color: primaryTextColor),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: background4Color,
          borderRadius: BorderRadius.circular(
            12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.createdAt.toString(),
              style: primaryTextStyle,
            ),
            Row(
              children: [
                Icon(
                  Icons.arrow_drop_up,
                  color: greenColor,
                  size: 26,
                ),
                Text(
                  data.hasilHitung.toString(),
                  style: primaryTextStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
