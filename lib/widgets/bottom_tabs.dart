import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTab extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabsPressed;
  BottomTab({this.selectedTab, this.tabsPressed});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(
              12.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1.0,
              blurRadius: 10.0,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabsBtn(
            imagePath: 'assets/images/home.png',
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabsPressed!(0);
            },
          ),
          BottomTabsBtn(
            imagePath: 'assets/images/magnifier.png',
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabsPressed!(1);
            },
          ),
          BottomTabsBtn(
            imagePath: 'assets/images/bookmark.png',
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabsPressed!(2);
            },
          ),
          BottomTabsBtn(
            imagePath: 'assets/images/logout.png',
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabsBtn extends StatelessWidget {
  final String? imagePath;
  final bool? selected;
  final Function()? onPressed;
  BottomTabsBtn({this.imagePath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 28.0,
          vertical: 24.0,
        ),
        child: Image(
          image: AssetImage(imagePath!),
          width: 22.0,
          height: 22.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
