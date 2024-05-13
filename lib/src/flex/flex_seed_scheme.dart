import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show internal;

import '../mcu/dynamiccolor/dynamic_scheme.dart';
import '../mcu/dynamiccolor/material_dynamic_colors.dart';
import '../mcu/hct/hct.dart';
import '../mcu/scheme/scheme_content.dart';
import '../mcu/scheme/scheme_expressive.dart';
import '../mcu/scheme/scheme_fidelity.dart';
import '../mcu/scheme/scheme_fruit_salad.dart';
import '../mcu/scheme/scheme_monochrome.dart';
import '../mcu/scheme/scheme_neutral.dart';
import '../mcu/scheme/scheme_rainbow.dart';
import '../mcu/scheme/scheme_tonal_spot.dart';
import '../mcu/scheme/scheme_vibrant.dart';
import 'flex_core_palette.dart';
import 'flex_scheme_variant.dart';
import 'flex_tones.dart';

// ignore_for_file: comment_references

/// This class is the same concept as Flutter's [ColorScheme] class.
///
/// It is used used to generate a [ColorScheme] based on a modified version of
/// [CorePalette] found in package material_color_utilities. It is a rewrite
/// of [Scheme] found in same "material_color_utilities" package.
///
/// It has two enhancements to makes it more flexible and powerful:
///
/// 1) Six seed colors instead of just one.
///
/// Instead of [CorePalette] it uses custom version called [FlexCorePalette]
/// that enables using up to six seed colors for more degrees
/// of freedom in seeded ColorScheme. Using defined seed colors for
/// primary, secondary and tertiary colors, as well as error color, surface
/// and surface variant color. The custom [FlexCorePalette]
/// version also allows for adjusting chroma usage and levels that are
/// hard coded into M3 design [CorePalette].
///
/// 2) Configurable tonal palette tone mappings to ColorScheme colors.
///
/// Which tones to use for what color in the [ColorScheme] is not hard coded
/// like it is in material_color_utilities [Scheme] class. This version
/// accepts an optional [FlexTones] class that can be used to configure
/// the tone mapping from [FlexTonalPalette] to [ColorScheme], including
/// passing the extra min chroma and fixed level parameters it should
/// use when computing the [FlexCorePalette].
///
/// This helper class is internal for now in [FlexSeedScheme] package.
/// If there ever is a need for using it via the library, post an issue and
/// we will consider it.
@immutable
@internal
class FlexSeedScheme {
  /// The color displayed most frequently across your app.
  final int primary;

  /// A color that's clearly legible when drawn on [primary].
  final int onPrimary;

  /// A color used for elements needing less emphasis than [primary].
  final int primaryContainer;

  /// A color that's clearly legible when drawn on [primaryContainer].
  final int onPrimaryContainer;

  /// A substitute for [primaryContainer] that's the same color for the dark
  /// and light themes.
  final int primaryFixed;

  /// A color used for elements needing more emphasis than [primaryFixed].
  final int primaryFixedDim;

  /// A color that is used for text and icons that exist on top of elements
  /// having [primaryFixed] color.
  final int onPrimaryFixed;

  /// A color that provides a lower-emphasis option for text and icons than
  /// [onPrimaryFixed].
  final int onPrimaryFixedVariant;

  /// An accent color used for less prominent components in the UI, such as
  /// filter chips, while expanding the opportunity for color expression.
  final int secondary;

  /// A color that's clearly legible when drawn on [secondary].
  final int onSecondary;

  /// A color used for elements needing less emphasis than [secondary].
  final int secondaryContainer;

  /// A color that's clearly legible when drawn on [secondaryContainer].
  final int onSecondaryContainer;

  /// A substitute for [secondaryContainer] that's the same color for the dark
  /// and light themes.
  final int secondaryFixed;

  /// A color used for elements needing more emphasis than [secondaryFixed].
  final int secondaryFixedDim;

  /// A color that is used for text and icons that exist on top of elements
  /// having [secondaryFixed] color.
  final int onSecondaryFixed;

  /// A color that provides a lower-emphasis option for text and icons than
  /// [onSecondaryFixed].
  final int onSecondaryFixedVariant;

  /// A color used as a contrasting accent that can balance [primary]
  /// and [secondary] colors or bring heightened attention to an element,
  /// such as an input field.
  final int tertiary;

  /// A color that's clearly legible when drawn on [tertiary].
  final int onTertiary;

  /// A color used for elements needing less emphasis than [tertiary].
  final int tertiaryContainer;

  /// A color that's clearly legible when drawn on [tertiaryContainer].
  final int onTertiaryContainer;

  /// A substitute for [tertiaryContainer] that's the same color for dark
  /// and light themes.
  final int tertiaryFixed;

  /// A color used for elements needing more emphasis than [tertiaryFixed].
  final int tertiaryFixedDim;

  /// A color that is used for text and icons that exist on top of elements
  /// having [tertiaryFixed] color.
  final int onTertiaryFixed;

  /// A color that provides a lower-emphasis option for text and icons than
  /// [onTertiaryFixed].
  final int onTertiaryFixedVariant;

