import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/byteplex_repository.dart';
import '../../../../data/repository/models/request_model.dart';

part 'contact_form_state.dart';

class ContactFormCubit extends Cubit<ContactFormState> {
  ContactFormCubit() : super(ContactFormInitial());

  final ByteplexRepo _repo = ByteplexRepo();

  Future<void> sendForm(RequestModel requestModel) async {
    emit(ContactFormLoading());
    try {
      final statusCode = await _repo.sendRequest(requestModel);

      if (statusCode == 201) {
        emit(ContactFormSuccess());
      } else {
        emit(ContactFormError('Server error: $statusCode'));
      }
    } catch (e) {
      emit(ContactFormError('Error: $e'));
    }
  }
}
