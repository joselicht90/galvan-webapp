import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/di/injection.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:galvan_webapp/screens/nft_home/nft_availability_dialog.dart';
import 'package:galvan_webapp/screens/nft_home/nft_home_cubit.dart';
import 'package:go_router/go_router.dart';

class NftHomeScreen extends StatelessWidget {
  const NftHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NftHomeCubit(getIt<ApiService>())..fetchNfts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NFTs'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<NftHomeCubit>().fetchNfts(),
            ),
          ],
        ),
        body: BlocBuilder<NftHomeCubit, NftHomeState>(
          builder: (context, state) {
            final cubit = context.read<NftHomeCubit>();

            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }

            final nfts = state.nfts;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔍 Search bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search NFTs...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: cubit.filterByQuery,
                  ),
                  const SizedBox(height: 16),

                  if (nfts.isEmpty)
                    const Expanded(child: Center(child: Text('No NFTs found')))
                  else
                    Expanded(
                      child: DataTable2(
                        columnSpacing: 16,
                        horizontalMargin: 8,
                        minWidth: 900,
                        sortColumnIndex: state.sortColumnIndex,
                        sortAscending: state.sortAscending,
                        headingRowColor: WidgetStateProperty.all(
                          Colors.grey.shade100,
                        ),
                        columns: [
                          DataColumn(
                            label: const Text('Name'),
                            onSort: (colIndex, asc) =>
                                cubit.sort((n) => n.name, colIndex, asc),
                          ),
                          DataColumn(
                            label: const Text('Standard'),
                            onSort: (colIndex, asc) => cubit.sort(
                              (n) => n.standardName,
                              colIndex,
                              asc,
                            ),
                          ),
                          DataColumn(
                            label: const Text('Owner'),
                            onSort: (colIndex, asc) =>
                                cubit.sort((n) => n.owner ?? '', colIndex, asc),
                          ),
                          DataColumn(
                            label: const Text('Price'),
                            numeric: true,
                            onSort: (colIndex, asc) =>
                                cubit.sort((n) => n.price ?? 0, colIndex, asc),
                          ),
                          DataColumn(
                            label: const Text('Created'),
                            onSort: (colIndex, asc) => cubit.sort(
                              (n) => n.createdAt.millisecondsSinceEpoch,
                              colIndex,
                              asc,
                            ),
                          ),
                          const DataColumn(label: Text('Actions')),
                        ],
                        rows: nfts.map((nft) {
                          return DataRow(
                            cells: [
                              DataCell(Text(nft.name)),
                              DataCell(Text(nft.standardName)),
                              DataCell(Text(nft.owner ?? '-')),
                              DataCell(
                                Text(
                                  nft.price != null
                                      ? '\$${nft.price!.toStringAsFixed(2)}'
                                      : '-',
                                ),
                              ),
                              DataCell(
                                Text(
                                  nft.createdAt.toIso8601String().substring(
                                    0,
                                    10,
                                  ),
                                ),
                              ),
                              DataCell(_buildActions(context, nft, cubit)),
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
        floatingActionButton: BlocBuilder<NftHomeCubit, NftHomeState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () async {
                final cubit = context.read<NftHomeCubit>();
                final result = await context.push('/nfts/new');
                if (result == true) {
                  cubit.fetchNfts();
                }
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActions(
    BuildContext context,
    NftWebApp nft,
    NftHomeCubit cubit,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit, size: 18),
          tooltip: 'Edit',
          onPressed: () async {
            final result = await context.push('/nfts/edit/${nft.id}');
            if (result == true) {
              cubit.fetchNfts();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, size: 18),
          tooltip: 'Delete',
          onPressed: () async {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (_) => DeleteNftDialog(),
            );

            if (confirmed == true) {
              await cubit.deleteNft(nft.id);
              scaffoldMessenger.showSnackBar(
                const SnackBar(content: Text('NFT deleted successfully')),
              );
            }
          },
        ),
        if (!nft.isAvailableNow)
          IconButton(
            icon: const Icon(Icons.play_arrow, size: 18, color: Colors.green),
            tooltip: 'Start Availability',
            onPressed: () async {
              final result = await showDialog<Map<String, DateTime>>(
                context: context,
                builder: (context) => AvailabilityDialog(),
              );
              if (result != null) {
                await cubit.startAvailability(
                  nftId: nft.id,
                  startAt: result['start']!,
                  endAt: result['end']!,
                );
              }
            },
          ),
        if (nft.isAvailableNow)
          IconButton(
            icon: const Icon(Icons.stop, size: 18, color: Colors.red),
            tooltip: 'Stop Availability',
            onPressed: () async {
              await cubit.stopAvailability(nft.id);
            },
          ),
      ],
    );
  }
}

class DeleteNftDialog extends StatelessWidget {
  const DeleteNftDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this NFT?'),
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
