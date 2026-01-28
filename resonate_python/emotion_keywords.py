"""
Emotion keyword dictionaries for English and Bengali
Used for emotion detection from transcripts
"""

EMOTION_KEYWORDS = {
    'en': {
        'happy': [
            'happy', 'joy', 'joyful', 'excited', 'great', 'wonderful', 'amazing',
            'fantastic', 'excellent', 'good', 'glad', 'pleased', 'delighted',
            'cheerful', 'content', 'satisfied', 'thrilled', 'ecstatic'
        ],
        'sad': [
            'sad', 'unhappy', 'depressed', 'down', 'blue', 'miserable', 'upset',
            'disappointed', 'heartbroken', 'gloomy', 'melancholy', 'sorrowful',
            'crying', 'tears', 'hurt', 'pain'
        ],
        'angry': [
            'angry', 'mad', 'furious', 'annoyed', 'irritated', 'frustrated',
            'rage', 'outraged', 'pissed', 'upset', 'bothered', 'aggravated'
        ],
        'anxious': [
            'anxious', 'worried', 'nervous', 'stressed', 'tense', 'uneasy',
            'concerned', 'afraid', 'scared', 'fearful', 'panic', 'overwhelmed'
        ],
        'grateful': [
            'grateful', 'thankful', 'blessed', 'appreciate', 'fortunate',
            'lucky', 'thank', 'thanks'
        ],
        'hopeful': [
            'hopeful', 'optimistic', 'positive', 'confident', 'looking forward',
            'excited about', 'can\'t wait'
        ],
        'lonely': [
            'lonely', 'alone', 'isolated', 'disconnected', 'abandoned',
            'left out', 'nobody'
        ],
        'loved': [
            'loved', 'love', 'caring', 'supported', 'appreciated',
            'valued', 'cherished'
        ],
        'tired': [
            'tired', 'exhausted', 'drained', 'fatigued', 'weary',
            'worn out', 'sleepy'
        ],
        'proud': [
            'proud', 'accomplished', 'achieved', 'success', 'successful',
            'did it', 'made it'
        ]
    },
    'bn': {
        'happy': [
            'খুশি', 'আনন্দ', 'ভালো', 'সুন্দর', 'চমৎকার', 'দারুণ',
            'মজা', 'হাসি', 'প্রসন্ন'
        ],
        'sad': [
            'দুঃখ', 'কষ্ট', 'খারাপ', 'মন খারাপ', 'বিষণ্ণ', 'হতাশ',
            'কান্না', 'ব্যথা'
        ],
        'angry': [
            'রাগ', 'ক্রোধ', 'বিরক্ত', 'ক্ষুব্ধ', 'রেগে', 'গোস্সা'
        ],
        'anxious': [
            'চিন্তা', 'উদ্বিগ্ন', 'ভয়', 'টেনশন', 'দুশ্চিন্তা', 'ঘাবড়ে',
            'আতঙ্ক'
        ],
        'grateful': [
            'কৃতজ্ঞ', 'ধন্যবাদ', 'শুকরিয়া', 'ভাগ্যবান'
        ],
        'hopeful': [
            'আশা', 'আশাবাদী', 'ইতিবাচক', 'আত্মবিশ্বাসী'
        ],
        'lonely': [
            'একা', 'নিঃসঙ্গ', 'বিচ্ছিন্ন', 'একাকী'
        ],
        'loved': [
            'ভালোবাসা', 'ভালোবাসি', 'ভালোবাসেন', 'স্নেহ', 'মমতা'
        ],
        'tired': [
            'ক্লান্ত', 'থাকা', 'ঘুম', 'শ্রান্ত'
        ],
        'proud': [
            'গর্বিত', 'গর্ব', 'সফল', 'সফলতা', 'অর্জন'
        ]
    }
}
