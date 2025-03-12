import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryColor = Color(0xFFE9BF2C);

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MetaHomeAppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/living_room.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: FronstedContainer(
              borderRadius: BorderRadius.circular(80),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Device",
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 32,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: PageScrollPhysics(),
                      children: [
                        FilterDeviceBox(enable: true, text: 'All Devices'),
                        SizedBox(width: 8),
                        FilterDeviceBox(text: "Living room"),
                        SizedBox(width: 8),
                        FilterDeviceBox(text: "Kitchen"),
                        SizedBox(width: 8),
                        FilterDeviceBox(text: "Bedroom"),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Expanded(child: AirControllerBox()),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(child: CleaningRobotControllerBox()),
                              SizedBox(height: 12),
                              Expanded(child: SpeakerControllerBox()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: VolumnSlider(
                      initialValue: 38,
                      onChanged: (double value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VolumnSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const VolumnSlider({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<VolumnSlider> createState() => _VolumnSliderState();
}

class _VolumnSliderState extends State<VolumnSlider> {
  late double _value;
  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: primaryColor,
        inactiveTrackColor: Colors.white24,
        trackShape: CustomRoundedRectSliderTrackShape(),
        thumbShape: CustomRoundSliderThumbShape(),
        trackHeight: 64,
        overlayColor: Colors.transparent,
        thumbColor: Colors.white,
        padding: EdgeInsets.zero,
      ),
      child: Stack(
        children: [
          Slider(
            value: _value,
            padding: EdgeInsets.zero,
            min: 0,
            max: 100,
            divisions: 100,
            onChanged: (value) {
              widget.onChanged(value);
              setState(() {
                _value = value;
              });
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Text(
                "${(_value).toInt()}%",
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRoundedRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const CustomRoundedRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    final ColorTween activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final ColorTween inactiveTrackColorTween = ColorTween(
      begin: sliderTheme.disabledInactiveTrackColor,
      end: sliderTheme.inactiveTrackColor,
    );
    final Paint activePaint =
        Paint()..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint =
        Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final (
      Paint leftTrackPaint,
      Paint rightTrackPaint,
    ) = switch (textDirection) {
      TextDirection.ltr => (activePaint, inactivePaint),
      TextDirection.rtl => (inactivePaint, activePaint),
    };

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 3);
    final Radius activeTrackRadius = Radius.circular(
      (trackRect.height + additionalActiveTrackHeight) / 3,
    );
    final bool isLTR = textDirection == TextDirection.ltr;
    final bool isRTL = textDirection == TextDirection.rtl;

    final bool drawInactiveTrack =
        thumbCenter.dx < (trackRect.right - (sliderTheme.trackHeight! / 2));
    if (drawInactiveTrack) {
      context.canvas.drawRRect(
        RRect.fromLTRBR(
          thumbCenter.dx - (sliderTheme.trackHeight! / 2),
          isRTL
              ? trackRect.top - (additionalActiveTrackHeight / 2)
              : trackRect.top,
          trackRect.right,
          isRTL
              ? trackRect.bottom + (additionalActiveTrackHeight / 2)
              : trackRect.bottom,
          isLTR ? trackRadius : activeTrackRadius,
        ),
        rightTrackPaint,
      );
    }
    final bool drawActiveTrack =
        thumbCenter.dx > (trackRect.left + (sliderTheme.trackHeight! / 2));
    if (drawActiveTrack) {
      final rrect = RRect.fromLTRBR(
        trackRect.left,
        isLTR
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx + (sliderTheme.trackHeight! / 2),
        isLTR
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        isLTR ? activeTrackRadius : trackRadius,
      );
      context.canvas.drawRRect(rrect, leftTrackPaint);

      final left = trackRect.left;
      final top =
          isLTR
              ? trackRect.top - (additionalActiveTrackHeight / 2)
              : trackRect.top;
      final right = thumbCenter.dx + (sliderTheme.trackHeight! / 2);
      final bottom =
          isLTR
              ? trackRect.bottom + (additionalActiveTrackHeight / 2)
              : trackRect.bottom;

      // Clip with bouding of rrect!!! Goooddd
      // line path หลักจากนี้ก็จะอยู่ภายใต้ rrect
      context.canvas.saveLayer(rrect.outerRect, leftTrackPaint);
      context.canvas.clipRRect(rrect);

      Paint linePaint =
          Paint()
            ..color = Color(0xffEFC43F)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4;
      Path linePath = Path();

      final width = right - left;
      final step = 16;
      final kCurve = 10;
      final x0 = left;
      final y0 = top;
      final y1 = bottom;

      List.generate((width / step).toInt(), (i) {
        linePath.moveTo(x0 + ((i + 1) * step) + kCurve, y0);
        linePath.lineTo(x0 + (i * step) - kCurve, y1);
        context.canvas.drawPath(linePath, linePaint);
      });
    }
  }

  @override
  bool get isRounded => true;
}

class CustomRoundSliderThumbShape extends SliderComponentShape {
  const CustomRoundSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });
  final double enabledThumbRadius;

  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
      isEnabled ? enabledThumbRadius : _disabledThumbRadius,
    );
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation = elevationTween.evaluate(
      activationAnimation,
    );

    // Shadow
    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(center.dx, center.dy / 2, 8, 32),
            Radius.circular(6),
          ),
        );

    canvas.drawShadow(path, Colors.black, evaluatedElevation, true);

    // Tump
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx, center.dy / 2, 8, 32),
        Radius.circular(6),
      ),
      Paint()..color = color,
    );
  }
}

