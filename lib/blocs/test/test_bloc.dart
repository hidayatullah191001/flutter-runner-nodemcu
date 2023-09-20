import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stopmcu/models/forms/test_form_model.dart';
import 'package:flutter_stopmcu/services/services.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestEvent>((event, emit) async {
      if (event is SimpanTesPeserta) {
        try {
          emit(TestLoading());
          final res = await PesertaServices()
              .saveTesPeserta(event.data, event.pesertaUid);
          emit(TestSuccess(res!));
        } catch (e) {
          emit(TestFailed(e.toString()));
        }
      }

      if (event is DeleteTestPeserta) {
        try {
          emit(TestLoading());
          await PesertaServices().deleteTest(event.uid);
          emit(DeleteTestSuccess());
        } catch (e) {
          emit(TestFailed(e.toString()));
        }
      }
    });
  }
}
