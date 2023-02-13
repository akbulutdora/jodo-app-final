import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class UnauthenticatedWrapperView extends StatelessWidget {
  const UnauthenticatedWrapperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
