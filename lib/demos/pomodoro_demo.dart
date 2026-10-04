import 'dart:async';

import 'package:flutter/material.dart';

import '../theme.dart';

class PomodoroDemo extends StatefulWidget {
  const PomodoroDemo({super.key});

  @override
  State<PomodoroDemo> createState() => _PomodoroDemoState();
}

class _PomodoroDemoState extends State<PomodoroDemo> {
  Timer? _timer;
  bool _focus = true;
  int _left = 25 * 60;

  int get _total => _focus ? 25 * 60 : 5 * 60;
  bool get _running => _timer != null;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  void _toggle() {
    if (_running) {
      setState(_stop);
      return;
    }
    if (_left == 0) _left = _total;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_left <= 1) {
        setState(() {
          _left = 0;
          _stop();
        });
      } else {
        setState(() => _left--);
      }
    });
    setState(() {});
  }

  void _reset() => setState(() {
        _stop();
        _left = _total;
      });

  void _setMode(bool focus) => setState(() {
        _stop();
        _focus = focus;
        _left = _total;
      });

  String get _clock {
    final m = (_left ~/ 60).toString().padLeft(2, '0');
    final s = (_left % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SegmentedButton<bool>(
          segments: const [
            ButtonSegment(value: true, label: Text('Fokus 25')),
            ButtonSegment(value: false, label: Text('Istirahat 5')),
          ],
          selected: {_focus},
          onSelectionChanged: (s) => _setMode(s.first),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 170,
          height: 170,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: 1 - _left / _total,
                  strokeWidth: 9,
                  color: AppColors.gold,
                  backgroundColor: AppColors.line,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _clock,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy,
                    ),
                  ),
                  Text(
                    _left == 0 ? 'Selesai' : (_focus ? 'Fokus' : 'Istirahat'),
                    style: const TextStyle(color: AppColors.muted),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: _toggle,
              icon: Icon(_running ? Icons.pause : Icons.play_arrow),
              label: Text(_running ? 'Jeda' : 'Mulai'),
            ),
            const SizedBox(width: 12),
            OutlinedButton(onPressed: _reset, child: const Text('Atur ulang')),
          ],
        ),
      ],
    );
  }
}
