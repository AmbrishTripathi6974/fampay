import 'package:flutter/material.dart';

class ContextualCardModel {
  final String designType;
  final List<CardDetails> cards;

  ContextualCardModel({required this.designType, required this.cards});

  factory ContextualCardModel.fromJson(Map<String, dynamic> json) {
    return ContextualCardModel(
      designType: json['design_type'] ?? '',
      cards: (json['cards'] as List<dynamic>?)
              ?.map((cardJson) => CardDetails.fromJson(cardJson))
              .toList() ??
          [],
    );
  }
}

class CardDetails {
  final int id;
  final String name;
  final String slug;
  final String? title;
  final FormattedText? formattedTitle;
  final FormattedText? formattedDescription;
  final String? description;
  final IconDetails? icon;
  final String? bgImageUrl;
  final String? bgColor;
  final HC9Gradient? bgGradient;
  final List<CTA>? cta;
  final double? aspectRatio;

  CardDetails({
    required this.id,
    required this.name,
    required this.slug,
    this.aspectRatio,
    this.title,
    this.bgGradient,
    this.formattedTitle,
    this.formattedDescription,
    this.description,
    this.icon,
    this.bgImageUrl,
    this.bgColor,
    this.cta,
  });

  factory CardDetails.fromJson(Map<String, dynamic> json) {
    return CardDetails(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      title: json['title'],
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'])
          : null,
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description'])
          : null,
      description: json['description'],
      icon: json['icon'] != null ? IconDetails.fromJson(json['icon']) : null,
      bgGradient: json['bg_gradient'] != null
          ? HC9Gradient.fromJson(json['bg_gradient'])
          : null,
      aspectRatio: (json['bg_image']?['aspect_ratio'] as num?)?.toDouble(),
      bgImageUrl: json['bg_image']?['image_url'],
      bgColor: json['bg_color'],
      cta: (json['cta'] as List<dynamic>?)
              ?.map((e) => CTA.fromJson(e))
              .toList() ??
          [],
    );
  }

  // Helper method to convert bgColor string to Color
  Color? getParsedBgColor() {
    if (bgColor == null) return null;
    try {
      return Color(int.parse(bgColor!.replaceFirst('#', '0xFF')));
    } catch (e) {
      return null; // Handle invalid color formats
    }
  }
}

class FormattedText {
  final String text;
  final String align;
  final List<TextEntity> entities;

  FormattedText({
    required this.text,
    required this.align,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) {
    return FormattedText(
      text: json['text'] ?? '',
      align: json['align'] ?? 'left',
      entities: (json['entities'] as List<dynamic>?)
              ?.map((e) => TextEntity.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TextEntity {
  final String text;
  final String type;
  final String color;
  final int? fontSize;
  final String? fontStyle;
  final String? fontFamily;

  TextEntity({
    required this.text,
    required this.type,
    required this.color,
    this.fontSize,
    this.fontStyle,
    this.fontFamily,
  });

  factory TextEntity.fromJson(Map<String, dynamic> json) {
    return TextEntity(
      text: json['text'] ?? '',
      type: json['type'] ?? '',
      color: json['color'] ?? '#000000',
      fontSize: json['font_size'],
      fontStyle: json['font_style'],
      fontFamily: json['font_family'],
    );
  }
}

class IconDetails {
  final String imageType;
  final String imageUrl;
  final double aspectRatio;

  IconDetails({
    required this.imageType,
    required this.imageUrl,
    required this.aspectRatio,
  });

  factory IconDetails.fromJson(Map<String, dynamic> json) {
    return IconDetails(
      imageType: json['image_type'] ?? '',
      imageUrl: json['image_url'] ?? '',
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble() ?? 1.0,
    );
  }
}

class HC9Gradient {
  final List<String> colors;
  final double? angle;

  HC9Gradient({
    required this.colors,
    this.angle,
  });

  factory HC9Gradient.fromJson(Map<String, dynamic> json) {
    return HC9Gradient(
      colors: List<String>.from(json['colors'] ?? []),
      angle: (json['angle'] as num?)?.toDouble(),
    );
  }
}

class CTA {
  final String text;
  final String bgColor;

  CTA({
    required this.text,
    required this.bgColor,
  });

  factory CTA.fromJson(Map<String, dynamic> json) {
    return CTA(
      text: json['text'] ?? '',
      bgColor: json['bg_color'] ?? '#FFFFFF',
    );
  }
}
