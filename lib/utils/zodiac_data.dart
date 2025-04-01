import 'package:flutter/material.dart';

// Burç tarihleri
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

// Burç uyumlulukları: Aşk, İş ve Arkadaşlık kategorileri altında
const Map<String, Map<String, List<String>>> zodiacCompatibility = {
  'Aries': {
    'love': ['Leo', 'Sagittarius', 'Gemini'],
    'work': ['Aquarius', 'Libra', 'Gemini'],
    'friendship': ['Sagittarius', 'Leo', 'Aquarius'],
  },
  'Taurus': {
    'love': ['Virgo', 'Capricorn', 'Pisces'],
    'work': ['Cancer', 'Capricorn', 'Pisces'],
    'friendship': ['Virgo', 'Capricorn', 'Cancer'],
  },
  'Gemini': {
    'love': ['Libra', 'Aquarius', 'Aries'],
    'work': ['Leo', 'Aquarius', 'Libra'],
    'friendship': ['Aries', 'Leo', 'Sagittarius'],
  },
  'Cancer': {
    'love': ['Scorpio', 'Pisces', 'Taurus'],
    'work': ['Virgo', 'Capricorn', 'Pisces'],
    'friendship': ['Scorpio', 'Pisces', 'Taurus'],
  },
  'Leo': {
    'love': ['Aries', 'Sagittarius', 'Gemini'],
    'work': ['Libra', 'Aquarius', 'Sagittarius'],
    'friendship': ['Aries', 'Gemini', 'Aquarius'],
  },
  'Virgo': {
    'love': ['Taurus', 'Capricorn', 'Cancer'],
    'work': ['Scorpio', 'Pisces', 'Capricorn'],
    'friendship': ['Taurus', 'Capricorn', 'Cancer'],
  },
  'Libra': {
    'love': ['Gemini', 'Aquarius', 'Leo'],
    'work': ['Sagittarius', 'Aquarius', 'Gemini'],
    'friendship': ['Gemini', 'Aquarius', 'Leo'],
  },
  'Scorpio': {
    'love': ['Cancer', 'Pisces', 'Virgo'],
    'work': ['Capricorn', 'Taurus', 'Pisces'],
    'friendship': ['Cancer', 'Pisces', 'Virgo'],
  },
  'Sagittarius': {
    'love': ['Leo', 'Aries', 'Aquarius'],
    'work': ['Libra', 'Aquarius', 'Gemini'],
    'friendship': ['Aries', 'Leo', 'Aquarius'],
  },
  'Capricorn': {
    'love': ['Taurus', 'Virgo', 'Pisces'],
    'work': ['Cancer', 'Virgo', 'Capricorn'],
    'friendship': ['Taurus', 'Virgo', 'Capricorn'],
  },
  'Aquarius': {
    'love': ['Gemini', 'Libra', 'Sagittarius'],
    'work': ['Aries', 'Sagittarius', 'Leo'],
    'friendship': ['Gemini', 'Libra', 'Sagittarius'],
  },
  'Pisces': {
    'love': ['Cancer', 'Scorpio', 'Taurus'],
    'work': ['Capricorn', 'Virgo', 'Taurus'],
    'friendship': ['Cancer', 'Scorpio', 'Capricorn'],
  },
};

// Her burç için overview (genel açıklama) metinleri
const Map<String, String> zodiacOverview = {
  'Aries':
      'Aries enerjik, girişken ve maceracıdır. Doğal liderlik özellikleri sayesinde yeni meydan okumalara cesurca atılır. Hızlı karar verebilme yeteneği ve ateşli yapısıyla çevresine ilham verir, zorluklar karşısında asla geri adım atmaz.',
  'Taurus':
      'Taurus sabırlı, güvenilir ve pratik bir burçtur. Stabilite ve konforu ön planda tutar, maddi güvence arar. İstikrarlı yaklaşımı ve inatçı yapısı sayesinde zorlu durumlarda bile sağlam durur ve çevresi tarafından takdir edilir.',
  'Gemini':
      'Gemini meraklı, iletişimde başarılı ve uyumlu bir burçtur. Sosyal çevresi geniştir, farklı fikirleri kolayca benimser. Esnek zekası sayesinde çevresinde popüler bir figür olup, değişen koşullara hızla uyum sağlar.',
  'Cancer':
      'Cancer duygusal, şefkatli ve sezgisel bir burçtur. Aile ve yakın ilişkilerine büyük önem verir; sevdiklerine karşı koruyucu ve fedakar davranır. İçsel duygu yoğunluğu, empati yeteneğini öne çıkarır.',
  'Leo':
      'Leo kendine güvenen, karizmatik ve tutkulu bir burçtur. Sahne ışıklarını ve ilgi odağı olmayı sever, doğal liderlik vasıflarıyla çevresini etkiler. Yaratıcılığı ve cömertliği sayesinde sosyal hayatta ve iş yaşamında öne çıkar.',
  'Virgo':
      'Virgo analitik, titiz ve çalışkandır. Detaylara verdiği önem ve düzenli yaşam tarzı sayesinde sorunları hızla çözebilir. Eleştirel düşünce yapısı, mükemmeliyetçi yaklaşımını pekiştirir.',
  'Libra':
      'Libra adaletli, diplomatik ve çekici bir burçtur. Denge ve uyum arayışında olan Libra, ilişkilerde dengeyi korur ve estetik anlayışıyla öne çıkar. Doğal arabuluculuğu sayesinde çevresinde sevilen bir figürdür.',
  'Scorpio':
      'Scorpio tutkulu, yoğun ve derin duygulara sahiptir. Gizemli yapısı ve güçlü sezgileriyle çevresinde merak uyandırır. İçsel dünyasındaki karmaşık duygular, hem etkileyici hem de zaman zaman zorlayıcı yönlerini ortaya koyar.',
  'Sagittarius':
      'Sagittarius maceraperest, iyimser ve özgürlüğüne düşkündür. Yeni deneyimlere açık olan Sagittarius, hayatı dolu dolu yaşamayı sever. Pozitif enerjisi ve felsefi bakış açısıyla çevresine ilham verir.',
  'Capricorn':
      'Capricorn disiplinli, sorumluluk sahibi ve hırslıdır. Uzun vadeli hedeflerine ulaşmak için planlı ve kararlı adımlar atar. Gerçekçi yaklaşımı ve çalışkanlığı sayesinde zorlukların üstesinden gelir, çevresi tarafından güvenilir olarak değerlendirilir.',
  'Aquarius':
      'Aquarius yenilikçi, bağımsız ve insancıldır. İlerici düşünceleri ve özgün fikirleriyle toplumsal değişimin öncüsü olur. Sosyal konulardaki duyarlılığı, sıradışı yaklaşımlarıyla dikkat çeker.',
  'Pisces':
      'Pisces duyarlı, sanatsal ve sezgisel bir burçtur. Hayal gücü ve empati yeteneği yüksek olan Pisces, çevresine duygusal derinlik katar. Zaman zaman içsel dünyasında kaybolsa da, bu durum onun yaratıcı yönünü besler.',
};

// Yardımcı fonksiyonlar
List<String> getCompatibleZodiacs(String zodiacName, String category) {
  return zodiacCompatibility[zodiacName.capitalized]?[category] ?? [];
}

String getZodiacOverview(String zodiacName) {
  return zodiacOverview[zodiacName.capitalized] ?? "Genel bilgi bulunamadı.";
}

extension Capitalize on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
