import 'package:flutter/material.dart';

class SetUpProfilePage extends StatefulWidget {
  const SetUpProfilePage({super.key});

  @override
  State<SetUpProfilePage> createState() => _SetUpProfilePageState();
}

class _SetUpProfilePageState extends State<SetUpProfilePage> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetUp profile'),
      ),
      body: Column(
        children: [
          TextFormField(
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Age",
                hintStyle: Theme.of(context).textTheme.labelMedium),
          ),
          TextFormField(
            readOnly: true,
            cursorColor: const Color(0xff289004),
            decoration: InputDecoration(
              hintText: selectedGender ?? "Gender",
              hintStyle: Theme.of(context).textTheme.labelMedium,
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.sizeOf(context).width * .05),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xffFCFCFC),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  underline: const SizedBox(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  items: ["Male", "Female"]
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ),
              prefixIcon: Icon(
                color: selectedGender == "Male"
                    ? Colors.blue
                    : selectedGender == "Female"
                        ? Colors.pink
                        : Colors.grey,
                selectedGender == "Male"
                    ? Icons.male
                    : selectedGender == "Female"
                        ? Icons.female
                        : Icons.person,
              ),
            ),
          ),
          TextFormField(
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Age",
                hintStyle: Theme.of(context).textTheme.labelMedium),
          ),
          TextFormField(
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Age",
                hintStyle: Theme.of(context).textTheme.labelMedium),
          ),
          TextFormField(
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Age",
                hintStyle: Theme.of(context).textTheme.labelMedium),
          ),
          TextFormField(
            cursorColor: const Color(0xff289004),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Age",
                hintStyle: Theme.of(context).textTheme.labelMedium),
          ),
        ],
      ),
    );
  }
}
