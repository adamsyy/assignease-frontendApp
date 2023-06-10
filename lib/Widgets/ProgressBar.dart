import 'package:asignease/Controller.dart';
import 'package:flutter/material.dart';


Controller globals = new Controller();
class ProgressBarPost extends StatefulWidget {
  final double? width_here;
  ProgressBarPost({this.width_here});

  @override
  State<ProgressBarPost> createState() => _ProgressBarPostState();
}

class _ProgressBarPostState extends State<ProgressBarPost> {
  @override
  Widget build(BuildContext context) {
    return    Container(
      height: 8,
      width: MediaQuery.of(context).size.width/1.2,
      decoration: BoxDecoration(
        color: Colors.white,// Background color of the progress bar
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: widget.width_here, // 30% fill progress
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6), // Fill color of the progress bar
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
