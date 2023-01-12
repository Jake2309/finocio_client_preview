import 'package:flutter/material.dart';
import 'package:stockolio/shared/colors.dart';

/// This is the common border radious of all the containers in the app.
const kStandatBorder = const BorderRadius.all(Radius.circular(6));

/// This border is slightly more sharp than the standard boder.
const kSharpBorder = const BorderRadius.all(Radius.circular(2));

/// This is the common text styling for a subtile.
const kSubtitleStyling =
    const TextStyle(color: kGray, fontSize: 24, fontWeight: FontWeight.w800);

/// This is the common text styling for a subtile.
const kCompanyNameHeading =
    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800);

const kProfileCompanyName = const TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const kProfileScreenSectionTitle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

const priceStyle = const TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

const subtitleStyle =
    const TextStyle(color: kLighterGray, fontSize: 14.5, height: 1.5);

const kCompanyNameStyle =
    const TextStyle(color: Color(0XFFc2c2c2), fontSize: 13, height: 1.5);

const kStockTickerSymbol =
    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

const kStockPriceStyle = const TextStyle(fontWeight: FontWeight.bold);
