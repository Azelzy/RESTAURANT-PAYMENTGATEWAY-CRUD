// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'dart:convert';

// --- MAIN PARSING FUNCTIONS ---

MangaModel mangaModelFromJson(String str) =>
    MangaModel.fromJson(json.decode(str));
String mangaModelToJson(MangaModel data) => json.encode(data.toJson());

// --------------------------------------------------------------------------------
// KELAS MODEL UTAMA UNTUK PARSING API RESPONSE
// --------------------------------------------------------------------------------

class MangaModel {
  final String result;
  final String response;
  final List<Datum> data;
  final int limit;
  final int offset;
  final int total;

  MangaModel({
    required this.result,
    required this.response,
    required this.data,
    required this.limit,
    required this.offset,
    required this.total,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) => MangaModel(
    result: json["result"],
    response: json["response"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    limit: json["limit"],
    offset: json["offset"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "response": response,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "limit": limit,
    "offset": offset,
    "total": total,
  };
}

// --------------------------------------------------------------------------------
// KELAS REPRESENTASI DATA MANGA UNTUK UI (DENGAN KOREKSI COVER IMAGE)
// --------------------------------------------------------------------------------

class Manga {
  final String id;
  final String title;
  final String? description;
  final String? status;
  final int? year;
  final List<String> tags;
  final String? coverImageUrl; // langsung URL siap pakai

  Manga({
    required this.id,
    required this.title,
    this.description,
    this.status,
    this.year,
    required this.tags,
    this.coverImageUrl,
  });

  // Factory untuk mengonversi data mentah API (Map<String, dynamic>) menjadi objek Manga siap pakai.
  factory Manga.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] ?? {};
    final relationships = json['relationships'] ?? [];
    final mangaId = json['id'];

    // Ambil title dari attributes['title']['en'] atau title['jaRo'] jika en null
    String title =
        attributes['title']?['en'] ??
        attributes['title']?['jaRo'] ??
        "No Title";

    // Ambil tags
    List<String> tags = [];
    if (attributes['tags'] != null && attributes['tags'] is List) {
      tags = (attributes['tags'] as List)
          .map((t) => t['attributes']?['name']?['en'] ?? "")
          .whereType<String>()
          .toList();
    }

    // Cari cover_art relationship
    String? coverFileName;
    for (var rel in relationships) {
      if (rel['type'] == 'cover_art' && rel['attributes'] != null) {
        coverFileName = rel['attributes']['fileName'];
        break;
      }
    }

    String? finalCoverUrl;
    if (coverFileName != null && coverFileName.isNotEmpty) {
      finalCoverUrl =
          "https://uploads.mangadex.org/covers/$mangaId/$coverFileName.256.jpg";
    }

    return Manga(
      id: mangaId,
      title: title,
      description: attributes['description']?['en'],
      status: attributes['status'],
      year: attributes['year'],
      tags: tags,
      coverImageUrl: finalCoverUrl,
    );
  }

  // Tambahkan method copyWithCover agar controller bisa update cover dari includes
  Manga copyWithCover(Map<String, dynamic>? coverJson) {
    if (coverJson == null) return this;
    final attributes = coverJson['attributes'] ?? {};
    final fileName = attributes['fileName'];
    if (fileName == null || fileName.isEmpty) return this;
    // Cari mangaId dari relationships
    String? mangaId;
    final relationships = coverJson['relationships'] ?? [];
    for (var rel in relationships) {
      if (rel['type'] == 'manga') {
        mangaId = rel['id'];
        break;
      }
    }
    mangaId ??= id;
    return Manga(
      id: id,
      title: title,
      description: description,
      status: status,
      year: year,
      tags: tags,
      coverImageUrl:
          "https://uploads.mangadex.org/covers/$mangaId/$fileName.256.jpg",
    );
  }

  // Method toJson (Opsional, untuk debugging atau caching)
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "year": year,
    "tags": tags,
    "coverImageUrl": coverImageUrl,
  };
}

// --------------------------------------------------------------------------------
// KELAS-KELAS PEMBANTU (MENGAMBIL DARI STRUKTUR YANG ANDA BERIKAN)
// --------------------------------------------------------------------------------

class Datum {
  final String id;
  final RelationshipType type;
  final DatumAttributes attributes;
  final List<Relationship> relationships;

