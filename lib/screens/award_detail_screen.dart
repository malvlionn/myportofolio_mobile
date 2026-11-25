import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/award.dart';
import 'package:myportofolio_mobile/screens/award_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class AwardDetailScreen extends StatefulWidget {
  const AwardDetailScreen({required this.award, this.onDataChanged, super.key});

  final Award award;
  final VoidCallback? onDataChanged;

  @override
  State<AwardDetailScreen> createState() => _AwardDetailScreenState();
}

class _AwardDetailScreenState extends State<AwardDetailScreen> {
  late Award _award;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _award = widget.award;
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
        SnackBar(
          content: Text('Operasi gagal (${e.statusCode}): ${e.message}'),
        ),
      );
    }
  }

  Future<void> _toggleStar() async {
    final id = _award.id;
    if (id == null || _isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isProcessing = true);
    try {
      final updated = await context.read<ApiClient>().toggleAwardStar(
        id,
        token: token,
      );
      if (!mounted) return;
      setState(() => _award = updated);
      widget.onDataChanged?.call();
    } on ApiException catch (e) {
      await _handleApiError(e);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _editAward() async {
    if (_isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final updated = await Navigator.push<Award>(
      context,
      MaterialPageRoute(builder: (_) => AwardFormPage(initialAward: _award)),
    );
    if (updated != null && mounted) {
      setState(() => _award = updated);
      widget.onDataChanged?.call();
    }
  }

  Future<void> _deleteAward() async {
    final id = _award.id;
    if (id == null || _isProcessing) return;
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Penghargaan?'),
        content: Text('Yakin ingin menghapus "${_award.title}"?'),
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
      await context.read<ApiClient>().deleteAward(id, token: token);
      if (!mounted) return;
      widget.onDataChanged?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Penghargaan berhasil dihapus.')),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_award.title),
        actions: [
          IconButton(
            tooltip: 'Star',
            onPressed: _isProcessing ? null : _toggleStar,
            icon: Icon(
              _award.isStarred ? Icons.star_rounded : Icons.star_border_rounded,
              color: _award.isStarred ? Colors.amber : null,
            ),
          ),
          IconButton(
            tooltip: 'Edit',
            onPressed: _isProcessing ? null : _editAward,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Hapus',
            onPressed: _isProcessing ? null : _deleteAward,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _award.title,
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Penyelenggara: ${_award.issuer}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                Chip(label: Text('Tingkat: ${_award.tier}')),
                Chip(label: Text('Tanggal: ${_award.date}')),
                if (_award.isWinner)
                  const Chip(
                    avatar: Icon(Icons.emoji_events_rounded, size: 16),
                    label: Text('Winner'),
                  ),
                Chip(
                  avatar: const Icon(Icons.star_rounded, size: 16),
                  label: Text('${_award.starCount} Stars'),
                ),
              ],
            ),
            if (_award.certificateUrl.trim().isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Tautan Sertifikat: ${_award.certificateUrl}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
            if (_award.starredByNames.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Di-star oleh: ${_award.starredByNames}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (_award.createdAt != null && _award.createdAt!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Dibuat pada: ${_award.createdAt}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
            if (_award.id != null) ...[
              const SizedBox(height: 4),
              Text(
                'ID: ${_award.id}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
            const Divider(height: 24),
            Text(
              _award.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
