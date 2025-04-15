// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/category/categorycardio/data/cubit/cardio_cubit.dart';
import 'package:flutter_application_1/views/category/widgets/shimmer_effect.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BlocListCardioPage extends StatelessWidget {
  final bool showArrowBack;
  final int? index;
  
  const BlocListCardioPage({
    super.key, 
    required this.showArrowBack, 
    this.index
  });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
  
    final cardPadding = screenWidth * 0.04; 
    final iconSize = screenWidth * 0.05; 
    final titleFontSize = screenWidth * 0.04; 
    final descriptionFontSize = screenWidth * 0.03; 
    final imageHeight = screenHeight * 0.22;
    final horizontalPadding = screenWidth * 0.04; 
    final verticalPadding = screenHeight * 0.015; 
    final borderRadius = screenWidth * 0.04; 
    final smallBorderRadius = screenWidth * 0.03; 
    final iconContainerSize = screenWidth * 0.1; 
    
    return BlocBuilder<CardioCubit, CardioState>(
      builder: (context, state) {
        if (state is ExeByTypeCardioSuccessState) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, 
              vertical: verticalPadding
            ),
            itemCount: state.exeByTypeList.length,
            itemBuilder: (context, inx) {
              // Check if this is the selected item
              final bool isSelected = index != null && inx == index;
              const Color primaryColor = Color(0xff289004);
              const Color secondaryColor = Color(0xff7FB041);
              const Color cardBgColor = Colors.white;
              
              // Dynamic colors based on selection
              final Color bgColor = isSelected ? primaryColor : cardBgColor;
              final Color textColor = isSelected ? Colors.white : Colors.black87;
              final Color accentColor = isSelected ? Colors.white : secondaryColor;
              
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: verticalPadding * 1.5),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                          ? primaryColor.withOpacity(0.3)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: screenWidth * 0.03,
                      offset: Offset(0, screenHeight * 0.004),
                      spreadRadius: isSelected ? screenWidth * 0.005 : 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: isSelected,
                      iconColor: accentColor,
                      collapsedIconColor: accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      tilePadding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding, 
                        vertical: verticalPadding
                      ),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      childrenPadding: EdgeInsets.zero,
                      title: Row(
                        children: [
                          // Category icon with circular background
                          Container(
                            height: iconContainerSize,
                            width: iconContainerSize,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white.withOpacity(0.2) : secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(smallBorderRadius),
                            ),
                            child: Icon(
                              Icons.sports_gymnastics,
                              color: accentColor,
                              size: iconSize,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.exeByTypeList[inx].name.toString(),
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: titleFontSize,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                // Add a short preview of the description if available
                                if (state.exeByTypeList[inx].description != null && 
                                    state.exeByTypeList[inx].description!.isNotEmpty)
                                  Text(
                                    _truncateText(state.exeByTypeList[inx].description!, 40),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: isSelected ? Colors.white70 : Colors.black54,
                                      fontSize: descriptionFontSize * 0.8,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.white.withOpacity(0.1) 
                                : Colors.grey.withOpacity(0.05),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(borderRadius),
                              bottomRight: Radius.circular(borderRadius),
                            ),
                          ),
                          padding: EdgeInsets.all(cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image with improved UI
                              Stack(
                                children: [
                                  Container(
                                    height: imageHeight,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(smallBorderRadius),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          spreadRadius: screenWidth * 0.002,
                                          blurRadius: screenWidth * 0.025,
                                          offset: Offset(0, screenHeight * 0.005),
                                        ),
                                      ],
                                    ),
                                    child: Hero(
                                      tag: 'meal_image_${state.exeByTypeList[inx].id}',
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(smallBorderRadius),
                                        child: Image.network(
                                          state.exeByTypeList[inx].imageUrl ?? 'assets/images/loading.png',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => Container(
                                            height: imageHeight,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(smallBorderRadius),
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.image_not_supported_outlined,
                                                size: iconSize * 2,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                          ),
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              height: imageHeight,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(smallBorderRadius),
                                                color: Colors.grey.shade100,
                                              ),
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  color: secondaryColor,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Optional: Add a gradient overlay for better text visibility
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: screenHeight * 0.05,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(smallBorderRadius),
                                          bottomRight: Radius.circular(smallBorderRadius),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.5),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: screenHeight * 0.02),
                              
                              // Description section with improved styling
                              Text(
                                'Description',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                  fontSize: titleFontSize,
                                ),
                              ),
                              
                              SizedBox(height: screenHeight * 0.01),
                              
                              Container(
                                padding: EdgeInsets.all(cardPadding),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? Colors.white.withOpacity(0.15) 
                                      : const Color(0xffF5F7F9),
                                  borderRadius: BorderRadius.circular(smallBorderRadius),
                                  border: isSelected
                                      ? Border.all(color: Colors.white.withOpacity(0.1), width: 1)
                                      : null,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.article_outlined,
                                      size: iconSize * 0.9,
                                      color: isSelected ? Colors.white70 : secondaryColor,
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    Expanded(
                                      child: Text(
                                        state.exeByTypeList[inx].description ?? 'No description available',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: isSelected ? Colors.white : Colors.black87,
                                          height: 1.5,
                                          fontSize: descriptionFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onExpansionChanged: (bool expanded) {
                        // Optional: Handle any actions when expanded
                      },
                    ),
                  ),
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
  
  // Helper method to truncate text
  String _truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}