class SpeakerControllerBox extends StatelessWidget {
  const SpeakerControllerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return FronstedContainer(
      borderRadius: BorderRadius.circular(100),
      padding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InfoAndSwitch(
                  onSwitchChanged: (bool isChanged) {},
                  deviceName: "Speaker",
                  roomName: "Bedroom",
                  icon: AssetImage('assets/icons/speaker.png'),
                ),
              ],
            ),
          ),
          // TODO Crop image with real size, dynamic position&size by parent
          Positioned(
            bottom: -80,
            left: 10,
            right: 10,
            child: Image(image: AssetImage('assets/images/speaker_device.png')),
          ),
        ],
      ),
    );
  }
}

class CleaningRobotControllerBox extends StatelessWidget {
  const CleaningRobotControllerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.0, end: 0.90),
                      duration: Duration(seconds: 1),
                      builder: (
                        BuildContext context,
                        double value,
                        Widget? child,
                      ) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black12,
                              ),
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                // TODO Add animation when start widget
                                // Tween 0 - percent target
                                child: CircularProgressIndicator(
                                  value: value,
                                  padding: EdgeInsets.all(2),
                                  strokeWidth: 4,
                                  color: Colors.white,
                                  backgroundColor: Colors.black12,
                                  year2023: false,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Center(
                                child: Text(
                                  "${(value * 100).toInt()}%",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                AutoSizeText(
                  "Cleaning\nRobot",
                  maxLines: 2,
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Kitchen",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          // TODO: dynamic size, give size Image and position by parent box size ratio
          Positioned(
            right: -32,
            top: -32,
            width: 128,
            child: Image(image: AssetImage('assets/images/cleaning_robot.png')),
          ),
        ],
      ),
    );
  }
}

class AirControllerBox extends StatefulWidget {
  const AirControllerBox({super.key});

  @override
  State<AirControllerBox> createState() => _AirControllerBoxState();
}

class _AirControllerBoxState extends State<AirControllerBox> {
  double _temp = 21.4;
  final _minTemp = 16;
  final _maxTemp = 30;
  Timer? _timer;

  void _increasing() {
    if (_temp >= _maxTemp) {
      return;
    }
    setState(() {
      _temp += 0.1;
    });
  }

  void _decreasing() {
    if (_temp <= _minTemp) {
      return;
    }
    setState(() {
      _temp -= 0.1;
    });
  }

