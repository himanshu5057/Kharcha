import 'package:flutter/material.dart';

class Transactions {
  String id;
  String title;
  double expense;
  DateTime date;
  Transactions(
      {@required this.id,
      @required this.expense,
      @required this.title,
      @required this.date});
}
