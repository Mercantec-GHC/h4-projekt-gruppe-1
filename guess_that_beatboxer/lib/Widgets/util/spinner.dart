import 'package:flutter/material.dart';

class LoadingSpinner extends StatefulWidget {
  final bool isLoading;
  final bool isSuccess;
  final String successMessage;

  LoadingSpinner({
    required this.isLoading,
    required this.isSuccess,
    this.successMessage = 'Success!',
  });

  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const Center(
        child:  CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      );
    } else if (widget.isSuccess) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const Positioned(
                            child: Icon(Icons.check, color: Colors.red, size: 80),
                          ),
                        ],
                      ),
            const SizedBox(height: 16),
            Text(widget.successMessage, style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w900, color: Colors.white)), 
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}