import 'package:flutter/material.dart';

import '../data.dart';
import '../theme.dart';
import '../utils.dart';
import '../widgets/dot_grid.dart';
import '../widgets/hover_lift.dart';
import '../widgets/id_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section_block.dart';

const _whatsappGreen = Color(0xFF1FA855);
const _tagBackground = Color(0xFFEEF1F7);

enum Section {
  tentang('Tentang'),
  keahlian('Keahlian'),
  proyek('Proyek'),
  kontak('Kontak');

  final String label;
  const Section(this.label);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<Section, GlobalKey> _keys = {
    for (final s in Section.values) s: GlobalKey(),
  };

  void _goTo(Section section) {
    final ctx = _keys[section]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroBand(onSelect: _goTo),
            SectionBlock(
              key: _keys[Section.tentang],
              title: 'Tentang saya',
              divider: false,
              child: const _About(),
            ),
            SectionBlock(
              key: _keys[Section.keahlian],
              title: 'Keahlian',
              child: const _Skills(),
            ),
            SectionBlock(
              key: _keys[Section.proyek],
              title: 'Proyek',
              child: const _Projects(),
            ),
            SectionBlock(
              key: _keys[Section.kontak],
              title: 'Kontak',
              child: const _Contact(),
            ),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- Hero

class _HeroBand extends StatelessWidget {
  final ValueChanged<Section> onSelect;
  const _HeroBand({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navy,
      child: Stack(
        children: [
          const Positioned.fill(child: DotGrid()),
          Column(
            children: [
              Content(child: _Header(onSelect: onSelect)),
              Content(child: _Hero(onSelect: onSelect)),
              Container(height: 6, color: AppColors.gold),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<Section> onSelect;
  const _Header({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          const Text(
            Profile.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          if (isWide(context))
            for (final s in Section.values)
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
                onPressed: () => onSelect(s),
                child: Text(s.label),
              )
          else
            PopupMenuButton<Section>(
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: 'Menu',
              onSelected: onSelect,
              itemBuilder: (_) => [
                for (final s in Section.values)
                  PopupMenuItem(value: s, child: Text(s.label)),
              ],
            ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final ValueChanged<Section> onSelect;
  const _Hero({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Halo, saya ${Profile.name}.',
          style: const TextStyle(
            color: AppColors.gold,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          Profile.headline,
          style: TextStyle(
            color: Colors.white,
            fontSize: wide ? 46 : 32,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: const Text(
            Profile.intro,
            style: TextStyle(color: Colors.white70, fontSize: 17, height: 1.6),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.navy,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () => onSelect(Section.proyek),
              child: const Text('Lihat proyek'),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _whatsappGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                textStyle: const TextStyle(fontWeight: FontWeight.w700),
              ),
              onPressed: () => openLink(context, Profile.whatsappUrl),
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Chat WhatsApp'),
            ),
          ],
        ),
      ],
    );

    final card = const Reveal(
      delay: Duration(milliseconds: 250),
      child: IdCard(),
    );

    return Padding(
      padding: EdgeInsets.only(top: wide ? 40 : 24, bottom: 64),
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Reveal(child: text)),
                const SizedBox(width: 48),
                card,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Reveal(child: text),
                const SizedBox(height: 48),
                Center(child: card),
              ],
            ),
    );
  }
}

// ---------------------------------------------------------------- Tentang

class _About extends StatelessWidget {
  const _About();

  @override
  Widget build(BuildContext context) {
    final text = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final p in Profile.about)
            Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Text(
                p,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(height: 1.7, fontSize: 17),
              ),
            ),
        ],
      ),
    );

    if (isWide(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: text),
          const SizedBox(width: 56),
          const _PortraitPhoto(width: 240),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PortraitPhoto(width: 200),
        const SizedBox(height: 24),
        text,
      ],
    );
  }
}

