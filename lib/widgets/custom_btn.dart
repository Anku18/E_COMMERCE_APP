import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool? outLineBtn;
  final bool? isLoading;
  CustomBtn({this.text, this.onPressed, this.outLineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _outLineBtn = outLineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 63.0,
        decoration: BoxDecoration(
          color: _outLineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text!,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outLineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: const Center(
                child: SizedBox(
                  height: 30.0,
                  width: 30.0,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
