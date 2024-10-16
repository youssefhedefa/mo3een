import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/add_zekr_to_saved_cubit/add_zekr_to_saved_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/delete_zekr_from_saved_cubit/delete_zekr_from_saved_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_states.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_zekr_item.dart';

class CustomAzkarList extends StatelessWidget {
  const CustomAzkarList({super.key, required this.azkar});

  final List<AzkarModel> azkar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return BlocBuilder<GetAllSavedAzkarCubit, GetAllSavedAzkarState>(
              builder: (context, state) {
            if (state is GetAllSavedAzkarSuccessState) {
              return GestureDetector(
                onTap: () {
                  log(containsAzkar(state.azkarList, azkar[index]).toString());
                },
                child: CustomZekrItem(
                  zekr: azkar[index],
                  isFavorite: containsAzkar(state.azkarList, azkar[index]),
                  onTap: () {
                    if (state.azkarList.contains(azkar[index])) {
                      context
                          .read<DeleteZekrFromSavedCubit>()
                          .deleteZekrFromSaved(zekr: azkar[index])
                          .then(
                        (_) {
                          if (context.mounted) {
                            context
                                .read<GetAllSavedAzkarCubit>()
                                .getAllSavedAzkar();
                          }
                        },
                      );
                      log('message');
                    } else {
                      context
                          .read<AddZekrToSavedCubit>()
                          .addToSaved(zekr: azkar[index])
                          .then(
                        (_) {
                          if (context.mounted) {
                            context
                                .read<GetAllSavedAzkarCubit>()
                                .getAllSavedAzkar();
                          }
                        },
                      );
                    }
                  },
                ),
              );
            }
            return const SizedBox();
          });
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: azkar.length,
      ),
    );
  }

  bool containsAzkar(List<AzkarModel> azkarList, AzkarModel azkar) {
    return azkarList.any((zkr) => zkr.id == azkar.id);
  }
}
