
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/aimeal/data/cubit/ai_meal_cubit.dart';
import 'package:flutter_application_1/views/aimeal/data/model/ai_meal_request_model.dart';
import 'package:flutter_application_1/views/recomendatios/recomendations_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  
  // Goal selection (only one can be selected)
  String? selectedGoal;

  String? selectedActivityLevel;
  int? selectedActivityValue;

  final _formKey = GlobalKey<FormState>();

  // Shortened activity level descriptions to avoid overflow
  final Map<String, int> activityLevelMap = {
    "Sedentary": 0,
    "Lightly active": 1,
    "Moderately active": 2,
    "Very active": 3,
    "Extra active": 4,
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
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final primaryColor = const Color(0xff289004);
    
    // Calculate responsive values
    final horizontalPadding = screenWidth * 0.04;
    final verticalPadding = screenHeight * 0.02;
    final inputHeight = screenHeight * 0.07;
    final sectionSpacing = screenHeight * 0.025;
    final itemSpacing = screenHeight * 0.015;
    final buttonHeight = screenHeight * 0.06;
    
    return BlocConsumer<AiMealCubit, AiMealState>(
      listener: (context, state) {
        // Listener logic preserved as-is
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information
                      Text(
                        "Basic Information",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Weight
                      Text("Weight (KG)", style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: itemSpacing * 0.5),
                      SizedBox(
                        height: inputHeight,
                        child: TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Enter weight in KG',
                            prefixIcon: Icon(Icons.monitor_weight_outlined, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: inputHeight * 0.25,
                              horizontal: horizontalPadding,
                            ),
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
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Height
                      Text("Height (CM)", style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: itemSpacing * 0.5),
                      SizedBox(
                        height: inputHeight,
                        child: TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Enter height in CM',
                            prefixIcon: Icon(Icons.height, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: inputHeight * 0.25,
                              horizontal: horizontalPadding,
                            ),
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
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Age
                      Text("Age", style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: itemSpacing * 0.5),
                      SizedBox(
                        height: inputHeight,
                        child: TextFormField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            hintText: 'Enter your age',
                            prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: inputHeight * 0.25,
                              horizontal: horizontalPadding,
                            ),
                          ),
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
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Gender
                      Text("Gender", style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: itemSpacing * 0.5),
                      SizedBox(
                        height: inputHeight,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: inputHeight * 0.25,
                              horizontal: horizontalPadding,
                            ),
                          ),
                          hint: const Text("Select gender"),
                          value: selectedGender,
                          isExpanded: true,
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
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    children: [
                                      Icon(
                                        value == "Male" ? Icons.male : Icons.female,
                                        color: value == "Male" ? Colors.blue : Colors.pink,
                                        size: screenWidth * 0.05,
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(value),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Activity Level
                      Text("Activity Level", style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: itemSpacing * 0.5),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.directions_run, color: primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: inputHeight * 0.25,
                            horizontal: horizontalPadding,
                          ),
                        ),
                        hint: const Text("Select your activity level"),
                        value: selectedActivityLevel,
                        isExpanded: true,
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
                            selectedActivityValue = activityLevelMap[newValue!];
                          });
                        },
                        items: activityLevelMap.keys.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(value),
                                if (activityLevelDescriptions.containsKey(value))
                                  Text(
                                    activityLevelDescriptions[value]!,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Colors.grey[600],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: sectionSpacing),
                      
                      // Health Conditions
                      Text(
                        "Health Conditions",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: itemSpacing * 0.5),
                      
                      // Health conditions checkboxes
                      Card(
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: CheckboxListTile(
                                title: const Text("Diabetes"),
                                value: hasDiabetes,
                                onChanged: (val) {
                                  setState(() {
                                    hasDiabetes = val!;
                                  });
                                },
                                activeColor: primaryColor,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                            const Divider(height: 1),
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: CheckboxListTile(
                                title: const Text("Hypertension"),
                                value: hasHypertension,
                                onChanged: (val) {
                                  setState(() {
                                    hasHypertension = val!;
                                  });
                                },
                                activeColor: primaryColor,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                            const Divider(height: 1),
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: CheckboxListTile(
                                title: const Text("Heart Disease"),
                                value: hasHeartDisease,
                                onChanged: (val) {
                                  setState(() {
                                    hasHeartDisease = val!;
                                  });
                                },
                                activeColor: primaryColor,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                            const Divider(height: 1),
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: CheckboxListTile(
                                title: const Text("Kidney Disease"),
                                value: hasKidneyDisease,
                                onChanged: (val) {
                                  setState(() {
                                    hasKidneyDisease = val!;
                                  });
                                },
                                activeColor: primaryColor,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      
                      // Goal Selection
                      Text(
                        "Your Goal",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: itemSpacing * 0.5),
                      Text(
                        "What do you want to achieve?",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: itemSpacing),
                      
                      // Goal selection radio buttons
                      Card(
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: RadioListTile<String>(
                                title: const Text("Weight Loss"),
                                value: "Weight Loss",
                                groupValue: selectedGoal,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGoal = value;
                                  });
                                },
                                activeColor: primaryColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                            const Divider(height: 1),
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: RadioListTile<String>(
                                title: const Text("Weight Gain"),
                                value: "Weight Gain",
                                groupValue: selectedGoal,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGoal = value;
                                  });
                                },
                                activeColor: primaryColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                            const Divider(height: 1),
                            SizedBox(
                              height: inputHeight * 0.8,
                              child: RadioListTile<String>(
                                title: const Text("Treat Acne"),
                                value: "Treat Acne",
                                groupValue: selectedGoal,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGoal = value;
                                  });
                                },
                                activeColor: primaryColor,
                                contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding * 0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      
                      // Generate Button
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenWidth * 0.02),
                            ),
                          ),
                          child: Text(
                            "Generate Meal Plan",
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: verticalPadding),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Check if a goal is selected
      if (selectedGoal == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select your goal"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      try {
        // Convert goal selection to boolean values for API
        bool hasWeightGain = selectedGoal == "Weight Gain";
        bool hasWeightLoss = selectedGoal == "Weight Loss";
        bool hasAcne = selectedGoal == "Treat Acne";
        
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
            dietary_preference: 0, // Default to no preference
          ),
        );

        Navigator.push(
          context,
          CustomPageRoute(
            page: BlocProvider.value(
              value: context.read<AiMealCubit>(),
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
}