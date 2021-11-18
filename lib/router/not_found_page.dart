import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {
  const WidgetNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("页面不存在"),
      ),
      body: const Center(
        child: Text("页面不存在"),
      ),
    );
  }
}
