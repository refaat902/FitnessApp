import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_request_model.dart';
import 'package:flutter_application_1/views/recomendatios/recomendations_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String? selectedGender;

  // Health condition checkboxes
  bool hasDiabetes = false;
  bool hasHypertension = false;
  bool hasHeartDisease = false;
  bool hasKidneyDisease = false;
  bool hasWeightGain = false;
  bool hasWeightLoss = false;
  bool hasAcne = false;

  String? selectedActivityLevel;
  int? selectedActivityValue;

  String? selectedDietary;
  int? selectedDietaryValue;

  final _formKey = GlobalKey<FormState>();

  // Shortened activity level descriptions to avoid overflow
  final Map<String, int> activityLevelMap = {
    "Sedentary": 0,
    "Lightly active": 1,
    "Moderately active": 2,
    "Very active": 3,
    "Extra active": 4,
  };

  final Map<String, int> dietaryMap = {
    "No specific preference": 0,
    "Vegetarian": 1,
    "Vegan": 2,
    "Keto": 3,
    "paleo": 4,
  };

  // Full descriptions for display elsewhere if needed
  final Map<String, String> activityLevelDescriptions = {
    "Sedentary": "Little or no exercise",
    "Lightly active": "Light exercise/sports 1-3 days/week",
    "Moderately active": "Moderate exercise/sports 3-5 days/week",
    "Very active": "Hard exercise/sports 6-7 days a week",
    "Extra active": "Very hard exercise, physical job or training twice a day",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AiMealCubit, AiMealState>(
        listener: (context, state) {
          // if (state is GetAiMealsSuccessState) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("Profile updated successfully!"),
          //       backgroundColor: Color(0xff289004),
          //     ),
          //   );
          //   // Navigate to result page or handle the response data
          //   // You can add navigation logic here if needed
          // }
        },
        builder: (context, state) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*.03,vertical: MediaQuery.sizeOf(context).height*.02),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildLabel("Weight (KG)"),
                              TextFormField(
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                cursorColor: const Color(0xff289004),
                                decoration: InputDecoration(
                                  hintText: 'Enter weight in KG',
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your weight';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .01,
                              ),
                              _buildLabel("Height (CM)"),
                              TextFormField(
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                cursorColor: const Color(0xff289004),
                                decoration: InputDecoration(
                                  hintText: 'Enter height in CM',
                                  hintStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your height';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .01,
                              ),
                              _buildLabel("Age"),
                              TextFormField(
                                cursorColor: const Color(0xff289004),
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Age",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your age';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Please enter a valid number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),
                              _buildLabel("Gender"),
                              // Using a separate widget for dropdown rather than inside TextFormField
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    isExpanded:
                                        true, // Make the dropdown take full width
                                    hint: Text("Select gender",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    value: selectedGender,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedGender = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your gender';
                                      }
                                      return null;
                                    },
                                    items: ["Male", "Female"]
                                        .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                            value: value,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  value == "Male"
                                                      ? Icons.male
                                                      : Icons.female,
                                                  color: value == "Male"
                                                      ? Colors.blue
                                                      : Colors.pink,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(value),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),
                              _buildLabel("Activity Level"),

                              // Standalone dropdown for activity levels
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true, // Takes full width
                                    hint: Text("Select your activity level",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    value: selectedActivityLevel,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your activity level';
                                      }
                                      return null;
                                    },
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedActivityLevel = newValue;
                                        selectedActivityValue =
                                            activityLevelMap[newValue!];
                                      });
                                    },
                                    items: activityLevelMap.keys
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(value,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              if (activityLevelDescriptions
                                                  .containsKey(value))
                                                Text(
                                                  activityLevelDescriptions[
                                                      value]!,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * .02,
                              ),
                              _buildLabel("Dietary Preference"),

                              // Standalone dropdown for activity levels
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true, // Takes full width
                                    hint: Text("Select your dietary preference",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    value: selectedDietary,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select your dietary preference';
                                      }
                                      return null;
                                    },
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedDietary = newValue;
                                        selectedDietaryValue =
                                            dietaryMap[newValue!];
                                      });
                                    },
                                    items: dietaryMap.keys.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(value,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),
                              _buildLabel(
                                  "Do you have any of these conditions?"),
                              _buildCheckbox("Diabetes", hasDiabetes, (val) {
                                setState(() {
                                  hasDiabetes = val!;
                                });
                              }),
                              _buildCheckbox("Hypertension", hasHypertension,
                                  (val) {
                                setState(() {
                                  hasHypertension = val!;
                                });
                              }),
                              _buildCheckbox("Heart Disease", hasHeartDisease,
                                  (val) {
                                setState(() {
                                  hasHeartDisease = val!;
                                });
                              }),
                              _buildCheckbox("Kidney Disease", hasKidneyDisease,
                                  (val) {
                                setState(() {
                                  hasKidneyDisease = val!;
                                });
                              }),
                              _buildCheckbox("Weight Gain", hasWeightGain,
                                  (val) {
                                setState(() {
                                  hasWeightGain = val!;
                                });
                              }),
                              _buildCheckbox("Weight Loss", hasWeightLoss,
                                  (val) {
                                setState(() {
                                  hasWeightLoss = val!;
                                });
                              }),
                              _buildCheckbox("Acne", hasAcne, (val) {
                                setState(() {
                                  hasAcne = val!;
                                });
                              }),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: _submitForm,
                                        child: const Text("Generate")),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              // if (state is AiMealLoading)
              //   Container(
              //     color: Colors.black.withOpacity(0.3),
              //     child: const Center(
              //       child: CircularProgressIndicator(
              //         color: Color(0xff289004),
              //       ),
              //     ),
              //   ),
            ],
          );
        },
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Validate all input fields
      try {
        BlocProvider.of<AiMealCubit>(context).emitGetAiMeals(
          AiMealRequestModel(
            age: int.parse(ageController.text),
            gender: selectedGender,
            height: int.parse(heightController.text),
            weight: int.parse(weightController.text),
            activity_level: selectedActivityValue,
            has_acne: hasAcne,
            has_diabetes: hasDiabetes,
            has_heart_disease: hasHeartDisease,
            has_hypertension: hasHypertension,
            has_kidney_disease: hasKidneyDisease,
            has_weight_gain: hasWeightGain,
            has_weight_loss: hasWeightLoss,
            dietary_preference: selectedDietaryValue,
          ),
        );
        // await SharedPrefService.setUserProfile(false);

        Navigator.push(
          context,
          CustomPageRoute(
            page: BlocProvider.value(
              value: context
                  .read<AiMealCubit>(), // reuses the same instance with data
              child: const RecomendationsPage(),
            ),
            transitionType: TransitionType.slide,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(title, style: GoogleFonts.montserrat(fontSize: 16)),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xff289004),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }
}
