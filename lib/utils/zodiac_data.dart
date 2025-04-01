// 📌 Burç tarihleri için bir harita oluşturduk.
const Map<String, String> zodiacDates = {
  'Aries': "Mart 21 - Nisan 19",
  'Taurus': "Nisan 20 - Mayıs 20",
  'Gemini': "Mayıs 21 - Haziran 20",
  'Cancer': "Haziran 21 - Temmuz 22",
  'Leo': "Temmuz 23 - Ağustos 22",
  'Virgo': "Ağustos 23 - Eylül 22",
  'Libra': "Eylül 23 - Ekim 22",
  'Scorpio': "Ekim 23 - Kasım 21",
  'Sagittarius': "Kasım 22 - Aralık 21",
  'Capricorn': "Aralık 22 - Ocak 19",
  'Aquarius': "Ocak 20 - Şubat 18",
  'Pisces': "Şubat 19 - Mart 20",
};

// 📌 String için capitalize (İlk harfi büyük yap)
extension Capitalize on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

// 📌 Uyumluluk listesi (Burçların en uyumlu olduğu burçlar)
const Map<String, List<String>> zodiacCompatibility = {
  'Aries': ['Leo', 'Sagittarius', 'Gemini', 'Aquarius'],
  'Taurus': ['Virgo', 'Capricorn', 'Cancer', 'Pisces'],
  'Gemini': ['Libra', 'Aquarius', 'Aries', 'Leo'],
  'Cancer': ['Scorpio', 'Pisces', 'Taurus', 'Virgo'],
  'Leo': ['Aries', 'Sagittarius', 'Gemini', 'Libra'],
  'Virgo': ['Taurus', 'Capricorn', 'Cancer', 'Scorpio'],
  'Libra': ['Gemini', 'Aquarius', 'Leo', 'Sagittarius'],
  'Scorpio': ['Cancer', 'Pisces', 'Virgo', 'Capricorn'],
  'Sagittarius': ['Leo', 'Aries', 'Libra', 'Aquarius'],
  'Capricorn': ['Taurus', 'Virgo', 'Scorpio', 'Pisces'],
  'Aquarius': ['Gemini', 'Libra', 'Aries', 'Sagittarius'],
  'Pisces': ['Cancer', 'Scorpio', 'Taurus', 'Capricorn'],
};

// 📌 Bir burcun uyumlu olduğu burçları döndüren fonksiyon
String getCompatibleZodiacs(String zodiacName) {
  return zodiacCompatibility[zodiacName]?.join(', ') ?? 'Bilinmiyor';
}
