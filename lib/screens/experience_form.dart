import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _proofUrlController = TextEditingController();

  static const List<String> _experienceTypes = [
    'Magang (Internship)',
    'Organisasi dan Kepanitiaan',
    'Asisten Dosen atau Riset',
    'Paruh Waktu (Part-time)',
    'Sukarelawan (Volunteer)',
  ];

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String _experienceType = _experienceTypes.first;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isCurrent = false;

  @override
  void dispose() {
    _roleController.dispose();
    _organizationController.dispose();
    _descriptionController.dispose();
    _proofUrlController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day} ${_monthNames[date.month -1]}${date.year}';
  }

  String _calculateDurationText() {
    if (_startDate == null) return '-';
    final DateTime end = _isCurrent ? DateTime.now() : (_endDate ?? _startDate!);
    int totalMonths = (end.year - _startDate!.year) * 12 + (end.month - _startDate!.month);
    if (end.day >= _startDate!.day) {
      totalMonths += 1;
    }
    if (totalMonths <= 0) totalMonths = 1;

    final int years = totalMonths ~/12;
    final int months = totalMonths % 12;
    
    if (years > 0 && months > 0) {
      return '$years tahun$months bulan';
    } else if (years > 0) {
      return '$years tahun';
    }
    return '$months bulan';
  }

  String? _validateRequiredText(
    String? value, {
      required String fieldLabel,
      required int minLength,
      required int maxLength, 
    }) {
      if (value == null || value.trim().isEmpty) {
        return '$fieldLabel tidak boleh kosong!';
      }
      final String trimmed = value.trim();
      if (trimmed.length < minLength) {
        return '$fieldLabel minimal terdiri dari$minLength karakter.';
      }
      if (trimmed.length > maxLength) {
        return '$fieldLabel maksimal$maxLength karakter.';
      }
      return null;
    }

    String? _validateOptionalUrl(String? value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }
      final Uri? uri = Uri.tryParse(value.trim());
      final bool hasValidScheme = uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
      final bool hasValidHost = uri != null && uri.host.isNotEmpty && uri.host.contains('.');

      if (!hasValidScheme || !hasValidHost) {
        return 'URL tidak valid. Awali dengan http:// atau https://';
      }
      return null;
    }

    Future<void> _pickDate({
      required FormFieldState<DateTime> fieldState,
      required bool isStart,
    }) async {
      final DateTime now = DateTime.now();
      final DateTime initialDate = isStart ? (_startDate ?? now) : (_endDate ?? _startDate ?? now);

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2035),
        helpText: isStart ? 'Pilih Tanggal Mulai' : 'Pilih Tanggal Selesai',
        cancelText: 'Batal',
        confirmText: 'Pilih', 
      );

      if (picked != null) {
        setState(() {
          if (isStart) {
            _startDate = picked;
          } else {
            _endDate = picked;
          }
        });
        fieldState.didChange(picked);
      }
    }

    void _resetForm() {
    _formKey.currentState?.reset();
    _roleController.clear();
    _organizationController.clear();
    _descriptionController.clear();
    _proofUrlController.clear();
    setState(() {
      _experienceType = _experienceTypes.first;
      _startDate = null;
      _endDate = null;
      _isCurrent = false;
    });      
    }

    void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String role = _roleController.text.trim();
    final String organization = _organizationController.text.trim();
    final String description = _descriptionController.text.trim();
    final String proofUrl = _proofUrlController.text.trim();
    final String startLabel =
        _startDate != null ? _formatDate(_startDate!) : '-';
    final String endLabel = _isCurrent
        ? 'Sekarang'
        : (_endDate != null ? _formatDate(_endDate!) : '-');
    final String durationLabel = _calculateDurationText();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        final ColorScheme colorScheme = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: colorScheme.primary,
                size: 26.0,
              ),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'Pengalaman Disimpan!',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _SummaryRow(label: 'Posisi / Peran', value: role),
                _SummaryRow(label: 'Organisasi / Instansi', value: organization),
                _SummaryRow(label: 'Tipe Pengalaman', value: _experienceType),
                _SummaryRow(
                  label: 'Periode',
                  value: '$startLabel – $endLabel ($durationLabel)',
                ),
                _SummaryRow(label: 'Deskripsi', value: description),
                _SummaryRow(
                  label: 'Tautan Bukti',
                  value: proofUrl.isEmpty ? 'Tidak dilampirkan' : proofUrl,
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );      
    }
