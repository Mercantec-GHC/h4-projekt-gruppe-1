import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:sound_mode/sound_mode.dart';

class EnableSoundButton extends StatefulWidget {
  @override
  _EnableSoundButtonState createState() => _EnableSoundButtonState();
}

class _EnableSoundButtonState extends State<EnableSoundButton> {
  bool _soundEnabled = true;

  Future<void> _toggleSound() async {
    try {
      if (_soundEnabled) {
        print('Setting sound mode to silent');
        await SoundMode.setSoundMode(RingerModeStatus.silent);
      } else {
        print('Setting sound mode to vibrate');
        await SoundMode.setSoundMode(RingerModeStatus.vibrate);
      }
      setState(() {
        _soundEnabled = !_soundEnabled;
        print('Sound enabled state: $_soundEnabled');
      });
    } on PlatformException catch (e) {
      print('PlatformException: ${e.message}');
      print('Please enable permissions required');
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enable sound'),
            Switch(
              value: _soundEnabled,
              onChanged: (bool value) {
                _toggleSound();
              },
              activeColor: Colors.red,
              activeTrackColor: Colors.black,
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Colors.white,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ],
    );
  }
}