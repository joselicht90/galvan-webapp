import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/screens/login/login_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<LoginCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Galvan Admin Web')),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: context.read<LoginCubit>().formKey,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
          } else if (state.token != null) {
            context.go('/home');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth < 500
                            ? constraints.maxWidth
                            : 800,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              'assets/icons/app_icon.png',
                              height: 100,
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'username',
                            enabled: !state.isLoading,
                            decoration: InputDecoration(labelText: 'Username'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: 'password',
                            enabled: !state.isLoading,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      context.read<LoginCubit>().submit();
                                    },
                              child: Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            ),
          );
        },
      ),
    );
  }
}
