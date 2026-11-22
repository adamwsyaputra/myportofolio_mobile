/// Shared form field validators and date formatting helpers for portfolio forms.
class FormValidators {
  FormValidators._();

  /// Rejects empty or whitespace-only text and enforces optional [maxLength].
  static String? validateRequiredText(
    String? value, {
    required String fieldLabel,
    int? maxLength,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return '$fieldLabel tidak boleh kosong.';
    }
    if (maxLength != null && trimmed.length > maxLength) {
      return '$fieldLabel maksimal $maxLength karakter.';
    }
    return null;
  }

  /// Allows blank input; if provided, requires a valid http or https URL.
  static String? validateOptionalUrl(
    String? value, {
    String fieldLabel = 'URL',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return null;
    }
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        !uri.hasScheme ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return '$fieldLabel harus diawali http:// atau https:// yang valid.';
    }
    return null;
  }

  /// Ensures a start date has been selected.
  static String? validateStartDate(DateTime? startDate) {
    if (startDate == null) {
      return 'Tanggal mulai wajib dipilih.';
    }
    return null;
  }

  /// Ensures end date is present and not before [startDate] when not ongoing.
  static String? validateEndDate({
    required DateTime? startDate,
    required DateTime? endDate,
    required bool isOngoing,
  }) {
    if (isOngoing) {
      return null;
    }
    if (endDate == null) {
      return 'Tanggal selesai wajib dipilih jika pengalaman sudah selesai.';
    }
    if (startDate != null && endDate.isBefore(startDate)) {
      return 'Tanggal selesai tidak boleh sebelum tanggal mulai.';
    }
    return null;
  }

  /// Formats [date] as YYYY-MM-DD for display in form fields and summary dialogs.
  static String formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
