part of 'peserta_bloc.dart';

abstract class PesertaState extends Equatable {
  const PesertaState();

  @override
  List<Object> get props => [];
}

class PesertaInitial extends PesertaState {}

class PesertaLoading extends PesertaState {}

class PesertaSuccess extends PesertaState {
  final bool check;

  const PesertaSuccess(this.check);
  @override
  List<Object> get props => [check];
}

class PesertaFailed extends PesertaState {
  final String e;
  const PesertaFailed(this.e);
  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class PesertaDeletedLoading extends PesertaState {}

class PesertaDeletedSuccess extends PesertaState {
  final bool check;

  const PesertaDeletedSuccess(this.check);
  @override
  List<Object> get props => [check];
}

class PesertaDeletedFailed extends PesertaState {
  final String e;
  const PesertaDeletedFailed(this.e);
  @override
  // TODO: implement props
  List<Object> get props => [e];
}