  void _startIncreasing() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      _increasing();
    });
  }

  void _startDecreasing() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      _decreasing();
    });
  }

  void _stopIncreasingAndDecreasing() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FronstedContainer(
      borderRadius: BorderRadius.circular(100),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InfoAndSwitch(
            onSwitchChanged: (bool isChanged) {},
            deviceName: "Air \nConditioner",
            roomName: "Bedroom",
            icon: AssetImage('assets/icons/fan.png'),
          ),
          Spacer(),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: _temp.toStringAsFixed(1),
              style: GoogleFonts.oswald(
                color: Colors.white,
                fontSize: 54,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: "°",
                  style: GoogleFonts.oswald(
                    color: Colors.white54,
                    fontSize: 54,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO Animation number -> decrease and increase
              Expanded(
                child: CircleIconButton(
                  onTap: _decreasing,
                  onTapDown: _startDecreasing,
                  onTapUp: _stopIncreasingAndDecreasing,
                  onTapCancel: _stopIncreasingAndDecreasing,
                  padding: EdgeInsets.all(12),
                  size: 40,
                  icon: AssetImage('assets/icons/minus.png'),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CircleIconButton(
                  onTap: _increasing,
                  onTapDown: _startIncreasing,
                  onTapUp: _stopIncreasingAndDecreasing,
                  onTapCancel: _stopIncreasingAndDecreasing,
                  padding: EdgeInsets.all(12),
                  size: 40,
                  icon: AssetImage('assets/icons/plus.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoAndSwitch extends StatefulWidget {
  final Function(bool isChanged) onSwitchChanged;
  final String deviceName;
  final String roomName;
  final ImageProvider icon;

  const InfoAndSwitch({
    super.key,
    required this.onSwitchChanged,
    required this.deviceName,
    required this.roomName,
    required this.icon,
  });

  @override
  State<InfoAndSwitch> createState() => _InfoAndSwitchState();
}

class _InfoAndSwitchState extends State<InfoAndSwitch> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleIconBox(
              padding: EdgeInsets.all(8),
              icon: widget.icon,
              size: 36,
            ),
            Switch.adaptive(
              value: isOn,
              onChanged: (isChanged) {
                widget.onSwitchChanged(isChanged);
                setState(() {
                  isOn = isChanged;
                });
              },
              activeColor: Colors.white,
              activeTrackColor: primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
            ),
          ],
        ),
        SizedBox(height: 8),
        AutoSizeText(
          widget.deviceName,
          maxLines: 2,
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            height: 1.3,
          ),
        ),
        SizedBox(height: 4),
        Text(
          widget.roomName,
          style: GoogleFonts.oswald(
            color: Colors.white54,
            fontSize: 16,
            height: 1.3,
          ),
        ),
      ],
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
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: "Meta",
                  style: GoogleFonts.oswald(
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

/*
'assets/icons/menu_64.png'
EdgeInsets.all(16)
width: 24,
*/

class CircleIconButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapCancel;
  final EdgeInsets padding;
  final ImageProvider icon;
  final double size;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.padding,
    required this.size,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.white.withValues(alpha: 0.2),
        child: InkWell(
          splashColor: primaryColor,
          onTap: onTap,
          onTapDown: (_) {
            onTapDown?.call();
          },
          onTapUp: (_) {
            onTapUp?.call();
          },
          onTapCancel: () {
            onTapCancel?.call();
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ImageIcon(icon, color: Colors.white, size: size),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleIconBox extends StatelessWidget {
  final EdgeInsets padding;
  final ImageProvider icon;
  final double size;

  const CircleIconBox({
    super.key,
    required this.padding,
    required this.size,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: ImageIcon(icon, color: Colors.white, size: size),
        ),
      ),
    );
  }
}

class FilterDeviceBox extends StatelessWidget {
  final String text;
  final bool enable;

  const FilterDeviceBox({super.key, required this.text, this.enable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: enable ? primaryColor : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.nunitoSans(
          color: enable ? Colors.white : Colors.white54,
          fontSize: 16,
          fontWeight: enable ? FontWeight.w800 : FontWeight.normal,
          height: 1,
        ),
      ),
    );
  }
}

class FronstedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;

  const FronstedContainer({
    super.key,
    required this.child,
    required this.padding,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShapeBorderClipper(
        shape: ContinuousRectangleBorder(borderRadius: borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
        child: Container(
          padding: padding,
          color: Colors.white.withValues(alpha: 0.1),
          child: child,
        ),
      ),
    );
  }
}
