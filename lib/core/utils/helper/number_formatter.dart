import 'package:get/get.dart';
import 'package:intl/intl.dart';

String formatPrice(int price) {
  final formatter = NumberFormat('#,##0', Get.locale.toString());
  return formatter.format(price);
}
