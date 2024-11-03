import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(



      title: Image.asset("assets/images/idea_logo.png",width: 80,),
      elevation: 10,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient:
          LinearGradient(
            colors: [Color(0XFFf2f2f2), Color(0xffb3b3b3)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),

        ),
      ),
      iconTheme: IconThemeData(color: Colors.white),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