  /// The color to use for input validation errors, e.g. for
  /// [InputDecoration.errorText].
  final int error;

  /// A color that's clearly legible when drawn on [error].
  final int onError;

  /// A color used for error elements needing less emphasis than [error].
  final int errorContainer;

  /// A color that's clearly legible when drawn on [errorContainer].
  final int onErrorContainer;

  /// The background color for widgets like [Card].
  final int surface;

  /// A color that's always darkest in the dark or light theme.
  final int surfaceDim;

  /// A color that's always the lightest in the dark or light theme.
  final int surfaceBright;

  /// A surface container color with the lightest tone and the least emphasis
  /// relative to the surface.
  final int surfaceContainerLowest;

  /// A surface container color with a lighter tone that creates less emphasis
  /// than [surfaceContainer] but more emphasis than [surfaceContainerLowest].
  final int surfaceContainerLow;

  /// A recommended color role for a distinct area within the surface.
  ///
  /// Surface container color roles are independent of elevation. They replace
  /// the old opacity-based model which applied a tinted overlay on top of
  /// surfaces based on their elevation.
  ///
  /// Surface container colors include [surfaceContainerLowest],
  /// [surfaceContainerLow], [surfaceContainer], [surfaceContainerHigh] and
  /// [surfaceContainerHighest].
  final int surfaceContainer;

  /// A surface container color with a darker tone. It is used to create more
  /// emphasis than [surfaceContainer] but less emphasis than
  /// [surfaceContainerHighest].
  final int surfaceContainerHigh;

  /// A surface container color with the darkest tone. It is used to create the
  /// most emphasis against the surface.
  final int surfaceContainerHighest;

  /// A color that's clearly legible when drawn on [surface].
  final int onSurface;

  /// A color that's clearly legible when drawn on [surfaceVariant].
  final int onSurfaceVariant;

  /// A utility color that creates boundaries and emphasis to improve usability.
  final int outline;

  /// A utility color that creates boundaries for decorative elements when a
  /// 3:1 contrast isn’t required, such as for dividers or decorative elements.
  final int outlineVariant;

  /// A color use to paint the drop shadows of elevated components.
  final int shadow;

  /// A color use to paint the scrim around of modal components.
  final int scrim;

  /// A surface color used for displaying the reverse of what’s seen in the
  /// surrounding UI, for example in a SnackBar to bring attention to
  /// an alert.
  final int inverseSurface;

  /// A color that's clearly legible when drawn on [inverseSurface].
  final int onInverseSurface;

  /// An accent color used for displaying a highlight color on [inverseSurface]
  /// backgrounds, like button text in a SnackBar.
  final int inversePrimary;

  /// A color used as an overlay on a surface color to indicate a component's
  /// elevation.
  final int surfaceTint;

  /// A color that typically appears behind scrollable content.
  @Deprecated('Use surface instead.')
  final int background;

  /// A color that's clearly legible when drawn on [background].
  @Deprecated('Use onSurface instead.')
  final int onBackground;

  /// A color variant of [surface] that can be used for differentiation against
  /// a component using [surface].
  @Deprecated('Use surfaceContainerHighest instead.')
  final int surfaceVariant;

  /// Private constructor requiring all int color values.
  ///
  /// A [FlexSeedScheme] cannot be created externally. It is only used
  /// internally to create a seeded [ColorScheme] via its static method
  /// [FlexSeedScheme.fromSeeds] from one to six seed colors, and optionally
  /// using customizable [FlexTones] tone mapping to [ColorScheme].
  const FlexSeedScheme._({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.primaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixed,
    required this.onPrimaryFixedVariant,
    //
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.secondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixed,
    required this.onSecondaryFixedVariant,
    //
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.tertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixed,
    required this.onTertiaryFixedVariant,
    //
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    //
    required this.surface,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.onSurface,
    required this.onSurfaceVariant,
    //
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.surfaceTint,
    //
    @Deprecated('Use surface instead.') required this.background,
    @Deprecated('Use onSurface instead.') required this.onBackground,
    @Deprecated('Use surfaceContainerHighest instead.')
    required this.surfaceVariant,
  });

