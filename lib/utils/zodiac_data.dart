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

// Uyumsuz burçlar: Aşk, İş ve Arkadaşlık kategorileri altında
const Map<String, Map<String, List<String>>> zodiacIncompatibility = {
  'Aries': {
    'love': ['Taurus', 'Cancer', 'Capricorn'],
    'work': ['Taurus', 'Cancer', 'Capricorn'],
    'friendship': ['Taurus', 'Virgo', 'Pisces'],
  },
  'Taurus': {
    'love': ['Aries', 'Gemini', 'Sagittarius'],
    'work': ['Aries', 'Gemini', 'Sagittarius'],
    'friendship': ['Aries', 'Gemini', 'Sagittarius'],
  },
  'Gemini': {
    'love': ['Taurus', 'Cancer', 'Capricorn'],
    'work': ['Taurus', 'Cancer', 'Capricorn'],
    'friendship': ['Taurus', 'Cancer', 'Capricorn'],
  },
  'Cancer': {
    'love': ['Aries', 'Gemini', 'Sagittarius'],
    'work': ['Aries', 'Gemini', 'Sagittarius'],
    'friendship': ['Aries', 'Gemini', 'Sagittarius'],
  },
  'Leo': {
    'love': ['Taurus', 'Cancer', 'Capricorn'],
    'work': ['Taurus', 'Cancer', 'Capricorn'],
    'friendship': ['Taurus', 'Cancer', 'Capricorn'],
  },
  'Virgo': {
    'love': ['Aries', 'Gemini', 'Sagittarius'],
    'work': ['Aries', 'Gemini', 'Sagittarius'],
    'friendship': ['Aries', 'Gemini', 'Sagittarius'],
  },
  'Libra': {
    'love': ['Taurus', 'Scorpio', 'Capricorn'],
    'work': ['Taurus', 'Scorpio', 'Capricorn'],
    'friendship': ['Taurus', 'Scorpio', 'Capricorn'],
  },
  'Scorpio': {
    'love': ['Aries', 'Libra', 'Aquarius'],
    'work': ['Aries', 'Libra', 'Aquarius'],
    'friendship': ['Aries', 'Libra', 'Aquarius'],
  },
  'Sagittarius': {
    'love': ['Taurus', 'Virgo', 'Cancer'],
    'work': ['Taurus', 'Virgo', 'Cancer'],
    'friendship': ['Taurus', 'Virgo', 'Cancer'],
  },
  'Capricorn': {
    'love': ['Aries', 'Gemini', 'Leo'],
    'work': ['Aries', 'Gemini', 'Leo'],
    'friendship': ['Aries', 'Gemini', 'Leo'],
  },
  'Aquarius': {
    'love': ['Taurus', 'Cancer', 'Virgo'],
    'work': ['Taurus', 'Cancer', 'Virgo'],
    'friendship': ['Taurus', 'Cancer', 'Virgo'],
  },
  'Pisces': {
    'love': ['Aries', 'Gemini', 'Leo'],
    'work': ['Aries', 'Gemini', 'Leo'],
    'friendship': ['Aries', 'Gemini', 'Leo'],
  },
};

