import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/di/injection.dart';
import 'package:flutter_application_1/core/helpers/shared_pref_helper.dart';
import 'package:flutter_application_1/core/widgets/pc.dart';
import 'package:flutter_application_1/core/widgets/prs.dart';
import 'package:flutter_application_1/views/navigation/navigation_page.dart';
import 'package:flutter_application_1/views/pageview/pageview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  Future<bool> _checkUserLoggedIn() async {
    return await SharedPrefService.isUserLoggedIn();
  }
  
  Future<bool> _checkPermissions() async {
    return await PermissionService.areAllPermissionsGranted();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 0,
            color: Color(0xffFCFCFC),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff289004)),
            ),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.02,
              horizontal: MediaQuery.of(context).size.width * 0.06,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff696969)),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: const Color(0xffF5F5F5),
          ),
          scaffoldBackgroundColor: const Color(0xffFCFCFC),
          textTheme: TextTheme(
            titleLarge: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
            titleMedium: GoogleFonts.bebasNeue(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            labelLarge: GoogleFonts.montserrat(
              color: const Color(0xff3A4750),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            labelMedium: GoogleFonts.montserrat(
              color: const Color(0xff303841),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            bodySmall: GoogleFonts.dmSans(
              color: const Color(0xff3A4750),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.black),
              textStyle: WidgetStateProperty.all(
                GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
              ),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              textStyle: WidgetStateProperty.all(
                GoogleFonts.bebasNeue(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              backgroundColor: WidgetStateProperty.all(const Color(0xff289004)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<List<bool>>(
          // Use Future.wait to run both checks in parallel
          future: Future.wait([
            _checkUserLoggedIn(),
            _checkPermissions(),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Extract results
            final isLoggedIn = snapshot.data?[0] ?? false;
            final permissionsGranted = snapshot.data?[1] ?? false;

            // If permissions are not granted, show permission screen
            if (!permissionsGranted) {
              return PermissionRequestScreen(isLoggedIn: isLoggedIn);
            }

            // If permissions are granted, proceed based on login status
            return isLoggedIn 
                ? const NavigationPage() 
                : const PageViewWithSlider();
          },
        ),
    );
  }
}