  /// Factory that creates a [FlexSeedScheme] based on seed keys and FlexTones
  /// tones mapping.
  ///
  /// A [FlexSeedScheme] cannot be created externally. It is only used
  /// internally to create a seeded [ColorScheme] via its static extension
  /// [SeedColorScheme.fromSeeds] from one to six seed colors, and with
  /// customizable [FlexTones] tone mapping to [ColorScheme].
  factory FlexSeedScheme._tones({
    required int primaryKey,
    int? secondaryKey,
    int? tertiaryKey,
    int? errorKey,
    int? neutralKey,
    int? neutralVariantKey,
    required FlexTones tones,
  }) {
    final FlexCorePalette core = FlexCorePalette.fromSeeds(
      primary: primaryKey,
      secondary: secondaryKey,
      tertiary: tertiaryKey,
      error: errorKey,
      neutral: neutralKey,
      neutralVariant: neutralVariantKey,
      primaryChroma: tones.primaryChroma,
      primaryMinChroma: tones.primaryMinChroma,
      secondaryChroma: tones.secondaryChroma,
      secondaryMinChroma: tones.secondaryMinChroma,
      tertiaryChroma: tones.tertiaryChroma,
      tertiaryMinChroma: tones.tertiaryMinChroma,
      tertiaryHueRotation: tones.tertiaryHueRotation,
      errorChroma: tones.errorChroma,
      errorMinChroma: tones.errorMinChroma,
      neutralChroma: tones.neutralChroma,
      neutralMinChroma: tones.neutralMinChroma,
      neutralVariantChroma: tones.neutralVariantChroma,
      neutralVariantMinChroma: tones.neutralVariantMinChroma,
      paletteType: tones.paletteType,
      useCam16: tones.useCam16,
    );
    return FlexSeedScheme._(
      primary: core.primary.get(tones.primaryTone),
      onPrimary: core.primary.get(tones.onPrimaryTone),
      primaryContainer: core.primary.get(tones.primaryContainerTone),
      onPrimaryContainer: core.primary.get(tones.onPrimaryContainerTone),
      primaryFixed: core.primary.get(tones.primaryFixedTone),
      primaryFixedDim: core.primary.get(tones.primaryFixedDimTone),
      onPrimaryFixed: core.primary.get(tones.onPrimaryFixedTone),
      onPrimaryFixedVariant: core.primary.get(tones.onPrimaryFixedVariantTone),
      //
      secondary: core.secondary.get(tones.secondaryTone),
      onSecondary: core.secondary.get(tones.onSecondaryTone),
      secondaryContainer: core.secondary.get(tones.secondaryContainerTone),
      onSecondaryContainer: core.secondary.get(tones.onSecondaryContainerTone),
      secondaryFixed: core.secondary.get(tones.secondaryFixedTone),
      secondaryFixedDim: core.secondary.get(tones.secondaryFixedDimTone),
      onSecondaryFixed: core.secondary.get(tones.onSecondaryFixedTone),
      onSecondaryFixedVariant:
          core.secondary.get(tones.onSecondaryFixedVariantTone),
      //
      tertiary: core.tertiary.get(tones.tertiaryTone),
      onTertiary: core.tertiary.get(tones.onTertiaryTone),
      tertiaryContainer: core.tertiary.get(tones.tertiaryContainerTone),
      onTertiaryContainer: core.tertiary.get(tones.onTertiaryContainerTone),
      tertiaryFixed: core.tertiary.get(tones.tertiaryFixedTone),
      tertiaryFixedDim: core.tertiary.get(tones.tertiaryFixedDimTone),
      onTertiaryFixed: core.tertiary.get(tones.onTertiaryFixedTone),
      onTertiaryFixedVariant:
          core.tertiary.get(tones.onTertiaryFixedVariantTone),
      //
      error: core.error.get(tones.errorTone),
      onError: core.error.get(tones.onErrorTone),
      errorContainer: core.error.get(tones.errorContainerTone),
      onErrorContainer: core.error.get(tones.onErrorContainerTone),
      //
      surface: core.neutral.get(tones.surfaceTone),
      surfaceDim: core.neutral.get(tones.surfaceDimTone),
      surfaceBright: core.neutral.get(tones.surfaceBrightTone),
      surfaceContainerLowest:
          core.neutral.get(tones.surfaceContainerLowestTone),
      surfaceContainerLow: core.neutral.get(tones.surfaceContainerLowTone),
      surfaceContainer: core.neutral.get(tones.surfaceContainerTone),
      surfaceContainerHigh: core.neutral.get(tones.surfaceContainerHighTone),
      surfaceContainerHighest:
          core.neutral.get(tones.surfaceContainerHighestTone),
      onSurface: core.neutral.get(tones.onSurfaceTone),
      onSurfaceVariant: core.neutralVariant.get(tones.onSurfaceVariantTone),
      //
      outline: core.neutralVariant.get(tones.outlineTone),
      outlineVariant: core.neutralVariant.get(tones.outlineVariantTone),
      shadow: core.neutral.get(tones.shadowTone),
      scrim: core.neutral.get(tones.scrimTone),
      inverseSurface: core.neutral.get(tones.inverseSurfaceTone),
      onInverseSurface: core.neutral.get(tones.onInverseSurfaceTone),
      inversePrimary: core.primary.get(tones.inversePrimaryTone),
      surfaceTint: core.primary.get(tones.surfaceTintTone),
      // Deprecated colors
      background: core.neutral.get(tones.backgroundTone),
      onBackground: core.neutral.get(tones.onBackgroundTone),
      surfaceVariant: core.neutralVariant.get(tones.surfaceVariantTone),
    );
  }
}

