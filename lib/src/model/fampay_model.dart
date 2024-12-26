class FamxPay {
  final int id;
  final String slug;
  final String? title;
  final String? formattedTitle;
  final String? description;
  final String? formattedDescription;
  final List<dynamic>? assets;
  final List<HcGroup> hcGroups;

  FamxPay({
    required this.id,
    required this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  factory FamxPay.fromJson(Map<String, dynamic> json) {
    return FamxPay(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      formattedTitle: json['formatted_title'],
      description: json['description'],
      formattedDescription: json['formatted_description'],
      assets: json['assets'],
      hcGroups: (json['hc_groups'] as List<dynamic>)
          .map((group) => HcGroup.fromJson(group))
          .toList(),
    );
  }
}

class HcGroup {
  final int id;
  final String name;
  final String designType;
  final int cardType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int height;
  final bool isFullWidth;
  final String slug;
  final int level;

  HcGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cardType,
    required this.cards,
    required this.isScrollable,
    required this.height,
    required this.isFullWidth,
    required this.slug,
    required this.level,
  });

  factory HcGroup.fromJson(Map<String, dynamic> json) {
    return HcGroup(
      id: json['id'],
      name: json['name'],
      designType: json['design_type'],
      cardType: json['card_type'],
      cards: (json['cards'] as List<dynamic>)
          .map((card) => CardModel.fromJson(card))
          .toList(),
      isScrollable: json['is_scrollable'],
      height: json['height'],
      isFullWidth: json['is_full_width'],
      slug: json['slug'],
      level: json['level'],
    );
  }
}


class CardModel {
  final int id;
  final String? name;
  final String? slug;
  final String? title;
  final FormattedTitle? formattedTitle;
  final String? description;
  final FormattedDescription? formattedDescription;
  final String? url;
  final BgImage? bgImage;
  final IconModel? icon;
  final List<CTA>? cta;
  final String? bgColor;

  CardModel({
    required this.id,
    this.name,
    this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.url,
    this.bgImage,
    this.icon,
    this.cta,
    this.bgColor,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      title: json['title'],
      formattedTitle: json['formatted_title'] != null
          ? FormattedTitle.fromJson(json['formatted_title'])
          : null,
      description: json['description'],
      formattedDescription: json['formatted_description'] != null
          ? FormattedDescription.fromJson(json['formatted_description'])
          : null,
      url: json['url'],
      bgImage: json['bg_image'] != null ? BgImage.fromJson(json['bg_image']) : null,
      icon: json['icon'] != null ? IconModel.fromJson(json['icon']) : null,
      cta: json['cta'] != null
          ? (json['cta'] as List).map((e) => CTA.fromJson(e)).toList()
          : null,
      bgColor: json['bg_color'],
    );
  }

  get bgGradient => null;
}


class FormattedTitle {
  final String? text;
  final String? align;

  FormattedTitle({this.text, this.align});

  factory FormattedTitle.fromJson(Map<String, dynamic> json) {
    return FormattedTitle(
      text: json['text'],
      align: json['align'],
    );
  }
}


class FormattedDescription {
  final String? text;
  final String? align;

  FormattedDescription({this.text, this.align});

  factory FormattedDescription.fromJson(Map<String, dynamic> json) {
    return FormattedDescription(
      text: json['text'],
      align: json['align'],
    );
  }
}

class Entity {
  final String text;
  final String type;
  final String color;
  final int? fontSize;
  final String? fontStyle;
  final String fontFamily;

  Entity({
    required this.text,
    required this.type,
    required this.color,
    this.fontSize,
    this.fontStyle,
    required this.fontFamily,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      text: json['text'],
      type: json['type'],
      color: json['color'],
      fontSize: json['font_size'],
      fontStyle: json['font_style'],
      fontFamily: json['font_family'],
    );
  }
}

class BgImage {
  final String? imageType;
  final String? imageUrl;
  final double? aspectRatio;

  BgImage({this.imageType, this.imageUrl, this.aspectRatio});

  factory BgImage.fromJson(Map<String, dynamic> json) {
    return BgImage(
      imageType: json['image_type'],
      imageUrl: json['image_url'],
      aspectRatio: json['aspect_ratio'],
    );
  }
}


class BgGradient {
  final int angle;
  final List<String> colors;

  BgGradient({
    required this.angle,
    required this.colors,
  });

  factory BgGradient.fromJson(Map<String, dynamic> json) {
    return BgGradient(
      angle: json['angle'],
      colors: List<String>.from(json['colors']),
    );
  }
}

class IconModel {
  final String? imageType;
  final String? imageUrl;
  final double? aspectRatio;

  IconModel({this.imageType, this.imageUrl, this.aspectRatio});

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      imageType: json['image_type'],
      imageUrl: json['image_url'],
      aspectRatio: json['aspect_ratio'],
    );
  }
}

class CTA {
  final String? text;
  final String? type;
  final String? bgColor;

  CTA({this.text, this.type, this.bgColor});

  factory CTA.fromJson(Map<String, dynamic> json) {
    return CTA(
      text: json['text'],
      type: json['type'],
      bgColor: json['bg_color'],
    );
  }
}

