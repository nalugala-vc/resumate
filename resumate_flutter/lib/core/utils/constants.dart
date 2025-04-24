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
