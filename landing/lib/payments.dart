// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:landing/types.dart';
// import 'package:video_player/video_player.dart';
// import 'dart:math' as math;

// import 'main.dart';

// class PaymentOptions extends StatefulWidget {
//   const PaymentOptions({super.key});

//   @override
//   State<PaymentOptions> createState() => _PaymentOptionsState();
// }

// class _PaymentOptionsState extends State<PaymentOptions> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//             child: Text("bank transfer"),
//           ),
//         ),
//         Expanded(
//             child: Column(
//           children: [],
//         ))
//       ],
//     );
//   }
// }

// class Developer extends StatefulWidget {
//   const Developer({super.key});

//   @override
//   State<Developer> createState() => _DeveloperState();
// }

// class _DeveloperState extends State<Developer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     _controller = VideoPlayerController.asset("assets/bg_vid.mp4");
//     // _controller.setLooping(true);
//     _controller.initialize().then((_) async {
//       print("initiated");
//       _controller.play();
//       setState(() {});
//     });
//     _controller.setVolume(0);
//     _controller.setLooping(true);
//     _controller.play();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SizedBox(
//         width: Window.fullWidth,
//         height: Window.fullHeight,
//         child: Column(
//           children: [
//             TopBar(),
//             Expanded(
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     width: Window.fullWidth,
//                     height: Window.fullHeight,
//                     child: Row(
//                       children: [
//                         ClipPath(clipper: TriangleClipper(), child: Image.asset("assets/raw.png")),
//                         Expanded(
//                             child: Stack(
//                           alignment: AlignmentDirectional.center,
//                           children: [
//                             VideoPlayer(_controller),
//                             Container(
//                               color: Colors.black.withOpacity(0.75),
//                             ),
//                             if (_controller.value.isInitialized)
//                               SizedBox(
//                                 width: 400,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                         Transform.rotate(
//                                             angle: -math.pi / 1, child: Center(child: Icon(Icons.format_quote_sharp))),
//                                       ],
//                                     ),
//                                     Text(
//                                       "when see coding\nas an art form",
//                                       style: GoogleFonts.rajdhani(fontSize: 40, fontWeight: FontWeight.w600),
//                                       // style: TextStyle(fontSize: 40),
//                                     ),
//                                     SizedBox(
//                                       height: 15,
//                                     ),
//                                     Text(
//                                       "u begin enjoying\nevery piece u make",
//                                       style: GoogleFonts.rajdhani(fontSize: 40, fontWeight: FontWeight.w600),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Icon(Icons.format_quote_sharp),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                         )),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     color: Colors.black.withOpacity(0.05),
//                   ),
//                   //  InkWell(
//                   //             onTap: (){
//                   //               _controller.play();
//                   //             },
//                   //             child: Container(width: 50,height: 50,
//                   //             color: Colors.red,
//                   //             ),
//                   //           )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TriangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.moveTo(0.0, 0.0);
//     path.lineTo(0.0, size.height);
//     path.lineTo(size.width * 0.70, size.height);
//     path.lineTo(size.width * 0.90, 0.0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(TriangleClipper oldClipper) => false;
// }

// class Downloads extends StatefulWidget {
//   const Downloads({super.key});

//   @override
//   State<Downloads> createState() => _DownloadsState();
// }

// class _DownloadsState extends State<Downloads> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [],
//     );
//   }
// }
