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
  final String name;
  final String slug;
  final String? title;
  final FormattedTitle? formattedTitle;
  final String? description;
  final FormattedDescription? formattedDescription;
  final String? url;
  final BgImage? bgImage;
  final BgGradient? bgGradient;
  final List<Cta>? cta;
  final String? bgColor;
  final Icon? icon;
  final bool isDisabled;
  final bool isShareable;
  final bool isInternal;

  CardModel({
    required this.id,
    required this.name,
    required this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.url,
    this.bgImage,
    this.bgGradient,
    this.cta,
    this.bgColor,
    this.icon,
    required this.isDisabled,
    required this.isShareable,
    required this.isInternal,
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
      bgImage:
          json['bg_image'] != null ? BgImage.fromJson(json['bg_image']) : null,
      bgGradient: json['bg_gradient'] != null
          ? BgGradient.fromJson(json['bg_gradient'])
          : null,
      cta: json['cta'] != null
          ? (json['cta'] as List<dynamic>)
              .map((action) => Cta.fromJson(action))
              .toList()
          : null,
      bgColor: json['bg_color'],
      icon: json['icon'] != null ? Icon.fromJson(json['icon']) : null,
      isDisabled: json['is_disabled'],
      isShareable: json['is_shareable'],
      isInternal: json['is_internal'],
    );
  }
}

class FormattedTitle {
  final String text;
  final String align;
  final List<Entity> entities;

  FormattedTitle({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedTitle.fromJson(Map<String, dynamic> json) {
    return FormattedTitle(
      text: json['text'],
      align: json['align'],
      entities: (json['entities'] as List<dynamic>)
          .map((entity) => Entity.fromJson(entity))
          .toList(),
    );
  }
}

class FormattedDescription {
  final String text;
  final String align;
  final List<Entity> entities;

  FormattedDescription({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedDescription.fromJson(Map<String, dynamic> json) {
    return FormattedDescription(
      text: json['text'],
      align: json['align'],
      entities: (json['entities'] as List<dynamic>)
          .map((entity) => Entity.fromJson(entity))
          .toList(),
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
  final String imageType;
  final String imageUrl;
  final double aspectRatio;

  BgImage({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

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

class Icon {
  final String imageType;
  final String imageUrl;
  final double aspectRatio;

  Icon({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory Icon.fromJson(Map<String, dynamic> json) {
    return Icon(
      imageType: json['image_type'],
      imageUrl: json['image_url'],
      aspectRatio: json['aspect_ratio'],
    );
  }
}

class Cta {
  final String text;
  final String type;
  final String bgColor;
  final bool isCircular;
  final bool isSecondary;
  final int strokeWidth;

  Cta({
    required this.text,
    required this.type,
    required this.bgColor,
    required this.isCircular,
    required this.isSecondary,
    required this.strokeWidth,
  });

  factory Cta.fromJson(Map<String, dynamic> json) {
    return Cta(
      text: json['text'],
      type: json['type'],
      bgColor: json['bg_color'],
      isCircular: json['is_circular'],
      isSecondary: json['is_secondary'],
      strokeWidth: json['stroke_width'],
    );
  }
}
