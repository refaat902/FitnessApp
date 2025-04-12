import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/fullExerciseCubit/full_exercise_cubit.dart';
import 'package:flutter_application_1/views/navigation/exercise/data/models/exercise_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<ExerciseModel> exercise = [];
  List strengthCategory = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FullExerciseCubit>(context).emitGetAllExercise();
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Full Exercise"),
//       ),
//       body: BlocBuilder<FullExerciseCubit, FullExerciseState>(
//         builder: (context, state) {
//           if (state is FullExerciseSuccessState) {
//             exercise = state.allExerciseList;
//             return ListView.builder(
//               itemCount: exercise.length,
//               itemBuilder: (context, index) {
//                 if (exercise[index].category == 'Strength') {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       color: Colors.amber,
//                       child: Text(exercise[index].category.toString()),
//                     ),
//                   );
//                 }else if(exercise[index].category == 'shoulder '){
//                                     return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: double.infinity,
//                       height: 60,
//                       color: Colors.red,
//                       child: Text(exercise[index].category.toString()),
//                     ),
//                   );

//                 }
//                 // return ListTile(
//                 //   title: Text(exercise[index].category.toString()),
//                 // );
//               },
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Full Exercise"),
      ),
      body: BlocBuilder<FullExerciseCubit, FullExerciseState>(
        builder: (context, state) {
          if (state is FullExerciseSuccessState) {
            exercise = state.allExerciseList;

            // ✅ Extract unique categories
            final Set<String> uniqueCategories = {};
            final List<String> displayCategories = [];

            for (var ex in exercise) {
              if (!uniqueCategories.contains(ex.category)) {
                uniqueCategories.add(ex.category.toString());
                displayCategories.add(ex.category.toString());
              }
            }

            return ListView.builder(
              itemCount: displayCategories.length,
              itemBuilder: (context, index) {
                final category = displayCategories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    color: category.trim().toLowerCase() == 'strength'
                        ? Colors.amber
                        : category.trim().toLowerCase() == 'shoulder'
                            ? Colors.red
                            : Colors.grey[300],
                    child: Center(
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
