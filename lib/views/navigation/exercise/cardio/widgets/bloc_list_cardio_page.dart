import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/categorystrength/data/cubit/strength_cubit.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListCardioPage extends StatelessWidget {
  final bool showArrowBack;
  final int? index;
  const BlocListCardioPage(
      {super.key, required this.showArrowBack, this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardioCubit, CardioState>(
      builder: (context, state) {
        if (state is ExeByTypeCardioSuccessState) {
          return ListView.builder(
            itemCount: state.exeByTypeList.length,
            itemBuilder: (context, inx) {
              // Check if this is the selected item
              final bool isSelected = index != null && inx == index;

              return Card(
                color: isSelected
                    ? const Color(0xff289004)
                    : const Color(0xffFCFCFC),
                elevation: 0,
                child: ExpansionTile(
                  iconColor: const Color(0xff7FB041),
                  collapsedIconColor: const Color(0xff7FB041),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  title: Row(
                    children: [
                      Text(state.exeByTypeList[inx].name.toString(),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 18,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xff7FB041),
                                  )),
                    ],
                  ),
                  children: [
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                  0.2), // Optional: Adds subtle shadow
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // Changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            state.exeByTypeList[inx].imageUrl ?? 'assets/images/loading.png',
                            width: MediaQuery.sizeOf(context).width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        '${state.exeByTypeList[inx].description}',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                  onExpansionChanged: (bool expanded) {
                    if (expanded) {
                      // Optional: Handle any actions when expanded
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const ShimmerListTile();
        }
      },
    );
  }
}
