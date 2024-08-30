import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // FlexSchemeVariant unit tests.
  //****************************************************************************
  group('FSVA1: WITH FlexSchemeVariant ', () {
    const Brightness brightness = Brightness.light;
    FlexTones tones = FlexTones.material(brightness);
    for (final FlexSchemeVariant variant in FlexSchemeVariant.values) {
      final FlexTones flexTones = variant.tones(brightness);

      test(
          'FSVA1.01: GIVEN a FlexSchemeVariant EXPECT variant to return '
          'correct tones for the FlexSchemeVariant', () {
        switch (variant) {
          case FlexSchemeVariant.tonalSpot:
            break;
          case FlexSchemeVariant.fidelity:
            break;
          case FlexSchemeVariant.monochrome:
            break;
          case FlexSchemeVariant.neutral:
            break;
          case FlexSchemeVariant.vibrant:
            break;
          case FlexSchemeVariant.expressive:
            break;
          case FlexSchemeVariant.content:
            break;
          case FlexSchemeVariant.rainbow:
            break;
          case FlexSchemeVariant.fruitSalad:
            break;
          case FlexSchemeVariant.material:
            tones = FlexTones.material(brightness);
            break;
          case FlexSchemeVariant.material3Legacy:
            tones = FlexTones.material3Legacy(brightness);
            break;
          case FlexSchemeVariant.soft:
            tones = FlexTones.soft(brightness);
            break;
          case FlexSchemeVariant.vivid:
            tones = FlexTones.vivid(brightness);
            break;
          case FlexSchemeVariant.vividSurfaces:
            tones = FlexTones.vividSurfaces(brightness);
            break;
          case FlexSchemeVariant.highContrast:
            tones = FlexTones.highContrast(brightness);
            break;
          case FlexSchemeVariant.ultraContrast:
            tones = FlexTones.ultraContrast(brightness);
            break;
          case FlexSchemeVariant.jolly:
            tones = FlexTones.jolly(brightness);
            break;
          case FlexSchemeVariant.vividBackground:
            tones = FlexTones.vividBackground(brightness);
            break;
          case FlexSchemeVariant.oneHue:
            tones = FlexTones.oneHue(brightness);
            break;
          case FlexSchemeVariant.candyPop:
            tones = FlexTones.candyPop(brightness);
            break;
          case FlexSchemeVariant.chroma:
            tones = FlexTones.chroma(brightness);
            break;
        }
        expect(flexTones, tones);
      });
    }
  });
}
