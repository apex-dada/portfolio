import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:portfolio/features/home/provider/home_viewmodel.dart';
import 'package:portfolio/core/widgets/bento_card.dart';

class LiveClockWidget extends StatefulWidget {
  const LiveClockWidget({super.key});

  @override
  State<LiveClockWidget> createState() => _LiveClockWidgetState();
}

class _LiveClockWidgetState extends State<LiveClockWidget> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final hourInt = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final hourStr = hourInt.toString().padLeft(2, '0');
    final minStr = dt.minute.toString().padLeft(2, '0');
    final secStr = dt.second.toString().padLeft(2, '0');
    final amPm = dt.hour >= 12 ? 'PM' : 'AM';
    return "$hourStr:$minStr:$secStr $amPm";
  }

  String _formatDate(DateTime dt) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

    final dayName = days[dt.weekday - 1];
    final monthName = months[dt.month - 1];
    return "$dayName, $monthName ${dt.day}, ${dt.year}";
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = context.select<HomeViewModel, Color>((vm) => vm.cardColor);
    final borderColor = context.select<HomeViewModel, Color>((vm) => vm.borderColor);
    final hoverBorderColor = context.select<HomeViewModel, Color>((vm) => vm.hoverBorderColor);
    final primaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.primaryTextColor);
    final secondaryTextColor = context.select<HomeViewModel, Color>((vm) => vm.secondaryTextColor);

    const greenAccent = Color(0xFF3DDC84);

    return BentoCard(
      backgroundColor: cardColor,
      borderColor: borderColor,
      hoverBorderColor: hoverBorderColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Live Status Badge
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "Dhaka, Bangladesh (GMT+6)",
                style: GoogleFonts.inter(
                  color: greenAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Digital Clock Time
          Text(
            _formatTime(_now),
            style: GoogleFonts.outfit(
              color: primaryTextColor,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),

          // Full Date
          Text(
            _formatDate(_now),
            style: GoogleFonts.inter(
              color: secondaryTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
