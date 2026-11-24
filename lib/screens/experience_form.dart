import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/utils/form_validators.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Form page allowing users to enter and validate a new portfolio experience.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  static const String _defaultCategory = 'Full-Time';

  String _title = '';
  String _category = _defaultCategory;
  String _description = '';
  String _thumbnail = '';
  bool _isOngoing = true;
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _categories = const [
    'Full-Time',
    'Part-Time',
    'Internship',
    'Research',
    'Volunteer',
    'Freelance',
  ];

  Future<void> _pickDate({
    required FormFieldState<DateTime> field,
    required bool isStart,
  }) async {
    final now = DateTime.now();
    final initialDate = isStart
        ? (_startDate ?? now)
        : (_endDate ?? _startDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
    field.didChange(picked);
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _title = '';
      _category = _defaultCategory;
      _description = '';
      _thumbnail = '';
      _isOngoing = true;
      _startDate = null;
      _endDate = null;
    });
  }

  Widget _buildDatePickerField({
    required String label,
    required String placeholder,
    required DateTime? selectedDate,
    required String? Function(DateTime?) validator,
    required bool isStart,
  }) {
    return FormField<DateTime>(
      initialValue: selectedDate,
      validator: (_) => validator(selectedDate),
      builder: (field) {
        final displayText = selectedDate != null
            ? FormValidators.formatDate(selectedDate)
            : placeholder;
        return InkWell(
          onTap: () => _pickDate(field: field, isStart: isStart),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              errorText: field.errorText,
              suffixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Text(
              displayText,
              style: TextStyle(
                color: selectedDate != null ? null : Colors.grey[600],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final thumbnailText = _thumbnail.trim().isEmpty ? '-' : _thumbnail.trim();
    final statusText = _isOngoing
        ? 'Sedang berlangsung'
        : 'Selesai (${FormValidators.formatDate(_endDate!)})';

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Pengalaman berhasil disimpan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Judul: ${_title.trim()}'),
                const SizedBox(height: 4),
                Text('Kategori: $_category'),
                const SizedBox(height: 4),
                Text('Deskripsi: ${_description.trim()}'),
                const SizedBox(height: 4),
                Text('Thumbnail: $thumbnailText'),
                const SizedBox(height: 4),
                Text(
                  'Tanggal Mulai: ${FormValidators.formatDate(_startDate!)}',
                ),
                const SizedBox(height: 4),
                Text('Status: $statusText'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tambah Pengalaman')),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Judul Pengalaman ===
              TextFormField(
                maxLength: 255,
                decoration: InputDecoration(
                  hintText: 'Contoh: Software Engineer Intern',
                  labelText: 'Judul Pengalaman',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                validator: (value) => FormValidators.validateRequiredText(
                  value,
                  fieldLabel: 'Judul pengalaman',
                  maxLength: 255,
                ),
              ),
              const SizedBox(height: 12.0),

              // === Kategori ===
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                initialValue: _defaultCategory,
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  if (newValue == null) return;
                  setState(() {
                    _category = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0),

              // === Deskripsi Peran ===
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ceritakan peran dan kontribusi Anda...',
                  labelText: 'Deskripsi Peran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                validator: (value) => FormValidators.validateRequiredText(
                  value,
                  fieldLabel: 'Deskripsi peran',
                ),
              ),
              const SizedBox(height: 16.0),

              // === URL Thumbnail ===
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'https://example.com/image.png',
                  labelText: 'URL Thumbnail (Opsional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _thumbnail = value;
                  });
                },
                validator: (value) => FormValidators.validateOptionalUrl(
                  value,
                  fieldLabel: 'URL thumbnail',
                ),
              ),
              const SizedBox(height: 16.0),

              // === Tanggal Mulai ===
              _buildDatePickerField(
                label: 'Tanggal Mulai',
                placeholder: 'Pilih tanggal mulai',
                selectedDate: _startDate,
                validator: FormValidators.validateStartDate,
                isStart: true,
              ),
              const SizedBox(height: 8.0),

              // === Sedang Berlangsung ===
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sedang Berlangsung'),
                subtitle: const Text(
                  'Aktifkan jika pengalaman ini masih berjalan',
                ),
                value: _isOngoing,
                onChanged: (value) {
                  setState(() {
                    _isOngoing = value;
                    if (_isOngoing) {
                      _endDate = null;
                    }
                  });
                },
              ),

              // === Tanggal Selesai (hanya muncul jika tidak ongoing) ===
              if (!_isOngoing) ...[
                const SizedBox(height: 8.0),
                _buildDatePickerField(
                  label: 'Tanggal Selesai',
                  placeholder: 'Pilih tanggal selesai',
                  selectedDate: _endDate,
                  validator: (value) => FormValidators.validateEndDate(
                    startDate: _startDate,
                    endDate: value,
                    isOngoing: _isOngoing,
                  ),
                  isStart: false,
                ),
              ],
              const SizedBox(height: 20.0),

              // === Tombol Simpan ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
