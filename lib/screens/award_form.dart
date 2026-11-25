import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/award.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class AwardFormPage extends StatefulWidget {
  const AwardFormPage({this.initialAward, super.key});

  final Award? initialAward;

  @override
  State<AwardFormPage> createState() => _AwardFormPageState();
}

class _AwardFormPageState extends State<AwardFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _issuerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _certificateUrlController =
      TextEditingController();

  static const List<String> _tierOptions = [
    'International',
    'National',
    'Provincial',
    'University',
    'Other',
  ];

  String _selectedTier = _tierOptions.first;
  bool _isWinner = false;
  bool _isSubmitting = false;

  bool get _isEditMode => widget.initialAward?.id != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.initialAward;
    if (existing != null) {
      _titleController.text = existing.title;
      _issuerController.text = existing.issuer;
      if (_tierOptions.contains(existing.tier)) {
        _selectedTier = existing.tier;
      }
      _dateController.text = existing.date;
      _descriptionController.text = existing.description;
      _certificateUrlController.text = existing.certificateUrl;
      _isWinner = existing.isWinner;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _issuerController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _certificateUrlController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String label, {int minLength = 2}) {
    if (value == null || value.trim().isEmpty) {
      return '$label tidak boleh kosong!';
    }
    if (value.trim().length < minLength) {
      return '$label minimal $minLength karakter.';
    }
    return null;
  }

  String? _validateOptionalUrl(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final uri = Uri.tryParse(value.trim());
    final validScheme =
        uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
    final validHost =
        uri != null && uri.host.isNotEmpty && uri.host.contains('.');
    if (!validScheme || !validHost) {
      return 'URL tidak valid. Awali dengan http:// atau https://';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _issuerController.clear();
    _dateController.clear();
    _descriptionController.clear();
    _certificateUrlController.clear();
    setState(() {
      _selectedTier = _tierOptions.first;
      _isWinner = false;
    });
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null) return;

    final payload = Award(
      title: _titleController.text.trim(),
      issuer: _issuerController.text.trim(),
      tier: _selectedTier,
      date: _dateController.text.trim(),
      description: _descriptionController.text.trim(),
      certificateUrl: _certificateUrlController.text.trim(),
      isWinner: _isWinner,
    );

    setState(() => _isSubmitting = true);

    try {
      final api = context.read<ApiClient>();
      final saved = _isEditMode
          ? await api.updateAward(
              widget.initialAward!.id!,
              payload,
              token: token,
            )
          : await api.createAward(payload, token: token);
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(
            _isEditMode ? 'Penghargaan Diperbarui!' : 'Penghargaan Disimpan!',
          ),
          content: Text(
            '${saved.title} (${saved.issuer} - ${saved.tier}) berhasil disimpan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
              child: const Text('Tambah Lagi'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (Navigator.canPop(context)) {
                  Navigator.pop(context, saved);
                } else {
                  _resetForm();
                }
              },
              child: const Text('Kembali ke Daftar'),
            ),
          ],
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      if (e.statusCode == 401) {
        context.read<AuthState>().clearSession();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi habis (401). Silakan login kembali.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menyimpan (${e.statusCode}): ${e.message}'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit Penghargaan' : 'Tambah Penghargaan',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _isEditMode ? null : const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Nama Penghargaan *',
                    hintText: 'Contoh: 1st Place National Hackathon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) => _validateRequired(v, 'Nama penghargaan'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _issuerController,
                  decoration: InputDecoration(
                    labelText: 'Penyelenggara / Issuer *',
                    hintText: 'Contoh: Fasilkom UI',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) => _validateRequired(v, 'Penyelenggara'),
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _selectedTier,
                  decoration: InputDecoration(
                    labelText: 'Tingkat / Tier *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _tierOptions
                      .map(
                        (tier) => DropdownMenuItem<String>(
                          value: tier,
                          child: Text(tier),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) setState(() => _selectedTier = value);
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal / Periode *',
                    hintText: 'Contoh: November 2026',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) => _validateRequired(v, 'Tanggal'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) =>
                      _validateRequired(v, 'Deskripsi', minLength: 5),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _certificateUrlController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    labelText: 'URL Sertifikat (Opsional)',
                    hintText: 'https://example.com/certificate.pdf',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: _validateOptionalUrl,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Tandai sebagai Winner / Juara Utama'),
                  value: _isWinner,
                  onChanged: (val) => setState(() => _isWinner = val),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: _isSubmitting ? null : _handleSubmit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_rounded),
                  label: Text(
                    _isSubmitting
                        ? 'Menyimpan...'
                        : (_isEditMode ? 'Perbarui' : 'Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
