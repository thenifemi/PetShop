import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var textEditingController = TextEditingController();
var maskTextInputFormatter = MaskTextInputFormatter(
    mask: "+## (##) #####-####", filter: {"#": RegExp(r'[0-9]')});
