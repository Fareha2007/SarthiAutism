import 'package:cloud_firestore/cloud_firestore.dart';

class ParentProfile {
  String name;
  String relationship;
  String phone;
  String city;

  ParentProfile({
    this.name = '',
    this.relationship = 'Mother',
    this.phone = '',
    this.city = 'Pune',
  });
}

class ChildProfile {
  String name;
  DateTime? dob;
  String gender;
  List<String> challenges;
  String supportLevel;
  String? screeningRisk;
  int? quizScore;

  ChildProfile({
    this.name = '',
    this.dob,
    this.gender = 'Boy',
    this.challenges = const [],
    this.supportLevel = 'Moderate',
    this.screeningRisk,
    this.quizScore,
  });

  int get age {
    if (dob == null) return 0;
    final t = DateTime.now();
    int y = t.year - dob!.year;
    if (t.month < dob!.month || (t.month == dob!.month && t.day < dob!.day))
      y--;
    return y;
  }

  ChildProfile copyWith({
    String? name,
    DateTime? dob,
    String? gender,
    List<String>? challenges,
    String? supportLevel,
    String? screeningRisk,
    int? quizScore,
  }) =>
      ChildProfile(
        name: name ?? this.name,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        challenges: challenges ?? this.challenges,
        supportLevel: supportLevel ?? this.supportLevel,
        screeningRisk: screeningRisk ?? this.screeningRisk,
        quizScore: quizScore ?? this.quizScore,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'dob': dob?.toIso8601String(),
        'gender': gender,
        'challenges': challenges,
        'supportLevel': supportLevel,
        'screeningRisk': screeningRisk,
        'quizScore': quizScore,
      };

  factory ChildProfile.fromMap(Map<String, dynamic> map) => ChildProfile(
        name: map['name'] as String? ?? '',
        //  dob: map['dob'] != null ? DateTime.tryParse(map['dob']) : null,
        dob: map['dob'] != null
            ? (map['dob'] is Timestamp
                ? (map['dob'] as Timestamp).toDate()
                : DateTime.tryParse(map['dob'].toString()))
            : null,
        gender: map['gender'] as String? ?? 'Boy',
        challenges: List<String>.from(map['challenges'] ?? []),
        supportLevel: map['supportLevel'] as String? ?? 'Moderate',
        screeningRisk: map['screeningRisk'] as String?,
        quizScore: map['quizScore'] as int?,
      );
}

class Activity {
  final int id;
  final String title, category, icon, duration, instructions, source;
  final List<String> ageGroups, supportLevels;

  const Activity({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.duration,
    required this.instructions,
    required this.source,
    required this.ageGroups,
    required this.supportLevels,
  });
}

class Doctor {
  final String name,
      role,
      rating,
      reviews,
      distance,
      location,
      priceRange,
      languages,
      nextAvailable,
      image;
  final List<String> tags;

  const Doctor({
    required this.name,
    required this.role,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.location,
    required this.priceRange,
    required this.languages,
    required this.nextAvailable,
    required this.image,
    required this.tags,
  });
}

// class GovtScheme {
//   final String name, ministry, description, eligibility, icon;

//   const GovtScheme({
//     required this.name,
//     required this.ministry,
//     required this.description,
//     required this.eligibility,
//     required this.icon,
class GovtScheme {
  final String id;
  final String name;
  final String ministry;
  final String description;
  final String eligibility;
  final String icon;
  final String category;
  final String applyUrl;
  final String phone;
  final String helplineNumber;

  const GovtScheme({
    required this.id,
    required this.name,
    required this.ministry,
    required this.description,
    required this.eligibility,
    required this.icon,
    required this.category,
    this.applyUrl = '',
    this.phone = '',
    this.helplineNumber = '',
  });
}

class Article {
  final String id;
  final String title;
  final String preview;
  final String body;
  final String icon;
  final String tag;
  final String readTime;

  Article({
    required this.id,
    required this.title,
    required this.preview,
    required this.body,
    required this.icon,
    required this.tag,
    required this.readTime,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: (json['id'] as String? ?? '').trim(),
      icon: (json['icon'] as String? ?? '📄').trim(),
      title: (json['title'] as String? ?? '').trim(),
      preview: (json['preview'] as String? ?? '').trim(),
      tag: (json['tag'] as String? ?? 'General').trim(),
      readTime: (json['readTime'] as String? ?? '3 min').trim(),
      body: (json['body'] as String? ?? '').trim(),
    );
  }
}

class SpecialistDoctor {
  final String id, name, qualification, speciality, hospital;
  final String city, state, address, phone, fee, availability, bio;
  final double rating;
  final int reviewCount;
  final List<String> tags, languages, consultationModes;
  final bool isGovt, isFree, offersOnline;
  final String nextSlot;

  const SpecialistDoctor({
    required this.id,
    required this.name,
    required this.qualification,
    required this.speciality,
    required this.hospital,
    required this.city,
    required this.state,
    required this.address,
    required this.phone,
    required this.fee,
    required this.availability,
    required this.bio,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.languages,
    required this.consultationModes,
    required this.isGovt,
    required this.isFree,
    required this.offersOnline,
    required this.nextSlot,
  });

  String get initials => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0])
      .join();
}

class Therapist {
  final String id, name, qualification, type, rciNumber, centre;
  final String city, state, phone, fee;
  final double rating;
  final int reviewCount;
  final List<String> sessionTypes, ageGroups, specialities;
  final bool offersOnline, offersHome;

  const Therapist({
    required this.id,
    required this.name,
    required this.qualification,
    required this.type,
    required this.rciNumber,
    required this.centre,
    required this.city,
    required this.state,
    required this.phone,
    required this.fee,
    required this.rating,
    required this.reviewCount,
    required this.sessionTypes,
    required this.ageGroups,
    required this.specialities,
    required this.offersOnline,
    required this.offersHome,
  });

  String get initials => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0])
      .join();
}

class SpecialistHospital {
  final String id, name, type, address, city, state, phone;
  final String opdDays, opdTime;
  final List<String> services;
  final bool isFree, isGovt, hasInpatient;

  const SpecialistHospital({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.city,
    required this.state,
    required this.phone,
    required this.opdDays,
    required this.opdTime,
    required this.services,
    required this.isFree,
    required this.isGovt,
    required this.hasInpatient,
  });
}

class SpecialistSchool {
  final String id, name, type, board, address, city, state, phone;
  final String ageRange, fees;
  final List<String> therapiesOnCampus;
  final bool isRTE, isResidential;

  const SpecialistSchool({
    required this.id,
    required this.name,
    required this.type,
    required this.board,
    required this.address,
    required this.city,
    required this.state,
    required this.phone,
    required this.ageRange,
    required this.fees,
    required this.therapiesOnCampus,
    required this.isRTE,
    required this.isResidential,
  });
}
