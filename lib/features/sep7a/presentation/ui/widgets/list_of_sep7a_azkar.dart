import 'package:flutter/material.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/sep7a_zekr_item.dart';

class ListOfSep7aAzkar extends StatelessWidget {
  const ListOfSep7aAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => Sep7aZekrItem(
          title: AppConstants.initialSep7aAzkar[index].title,
          count: AppConstants.initialSep7aAzkar[index].count.toString(),
          onTap: (){
            Navigator.pushNamed(context, AppRoutingConstances.sep7aCounter);
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: AppConstants.initialSep7aAzkar.length,
      ),
    );
  }
}
