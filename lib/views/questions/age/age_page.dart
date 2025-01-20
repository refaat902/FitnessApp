import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/questions/weight/weight_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int selectedAge = 27;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height * .03,
          top: MediaQuery.sizeOf(context).height * .03,
          left: MediaQuery.sizeOf(context).width * .03,
          right: MediaQuery.sizeOf(context).width * .03,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Step 1 of 9",
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "How old Are you?",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50,
                perspective: 0.005,
                diameterRatio: 1,
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedAge = index + 18;
                  });
                },
                physics: const FixedExtentScrollPhysics(),
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    final age = index + 18;
                    return Center(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * .2,
                        height: MediaQuery.sizeOf(context).height * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: age == selectedAge ? Colors.black : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              age.toString(),
                              style: GoogleFonts.bebasNeue(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: age == selectedAge
                                    ? Colors.white
                                    : const Color(0xff3A4750),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 100,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const WeightPage(),));
                        },
                        child: const Text("Next Step"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
