
import 'package:cloud_firestore/cloud_firestore.dart';

class References {
  static final constants =
      FirebaseFirestore.instance.doc("constants/Ucjs90Zv9QxLzgcn1byf");
  static final earningConstants =
      FirebaseFirestore.instance.doc("constants/iJCzB0EVp0QV10OPu2Pk");
  static final rates =
      FirebaseFirestore.instance.doc("constants/jmp272WWOAaWp2Zdqola");

  static final lives = FirebaseFirestore.instance.collection("lives");

  static final categorias = FirebaseFirestore.instance.collection("categorias");

  static final users = FirebaseFirestore.instance.collection("users");

  static final purchases = FirebaseFirestore.instance.collection("purchases");

  static final feedback = FirebaseFirestore.instance.collection("feedback");

  static final merchant = FirebaseFirestore.instance.collection("merchant");

  static final products = FirebaseFirestore.instance.collection("products");

  static final reviews = FirebaseFirestore.instance.collection("reviews");

  static final withdrawal = FirebaseFirestore.instance.collection("withdrawal");
}
