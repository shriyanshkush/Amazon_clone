import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response responce,
  required BuildContext buildcontext,
  required VoidCallback onSuccess,
}) {
  switch(responce.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(buildcontext, jsonDecode(responce.body)['msg']);
      break;
    case 500:
      showSnackBar(buildcontext, jsonDecode(responce.body)['error']);
      break;
    default:
      showSnackBar(buildcontext,responce.body);
      break;

  }
}