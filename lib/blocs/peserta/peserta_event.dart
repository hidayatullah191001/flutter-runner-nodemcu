part of 'peserta_bloc.dart';

abstract class PesertaEvent extends Equatable {
  const PesertaEvent();

  @override
  List<Object> get props => [];
}

class PesertaAdd extends PesertaEvent {
  final PesertaFormModel data;
  final String userUid;
  const PesertaAdd(this.data, this.userUid);
  @override
  // TODO: implement props
  List<Object> get props => [data, userUid];
}

class PesertaDelete extends PesertaEvent {
  final String uid;
  const PesertaDelete(this.uid);

  @override
  // TODO: implement props
  List<Object> get props => [uid];
}
