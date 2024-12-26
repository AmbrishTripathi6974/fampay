class ContextualCardModel {
  final String designType;
  final List<CardDetails> cards;

  ContextualCardModel({
    required this.designType,
    required this.cards,
  });

  factory ContextualCardModel.fromJson(Map<String, dynamic> json) {
    var cardsList = json['cards'] as List;
    List<CardDetails> cards =
        cardsList.map((card) => CardDetails.fromJson(card)).toList();

    return ContextualCardModel(
      designType: json['design_type'],
      cards: cards,
    );
  }
}

class CardDetails {
  final String title;
  final String? description;
  final String? bgImageUrl;
  final String? bgColor;
  final List<FormattedTextEntity>? formattedTitleEntities;
  final List<CTA>? cta;

  CardDetails({
    required this.title,
    this.description,
    this.bgImageUrl,
    this.bgColor,
    this.formattedTitleEntities,
    this.cta,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    var formattedTitleEntitiesList = json['formatted_title']?['entities'] as List? ?? [];
    List<FormattedTextEntity> entities = formattedTitleEntitiesList
        .map((e) => FormattedTextEntity.fromJson(e))
        .toList();

    var ctaList = json['cta'] as List? ?? [];
    List<CTA> ctas = ctaList.map((e) => CTA.fromJson(e)).toList();

    return CardDetails(
      title: json['title'] ?? '',
      description: json['description'],
      bgImageUrl: json['bg_image']?['image_url'],
      bgColor: json['bg_color'],
      formattedTitleEntities: entities,
      cta: ctas,
    );
  }
}

class FormattedTextEntity {
  final String text;
  final String color;
  final int fontSize;
  final String fontStyle;

  FormattedTextEntity({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontStyle,
  });

  factory FormattedTextEntity.fromJson(Map<String, dynamic> json) {
    return FormattedTextEntity(
      text: json['text'],
      color: json['color'],
      fontSize: json['font_size'],
      fontStyle: json['font_style'],
    );
  }
}

class CTA {
  final String text;
  final String type;
  final String bgColor;

  CTA({
    required this.text,
    required this.type,
    required this.bgColor,
  });

  factory CTA.fromJson(Map<String, dynamic> json) {
    return CTA(
      text: json['text'],
      type: json['type'],
      bgColor: json['bg_color'],
    );
  }
}