// Her burç için overview (genel açıklama) metinleri
const Map<String, String> zodiacOverview = {
  'Aries':
      'Aries enerjik, girişken ve maceracı bir burçtur. Doğal liderlik özellikleri sayesinde her yeni meydan okumaya cesurca atılır. Hızlı karar verebilme yeteneği, ateşli yapısı ve inatçı ruhu, onu zorluklarla başa çıkmada eşsiz kılar. Enerjisini ve coşkusunu etrafına yayan Aries, spontane hareketleriyle hayatın her anını dolu dolu yaşamayı sever. Cesareti ve yenilikçi bakış açısıyla, hayatına sürekli yeni bir soluk katar.',
  'Taurus':
      'Taurus sabırlı, güvenilir ve pratik bir burçtur. Stabilite ve konforu yaşamının merkezine koyar; maddi ve manevi güvence arayışındadır. İnatçı ve kararlı yapısı, zorlu koşullarda bile sarsılmaz bir duruş sergilemesine olanak tanır. Doğayla ve sanatsal değerlere olan yakınlığı, Taurus’un yaşamındaki dengeyi ve huzuru pekiştirir. Bu sağlam temelleri sayesinde, yaşamın her alanında istikrarını korur.',
  'Gemini':
      'Gemini meraklı, iletişimde başarılı ve uyumlu kişiliğiyle dikkat çeker. Zekası, esnek düşünce yapısı ve değişime olan açıklığı sayesinde her türlü sosyal ortamda kolaylıkla uyum sağlar. Geniş arkadaş çevresi ve sürekli bilgi arayışı, Gemini’nin yaşamına renk katar. Her yeni deneyimle kendini yenileyen bu burç, entelektüel merakını da doyasıya yaşar. Sosyal çevresi ve iletişim becerileri, ona sürekli yeni kapılar açar.',
  'Cancer':
      'Cancer duygusal, şefkatli ve sezgisel bir burçtur. Aile ve yakın ilişkilerine büyük önem verir; sevdiklerine karşı koruyucu ve fedakar bir tavır sergiler. Zengin iç dünyası ve derin duygusal bağlantıları, onun empati yeteneğini güçlendirir. Evini ve sevdiklerini sarmalayan sıcaklık, Cancer için yaşamın en değerli hazinesidir. Duygusal derinliğiyle, çevresine samimi bir bağlılık sunar.',
  'Leo':
      'Leo kendine güvenen, karizmatik ve tutkulu bir burçtur. Sahne ışıklarını ve ilgi odağı olmayı seven Leo, doğal liderlik vasıflarıyla çevresini etkiler. Yaratıcılığı, cömertliği ve coşkulu enerjisi sayesinde sosyal ortamlarda öne çıkar. Onun canlı kişiliği, hem iş hayatında hem de özel yaşantısında ilham verici bir etki yaratır. Kendine olan inancı ve coşkusuyla, etrafındakilere ilham kaynağı olur.',
  'Virgo':
      'Virgo analitik, titiz ve çalışkandır. Detaylara gösterdiği özen ve mükemmeliyetçi yaklaşımı, onu her türlü sorunu çözmede başarılı kılar. Gerçekçi düşünce yapısı ve disiplinli yaşam tarzı, Virgo’nun iş ve özel hayatında düzeni sağlamasına yardımcı olur. Planlı ve metodik yaklaşımı, çevresindeki insanlar tarafından büyük takdir görür. Titizliği ve sistematik düşüncesi, yaşamındaki düzeni pekiştirir.',
  'Libra':
      'Libra adaletli, diplomatik ve çekici bir burçtur. Denge ve uyum arayışı, Libra’nın sosyal ilişkilerinde en belirgin özelliklerindendir. Hem kişisel hem de toplumsal ilişkilerde dengeyi sağlamak için özenle çalışır. Estetik duyarlılığı ve zarafeti, onu sanatsal alanlarda ön plana çıkarırken, doğal arabuluculuk yeteneğiyle çevresindeki insanlara huzur verir. Zarafet ve uyum arayışı, onun yaşamına eşsiz bir estetik derinlik katar.',
  'Scorpio':
      'Scorpio tutkulu, yoğun ve derin duygulara sahip bir burçtur. Gizemli yapısı ve güçlü sezgileri, çevresindeki insanlarda merak uyandırır. İçsel dünyasındaki karmaşıklık, onun duygusal derinliğini ve dayanıklılığını ortaya koyar. Tutkuları ve derin ilişkileri, Scorpio’nun yaşamını anlamlı kılan temel öğelerdendir; bu yüzden her anı yoğun yaşar. Yoğun tutkuları ve sezgisel gücü, çevresinde derin izler bırakır.',
  'Sagittarius':
      'Sagittarius maceraperest, iyimser ve özgürlüğüne düşkündür. Yeni deneyimlere ve keşiflere olan tutkusu, yaşamına sürekli hareket katar. Geniş vizyonu ve felsefi bakış açısıyla çevresindeki insanlara ilham verir. Her yeni yolculuk, Sagittarius için bilgi ve deneyim birikimini artırırken, hayatı doyasıya yaşamanın önemini de pekiştirir. Açık fikirliliği ve maceracı ruhu, ona sürekli yenilikler sunar.',
  'Capricorn':
      'Capricorn disiplinli, sorumluluk sahibi ve hırslıdır. Uzun vadeli hedeflerine ulaşmak için titizlikle plan yapar ve kararlı adımlarla ilerler. Gerçekçi yaklaşımı ve çalışkanlığı, ona karşılaşılan zorlukların üstesinden gelmede yardımcı olur. Başarıya ulaşmak için gösterdiği özveri, Capricorn’u güvenilir ve saygı duyulan bir lider haline getirir. Azmi ve kararlılığı, her engeli aşmasını sağlayan temel güçtür.',
  'Aquarius':
      'Aquarius yenilikçi, bağımsız ve insancıldır. Farklı düşünce yapısı ve özgün yaklaşımları sayesinde toplumsal değişimin öncüsü olur. İleri görüşlü ve yaratıcı zekası, onu sıradışı fikirlerle donatır. Bireysellik ve özgürlük, Aquarius için yaşamın temel yapı taşlarıdır; bu nedenle sürekli yeniliklere açık ve orijinal çözümler üretir. Yaratıcı düşünceleriyle, geleceğe dair umut verici adımlar atar.',
  'Pisces':
      'Pisces duyarlı, sanatsal ve sezgisel bir burçtur. Zengin hayal gücü ve yüksek empati yeteneği, onun duygusal dünyasını derinleştirir. Sanata ve estetiğe olan tutkusu, çevresindeki insanlara ilham verirken, içsel dünyasında yaratıcılığı besleyen kaynakları oluşturur. Hayatın akışına kendini bırakabilen Pisces, duygusal zenginliğini ve romantik bakış açısını yaşamına yansıtır. Duygusallığı ve sanatsal yeteneği, onu benzersiz kılan önemli unsurlardandır.',
};

// Yardımcı fonksiyonlar
List<String> getCompatibleZodiacs(String zodiacName, String category) {
  return zodiacCompatibility[zodiacName.capitalized]?[category] ?? [];
}

String getZodiacOverview(String zodiacName) {
  return zodiacOverview[zodiacName.capitalized] ?? "Genel bilgi bulunamadı.";
}

List<String> getIncompatibleZodiacs(String zodiacName, String category) {
  return zodiacIncompatibility[zodiacName.capitalized]?[category] ?? [];
}

extension Capitalize on String {
  String get capitalized =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
