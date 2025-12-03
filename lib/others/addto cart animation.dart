


import 'package:flutter/material.dart';

class CartAnimation extends StatefulWidget {
  const CartAnimation({super.key});

  @override
  _CartAnimationState createState() => _CartAnimationState();
}

class _CartAnimationState extends State<CartAnimation> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.green,
      actions: [
        IconButton(onPressed: (){
            if (_animationController.status == AnimationStatus.completed) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
        }, icon: Icon(Icons.shopping_cart))
      ],
    ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: const Color.fromARGB(255, 182, 181, 181),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                  );
                },
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}


