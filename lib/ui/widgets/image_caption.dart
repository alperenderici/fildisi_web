String captionFromAssetPath(String assetPath) {
  final file = assetPath.split('/').last;
  final noExt = file.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), '');
  final normalized = noExt.replaceAll('_', ' ').trim();
  if (normalized.isEmpty) return '';

  // Simple title-case-ish: keep Turkish chars as-is.
  final parts = normalized.split(RegExp(r'\s+'));
  final mapped = parts.map((p) {
    if (p.isEmpty) return p;
    final lower = p.toLowerCase();
    return lower[0].toUpperCase() + lower.substring(1);
  }).toList();
  return mapped.join(' ');
}
