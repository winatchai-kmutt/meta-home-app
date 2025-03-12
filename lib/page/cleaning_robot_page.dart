import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_home_ai/model.dart';
import 'package:meta_home_ai/widgets/circle_icon_button.dart';
import 'package:meta_home_ai/widgets/custom_switch.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CleaningRobotPage extends StatelessWidget {
  const CleaningRobotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE2C55D), Color(0xFFE9BF2C)],
            stops: [0.1, 0.9],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 24,
                top: MediaQuery.of(context).size.height * 0.2,
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Image(
                    width: MediaQuery.of(context).size.width * 1.2,
                    image: AssetImage('assets/images/cleaning_robot.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleIconButton(
                      onTap: () => Navigator.pop(context),
                      icon: AssetImage("assets/icons/back.png"),
                      padding: EdgeInsets.all(8),
                      size: 32,
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      color: Colors.white10,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Robot\nCleaner",
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w300,
                            height: 1,
                          ),
                        ),
                        CustomSwitch(
                          onChanged: (isChanged) {},
                          isOn: true,
                          thumbColor: primaryColor,
                          inactiveTrackColor: Colors.black45,
                          activeTrackColor: Colors.white,
                        ),
                      ],
                    ),
                    Spacer(),
                    RobotCleaningProgress(),
                    SizedBox(height: 32),
                    SlideAction(
                      onSubmit: () async {
                        // For testing
                        await Future.delayed(Duration(milliseconds: 500));
                        Navigator.pop(context);
                      },
                      text: "Stop Session",
                      sliderButtonIcon: ImageIcon(
                        AssetImage("assets/icons/cross_circle.png"),
                        color: primaryColor,
                        size: 32,
                      ),
                      sliderButtonIconPadding: 12,
                      borderRadius: 32,
                      sliderRotate: false,
                      elevation: 0,
                      innerColor: Colors.white,
                      outerColor: Color(0xFFAD8E22),
                      textStyle: GoogleFonts.oswald(
                        color: Colors.white,
                        fontSize: 28,
                        height: 1,
                      ),
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
}

class RobotCleaningProgress extends StatelessWidget {
  const RobotCleaningProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 32.0),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                child!,
                Text(
                  "${value.toInt()}%",
                  style: GoogleFonts.oswald(
                    color: Colors.white54,
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: value.toInt(),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 100 - value.toInt(),
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      child: Text(
        "Cleaning Progress",
        style: GoogleFonts.oswald(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.w300,
          height: 1,
        ),
      ),
    );
  }
}
