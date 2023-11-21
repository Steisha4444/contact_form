part of 'contact_form_cubit.dart';

sealed class ContactFormState {}

final class ContactFormInitial extends ContactFormState {}

class ContactFormLoading extends ContactFormState {}

class ContactFormSuccess extends ContactFormState {}

class ContactFormError extends ContactFormState {
  final String errorMessage;

  ContactFormError(this.errorMessage);

  List<Object> get props => [errorMessage];
}
