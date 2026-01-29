import 'dart:convert';

void main() {
  // Test Bengali text
  final bengaliText = 'আমি আজ খুব খুশি';
  print('Original: $bengaliText');
  
  // Simulate what happens in the code
  final bytes = utf8.encode(bengaliText);
  print('Bytes: $bytes');
  
  final decoded = utf8.decode(bytes);
  print('Decoded: $decoded');
  
  // Test JSON encoding/decoding
  final json = jsonEncode({'transcript': bengaliText});
  print('JSON: $json');
  
  final parsed = jsonDecode(json);
  print('Parsed: ${parsed['transcript']}');
  
  // Verify
  if (parsed['transcript'] == bengaliText) {
    print('✓ Encoding works correctly!');
  } else {
    print('✗ Encoding failed!');
  }
}
