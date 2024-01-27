import 'package:fluttertoast/fluttertoast.dart';

Future toast({required String message}) {
  return Fluttertoast.showToast(msg: message);
}
