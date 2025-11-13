import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/screens/proof_of_action/proof_of_action_cubit.dart';
import 'package:galvan_webapp/utils/date_time_extension.dart';
import 'package:galvan_webapp/utils/galvan_style_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProofOfActionHomeScreen extends StatelessWidget {
  const ProofOfActionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProofOfActionCubit(getIt<ApiService>())..fetchProofs(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Proof of Action'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<ProofOfActionCubit>().fetchProofs(),
            ),
          ],
        ),
        body: BlocBuilder<ProofOfActionCubit, ProofOfActionState>(
          builder: (context, state) {
            final cubit = context.read<ProofOfActionCubit>();

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            final filtered = state.proofs.where((p) {
              final q = state.searchQuery.toLowerCase();
              return p.email.toLowerCase().contains(q) ||
                  p.walletAddress.toLowerCase().contains(q) ||
                  (p.sponsorEmail ?? '').toLowerCase().contains(q);
            }).toList();

            if (filtered.isEmpty) {
              return const Center(child: Text('No proofs found'));
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Proofs...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: cubit.filterByQuery,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 16,
                      horizontalMargin: 8,
                      minWidth: 1200,
                      sortColumnIndex: state.sortColumnIndex,
                      sortAscending: state.sortAscending,
                      headingRowColor: WidgetStateProperty.all(
                        GalvanColors.lightTurqz.withValues(alpha: 0.5),
                      ),

                      sortArrowIconColor: GalvanColors.white,
                      columns: [
                        DataColumn2(
                          label: Text('Email', style: _headerTextStyle),

                          size: ColumnSize.M,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.email, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Wallet', style: _headerTextStyle),
                          size: ColumnSize.L,
                          fixedWidth: 400,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.walletAddress, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Wallet Type', style: _headerTextStyle),
                          size: ColumnSize.S,
                          fixedWidth: 150,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.walletTypeId, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Image', style: _headerTextStyle),
                          size: ColumnSize.S,
                          fixedWidth: 150,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.imageUrl, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Proof of', style: _headerTextStyle),
                          size: ColumnSize.S,
                          fixedWidth: 150,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.actionType, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Product', style: _headerTextStyle),
                          size: ColumnSize.M,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.nft.name, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Date', style: _headerTextStyle),
                          size: ColumnSize.M,
                          onSort: (i, asc) =>
                              cubit.sort((p) => p.createdAt, i, asc),
                        ),
                        DataColumn2(
                          label: Text('Approved', style: _headerTextStyle),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: Text('Actions', style: _headerTextStyle),
                          size: ColumnSize.M,
                        ),
                      ],
                      rows: filtered.map((p) {
                        return DataRow2(
                          cells: [
                            DataCell(_copyableText(p.email)),
                            DataCell(_copyableText(p.walletAddress)),
                            DataCell(_copyableText(p.walletTypeId.toString())),
                            DataCell(
                              InkWell(
                                onTap: () async {
                                  await launchUrl(Uri.parse(p.imageUrl));
                                },
                                child: Tooltip(
                                  message: p.imageUrl,
                                  child: Center(
                                    child: const Icon(
                                      Icons.open_in_browser,
                                      color: GalvanColors.mainGreen,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(_copyableText(p.actionType)),
                            DataCell(_copyableText(p.nft.name)),
                            DataCell(_copyableText(p.createdAt.formatDate())),
                            DataCell(
                              Builder(
                                builder: (context) {
                                  if (p.approved == true) {
                                    return const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    );
                                  } else {
                                    return Switch(
                                      value: p.approved,
                                      onChanged: (v) async {
                                        await cubit.approveProof(p.id!);
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 18),
                                    tooltip: 'Delete',
                                    onPressed: () async {
                                      final scaffoldMessenger =
                                          ScaffoldMessenger.of(context);
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (_) => _DeleteDialog(),
                                      );
                                      if (confirm == true) {
                                        await cubit.deleteProof(p.id!);
                                        scaffoldMessenger.showSnackBar(
                                          const SnackBar(
                                            content: Text('Proof deleted'),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

TextStyle get _headerTextStyle => const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: GalvanColors.white,
);

class _DeleteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text(
        'Are you sure you want to delete this Proof of Action?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}

/// Texto copiable y con ellipsis si desborda
Widget _copyableText(String text) {
  return Tooltip(
    message: text,
    child: SelectableText(
      text,
      style: const TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
      maxLines: 1,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      textAlign: TextAlign.start,
    ),
  );
}
