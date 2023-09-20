part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class SimpanTesPeserta extends TestEvent {
  final TestFormModel data;
  final String pesertaUid;
  const SimpanTesPeserta(this.data, this.pesertaUid);

  @override
  List<Object> get props => [data, pesertaUid];
}

class DeleteTestPeserta extends TestEvent {
  final String uid;
  const DeleteTestPeserta(this.uid);

  @override
  // TODO: implement props
  List<Object> get props => [uid];
}
