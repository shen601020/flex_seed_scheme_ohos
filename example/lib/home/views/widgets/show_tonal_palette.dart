import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import '../../../theme/controllers/theme_controller.dart';
import 'select_palette_type.dart';
import 'tonal_palette_colors.dart';

class ShowTonalPalette extends StatelessWidget {
  const ShowTonalPalette({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Brightness brightness = theme.brightness;
    // Get the FlexTones setup
    final FlexTones tones = controller.usedVariant.tones(brightness);
    // Type of palette to show.
    final FlexPaletteType paletteType = controller.paletteType;

    // List of ints that we need to draw the tonal palettes.
    List<int> primaryTonals = <int>[];
    List<int> secondaryTonals = <int>[];
    List<int> tertiaryTonals = <int>[];
    List<int> errorTonals = <int>[];
    List<int> neutralTonals = <int>[];
    List<int> neutralVariantTonals = <int>[];

    // TODO(rydmike): Add usage of contrast level to demo app.
    // Are we using a Flutter SDK scheme? Otherwise use FlexTone.
    if (controller.usedVariant.isFlutterScheme) {
      // Get DynamicScheme tones if using Flutter SDK scheme.
      final DynamicScheme dynamicScheme = SeedColorScheme.buildDynamicScheme(
          brightness, controller.primarySeedColor, controller.usedVariant, 0.0);

      // Assign the tonals for the schemes to the int lists using tone indexes
      // from FlexTonalPalette based on used type.
      switch (paletteType) {
        case FlexPaletteType.common:
          for (final int i in FlexTonalPalette.commonTones) {
            primaryTonals.add(dynamicScheme.primaryPalette.get(i));
            secondaryTonals.add(dynamicScheme.secondaryPalette.get(i));
            tertiaryTonals.add(dynamicScheme.tertiaryPalette.get(i));
            errorTonals.add(dynamicScheme.errorPalette.get(i));
            neutralTonals.add(dynamicScheme.neutralPalette.get(i));
            neutralVariantTonals
                .add(dynamicScheme.neutralVariantPalette.get(i));
          }
        case FlexPaletteType.extended:
          for (final int i in FlexTonalPalette.extendedTones) {
            primaryTonals.add(dynamicScheme.primaryPalette.get(i));
            secondaryTonals.add(dynamicScheme.secondaryPalette.get(i));
            tertiaryTonals.add(dynamicScheme.tertiaryPalette.get(i));
            errorTonals.add(dynamicScheme.errorPalette.get(i));
            neutralTonals.add(dynamicScheme.neutralPalette.get(i));
            neutralVariantTonals
                .add(dynamicScheme.neutralVariantPalette.get(i));
          }
      }
    } else {
      // Get FlexCorePalette tones if using FlexTone
      final FlexCorePalette palettes = FlexCorePalette.fromSeeds(
        primary: controller.primarySeedColor.value,
        // Pass in null if set to not use secondary or tertiary seed keys.
        secondary: controller.useSecondaryKey
            ? controller.secondarySeedColor.value
            : null,
        tertiary: controller.useTertiaryKey
            ? controller.tertiarySeedColor.value
            : null,
        error: controller.useErrorKey ? controller.errorSeedColor.value : null,
        // Tone config details we get from active FlexTones.
        primaryChroma: tones.primaryChroma,
        primaryMinChroma: tones.primaryMinChroma,
        secondaryChroma: tones.secondaryChroma,
        secondaryMinChroma: tones.secondaryMinChroma,
        tertiaryChroma: tones.tertiaryChroma,
        tertiaryMinChroma: tones.tertiaryMinChroma,
        tertiaryHueRotation: tones.tertiaryHueRotation,
        neutralChroma: tones.neutralChroma,
        neutralVariantChroma: tones.neutralVariantChroma,
        paletteType: paletteType,
      );
      // Assign the tonals for the schemes to the int lists.
      primaryTonals = palettes.primary.asList;
      secondaryTonals = palettes.secondary.asList;
      tertiaryTonals = palettes.tertiary.asList;
      errorTonals = palettes.error.asList;
      neutralTonals = palettes.neutral.asList;
      neutralVariantTonals = palettes.neutralVariant.asList;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'TonalPalettes Tones and Colors',
                style: theme.textTheme.titleMedium,
              ),
            ),
            const Spacer(),
            SelectPaletteType(controller: controller),
            const SizedBox(width: 12),
          ],
        ),
        TonalPaletteColors(
          name: 'Primary',
          tonalPalette: primaryTonals,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Secondary',
          tonalPalette: secondaryTonals,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Tertiary',
          tonalPalette: tertiaryTonals,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Error',
          tonalPalette: errorTonals,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Neutral',
          tonalPalette: neutralTonals,
          paletteType: paletteType,
        ),
        TonalPaletteColors(
          name: 'Neutral variant',
          tonalPalette: neutralVariantTonals,
          paletteType: paletteType,
        ),
      ],
    );
  }
}
