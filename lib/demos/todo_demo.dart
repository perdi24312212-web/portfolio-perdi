import 'package:flutter/material.dart';

import '../theme.dart';

class _Task {
  final String title;
  bool done;
  _Task(this.title, {this.done = false});
}

class TodoDemo extends StatefulWidget {
  const TodoDemo({super.key});

  @override
  State<TodoDemo> createState() => _TodoDemoState();
}

class _TodoDemoState extends State<TodoDemo> {
  final _controller = TextEditingController();
  final List<_Task> _tasks = [
    _Task('Kerjakan tugas pemrograman'),
    _Task('Baca materi basis data', done: true),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _tasks.insert(0, _Task(text)));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final done = _tasks.where((t) => t.done).length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _add(),
                decoration: const InputDecoration(
                  hintText: 'Tulis tugas baru',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton(onPressed: _add, child: const Text('Tambah')),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          _tasks.isEmpty
              ? 'Belum ada tugas. Tulis tugas pertamamu di atas.'
              : '$done dari ${_tasks.length} tugas selesai',
          style: const TextStyle(color: AppColors.muted),
        ),
        const SizedBox(height: 4),
        for (final t in _tasks)
          CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: t.done,
            onChanged: (v) => setState(() => t.done = v ?? false),
            title: Text(
              t.title,
              style: TextStyle(
                decoration: t.done ? TextDecoration.lineThrough : null,
                color: t.done ? AppColors.muted : AppColors.ink,
              ),
            ),
            secondary: IconButton(
              tooltip: 'Hapus',
              icon: const Icon(Icons.delete_outline, size: 20),
              onPressed: () => setState(() => _tasks.remove(t)),
            ),
          ),
      ],
    );
  }
}
