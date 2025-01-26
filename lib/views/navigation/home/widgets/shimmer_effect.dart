// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:shimmer/shimmer.dart';

// Widget buildShimmerPlaceholderForHomePage(BuildContext context) {
//   return Shimmer.fromColors(
//     baseColor: Colors.grey[300]!,
//     highlightColor: Colors.grey[100]!,
//     child: Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width * .03),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: MediaQuery.sizeOf(context).height * .2,
//                 width: MediaQuery.sizeOf(context).width * .9,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerPlaceholderForHomePage(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.sizeOf(context).width * .03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .2,
                  width: MediaQuery.sizeOf(context).width * .9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .01,
                ), // Add space between the container and text
                Container(
                  height: 20,
                  width: MediaQuery.sizeOf(context).width *
                      .6, // Adjust width as needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .01,
                ),
                Container(
                  height: 20,
                  width: MediaQuery.sizeOf(context).width *
                      .3, // Adjust width as needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .2,
                  width: MediaQuery.sizeOf(context).width * .9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .01,
                ), // Add space between the container and text
                Container(
                  height: 20,
                  width: MediaQuery.sizeOf(context).width *
                      .6, // Adjust width as needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * .01,
                ),
                Container(
                  height: 20,
                  width: MediaQuery.sizeOf(context).width *
                      .3, // Adjust width as needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ), 
        ],
      ),
    ),
  );
}
