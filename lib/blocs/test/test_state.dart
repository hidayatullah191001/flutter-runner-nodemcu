part of 'test_bloc.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestInitial extends TestState {}

class TestLoading extends TestState {}

class TestFailed extends TestState {
  final String e;
  const TestFailed(this.e);
  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class TestSuccess extends TestState {
  final bool check;
  const TestSuccess(this.check);
  @override
  // TODO: implement props
  List<Object> get props => [check];
}

class DeleteTestSuccess extends TestState {}
