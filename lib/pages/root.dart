import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1, // 50% of available height
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text('النداء')),
                ),
              ),
              Expanded(
                flex: 2, // 50% of available height
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text('النداء')),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}