class _PortraitPhoto extends StatelessWidget {
  final double width;
  const _PortraitPhoto({required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Image.asset(
            'assets/images/profile.jpg',
            fit: BoxFit.cover,
            semanticLabel: 'Foto ${Profile.name}',
            errorBuilder: (_, __, ___) => Container(color: _tagBackground),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- Keahlian

class _Skills extends StatelessWidget {
  const _Skills();

  static const _icons = [
    Icons.code,
    Icons.build_outlined,
    Icons.school_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final entries = skills.entries.toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 20.0;
        final columns = constraints.maxWidth >= 900 ? 3 : 1;
        final cardWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (var i = 0; i < entries.length; i++)
              SizedBox(
                width: cardWidth,
                child: _SkillCard(
                  icon: _icons[i % _icons.length],
                  title: entries[i].key,
                  items: entries[i].value,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _SkillCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;
  const _SkillCard({
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.navy,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.gold, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.navy,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final s in items) _Tag(s)],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _tagBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

// ---------------------------------------------------------------- Proyek

class _Projects extends StatelessWidget {
  const _Projects();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 20.0;
        final columns = constraints.maxWidth >= 720 ? 2 : 1;
        final cardWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final p in projects)
              SizedBox(
                width: cardWidth,
                child: HoverLift(child: _ProjectCard(p)),
              ),
          ],
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  const _ProjectCard(this.project);

  @override
  Widget build(BuildContext context) {
    // Catatan: Border dengan sisi berbeda warna tidak boleh dikombinasikan
    // dengan borderRadius, jadi garis emas dibuat sebagai strip terpisah.
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 5,
            child: ColoredBox(color: AppColors.gold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(27, 22, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(project.icon, color: AppColors.navy, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  project.description,
                  style: const TextStyle(color: AppColors.muted, height: 1.55),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [for (final t in project.tags) _Tag(t)],
                ),
                if (project.demo != null) ...[
                  const SizedBox(height: 18),
                  FilledButton.tonalIcon(
                    onPressed: () => _openDemo(context, project),
                    icon: const Icon(Icons.play_arrow, size: 18),
                    label: const Text('Coba demo'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _openDemo(BuildContext context, Project project) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 14, 14, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Tutup',
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 8),
                  child: project.demo!(dialogContext),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------- Kontak

class _Contact extends StatelessWidget {
  const _Contact();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CtaPanel(),
        const SizedBox(height: 24),
        _ContactRow(
          icon: Icons.chat_bubble_outline,
          label: 'WhatsApp',
          value: Profile.whatsappDisplay,
          url: Profile.whatsappUrl,
          copyValue: Profile.whatsappRaw,
        ),
        _ContactRow(
          icon: Icons.mail_outline,
          label: 'Email',
          value: Profile.email,
          url: Profile.emailUrl,
        ),
        _ContactRow(
          icon: Icons.code,
          label: 'GitHub',
          value: Profile.github,
          url: 'https://${Profile.github}',
        ),
        _ContactRow(
          icon: Icons.work_outline,
          label: 'LinkedIn',
          value: Profile.linkedin,
          url: 'https://${Profile.linkedin}',
        ),
      ],
    );
  }
}

class _CtaPanel extends StatelessWidget {
  const _CtaPanel();

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Ayo berkenalan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Terbuka untuk kolaborasi proyek, magang, atau sekadar bertukar ide.',
          style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
        ),
      ],
    );

    final buttons = Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: _whatsappGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
          onPressed: () => openLink(context, Profile.whatsappUrl),
          icon: const Icon(Icons.chat_bubble_outline, size: 18),
          label: const Text('Chat WhatsApp'),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: AppColors.navy,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
          onPressed: () => openLink(context, Profile.emailUrl),
          icon: const Icon(Icons.mail_outline, size: 18),
          label: const Text('Kirim email'),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.navy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: wide
          ? Row(
              children: [
                Expanded(child: text),
                const SizedBox(width: 32),
                buttons,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [text, const SizedBox(height: 22), buttons],
            ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String url;
  final String? copyValue;
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    this.copyValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => openLink(context, url),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.line),
              ),
              child: Row(
                children: [
                  Icon(icon, color: AppColors.navy),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.muted),
                        ),
                        Text(
                          value,
                          style:
                              const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: 'Salin $label',
                    icon: const Icon(Icons.copy, size: 18),
                    color: AppColors.muted,
                    onPressed: () =>
                        copyText(context, label, copyValue ?? value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- Footer

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.navy,
      child: const Content(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 24,
            runSpacing: 8,
            children: [
              Text(
                '${Profile.name}, ${Profile.prodi} - ${Profile.campus}',
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                'Dibuat dengan Flutter',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
