"""
Test Bengali text encoding in JSON responses
"""
import json

# Test Bengali text
bengali_text = "আমি আজ খুব খুশি"
print(f"Original Bengali text: {bengali_text}")

# Test JSON encoding
json_data = {
    "transcript": bengali_text,
    "language": "bn"
}

# Encode to JSON (default UTF-8)
json_string = json.dumps(json_data, ensure_ascii=False)
print(f"JSON string: {json_string}")

# Decode back
decoded_data = json.loads(json_string)
print(f"Decoded transcript: {decoded_data['transcript']}")

# Verify
if decoded_data['transcript'] == bengali_text:
    print("✓ Bengali encoding/decoding works correctly!")
else:
    print("✗ Bengali encoding/decoding failed!")
