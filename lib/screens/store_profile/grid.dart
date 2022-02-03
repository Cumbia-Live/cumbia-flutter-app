// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:prueba_kubo/src/models/product.dart';
// import 'package:prueba_kubo/src/tools/colors.dart';
// import 'package:prueba_kubo/src/tools/styles.dart';
// import 'package:prueba_kubo/src/views/home/home_controller.dart';

// class Grid extends StatefulWidget {
//   Grid({this.product});
//   Product product;

//   @override
//   _GridState createState() => _GridState();
// }

// class _GridState extends State<Grid> {
//   HomeController controller = HomeController.con;
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//         childAspectRatio: 0.55,
//       ),
//       itemCount: widget.product.data.length,
//       itemBuilder: (BuildContext context, index) {
//         return CupertinoButton(
//           onPressed: () {
//             controller.toDetail(context, widget.product.data[index]);
//           },
//           padding: index % 2 == 0
//               ? EdgeInsets.only(left: 10)
//               : EdgeInsets.only(right: 10),
//           child: Container(
//             margin: index == 0 || index == 1
//                 ? EdgeInsets.only(top: 10)
//                 : EdgeInsets.only(top: 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               color: Palette.white,
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                   color: Palette.black.withOpacity(0.2),
//                   blurRadius: 6.0,
//                   offset: Offset(0.2, 0.7),
//                 ),
//               ],
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: EdgeInsets.only(right: 15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 10),
//                   Stack(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(
//                           top: (MediaQuery.of(context).size.height * 0.2) - 45,
//                           left: 5,
//                         ),
//                         height: 45,
//                         width: 10,
//                         decoration: BoxDecoration(
//                           color: Palette.mainColor,
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(6),
//                             topLeft: Radius.circular(15),
//                           ),
//                         ),
//                       ),
//                       Stack(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 15),
//                             height: MediaQuery.of(context).size.height * 0.2,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(14),
//                               color: Palette.lightGrey,
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   widget.product.data[index].imagen,
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top:
//                                     (MediaQuery.of(context).size.height * 0.2) -
//                                         40),
//                             child: Container(
//                               margin: EdgeInsets.only(left: 15),
//                               height: 40,
//                               width: 70,
//                               decoration: BoxDecoration(
//                                 color: Palette.mainColor,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(6),
//                                 ),
//                               ),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10),
//                                   child: Text(
//                                       '${widget.product.data[index].valorPromo} %',
//                                       style: Styles.discountStyle),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Container(
//                     margin: EdgeInsets.only(left: 15),
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     child: Text(
//                       widget.product.data[index].nombre,
//                       overflow: TextOverflow.ellipsis,
//                       style: Styles.gridViewStyle1,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15),
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     child: Text(
//                       controller.formatCurrncy(
//                         int.parse(
//                           widget.product.data[index].precio,
//                         ),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       style: Styles.gridViewStyle2,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15),
//                     width: MediaQuery.of(context).size.width * 0.35,
//                     child: Text(
//                       controller.formatCurrncy(
//                         int.parse(
//                               widget.product.data[index].precio,
//                             ) -
//                             (int.parse(
//                                   widget.product.data[index].precio,
//                                 ) *
//                                 int.parse(
//                                   widget.product.data[index].valorPromo,
//                                 ) ~/
//                                 100),
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       style: Styles.gridViewStyle3,
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 25),
//                         child: Icon(
//                           Icons.favorite_outline,
//                           color: Palette.black.withOpacity(0.3),
//                         ),
//                       ),
//                       Icon(
//                         Icons.shopping_basket_outlined,
//                         color: Palette.black.withOpacity(0.3),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
