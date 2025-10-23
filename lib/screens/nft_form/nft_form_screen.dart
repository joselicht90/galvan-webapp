import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:galvan_webapp/screens/nft_form/nft_form_cubit.dart';

class NftFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  NftFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NftFormCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Crear / Editar NFT')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<NftFormCubit, NftFormState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error!)));
              } else if (state.nft != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('NFT creado correctamente!')),
                );
              }
            },
            builder: (context, state) {
              return FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: 'standardName',
                      decoration: const InputDecoration(
                        labelText: 'Standard Name',
                      ),
                      validator: FormBuilderValidators.required(),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: 'owner',
                      decoration: const InputDecoration(labelText: 'Owner'),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: 'description',
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                      ),
                    ),
                    const SizedBox(height: 8),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: const InputDecoration(labelText: 'Precio'),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.numeric(),
                    ),
                    const SizedBox(height: 16),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final values = _formKey.currentState!.value;
                                final nft = NftWebApp(
                                  id: 0, // backend asignará
                                  name: values['name'],
                                  standardName: values['standardName'],
                                  createdAt: DateTime.now(),
                                  owner: values['owner'],
                                  description: values['description'],
                                  price: values['price'] != null
                                      ? double.tryParse(
                                          values['price'].toString(),
                                        )
                                      : null,
                                );

                                context.read<NftFormCubit>().submit(nft);
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
