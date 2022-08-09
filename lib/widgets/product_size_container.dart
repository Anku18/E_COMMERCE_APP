import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List? productSize;
  final Function(String)? onselected;
  ProductSize({this.productSize, this.onselected});
  @override
  State<ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        top: 0,
        left: 20.0,
        right: 20.0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize!.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onselected!('${widget.productSize![i]}');
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : const Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  '${widget.productSize![i]}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _selected == i ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
