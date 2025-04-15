import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/transitions/transitions_class.dart';
import 'package:flutter_application_1/views/webview/webview_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AiExePage extends StatelessWidget {
  final String name;
  final String image;
  final String youtubeUrl;
  final String instructionSteps;
  final String? aiModel;

  const AiExePage({
    super.key,
    required this.name,
    required this.image,
    required this.youtubeUrl,
    this.aiModel,
    required this.instructionSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom app bar with image as background
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).height * 0.35,
            pinned: true,
            backgroundColor: const Color(0xff289004),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Color(0xff289004), size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                name,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Hero image with gradient overlay
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                  // Gradient overlay for better text visibility
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          // ignore: deprecated_member_use
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section title
                  Text(
                    "Instructions",
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff289004),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Instruction card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      instructionSteps,
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        height: 1.5,
                        color: const Color(0xff3A4750),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.play_circle_fill),
                          label: Text(
                            'Watch Tutorial',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                page: WebViewPage(url: youtubeUrl),
                                transitionType: TransitionType.slide,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: aiModel == null || aiModel!.isEmpty
                                ? Colors.grey.shade400
                                : const Color(0xff289004),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.model_training),
                          label: Text(
                            'AI Assistant',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: aiModel == null || aiModel!.isEmpty
                              ? null
                              : () {
                                
                                },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Additional tips section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        // ignore: deprecated_member_use
                        color: const Color(0xff289004).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb,
                              color: Color(0xff289004),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Pro Tips",
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff289004),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "• Maintain proper form throughout the exercise\n• Focus on your breathing technique\n• Start with lighter weights and increase gradually\n• Avoid rushing through the movements",
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            height: 1.5,
                            color: const Color(0xff3A4750),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
