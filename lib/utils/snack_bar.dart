import 'package:flutter/material.dart';
import 'package:noteappnew/utils/text_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

successSnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      message: " ✔️ Note Added Successfully",
      backgroundColor: Colors.green,
      textStyle: AppTextTheme.titleTextStyle,
    ));
warningSnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(
      backgroundColor: Colors.orangeAccent,
      message: "Title Must Not Be Empty",
      textStyle: AppTextTheme.titleTextStyle,
    ));
errorSnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      backgroundColor: Colors.red,
      message: "Title Must Not Be Empty",
      textStyle: AppTextTheme.titleTextStyle,
    ));

error1SnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      backgroundColor: Colors.red,
      message: "Something went wrong. Note could not be Added!!",
      textStyle: AppTextTheme.titleTextStyle,
    ));
updateSuccessSnackBar(context) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(
      backgroundColor: Colors.blue,
      message: "Note Successfully Updated!!",
      textStyle: AppTextTheme.titleTextStyle,
    ));
