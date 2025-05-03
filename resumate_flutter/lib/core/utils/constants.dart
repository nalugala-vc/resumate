String getTitleFromTrack(String track) {
  switch (track) {
    case 'ml':
      return 'Machine Learning Engineer';
    case 'frontend':
      return 'Frontend Developer';
    case 'backend':
      return 'Backend Developer';
    default:
      return 'Unknown Track';
  }
}

String formatDateWithLineBreak(DateTime date) {
  final day = date.day;
  final suffix = _getDaySuffix(day);
  final month = _monthName(date.month);
  final year = date.year;

  return "$day$suffix\n$month $year";
}

String _getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String _monthName(int month) {
  const months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month];
}
