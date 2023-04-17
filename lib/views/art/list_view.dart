import 'package:aria_client/viewmodels/art_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtListView extends GetView<ArtViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Text('hi'),),);
  }
}