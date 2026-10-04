import 'package:flutter/material.dart';

import '../theme.dart';

/// Bobot nilai huruf (skala 4,0 yang umum dipakai di UI).
const _bobot = <String, double>{
  'A': 4.0,
  'A-': 3.7,
  'B+': 3.3,
  'B': 3.0,
  'B-': 2.7,
  'C+': 2.3,
  'C': 2.0,
  'D': 1.0,
  'E': 0.0,
};

class _Entry {
  int sks;
  String grade;
  _Entry(this.sks, this.grade);
}

class IpkDemo extends StatefulWidget {
  const IpkDemo({super.key});

  @override
  State<IpkDemo> createState() => _IpkDemoState();
}

class _IpkDemoState extends State<IpkDemo> {
  final List<_Entry> _entries = [
    _Entry(3, 'A'),
    _Entry(3, 'B+'),
    _Entry(2, 'A-'),
  ];

  int get _totalSks => _entries.fold(0, (sum, e) => sum + e.sks);

  double get _ipk {
    if (_totalSks == 0) return 0;
    final points =
        _entries.fold<double>(0, (sum, e) => sum + e.sks * _bobot[e.grade]!);
    return points / _totalSks;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih SKS dan nilai huruf tiap mata kuliah.',
          style: TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < _entries.length; i++)
          Row(
            children: [
              SizedBox(
                width: 28,
                child: Text('${i + 1}.',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Expanded(
                child: DropdownButton<int>(
                  value: _entries[i].sks,
                  isExpanded: true,
                  items: [
                    for (var s = 1; s <= 6; s++)
                      DropdownMenuItem(value: s, child: Text('$s SKS')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _entries[i].sks = v);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<String>(
                  value: _entries[i].grade,
                  isExpanded: true,
                  items: [
                    for (final g in _bobot.keys)
                      DropdownMenuItem(value: g, child: Text('Nilai $g')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _entries[i].grade = v);
                  },
                ),
              ),
              IconButton(
                tooltip: 'Hapus',
                icon: const Icon(Icons.close, size: 18),
                onPressed: _entries.length > 1
                    ? () => setState(() => _entries.removeAt(i))
                    : null,
              ),
            ],
          ),
        TextButton.icon(
          onPressed: _entries.length < 12
              ? () => setState(() => _entries.add(_Entry(3, 'A')))
              : null,
          icon: const Icon(Icons.add),
          label: const Text('Tambah mata kuliah'),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total $_totalSks SKS',
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
              const Text('IPK ', style: TextStyle(color: Colors.white70)),
              Text(
                _ipk.toStringAsFixed(2),
                style: const TextStyle(
                  color: AppColors.gold,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
