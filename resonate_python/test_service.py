"""
Test script for Resonate Python AI Service
Tests all endpoints without requiring actual audio files
"""

import requests
import json
from io import BytesIO
import numpy as np
import soundfile as sf

BASE_URL = "https://resonate-vole.onrender.com"


def create_test_audio():
    """Create a simple test audio file (1 second of sine wave)"""
    sample_rate = 22050
    duration = 1.0
    frequency = 440.0  # A4 note
    
    t = np.linspace(0, duration, int(sample_rate * duration))
    audio = np.sin(2 * np.pi * frequency * t)
    
    # Create in-memory audio file
    buffer = BytesIO()
    sf.write(buffer, audio, sample_rate, format='WAV')
    buffer.seek(0)
    
    return buffer


def test_health():
    """Test health check endpoint"""
    print("\n1. Testing /health endpoint...")
    try:
        response = requests.get(f"{BASE_URL}/health")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {response.json()}")
        return response.status_code == 200
    except Exception as e:
        print(f"   ERROR: {e}")
        return False


def test_languages():
    """Test languages endpoint"""
    print("\n2. Testing /languages endpoint...")
    try:
        response = requests.get(f"{BASE_URL}/languages")
        print(f"   Status: {response.status_code}")
        print(f"   Response: {response.json()}")
        return response.status_code == 200
    except Exception as e:
        print(f"   ERROR: {e}")
        return False


def test_acoustic_analysis():
    """Test acoustic analysis endpoint"""
    print("\n3. Testing /analyze/acoustic endpoint...")
    try:
        audio_buffer = create_test_audio()
        files = {'audio': ('test.wav', audio_buffer, 'audio/wav')}
        
        response = requests.post(f"{BASE_URL}/analyze/acoustic", files=files)
        print(f"   Status: {response.status_code}")
        
        if response.status_code == 200:
            data = response.json()
            print(f"   Duration: {data.get('duration_seconds', 0):.2f}s")
            print(f"   Acoustic Mood: {data.get('mood_label', 'unknown')}")
            print(f"   Mood Score: {data.get('acoustic_mood_score', 0):.2f}")
        else:
            print(f"   Response: {response.text}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"   ERROR: {e}")
        return False


def test_full_analysis():
    """Test full analysis endpoint"""
    print("\n4. Testing /analyze endpoint (full analysis)...")
    try:
        audio_buffer = create_test_audio()
        files = {'audio': ('test.wav', audio_buffer, 'audio/wav')}
        data = {
            'language': 'en',
            'privacy_level': 'acoustic'  # Use acoustic only to avoid transcription
        }
        
        response = requests.post(f"{BASE_URL}/analyze", files=files, data=data)
        print(f"   Status: {response.status_code}")
        
        if response.status_code == 200:
            result = response.json()
            print(f"   Acoustic Mood: {result['acoustic'].get('mood_label', 'unknown')}")
            print(f"   Final Mood: {result['fusion'].get('mood_label', 'unknown')}")
            print(f"   Confidence: {result['fusion'].get('confidence', 0):.2f}")
        else:
            print(f"   Response: {response.text}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"   ERROR: {e}")
        return False


def test_insight_generation():
    """Test insight generation endpoint"""
    print("\n5. Testing /insights/generate endpoint...")
    try:
        mood_history = [
            {
                "date": "2026-01-20",
                "mood_score": 0.72,
                "mood_label": "positive",
                "emotions": ["happy", "hopeful"]
            },
            {
                "date": "2026-01-21",
                "mood_score": 0.65,
                "mood_label": "positive",
                "emotions": ["grateful"]
            },
            {
                "date": "2026-01-22",
                "mood_score": 0.58,
                "mood_label": "neutral",
                "emotions": ["neutral"]
            }
        ]
        
        payload = {
            "mood_history": mood_history,
            "type": "weekly_summary"
        }
        
        response = requests.post(
            f"{BASE_URL}/insights/generate",
            json=payload,
            headers={'Content-Type': 'application/json'}
        )
        
        print(f"   Status: {response.status_code}")
        
        if response.status_code == 200:
            result = response.json()
            print(f"   Insight Type: {result.get('insight_type', 'unknown')}")
            print(f"   Insight: {result.get('insight_text', 'N/A')[:100]}...")
        else:
            print(f"   Response: {response.text}")
        
        return response.status_code == 200
    except Exception as e:
        print(f"   ERROR: {e}")
        return False


def main():
    """Run all tests"""
    print("=" * 60)
    print("Resonate Python AI Service - Test Suite")
    print("=" * 60)
    
    # Check if service is running
    try:
        requests.get(f"{BASE_URL}/health", timeout=2)
    except requests.exceptions.ConnectionError:
        print("\nERROR: Service is not running!")
        print("Please start the service first: python app.py")
        return
    
    # Run tests
    results = {
        "Health Check": test_health(),
        "Languages": test_languages(),
        "Acoustic Analysis": test_acoustic_analysis(),
        "Full Analysis": test_full_analysis(),
        "Insight Generation": test_insight_generation()
    }
    
    # Summary
    print("\n" + "=" * 60)
    print("Test Summary")
    print("=" * 60)
    
    for test_name, passed in results.items():
        status = "✓ PASS" if passed else "✗ FAIL"
        print(f"{test_name:.<40} {status}")
    
    total = len(results)
    passed = sum(results.values())
    print(f"\nTotal: {passed}/{total} tests passed")
    
    if passed == total:
        print("\n🎉 All tests passed!")
    else:
        print(f"\n⚠️  {total - passed} test(s) failed")


if __name__ == "__main__":
    main()
