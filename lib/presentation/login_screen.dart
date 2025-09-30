import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:task_1/controller/login_screen_controller.dart';
import 'package:task_1/domain/user.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({this.accountCreated = false, super.key});

  final bool accountCreated;

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void onSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState?.value;
      await ref
          .read(loginScreenControllerProvider.notifier)
          .login(
            User(
              email: formData?['email'],
              pass: formData?['pass'],
            ),
          );
    } else {
      log('Validation failed');
    }
  }

  void goToSignUp() {
    context.go('/signup');
  }

  @override
  void initState() {
    super.initState();
    if (widget.accountCreated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAccountCreatedSnackBar();
      });
    }
  }

  void showAccountCreatedSnackBar() {
    final snackBar = SnackBar(
      content: Text('Account created successfully! Please log in.'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      loginScreenControllerProvider,
      (_, state) {
        if (state is AsyncError) {
          final error = state.error;
          final snackBar = SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );

    final isLoading = ref.watch(loginScreenControllerProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login To Your Account', style: TextStyle(fontSize: 24)),
              FormBuilderTextField(
                name: 'email',
                enabled: !isLoading,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              FormBuilderTextField(
                name: 'pass',
                enabled: !isLoading,

                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
                obscureText: true,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onSubmit,
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text('Login'),
                ),
              ),
              TextButton(
                onPressed: goToSignUp,
                child: Text('Don\'t have an account? Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
