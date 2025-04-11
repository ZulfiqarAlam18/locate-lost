import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnimatedProgressCard extends StatefulWidget {
  const AnimatedProgressCard({super.key});

  @override
  State<AnimatedProgressCard> createState() => _AnimatedProgressCardState();
}

class _AnimatedProgressCardState extends State<AnimatedProgressCard>
    with SingleTickerProviderStateMixin {
  double progressPercent = 0.25; // Can be dynamic later

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 6,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              // Left side: Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Application Progress',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Enter missing person’s real\nname here',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),

              // Right side: Circular progress
              CircularPercentIndicator(
                radius: 40,
                lineWidth: 8.0,
                percent: progressPercent,
                animation: true,
                animationDuration: 1000,
                progressColor: Colors.teal,
                backgroundColor: Colors.teal.shade100,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  "${(progressPercent * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
