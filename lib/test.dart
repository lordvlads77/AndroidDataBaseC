import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'customloading.dart';

/*var _list = ['smile', 'icon', 'normal'];

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => _show(),
        child: const Text("click me"),
      ),
    );
  }

  void _onItem(String msg) async {
    if (_list[0] == msg) {
      SmartDialog.showLoading(
        animationType: SmartAnimationType.scale,
        builder: (_) => const CustomLoading(),
      );
    } else if (_list[1] == msg) {
      SmartDialog.showLoading(
        animationType: SmartAnimationType.scale,
        builder: (_) => const CustomLoading(type: 1),
      );
    } else if (_list[2] == msg) {
      SmartDialog.showLoading(builder: (_) => const CustomLoading(type: 2));
    }

    await Future.delayed(const Duration(seconds: 2));
    SmartDialog.dismiss(status: SmartStatus.loading);
  }
}*/