/// Extension on [ColorScheme] to provide a more flexible alternative to
/// Flutter's Material 3 [ColorScheme.fromSeed].
///
/// Use this extension to make a seeded [ColorScheme] using separate key colors
/// for primary, secondary, tertiary, error, neutral and neutral variant
/// color groups in [ColorScheme].
///
/// By providing a [FlexTones] you can also customize tone mapping from
/// tonal palettes to [ColorScheme] color and key color chroma usage per key
/// color, used by the Material 3 tonal palette creation HCT (Hue-Chroma-Tone)
/// color space algorithm.
///
/// As with [ColorScheme.fromSeed], prefer using same key colors when seed
/// generating your light and dark [ColorScheme] to create a balanced and
/// matching light and dark scheme.
extension SeedColorScheme on ColorScheme {
  /// Returns a [ColorScheme] from seed keys [primaryKey], [secondaryKey],
  /// [tertiaryKey], [errorKey], [neutralKey] and [neutralVariantKey] colors.
  ///
  /// Use [FlexTones] configuration to customize tone mapping from tonal
  /// palettes to [ColorScheme] color and key color chroma usage, per key
  /// color for the tonal palette creation.
  ///
  /// Any seed produced [ColorScheme] color can be overridden by providing it a
  /// given [Color] value.
  static ColorScheme fromSeeds({
    /// The overall brightness of this color scheme.
    Brightness brightness = Brightness.light,

    /// Seed color used to generate all the primary color dependent colors in
    /// a ColorScheme.
    ///
    /// In Material 3 color system and in [ColorScheme.fromSeed], this color is
    /// used to generate palettes for all tonal palettes, except error palette
    /// that has its own fixed seed value.
    ///
    /// The default is the same here. However, if colors are provided for
    /// [secondaryKey] and [tertiaryKey] their tonal palettes will be seeded
    /// from their own key color. Likewise for [errorKey], [neutralKey] and
    /// the [neutralVariantKey] colors. It is however uncommon and seldom
    /// needed to customize them, but to create very custom an unique looking
    /// apps, it is possible to do so.
    ///
    /// As in [ColorScheme.fromSeed], there is no guarantee that the used key
    /// color, used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [primaryKey] will typically not become your [ColorScheme.primary] color.
    /// It will only be of the same hue. If you used a color intended for light
    /// theme mode as [primaryKey], consider overriding [primary] for the light
    /// theme with the same color value as your [primaryKey].
    required Color primaryKey,

    /// Optional key color used to seed the secondary tonal palette.
    ///
    /// There is no guarantee that the used key
    /// color used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [secondaryKey] will typically not become your [ColorScheme.secondary]
    /// color. It will only be of the same hue. If you used a color intended
    /// for light theme mode as [secondaryKey], consider overriding [secondary]
    /// for the light theme with the same color value as your [secondaryKey].
    Color? secondaryKey,

    /// Optional key color used to seed the tertiary tonal palette.
    ///
    /// There is no guarantee that the used key
    /// color used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [tertiaryKey] will typically not become your [ColorScheme.tertiary]
    /// color. It will only be of the same hue. If you used a color intended
    /// for light theme mode as [tertiaryKey], consider overriding [tertiary]
    /// for the light theme with the same color value as your [tertiaryKey].
    Color? tertiaryKey,

    /// Optional key color used to seed the error tonal palette.
    ///
    /// There is no guarantee that the used key
    /// color used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [errorKey] will typically not become your [ColorScheme.error]
    /// color. It will only be of the same hue. If you used a color intended
    /// for light theme mode as [errorKey], consider overriding [error]
    /// for the light theme with the same color value as your [errorKey].
    Color? errorKey,

    /// Optional key color used to seed the neutral tonal palette.
    ///
    /// There is no guarantee that the used key
    /// color used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [neutralKey] will typically not become your [ColorScheme.surface]
    /// color. It will only be of the same hue. If you used a color intended
    /// for light theme mode as [neutralKey], consider overriding [surface]
    /// for the light theme with the same color value as your [neutralKey].
    Color? neutralKey,

    /// Optional key color used to seed the neutral variant tonal palette.
    ///
    /// There is no guarantee that the used key
    /// color used as seed, ends up as the corresponding main color in the
    /// produced [ColorScheme] for the palette in question. In this case
    /// [neutralVariantKey] will typically not become your
    /// [ColorScheme] variant colors. It will only be of the same hue.
    /// If you used a color intended for light theme mode as
    /// [neutralVariantKey], consider overriding one of the variant theme colors
    /// with the same color value as your [neutralVariantKey].
    ///
    /// The variant palette is only used by the [ColorScheme] variant colors
    /// [onSurfaceVariant], [outline] and [outlineVariant], the
    /// main color that used it prior to Flutter 3.22 surfaceVariant has been
    /// deprecated.
    Color? neutralVariantKey,

    /// Tonal palette chroma usage configuration and mapping to [ColorScheme].
    ///
    /// Optional mapping configuration for how tonal palette tones are mapped
    /// to their corresponding [ColorScheme] colors.
    ///
    /// Can also configure how chroma is limited or fixed from the provided
    /// key colors when generating each tonal palette.
    ///
    /// If not provided, a setup matching the Material 3 Color System
    /// specification is used. To create seed generated [ColorScheme] with
    /// different chroma limits and tonal mappings provide a custom [FlexTones],
    /// or use a predefined one like [FlexTones.jolly], [FlexTones.vivid] or
    /// [FlexTones.highContrast].
    ///
    /// Starting with version 2.0.0 you can also use [variant] as an optional
    /// way to select a predefined seed generation configuration, instead of
    /// providing a [FlexTones] configuration. The [variant] API is also used
    /// to provide access to the DynamicSchemeVariant that are available
    /// in Flutter 3.23.0 and later. With FSS you can use them in Flutter 3.22
    /// already.
    FlexTones? tones,

    /// An optional way to select the used algorithm for seeded [ColorScheme]
    /// generation, can be used instead of a [FlexTones] provided in [tones].
    ///
    /// If used and a non null value is given, any seed generation configuration
    /// provided via [tones] is ignored and the [variant] is used to select
    /// a predefined seed generation configuration.
    ///
    /// The [variant] selections includes all the Flutter SDK defined options
    /// that will be available in the future in Flutter Stable after 3.22.x,
    /// that are available in master channel now but did not land in Flutter
    /// 3.22. Variant options that are identical to the Flutter SDK options
    /// have [FlexSchemeVariant.value], [isFlutterScheme] set to true. These
    /// enum  options will not respect and use any other seed generation key
    /// than the [primaryKey], as they only support using one seed color.
    ///
    /// The [FlexSchemeVariant] also includes quick selections for all the
    /// predefined [FlexTones] configurations. However, with [variant] you can
    /// only select one of the predefined configurations, and not make custom
    /// configurations like you can with [FlexTones]. Additionally you can not
    /// use the [FlexTones] modifiers [onMainsUseBW], [onSurfacesUseBW] and
    /// [surfacesUseBW], since the only operate on the [FlexTones]
    /// configurations passed in to [tones].
    FlexSchemeVariant? variant,

    /// Override color for the seed generated [primary] color.
    ///
    /// You may want to assign the [primaryKey] to this color in light
    /// brightness mode, if it is also your branding or main design color.
    Color? primary,

    /// Override color for the seed generated [onPrimary] color.
    Color? onPrimary,

    /// Override color for the seed generated [primaryContainer] color.
    Color? primaryContainer,

    /// Override color for the seed generated [onPrimaryContainer] color.
    Color? onPrimaryContainer,

    /// Override color for the seed generated [primaryFixed] color.
    Color? primaryFixed,

    /// Override color for the seed generated [primaryFixedDim] color.
    Color? primaryFixedDim,

    /// Override color for the seed generated [onPrimaryFixed] color.
    Color? onPrimaryFixed,

    /// Override color for the seed generated [onPrimaryFixedVariant] color.
    Color? onPrimaryFixedVariant,

    /// Override color for the seed generated [secondary] color.
    ///
    /// You may sometimes want to assign the [secondaryKey] to this color in
    /// light brightness mode, if it is also your secondary brand or design
    /// color.
    ///
    /// If you only have two brand or design colors, consider using it as key
    /// color and override for the tertiary color instead, as the M3 color
    /// system calls for a secondary color that is same or close in hue to the
    /// primary color but with less chroma. Your secondary brand or design color
    /// may not fit well with that constraint. The tertiary color in M3 color
    /// system does not have this preference.
    Color? secondary,

    /// Override color for the seed generated [onSecondary] color.
    Color? onSecondary,

    /// Override color for the seed generated [secondaryContainer] color.
    Color? secondaryContainer,

    /// Override color for the seed generated [onSecondaryContainer] color.
    Color? onSecondaryContainer,

    /// Override color for the seed generated [secondaryFixed] color.
    Color? secondaryFixed,

    /// Override color for the seed generated [secondaryFixedDim] color.
    Color? secondaryFixedDim,

    /// Override color for the seed generated [onSecondaryFixed] color.
    Color? onSecondaryFixed,

    /// Override color for the seed generated [onSecondaryFixedVariant] color.
    Color? onSecondaryFixedVariant,

    /// Override color for the seed generated [tertiary] color.
    ///
    /// You may sometimes want to assign the [tertiaryKey] to this color in
    /// light brightness mode, if it is also your secondary or tertiary brand
    /// or design color.
    ///
    /// If you only have two brand or design colors, consider using it as
    /// key color and override for the tertiary color, as the M3 color
    /// system calls for a secondary color that is same or close in hue to the
    /// primary color but with less chroma. Your secondary brand or design color
    /// may not fit well with that constraint. The tertiary color in M3 color
    /// system does not have this preference.
    Color? tertiary,

    /// Override color for the seed generated [onTertiary] color.
    Color? onTertiary,

    /// Override color for the seed generated [tertiaryContainer] color.
    Color? tertiaryContainer,

    /// Override color for the seed generated [onTertiaryContainer] color.
    Color? onTertiaryContainer,

    /// Override color for the seed generated [tertiaryFixed] color.
    Color? tertiaryFixed,

    /// Override color for the seed generated [tertiaryFixedDim] color.
    Color? tertiaryFixedDim,

    /// Override color for the seed generated [onTertiaryFixed] color.
    Color? onTertiaryFixed,

    /// Override color for the seed generated [onTertiaryFixedVariant] color.
    Color? onTertiaryFixedVariant,

    /// Override color for the seed generated [error] color.
    Color? error,

    /// Override color for the seed generated [onError] color.
    Color? onError,

    /// Override color for the seed generated [errorContainer] color.
    Color? errorContainer,

    /// Override color for the seed generated [onErrorContainer] color.
    Color? onErrorContainer,

    /// Override color for the seed generated [surface] color.
    Color? surface,

    /// Override color for the seed generated [surfaceDim] color.
    Color? surfaceDim,

    /// Override color for the seed generated [surfaceBright] color.
    Color? surfaceBright,

    /// Override color for the seed generated [surfaceContainerLowest] color.
    Color? surfaceContainerLowest,

    /// Override color for the seed generated [surfaceContainerLow] color.
    Color? surfaceContainerLow,

    /// Override color for the seed generated [surfaceContainer] color.
    Color? surfaceContainer,

    /// Override color for the seed generated [surfaceContainerHigh] color.
    Color? surfaceContainerHigh,

    /// Override color for the seed generated [surfaceContainerHighest] color.
    Color? surfaceContainerHighest,

    /// Override color for the seed generated [onSurface] color.
    Color? onSurface,

    /// Override color for the seed generated [onSurfaceVariant] color.
    Color? onSurfaceVariant,

    /// Override color for the seed generated [outline] color.
    Color? outline,

    /// Override color for the seed generated [outlineVariant] color.
    Color? outlineVariant,

    /// Override color for the seed generated [shadow] color.
    Color? shadow,

    /// Override color for the seed generated [scrim] color.
    Color? scrim,

    /// Override color for the seed generated [inverseSurface] color.
    Color? inverseSurface,

    /// Override color for the seed generated [onInverseSurface] color.
    Color? onInverseSurface,

    /// Override color for the seed generated [inversePrimary] color.
    Color? inversePrimary,

    /// Override color for the seed generated [surfaceTint] color.
    Color? surfaceTint,

    /// Override color for the seed generated [background] color.
    @Deprecated('Use surface instead.') Color? background,

    /// Override color for the seed generated [onBackground] color.
    @Deprecated('Use onSurface instead.') Color? onBackground,

    /// Override color for the seed generated [surfaceVariant] color.
    @Deprecated('Use surfaceContainerHighest instead.') Color? surfaceVariant,
  }) {
    // Assert that a none null value has not been assign to tones and variant
    // at the same time, since they are mutually exclusive, both can be null.
    assert(tones == null || variant == null,
        'Only one of tones or variant can be provided, not both.');

    if (variant != null && variant.isFlutterScheme) {
      final DynamicScheme scheme =
          buildDynamicScheme(brightness, primaryKey, variant);
      return ColorScheme(
        primary:
            primary ?? Color(MaterialDynamicColors.primary.getArgb(scheme)),
        onPrimary:
            onPrimary ?? Color(MaterialDynamicColors.onPrimary.getArgb(scheme)),
        primaryContainer: primaryContainer ??
            Color(MaterialDynamicColors.primaryContainer.getArgb(scheme)),
        onPrimaryContainer: onPrimaryContainer ??
            Color(MaterialDynamicColors.onPrimaryContainer.getArgb(scheme)),
        primaryFixed: primaryFixed ??
            Color(MaterialDynamicColors.primaryFixed.getArgb(scheme)),
        primaryFixedDim: primaryFixedDim ??
            Color(MaterialDynamicColors.primaryFixedDim.getArgb(scheme)),
        onPrimaryFixed: onPrimaryFixed ??
            Color(MaterialDynamicColors.onPrimaryFixed.getArgb(scheme)),
        onPrimaryFixedVariant: onPrimaryFixedVariant ??
            Color(MaterialDynamicColors.onPrimaryFixedVariant.getArgb(scheme)),
        secondary:
            secondary ?? Color(MaterialDynamicColors.secondary.getArgb(scheme)),
        onSecondary: onSecondary ??
            Color(MaterialDynamicColors.onSecondary.getArgb(scheme)),
        secondaryContainer: secondaryContainer ??
            Color(MaterialDynamicColors.secondaryContainer.getArgb(scheme)),
        onSecondaryContainer: onSecondaryContainer ??
            Color(MaterialDynamicColors.onSecondaryContainer.getArgb(scheme)),
        secondaryFixed: secondaryFixed ??
            Color(MaterialDynamicColors.secondaryFixed.getArgb(scheme)),
        secondaryFixedDim: secondaryFixedDim ??
            Color(MaterialDynamicColors.secondaryFixedDim.getArgb(scheme)),
        onSecondaryFixed: onSecondaryFixed ??
            Color(MaterialDynamicColors.onSecondaryFixed.getArgb(scheme)),
        onSecondaryFixedVariant: onSecondaryFixedVariant ??
            Color(
                MaterialDynamicColors.onSecondaryFixedVariant.getArgb(scheme)),
        tertiary:
            tertiary ?? Color(MaterialDynamicColors.tertiary.getArgb(scheme)),
        onTertiary: onTertiary ??
            Color(MaterialDynamicColors.onTertiary.getArgb(scheme)),
        tertiaryContainer: tertiaryContainer ??
            Color(MaterialDynamicColors.tertiaryContainer.getArgb(scheme)),
        onTertiaryContainer: onTertiaryContainer ??
            Color(MaterialDynamicColors.onTertiaryContainer.getArgb(scheme)),
        tertiaryFixed: tertiaryFixed ??
            Color(MaterialDynamicColors.tertiaryFixed.getArgb(scheme)),
        tertiaryFixedDim: tertiaryFixedDim ??
            Color(MaterialDynamicColors.tertiaryFixedDim.getArgb(scheme)),
        onTertiaryFixed: onTertiaryFixed ??
            Color(MaterialDynamicColors.onTertiaryFixed.getArgb(scheme)),
        onTertiaryFixedVariant: onTertiaryFixedVariant ??
            Color(MaterialDynamicColors.onTertiaryFixedVariant.getArgb(scheme)),
        error: error ?? Color(MaterialDynamicColors.error.getArgb(scheme)),
        onError:
            onError ?? Color(MaterialDynamicColors.onError.getArgb(scheme)),
        errorContainer: errorContainer ??
            Color(MaterialDynamicColors.errorContainer.getArgb(scheme)),
        onErrorContainer: onErrorContainer ??
            Color(MaterialDynamicColors.onErrorContainer.getArgb(scheme)),
        outline:
            outline ?? Color(MaterialDynamicColors.outline.getArgb(scheme)),
        outlineVariant: outlineVariant ??
            Color(MaterialDynamicColors.outlineVariant.getArgb(scheme)),
        surface:
            surface ?? Color(MaterialDynamicColors.surface.getArgb(scheme)),
        surfaceDim: surfaceDim ??
            Color(MaterialDynamicColors.surfaceDim.getArgb(scheme)),
        surfaceBright: surfaceBright ??
            Color(MaterialDynamicColors.surfaceBright.getArgb(scheme)),
        surfaceContainerLowest: surfaceContainerLowest ??
            Color(MaterialDynamicColors.surfaceContainerLowest.getArgb(scheme)),
        surfaceContainerLow: surfaceContainerLow ??
            Color(MaterialDynamicColors.surfaceContainerLow.getArgb(scheme)),
        surfaceContainer: surfaceContainer ??
            Color(MaterialDynamicColors.surfaceContainer.getArgb(scheme)),
        surfaceContainerHigh: surfaceContainerHigh ??
            Color(MaterialDynamicColors.surfaceContainerHigh.getArgb(scheme)),
        surfaceContainerHighest: surfaceContainerHighest ??
            Color(
                MaterialDynamicColors.surfaceContainerHighest.getArgb(scheme)),
        onSurface:
            onSurface ?? Color(MaterialDynamicColors.onSurface.getArgb(scheme)),
        onSurfaceVariant: onSurfaceVariant ??
            Color(MaterialDynamicColors.onSurfaceVariant.getArgb(scheme)),
        inverseSurface: inverseSurface ??
            Color(MaterialDynamicColors.inverseSurface.getArgb(scheme)),
        onInverseSurface: onInverseSurface ??
            Color(MaterialDynamicColors.inverseOnSurface.getArgb(scheme)),
        inversePrimary: inversePrimary ??
            Color(MaterialDynamicColors.inversePrimary.getArgb(scheme)),
        shadow: shadow ?? Color(MaterialDynamicColors.shadow.getArgb(scheme)),
        scrim: scrim ?? Color(MaterialDynamicColors.scrim.getArgb(scheme)),
        surfaceTint:
            surfaceTint ?? Color(MaterialDynamicColors.primary.getArgb(scheme)),
        brightness: brightness,
        // DEPRECATED (newest deprecations at the bottom)
        background: background ??
            Color(MaterialDynamicColors.background.getArgb(scheme)),
        onBackground: onBackground ??
            Color(MaterialDynamicColors.onBackground.getArgb(scheme)),
        surfaceVariant: surfaceVariant ??
            Color(MaterialDynamicColors.surfaceVariant.getArgb(scheme)),
      );
    } else {
      FlexTones? variantTones;
      // If a variant is selected, use its tones.
      if (variant != null) {
        variantTones = variant.tones(brightness);
      }
      final FlexSeedScheme scheme = FlexSeedScheme._tones(
        primaryKey: primaryKey.value,
        secondaryKey: secondaryKey?.value,
        tertiaryKey: tertiaryKey?.value,
        errorKey: errorKey?.value,
        neutralKey: neutralKey?.value,
        neutralVariantKey: neutralVariantKey?.value,
        tones: tones ?? variantTones ?? FlexTones.material(brightness),
      );

      return ColorScheme(
        primary: primary ?? Color(scheme.primary),
        onPrimary: onPrimary ?? Color(scheme.onPrimary),
        primaryContainer: primaryContainer ?? Color(scheme.primaryContainer),
        onPrimaryContainer:
            onPrimaryContainer ?? Color(scheme.onPrimaryContainer),
        primaryFixed: primaryFixed ?? Color(scheme.primaryFixed),
        primaryFixedDim: primaryFixedDim ?? Color(scheme.primaryFixedDim),
        onPrimaryFixed: onPrimaryFixed ?? Color(scheme.onPrimaryFixed),
        onPrimaryFixedVariant:
            onPrimaryFixedVariant ?? Color(scheme.onPrimaryFixedVariant),
        //
        secondary: secondary ?? Color(scheme.secondary),
        onSecondary: onSecondary ?? Color(scheme.onSecondary),
        secondaryContainer:
            secondaryContainer ?? Color(scheme.secondaryContainer),
        onSecondaryContainer:
            onSecondaryContainer ?? Color(scheme.onSecondaryContainer),
        secondaryFixed: secondaryFixed ?? Color(scheme.secondaryFixed),
        secondaryFixedDim: secondaryFixedDim ?? Color(scheme.secondaryFixedDim),
        onSecondaryFixed: onSecondaryFixed ?? Color(scheme.onSecondaryFixed),
        onSecondaryFixedVariant:
            onSecondaryFixedVariant ?? Color(scheme.onSecondaryFixedVariant),
        //
        tertiary: tertiary ?? Color(scheme.tertiary),
        onTertiary: onTertiary ?? Color(scheme.onTertiary),
        tertiaryContainer: tertiaryContainer ?? Color(scheme.tertiaryContainer),
        onTertiaryContainer:
            onTertiaryContainer ?? Color(scheme.onTertiaryContainer),
        tertiaryFixed: tertiaryFixed ?? Color(scheme.tertiaryFixed),
        tertiaryFixedDim: tertiaryFixedDim ?? Color(scheme.tertiaryFixedDim),
        onTertiaryFixed: onTertiaryFixed ?? Color(scheme.onTertiaryFixed),
        onTertiaryFixedVariant:
            onTertiaryFixedVariant ?? Color(scheme.onTertiaryFixedVariant),
        //
        error: error ?? Color(scheme.error),
        onError: onError ?? Color(scheme.onError),
        errorContainer: errorContainer ?? Color(scheme.errorContainer),
        onErrorContainer: onErrorContainer ?? Color(scheme.onErrorContainer),
        //
        surface: surface ?? Color(scheme.surface),
        surfaceDim: surfaceDim ?? Color(scheme.surfaceDim),
        surfaceBright: surfaceBright ?? Color(scheme.surfaceBright),
        surfaceContainerLowest:
            surfaceContainerLowest ?? Color(scheme.surfaceContainerLowest),
        surfaceContainerLow:
            surfaceContainerLow ?? Color(scheme.surfaceContainerLow),
        surfaceContainer: surfaceContainer ?? Color(scheme.surfaceContainer),
        surfaceContainerHigh:
            surfaceContainerHigh ?? Color(scheme.surfaceContainerHigh),
        surfaceContainerHighest:
            surfaceContainerHighest ?? Color(scheme.surfaceContainerHighest),
        onSurface: onSurface ?? Color(scheme.onSurface),
        onSurfaceVariant: onSurfaceVariant ?? Color(scheme.onSurfaceVariant),
        //
        outline: outline ?? Color(scheme.outline),
        outlineVariant: outlineVariant ?? Color(scheme.outlineVariant),
        shadow: shadow ?? Color(scheme.shadow),
        scrim: scrim ?? Color(scheme.scrim),
        inverseSurface: inverseSurface ?? Color(scheme.inverseSurface),
        onInverseSurface: onInverseSurface ?? Color(scheme.onInverseSurface),
        inversePrimary: inversePrimary ?? Color(scheme.inversePrimary),
        surfaceTint: surfaceTint ?? Color(scheme.primary),
        // Deprecated colors
        background: background ?? Color(scheme.background),
        onBackground: onBackground ?? Color(scheme.onBackground),
        surfaceVariant: surfaceVariant ?? Color(scheme.surfaceVariant),
        //
        brightness: brightness,
      );
    }
  }

