import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stopmcu/models/forms/peserta_form_model.dart';
import 'package:flutter_stopmcu/services/services.dart';

part 'peserta_event.dart';
part 'peserta_state.dart';

class PesertaBloc extends Bloc<PesertaEvent, PesertaState> {
  PesertaBloc() : super(PesertaInitial()) {
    on<PesertaEvent>((event, emit) async {
      if (event is PesertaAdd) {
        try {
          emit(PesertaLoading());
          final res =
              await PesertaServices().addNewPeserta(event.data, event.userUid);
          emit(PesertaSuccess(res!));
        } catch (e) {
          emit(PesertaFailed(e.toString()));
        }
      }

      if (event is PesertaDelete) {
        try {
          emit(PesertaDeletedLoading());
          final res = await PesertaServices().deletePeserta(event.uid);
          emit(PesertaDeletedSuccess(res!));
        } catch (e) {
          emit(PesertaDeletedFailed(e.toString()));
        }
      }
    });
  }
}
