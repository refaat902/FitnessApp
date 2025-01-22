import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isKgSelected = true;
  bool isCmSelected = true;
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: MediaQuery.sizeOf(context).height * .2,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("edit profile",
                  style: Theme.of(context).textTheme.titleLarge),
              background: Container(color: const Color(0xffFCFCFC)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.sizeOf(context).height * .03,
                      top: MediaQuery.sizeOf(context).height * .03,
                      left: MediaQuery.sizeOf(context).width * .03,
                      right: MediaQuery.sizeOf(context).width * .03),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Full Name",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "John Welles",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Phone",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "0103651478",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Email address",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "johnwelles@gmail.com",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Weight",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: isKgSelected
                                ? 'Enter weight in KG'
                                : 'Enter weight in LBS',
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.sizeOf(context).width * .02),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isKgSelected = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isKgSelected
                                            ? Colors.white
                                            : Colors.grey[300],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(8)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.sizeOf(context).height *
                                                .01,
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .02,
                                      ),
                                      child: Text(
                                        'KG',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: isKgSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isKgSelected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !isKgSelected
                                            ? Colors.white
                                            : Colors.grey[300],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(8)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.sizeOf(context).height *
                                                .01,
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .02,
                                      ),
                                      child: Text(
                                        'LB',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: !isKgSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Height",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: isCmSelected
                                ? 'Enter weight in FEET'
                                : 'Enter weight in CM',
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.sizeOf(context).width * .02),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCmSelected = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isCmSelected
                                            ? Colors.white
                                            : Colors.grey[300],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                left: Radius.circular(8)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.sizeOf(context).height *
                                                .01,
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .02,
                                      ),
                                      child: Text(
                                        'FEET',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: isKgSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCmSelected = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: !isCmSelected
                                            ? Colors.white
                                            : Colors.grey[300],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            const BorderRadius.horizontal(
                                                right: Radius.circular(8)),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            MediaQuery.sizeOf(context).height *
                                                .01,
                                        horizontal:
                                            MediaQuery.sizeOf(context).width *
                                                .02,
                                      ),
                                      child: Text(
                                        'CM',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: !isCmSelected
                                              ? Colors.black
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // hintText: "*****",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Gender",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
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
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      Row(
                        children: [
                          Text(
                            "Age",
                            style: Theme.of(context).textTheme.labelLarge,
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .01),
                      TextFormField(
                        cursorColor: const Color(0xff289004),
                        decoration: InputDecoration(
                            hintText: "Age",
                            hintStyle: Theme.of(context).textTheme.labelMedium),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .03),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: () {}, child: const Text("save"))),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
