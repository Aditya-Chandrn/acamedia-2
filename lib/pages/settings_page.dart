// ignore_for_file: camel_case_types, prefer_const_constructors, unused_import, implementation_imports, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
      ),
    );
  }
}