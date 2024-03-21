import 'package:flutter/material.dart';

class FlagSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FlagSwitch({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _FlagSwitchState createState() => _FlagSwitchState();
}

class _FlagSwitchState extends State<FlagSwitch> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChanged(!widget.value),
      child: Container(
        width: 80,
        height: 40,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.value) ...[
              Image.asset('assets/images/icons/usa_flag.png', width: 30),
              Expanded(child: Center(child: Text('de', style: TextStyle(fontSize: 16)))),
            ] else ...[
              Expanded(child: Center(child: Text('en', style: TextStyle(fontSize: 16)))),
              Image.asset('assets/images/icons/austria_avg.png', width: 26),
            ],
          ],
        ),
      ),
    );
  }
}
