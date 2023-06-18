class NyxTextFormat {
  int textSize;
  bool underline;
  double textScaleX;
  double textScaleY;
  double letterSpacing;
  double lineSpacing;
  int topPadding;
  int leftPadding;
  NyxAlign align;
  NyxFontStyle style;
  NyxFont font;
  NyxTextFormat({
    this.textSize = 24,
    this.underline = false,
    this.textScaleX = 1.0,
    this.textScaleY = 1.0,
    this.letterSpacing = 0,
    this.lineSpacing = 0,
    this.topPadding = 0,
    this.leftPadding = 0,
    this.align = NyxAlign.left,
    this.style = NyxFontStyle.normal,
    this.font = NyxFont.defaultFont,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'textSize': textSize,
      'underline': underline,
      'textScaleX': textScaleX,
      'textScaleY': textScaleY,
      'letterSpacing': letterSpacing,
      'lineSpacing': lineSpacing,
      'topPadding': topPadding,
      'leftPadding': leftPadding,
      'align': align == NyxAlign.left
          ? 0
          : align == NyxAlign.center
              ? 1
              : 2,
      'style': style == NyxFontStyle.normal
          ? 0
          : style == NyxFontStyle.bold
              ? 1
              : style == NyxFontStyle.italic
                  ? 2
                  : 3,
      'font': font == NyxFont.defaultFont
          ? 0
          : font == NyxFont.defaultBold
              ? 1
              : font == NyxFont.sansSerif
                  ? 2
                  : font == NyxFont.serif
                      ? 3
                      : 4,
    };
  }
}

enum NyxFontStyle {
  normal,
  bold,
  italic,
  boldItalic,
}

enum NyxFont {
  defaultFont,
  defaultBold,
  sansSerif,
  serif,
  monospace,
}

enum NyxAlign {
  left,
  center,
  right,
}
