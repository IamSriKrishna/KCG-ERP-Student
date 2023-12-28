// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// class ListTileShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: CircleAvatar(
//           backgroundColor: Colors.white,
//           radius: 20.0,
//         ),
//       ),
//       title: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           color: Colors.white,
//           height: 16.0,
//           width: MediaQuery.of(context).size.width * 0.6,
//           margin: EdgeInsets.only(top: 8.0),
//         ),
//       ),
//       subtitle: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           color: Colors.white,
//           height: 16.0,
//           width: MediaQuery.of(context).size.width * 0.4,
//           margin: EdgeInsets.only(top: 8.0),
//         ),
//       ),
//     );
//   }
// }