  /// Build one of the Flutter SDK defined DynamicScheme variants.
  ///
  /// If used with a FlexTones based [FlexSchemeVariant] variant it returns
  /// tonalSpot, the default Material-3 SDK style.
  static DynamicScheme buildDynamicScheme(
      Brightness brightness, Color seedColor, FlexSchemeVariant variant) {
    final bool isDark = brightness == Brightness.dark;
    final Hct sourceColor = Hct.fromInt(seedColor.value);
    return switch (variant) {
      FlexSchemeVariant.material ||
      FlexSchemeVariant.material3Legacy ||
      FlexSchemeVariant.soft ||
      FlexSchemeVariant.vivid ||
      FlexSchemeVariant.vividSurfaces ||
      FlexSchemeVariant.highContrast ||
      FlexSchemeVariant.ultraContrast ||
      FlexSchemeVariant.jolly ||
      FlexSchemeVariant.vividBackground ||
      FlexSchemeVariant.oneHue ||
      FlexSchemeVariant.candyPop ||
      FlexSchemeVariant.chroma ||
      FlexSchemeVariant.tonalSpot =>
        SchemeTonalSpot(
            sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.fidelity => SchemeFidelity(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.content => SchemeContent(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.monochrome => SchemeMonochrome(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.neutral => SchemeNeutral(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.vibrant => SchemeVibrant(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.expressive => SchemeExpressive(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.rainbow => SchemeRainbow(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
      FlexSchemeVariant.fruitSalad => SchemeFruitSalad(
          sourceColorHct: sourceColor, isDark: isDark, contrastLevel: 0.0),
    };
  }
}
