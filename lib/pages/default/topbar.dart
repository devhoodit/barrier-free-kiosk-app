import 'package:flutter/material.dart';

class TopProcessBar extends StatelessWidget {
  final int curProcess;
  final List<String> processes;

  const TopProcessBar(
      {Key? key, required this.curProcess, required this.processes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: processes.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(left: 20),
            child: Center(
                child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            )),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(left: 20),
            child: Center(
              child: Text(
                processes[index],
                style: const TextStyle(fontSize: 50),
              ),
            ),
          );
        },
      ),
    );
  }
}