  Datum({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: relationshipTypeValues.map[json["type"]]!,
    attributes: DatumAttributes.fromJson(json["attributes"]),
    relationships: List<Relationship>.from(
      json["relationships"].map((x) => Relationship.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": relationshipTypeValues.reverse[type],
    "attributes": attributes.toJson(),
    "relationships": List<dynamic>.from(relationships.map((x) => x.toJson())),
  };
}

class DatumAttributes {
  final Title title;
  final List<AltTitle> altTitles;
  final PurpleDescription description;
  final bool isLocked;
  final Links links;
  final dynamic officialLinks;
  final OriginalLanguage originalLanguage;
  final String? lastVolume;
  final String? lastChapter;
  final PublicationDemographic? publicationDemographic;
  final Status status;
  final int year;
  final ContentRating contentRating;
  final List<Tag> tags;
  final State state;
  final bool chapterNumbersResetOnNewVolume;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final List<String> availableTranslatedLanguages;
  final String latestUploadedChapter;

  DatumAttributes({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.isLocked,
    required this.links,
    required this.officialLinks,
    required this.originalLanguage,
    required this.lastVolume,
    required this.lastChapter,
    required this.publicationDemographic,
    required this.status,
    required this.year,
    required this.contentRating,
    required this.tags,
    required this.state,
    required this.chapterNumbersResetOnNewVolume,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.availableTranslatedLanguages,
    required this.latestUploadedChapter,
  });

  factory DatumAttributes.fromJson(Map<String, dynamic> json) =>
      DatumAttributes(
        title: Title.fromJson(json["title"]),
        altTitles: List<AltTitle>.from(
          json["altTitles"].map((x) => AltTitle.fromJson(x)),
        ),
        description: PurpleDescription.fromJson(json["description"]),
        isLocked: json["isLocked"],
        links: Links.fromJson(json["links"]),
        officialLinks: json["officialLinks"],
        originalLanguage: originalLanguageValues.map[json["originalLanguage"]]!,
        lastVolume: json["lastVolume"],
        lastChapter: json["lastChapter"],
        publicationDemographic:
            publicationDemographicValues.map[json["publicationDemographic"]]!,
        status: statusValues.map[json["status"]]!,
        year: json["year"],
        contentRating: contentRatingValues.map[json["contentRating"]]!,
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        state: stateValues.map[json["state"]]!,
        chapterNumbersResetOnNewVolume: json["chapterNumbersResetOnNewVolume"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        version: json["version"],
        availableTranslatedLanguages: List<String>.from(
          json["availableTranslatedLanguages"].map((x) => x),
        ),
        latestUploadedChapter: json["latestUploadedChapter"],
      );

  Map<String, dynamic> toJson() => {
    "title": title.toJson(),
    "altTitles": List<dynamic>.from(altTitles.map((x) => x.toJson())),
    "description": description.toJson(),
    "isLocked": isLocked,
    "links": links.toJson(),
    "officialLinks": officialLinks,
    "originalLanguage": originalLanguageValues.reverse[originalLanguage],
    "lastVolume": lastVolume,
    "lastChapter": lastChapter,
    "publicationDemographic":
        publicationDemographicValues.reverse[publicationDemographic],
    "status": statusValues.reverse[status],
    "year": year,
    "contentRating": contentRatingValues.reverse[contentRating],
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "state": stateValues.reverse[state],
    "chapterNumbersResetOnNewVolume": chapterNumbersResetOnNewVolume,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "version": version,
    "availableTranslatedLanguages": List<dynamic>.from(
      availableTranslatedLanguages.map((x) => x),
    ),
    "latestUploadedChapter": latestUploadedChapter,
  };
}

class AltTitle {
  final String? ko;
  final String? en;
  final String? koRo;
  final String? jaRo;
  // ... properti bahasa lainnya
  final String? id;

  AltTitle({
    this.ko,
    this.en,
    this.koRo,
    this.jaRo,
    this.id,
    // ...
  });

  factory AltTitle.fromJson(Map<String, dynamic> json) => AltTitle(
    ko: json["ko"],
    en: json["en"],
    koRo: json["ko-ro"],
    jaRo: json["ja-ro"],
    id: json["id"],
    // ...
  );

  Map<String, dynamic> toJson() => {
    "ko": ko,
    "en": en,
    "ko-ro": koRo,
    "ja-ro": jaRo,
    "id": id,
    // ...
  };
}

// ignore: constant_identifier_names
enum ContentRating { SAFE, SUGGESTIVE }

final contentRatingValues = EnumValues({
  "safe": ContentRating.SAFE,
  "suggestive": ContentRating.SUGGESTIVE,
});

class PurpleDescription {
  final String en;
  // ... properti bahasa lainnya

  PurpleDescription({
    required this.en,
    // ...
  });

  factory PurpleDescription.fromJson(Map<String, dynamic> json) =>
      PurpleDescription(
        en: json["en"],
        // ...
      );

  Map<String, dynamic> toJson() => {
    "en": en,
    // ...
  };
}

class Links {
  final String? al;
  final String? ap;
  final String kt;
  final String mu;
  final String mal;

  Links({
    this.al,
    this.ap,
    required this.kt,
    required this.mu,
    required this.mal,
    // ...
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    al: json["al"],
    ap: json["ap"],
    kt: json["kt"],
    mu: json["mu"],
    mal: json["mal"],
    // ...
  );

  Map<String, dynamic> toJson() => {
    "al": al,
    "ap": ap,
    "kt": kt,
    "mu": mu,
    "mal": mal,
    // ...
  };
}

enum OriginalLanguage { JA, KO }

final originalLanguageValues = EnumValues({
  "ja": OriginalLanguage.JA,
  "ko": OriginalLanguage.KO,
});

enum PublicationDemographic { SEINEN, SHOUJO, SHOUNEN }

final publicationDemographicValues = EnumValues({
  "seinen": PublicationDemographic.SEINEN,
  "shoujo": PublicationDemographic.SHOUJO,
  "shounen": PublicationDemographic.SHOUNEN,
});

enum State { PUBLISHED }

final stateValues = EnumValues({"published": State.PUBLISHED});

enum Status { COMPLETED, ONGOING }

final statusValues = EnumValues({
  "completed": Status.COMPLETED,
  "ongoing": Status.ONGOING,
});

class Tag {
  final String id;
  final TagType type;
  final TagAttributes attributes;
  final List<dynamic> relationships;

  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    type: tagTypeValues.map[json["type"]]!,
    attributes: TagAttributes.fromJson(json["attributes"]),
    relationships: List<dynamic>.from(json["relationships"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": tagTypeValues.reverse[type],
    "attributes": attributes.toJson(),
    "relationships": List<dynamic>.from(relationships.map((x) => x)),
  };
}

class TagAttributes {
  final Name name;
  final FluffyDescription description;
  final Group group;
  final int version;

  TagAttributes({
    required this.name,
    required this.description,
    required this.group,
    required this.version,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => TagAttributes(
    name: Name.fromJson(json["name"]),
    description: FluffyDescription.fromJson(json["description"]),
    group: groupValues.map[json["group"]]!,
    version: json["version"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "description": description.toJson(),
    "group": groupValues.reverse[group],
    "version": version,
  };
}

class FluffyDescription {
  FluffyDescription();

  factory FluffyDescription.fromJson(Map<String, dynamic> json) =>
      FluffyDescription();

  Map<String, dynamic> toJson() => {};
}

enum Group { CONTENT, FORMAT, GENRE, THEME }

final groupValues = EnumValues({
  "content": Group.CONTENT,
  "format": Group.FORMAT,
  "genre": Group.GENRE,
  "theme": Group.THEME,
});

class Name {
  final String en;

  Name({required this.en});

  factory Name.fromJson(Map<String, dynamic> json) => Name(en: json["en"]);

  Map<String, dynamic> toJson() => {"en": en};
}

enum TagType { TAG }

final tagTypeValues = EnumValues({"tag": TagType.TAG});

class Title {
  final String? koRo;
  final String? en;
  final String? jaRo;

  Title({this.koRo, this.en, this.jaRo});

  factory Title.fromJson(Map<String, dynamic> json) =>
      Title(koRo: json["ko-ro"], en: json["en"], jaRo: json["ja-ro"]);

  Map<String, dynamic> toJson() => {"ko-ro": koRo, "en": en, "ja-ro": jaRo};
}

class Relationship {
  final String id;
  final RelationshipType type;
  final RelationshipAttributes? attributes;
  final Related? related;

  Relationship({
    required this.id,
    required this.type,
    this.attributes,
    this.related,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
    id: json["id"],
    type: relationshipTypeValues.map[json["type"]]!,
    attributes: json["attributes"] == null
        ? null
        : RelationshipAttributes.fromJson(json["attributes"]),
    related: relatedValues.map[json["related"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": relationshipTypeValues.reverse[type],
    "attributes": attributes?.toJson(),
    "related": relatedValues.reverse[related],
  };
}

class RelationshipAttributes {
  final String description;
  final String volume;
  final String fileName;
  final OriginalLanguage locale;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  RelationshipAttributes({
    required this.description,
    required this.volume,
    required this.fileName,
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory RelationshipAttributes.fromJson(Map<String, dynamic> json) =>
      RelationshipAttributes(
        description: json["description"],
        volume: json["volume"],
        fileName: json["fileName"],
        locale: originalLanguageValues.map[json["locale"]]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
    "description": description,
    "volume": volume,
    "fileName": fileName,
    "locale": originalLanguageValues.reverse[locale],
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "version": version,
  };
}

enum Related {
  ADAPTED_FROM,
  // ... properti lainnya
}

final relatedValues = EnumValues({
  "adapted_from": Related.ADAPTED_FROM,
  // ... properti lainnya
});

enum RelationshipType { ARTIST, AUTHOR, COVER_ART, MANGA }

final relationshipTypeValues = EnumValues({
  "artist": RelationshipType.ARTIST,
  "author": RelationshipType.AUTHOR,
  "cover_art": RelationshipType.COVER_ART,
  "manga": RelationshipType.MANGA,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
