import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:galvan_webapp/screens/nft_form/nft_form_cubit.dart';
import 'package:go_router/go_router.dart';

class NftFormScreen extends StatefulWidget {
  final int? nftId; // optional, if editing

  const NftFormScreen({super.key, this.nftId});

  @override
  State<NftFormScreen> createState() => _NftFormScreenState();
}

class _NftFormScreenState extends State<NftFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NftFormCubit>()..maybeLoadNft(widget.nftId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.nftId == null ? 'Create NFT' : 'Edit NFT'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<NftFormCubit, NftFormState>(
            listener: (context, state) {
              if (state.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error!),
                    backgroundColor: Colors.red.shade400,
                  ),
                );
              } else if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.isEditMode
                          ? 'NFT updated successfully!'
                          : 'NFT created successfully!',
                    ),
                    backgroundColor: Colors.green.shade400,
                  ),
                );
                context.pop(true);
              }

              // ✅ Update form values dynamically when NFT loads
              if (state.nft != null && _formKey.currentState != null) {
                _formKey.currentState!.patchValue({
                  'name': state.nft!.name,
                  'standardName': state.nft!.standardName,
                  'owner': state.nft!.owner,
                  'description': state.nft!.description,
                  'price': state.nft!.price?.toString(),
                });
              }
            },
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state.isLoading,
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: FormBuilderValidators.required(),
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'standardName',
                          decoration: const InputDecoration(
                            labelText: 'Standard Name',
                          ),
                          validator: FormBuilderValidators.required(),
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'owner',
                          decoration: const InputDecoration(labelText: 'Owner'),
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'description',
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 12),
                        FormBuilderTextField(
                          name: 'price',
                          decoration: const InputDecoration(labelText: 'Price'),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*$'),
                            ),
                          ],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.min(0),
                          ]),
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            label: Text(state.isEditMode ? 'Update' : 'Create'),
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                final values = _formKey.currentState!.value;
                                final newNft = NftWebApp(
                                  id: state.nft?.id ?? 0,
                                  name: values['name'],
                                  standardName: values['standardName'],
                                  createdAt:
                                      state.nft?.createdAt ?? DateTime.now(),
                                  owner: values['owner'],
                                  description: values['description'],
                                  price: values['price'] != null
                                      ? double.tryParse(
                                          values['price'].toString(),
                                        )
                                      : null,
                                );

                                context.read<NftFormCubit>().submit(newNft);
                              }
                            },
                          ),
                        ),
                        if (state.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Helper: load NFT if ID is present
extension on NftFormCubit {
  void maybeLoadNft(int? id) {
    if (id != null && id > 0) {
      loadNft(id);
    }
  }
}
