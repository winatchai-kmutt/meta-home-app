import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_home_ai/widgets/control_panel.dart';
import 'package:meta_home_ai/widgets/circle_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showModalControlPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 64),
          child: ShowModalControlPanel(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MetaHomeAppBar(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/living_room.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient here on top and bottom
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black87, Colors.transparent],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black87],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              bottom: false,
              child: Padding(padding: const EdgeInsets.only(top: 48)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: SafeArea(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Smart Living, ",
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 48,
                      height: 1,
                    ),
                  ),
                  Text(
                    "Simplified",
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    CircleIconButton(
                      icon: AssetImage('assets/icons/microphone.png'),
                      padding: EdgeInsets.all(14),
                      size: 28,
                      color: Colors.white30,
                    ),

                    CircleIconButton(
                      icon: AssetImage('assets/icons/menu_64.png'),
                      padding: EdgeInsets.all(18),
                      size: 32,
                      color: Colors.white,
                      iconColor: Colors.black87,
                      onTap: () {
                        showModalControlPanel(context);
                      },
                    ),
                    CircleIconButton(
                      icon: AssetImage('assets/icons/camera.png'),
                      padding: EdgeInsets.all(14),
                      size: 28,
                      color: Colors.white30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MetaHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MetaHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Meta",
                  style: GoogleFonts.oswald(
                    color: Colors.white38,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                  children: [
                    TextSpan(
                      text: "Home",
                      style: GoogleFonts.oswald(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(64);
}