@override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pengalaman',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header pengantar formulir
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.work_history_outlined,
                        color: colorScheme.primary,
                        size: 24.0,
                      ),
                      const SizedBox(width: 12.0),
                      const Expanded(
                        child: Text(
                          'Catat pengalaman magang, organisasi, kepanitiaan, atau riset ke dalam portofolio.',
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),

                // 1. Posisi / Peran
                TextFormField(
                  controller: _roleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Posisi / Peran *',
                    hintText: 'Contoh: Software Engineer Intern',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) => _validateRequiredText(
                    value,
                    fieldLabel: 'Posisi atau peran',
                    minLength: 3,
                    maxLength: 100,
                  ),
                ),

                const SizedBox(height: 14.0),

                // 2. Organisasi / Perusahaan
                TextFormField(
                  controller: _organizationController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Organisasi / Perusahaan *',
                    hintText: 'Contoh: RISTEK Fasilkom UI',
                    prefixIcon: const Icon(Icons.business_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) => _validateRequiredText(
                    value,
                    fieldLabel: 'Nama organisasi/perusahaan',
                    minLength: 2,
                    maxLength: 100,
                  ),
                ),

                const SizedBox(height: 14.0),

                // 3. Tipe Pengalaman
                DropdownButtonFormField<String>(
                  initialValue: _experienceType,
                  decoration: InputDecoration(
                    labelText: 'Tipe Pengalaman *',
                    prefixIcon: const Icon(Icons.category_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: _experienceTypes
                      .map(
                        (String type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _experienceType = newValue;
                      });
                    }
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Pilih tipe pengalaman terlebih dahulu.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 14.0),

                // 4. Tanggal Mulai (showDatePicker terintegrasi FormField)
                FormField<DateTime>(
                  validator: (_) {
                    if (_startDate == null) {
                      return 'Tanggal mulai wajib dipilih.';
                    }
                    if (_startDate!.isAfter(DateTime.now())) {
                      return 'Tanggal mulai tidak boleh melebihi hari ini.';
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> fieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () => _pickDate(
                            fieldState: fieldState,
                            isStart: true,
                          ),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Tanggal Mulai *',
                              prefixIcon: const Icon(Icons.event_outlined),
                              suffixIcon: const Icon(Icons.calendar_today),
                              errorText: fieldState.errorText,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              _startDate != null
                                  ? _formatDate(_startDate!)
                                  : 'Pilih tanggal mulai',
                              style: TextStyle(
                                color: _startDate != null
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 8.0),

                // Fitur ekstra UX: Switch masih aktif saat ini
                SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  title: const Text(
                    'Saat ini masih aktif di posisi ini',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  value: _isCurrent,
                  onChanged: (bool value) {
                    setState(() {
                      _isCurrent = value;
                      if (_isCurrent) {
                        _endDate = null;
                      }
                    });
                  },
                ),

                const SizedBox(height: 6.0),

                // 5. Tanggal Selesai (nonaktif otomatis jika _isCurrent == true)
                FormField<DateTime>(
                  validator: (_) {
                    if (_isCurrent) return null;
                    if (_endDate == null) {
                      return 'Tanggal selesai wajib dipilih jika tidak sedang aktif.';
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai tidak boleh lebih awal dari tanggal mulai.';
                    }
                    return null;
                  },
                  builder: (FormFieldState<DateTime> fieldState) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: _isCurrent
                          ? null
                          : () => _pickDate(
                                fieldState: fieldState,
                                isStart: false,
                              ),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Tanggal Selesai',
                          enabled: !_isCurrent,
                          prefixIcon: const Icon(Icons.event_available_outlined),
                          suffixIcon: const Icon(Icons.calendar_today),
                          errorText: _isCurrent ? null : fieldState.errorText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          _isCurrent
                              ? 'Sekarang (Masih aktif)'
                              : (_endDate != null
                                  ? _formatDate(_endDate!)
                                  : 'Pilih tanggal selesai'),
                          style: TextStyle(
                            color: (!_isCurrent && _endDate != null)
                                ? colorScheme.onSurface
                                : colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 14.0),

                // 6. Deskripsi & Pencapaian
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  maxLength: 500,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi & Pencapaian *',
                    hintText:
                        'Jelaskan tanggung jawab utama dan dampak yang dihasilkan...',
                    alignLabelWithHint: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 56.0),
                      child: Icon(Icons.description_outlined),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (String? value) => _validateRequiredText(
                    value,
                    fieldLabel: 'Deskripsi pengalaman',
                    minLength: 10,
                    maxLength: 500,
                  ),
                ),

                const SizedBox(height: 10.0),

                // 7. Tautan Bukti / Sertifikat (Opsional dengan validasi URL)
                TextFormField(
                  controller: _proofUrlController,
                  keyboardType: TextInputType.url,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Tautan Bukti / Sertifikat (Opsional)',
                    hintText: 'https://linkedin.com/... atau https://drive.google.com/...',
                    prefixIcon: const Icon(Icons.link_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: _validateOptionalUrl,
                ),

                const SizedBox(height: 22.0),

                // Baris tombol Reset dan Simpan agar tetap terjangkau di layar sempit
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton.icon(
                        onPressed: _resetForm,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: _handleSubmit,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text(
                          'Simpan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({
    required this.label,
    required this.value,
  });

@override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            value,
            style: const TextStyle(fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}