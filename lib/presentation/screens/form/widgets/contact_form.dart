import '../cubit/contact_form_cubit.dart';
import 'contact_us.dart';
import 'unlock.dart';
import '../../../../utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/models/request_model.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool buttonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactFormCubit, ContactFormState>(
      listener: (context, state) {
        if (state is ContactFormSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is ContactFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'An error occurred.',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text('details: ${state.errorMessage}'),
                ],
              ),
              duration: const Duration(seconds: 4),
            ),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: () => setState(
              () => buttonEnabled = (_emailController.text.isEmpty ||
                  _nameController.text.isEmpty ||
                  _messageController.text.isEmpty),
            ),
            child: Column(
              children: [
                const ContactUs(),
                const SizedBox(height: 16),
                Flexible(
                  child: Row(
                    children: [
                      const Unlock(),
                      Expanded(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: Row(
                    children: [
                      const Unlock(),
                      Expanded(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            if (!value.isValidEmail()) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: Row(
                    children: [
                      const Unlock(),
                      Expanded(
                        child: TextFormField(
                          controller: _messageController,
                          decoration:
                              const InputDecoration(labelText: 'Message'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your message';
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: 280,
                  child: ElevatedButton(
                    onPressed: buttonEnabled
                        ? null
                        : () {
                            final requestModel = RequestModel(
                              name: _nameController.text,
                              email: _emailController.text,
                              message: _messageController.text,
                            );
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<ContactFormCubit>()
                                  .sendForm(requestModel);
                            }
                          },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return states.contains(MaterialState.disabled) ||
                                  state is ContactFormLoading
                              ? const Color.fromARGB(255, 163, 149, 160)
                              : const Color.fromRGBO(152, 109, 142, 1);
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                    child: Text(
                        state is ContactFormLoading ? 'Please wait' : 'Send'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
