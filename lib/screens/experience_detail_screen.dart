import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ExperienceDetailScreen extends StatefulWidget {
  const ExperienceDetailScreen({
    required this.experience,
    this.onDataChanged,
    super.key,
  });

  final Experience experience;
  final VoidCallback? onDataChanged;

  @override
  State<ExperienceDetailScreen> createState() => _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState extends State<ExperienceDetailScreen> {
  late Experience _experience;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _experience = widget.experience;
  }

  Future<void> _handleApiError(ApiException e) async {
    if (!mounted) return;
    if (e.statusCode == 401) {
      context.read<AuthState>().clearSession();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesi berakhir (401). Silakan login kembali.'),
        ),
      );
      await ensureLoggedIn(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Operasi gagal (${e.statusCode}):${e.message}')),
      );
    }
  }

  Future<void> _toggleStar() async {
    final id = _experience.id;
    if (id == null || _isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isProcessing = true);
    try {
      final updated = await context.read<ApiClient>().toggleExperienceStar(
        id,
        token: token,
      );
      if (!mounted) return;
      setState(() => _experience = updated);
      widget.onDataChanged?.call();
    } on ApiException catch (e) {
      await _handleApiError(e);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _editExperience() async {
    if (_isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final updated = await Navigator.push<Experience>(
      context,
      MaterialPageRoute(
        builder: (_) => ExperienceFormPage(initialExperience: _experience),
      ),
    );
    if (updated != null && mounted) {
      setState(() => _experience = updated);
      widget.onDataChanged?.call();
    }
  }

  Future<void> _deleteExperience() async {
    final id = _experience.id;
    if (id == null || _isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Pengalaman?'),
        content: Text('Yakin ingin menghapus "${_experience.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isProcessing = true);
    try {
      await context.read<ApiClient>().deleteExperience(id, token: token);
      if (!mounted) return;
      widget.onDataChanged?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengalaman berhasil dihapus.')),
      );
      Navigator.pop(context);
    } on ApiException catch (e) {
      await _handleApiError(e);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryText = _experience.categoryDisplay.isNotEmpty
        ? _experience.categoryDisplay
        : _experience.category;
    final hasImage = _experience.thumbnail.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(_experience.title),
        actions: [
          IconButton(
            tooltip: 'Star',
            onPressed: _isProcessing ? null : _toggleStar,
            icon: Icon(
              _experience.isStarred
                  ? Icons.star_rounded
                  : Icons.star_border_rounded,
              color: _experience.isStarred ? Colors.amber : null,
            ),
          ),
          IconButton(
            tooltip: 'Edit',
            onPressed: _isProcessing ? null : _editExperience,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Hapus',
            onPressed: _isProcessing ? null : _deleteExperience,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _experience.thumbnail,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              _experience.title,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                Chip(label: Text(categoryText)),
                Chip(
                  avatar: const Icon(Icons.star_rounded, size: 16),
                  label: Text('${_experience.starCount} Stars'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_experience.startedAt != null &&
                _experience.startedAt!.isNotEmpty)
              Text(
                'Mulai: ${_experience.startedAt}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Text(
              _experience.isOngoing
                  ? 'Status: Masih Berlangsung'
                  : 'Selesai: ${_experience.endedAt ?? '-'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (_experience.starredByNames.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Di-star oleh: ${_experience.starredByNames}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (_experience.id != null) ...[
              const SizedBox(height: 4),
              Text(
                'ID: ${_experience.id}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
            const Divider(height: 24),
            Text(
              _experience.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
