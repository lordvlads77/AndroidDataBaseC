import 'package:flutter/material.dart';
//import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class CustomLoading extends StatefulWidget {
  const CustomLoading({Key? key, this.type = 0}) : super(key: key);

  final int type;

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
      with TickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState(){
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(visible: widget.type == 1, child: _buildSimpleLoadingImg()),
      ],
    );
  }

  Widget _buildSimpleLoadingImg(){
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
            'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101162946.png',
          height: 50,
          width: 50,
        ),
        RotationTransition(
          alignment: Alignment.center,
          turns: _animationController,
          child: Image.network(
              'https://raw.githubusercontent.com/xdd666t/MyData/master/pic/flutter/blog/20211101173708.png',
            height: 80,
            width: 80,
          ),
        ),
      ],
    );
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

}
