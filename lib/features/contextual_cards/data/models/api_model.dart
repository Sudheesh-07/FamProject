import 'package:equatable/equatable.dart';

/// This model represents entities used in contextual cards.
class Entity extends Equatable {

  /// Constructs an [Entity] instance.
  const Entity({
    required this.text,
    this.color,
    this.url,
    this.fontStyle,
    this.fontSize,
    this.fontFamily,
    this.type,
  });

  /// Creates an [Entity] instance from a JSON map.
  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
      text: json['text'] as String? ?? '',
      color: json['color'] as String?,
      url: json['url'] as String?,
      fontStyle: json['font_style'] as String?,
      fontSize: json['font_size'] as int?,
      fontFamily: json['font_family'] as String?,
      type: json['type'] as String?,
    );
  /// The text content of the entity.
  final String text;
  /// The color content of the entity.
  final String? color;
  /// The URL associated with the entity, if any.
  final String? url;
  /// The font style of the entity's text.
  final String? fontStyle;
  /// The font size of the entity's text.(This is in int format)
  final int? fontSize;
  /// The font family of the entity's text.
  final String? fontFamily;
  /// The type of the entity (it is 'generic_text' in the api).
  final String? type;

@override
  List<Object?> get props => <Object?>[
    text,
    color,
    url,
    fontStyle,
    fontSize,
    fontFamily,
    type,
  ];
}
/// Formatted Text Model
class FormattedText extends Equatable {
  /// Constructs a [FormattedText] instance.
  const FormattedText({required this.text, required this.entities, this.align});

/// Creates a [FormattedText] instance from a JSON map.
  factory FormattedText.fromJson(Map<String, dynamic> json) => FormattedText(
      text: json['text'] as String ?? '',
      align: json['align'] as String,
      entities:
          (json['entities'] as List<dynamic>?)
              ?.map((e) => Entity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <Entity>[],
    );
  /// The main text content.
  final String text;
  /// Text alignment (e.g., 'left', 'center', 'right').
  final String? align;
  /// List of entities within the text.
  final List<Entity> entities;

  @override
  List<Object?> get props => <Object?>[text, align, entities];
}

/// Card Image Model
class CardImage extends Equatable {
  /// Constructs a [CardImage] instance.
  const CardImage({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.aspectRatio,
  });
  /// Creates a [CardImage] instance from a JSON map.
  factory CardImage.fromJson(Map<String, dynamic> json) => CardImage(
      imageType: json['image_type'] as String? ?? '',
      assetType: json['asset_type'] as String?,
      imageUrl: json['image_url'] as String?,
      aspectRatio: (json['aspect_ratio'] as num?)?.toDouble(),
    );
    /// The type of the image (e.g., 'asset', 'network').
  final String imageType;
  /// The type of asset if applicable (e.g., 'svg', 'png').
  final String? assetType;
  /// The URL of the image if applicable.
  final String? imageUrl;
  /// The aspect ratio of the image if applicable.
  final double? aspectRatio;

  @override
  List<Object?> get props => <Object?>[imageType, assetType, imageUrl, aspectRatio];
}

/// Gradient Model
class BgGradient extends Equatable {
  /// Constructs a [BgGradient] instance.
  const BgGradient({required this.colors, required this.angle});

  /// Creates a [BgGradient] instance from a JSON map.
  factory BgGradient.fromJson(Map<String, dynamic> json) => BgGradient(
      colors: List<String>.from(json['colors'] as List<dynamic>? ?? []),
      angle: json['angle'] as int? ?? 0,
    );
    /// List of colors in the gradient.
  final List<String> colors;
  /// Angle of the gradient in degrees.
  final int angle;

  @override
  List<Object?> get props => <Object?>[colors, angle];
}

/// CTA Model
class CTA extends Equatable {

  /// Constructs a [CTA] instance.
  const CTA({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
    this.type,
    this.isCircular,
    this.isSecondary,
    this.strokeWidth,
  });

