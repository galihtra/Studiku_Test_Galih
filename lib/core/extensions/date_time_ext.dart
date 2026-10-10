// lib/core/extensions/date_time_ext.dart
extension DateTimeExt on DateTime {
  String toFormattedString({bool shortMonth = false}) {
    const fullMonths = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    const shortMonths = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
    ];

    final local = toLocal();
    final minute = local.minute.toString().padLeft(2, '0');
    final monthName =
        shortMonth ? shortMonths[local.month - 1] : fullMonths[local.month - 1];

    return '${local.day} $monthName ${local.year} • ${local.hour}:$minute';
  }
}
