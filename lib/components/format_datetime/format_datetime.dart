String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  final hours = dateTime.hour.toString().padLeft(2, '0');
  final minutes = dateTime.minute.toString().padLeft(2, '0');

  if (dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day) {
    return 'Today At $hours:$minutes';
  } else if (dateTime.year == tomorrow.year &&
      dateTime.month == tomorrow.month &&
      dateTime.day == tomorrow.day) {
    return 'Tomorrow At ${dateTime.hour}:${dateTime.minute}';
  } else {
    // Sử dụng một định dạng ngày tháng tùy ý nếu không phải "today" hoặc "tomorrow"
    final formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return '$formattedDate At $hours:$minutes';
  }
}