  /// Creates a [CTA] instance from a JSON map.
  factory CTA.fromJson(Map<String, dynamic> json) => CTA(
      text: json['text'] as String? ?? '',
      bgColor: json['bg_color'] as String?,
      textColor: json['text_color'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      isCircular: json['is_circular'] as bool?,
      isSecondary: json['is_secondary'] as bool?,
      strokeWidth: json['stroke_width'] as int?,
    );
    /// The display text of the CTA button.
  final String text;
  /// The background Color of the button
  final String? bgColor;
  /// The text color
  final String? textColor;
  /// url of the button
  final String? url;
  /// typew of the button
  final String? type;
  ///
  final bool? isCircular;
  ///
  final bool? isSecondary;
  ///
  final int? strokeWidth;

  @override
  List<Object?> get props => <Object?>[
    text,
    bgColor,
    textColor,
    url,
    type,
    isCircular,
    isSecondary,
    strokeWidth,
  ];
}

/// Card Model
class CardModel extends Equatable {

  /// Constructor for [CarModel] 
  const CardModel({
    required this.id,
    required this.name,
    this.slug,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.icon,
    this.bgImage,
    this.bgColor,
    this.bgGradient,
    this.url,
    this.cta,
    this.iconSize,
    this.isDisabled,
  });

/// 
  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
      id: json['id'] as int,
      name: json['name'] as String ?? '',
      slug: json['slug'] as String?,
      title: json['title'] as String?,
      formattedTitle: json['formatted_title'] != null
          ? FormattedText.fromJson(json['formatted_title'] as Map<String, dynamic>)
          : null,
      description: json['description'] as String?,
      formattedDescription: json['formatted_description'] != null
          ? FormattedText.fromJson(json['formatted_description']as Map<String, dynamic>)
          : null,
      icon: json['icon'] != null ? CardImage.fromJson(json['icon']as Map<String, dynamic>) : null,
      bgImage: json['bg_image'] != null
          ? CardImage.fromJson(json['bg_image'] as Map<String, dynamic>)
          : null,
      bgColor: json['bg_color']as String?,
      bgGradient: json['bg_gradient'] != null
          ? BgGradient.fromJson(json['bg_gradient']as Map<String, dynamic>)
          : null,
      url: json['url']as String?,
      cta: (json['cta'] as List?)?.map((e) => CTA.fromJson(e as Map<String, dynamic>)).toList(),
      iconSize: json['icon_size']as int?,
      isDisabled: json['is_disabled'] as bool?,
    );
  final int id;
  final String name;
  final String? slug;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final CardImage? icon;
  final CardImage? bgImage;
  final String? bgColor;
  final BgGradient? bgGradient;
  final String? url;
  final List<CTA>? cta;
  final int? iconSize;
  final bool? isDisabled;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    slug,
    title,
    formattedTitle,
    description,
    formattedDescription,
    icon,
    bgImage,
    bgColor,
    bgGradient,
    url,
    cta,
    iconSize,
    isDisabled,
  ];
}

/// Card Group Model
class CardGroup extends Equatable {

  const CardGroup({
    required this.id,
    required this.name,
    required this.designType,
    required this.cards,
    required this.isScrollable,
    this.height,
    this.isFullWidth,
    this.slug,
    this.level,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) => CardGroup(
      id: json['id'] as int,
      name: json['name'] as String ?? '',
      designType: json['design_type'] as String ?? '',
      cards:
          (json['cards'] as List?)
              ?.map((e) => CardModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <CardModel>[],
      isScrollable: json['is_scrollable'] as bool ?? false,
      height: json['height']as int?,
      isFullWidth: json['is_full_width']as bool?,
      slug: json['slug']as String?,
      level: json['level']as int?,
    );
  final int id;
  final String name;
  final String designType;
  final List<CardModel> cards;
  final bool isScrollable;
  final int? height;
  final bool? isFullWidth;
  final String? slug;
  final int? level;

  @override
  List<Object?> get props => <Object?>[
    id,
    name,
    designType,
    cards,
    isScrollable,
    height,
    isFullWidth,
    slug,
    level,
  ];
}

/// API Response Model
class ApiResponse extends Equatable {

  const ApiResponse({
    required this.id,
    required this.slug,
    required this.hcGroups,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
      id: json['id']as int,
      slug: json['slug'] as String ?? '',
      hcGroups:
          (json['hc_groups'] as List?)
              ?.map((e) => CardGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <CardGroup>[],
    );
  final int id;
  final String slug;
  final List<CardGroup> hcGroups;

  @override
  List<Object?> get props => <Object?>[id, slug, hcGroups];
}
