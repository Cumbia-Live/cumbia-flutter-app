import 'package:flutter/cupertino.dart';

import '../config.dart';

mixin Styles {
  /// BOTONES
  static TextStyle btn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Palette.white,
  );
  static TextStyle btnPromoter = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );
  static TextStyle txtBtn(
          {bool isEnabled = true,
          double size = 15,
          FontWeight fontWeight = FontWeight.w600}) =>
      TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: isEnabled ? Palette.cumbiaDark : Palette.black.withOpacity(0.25),
      );
  static TextStyle navBtn(
          {bool isEnabled = true, double size = 17, Color color}) =>
      TextStyle(
        fontSize: size,
        color: color == null
            ? isEnabled
                ? Palette.cumbiaDark
                : Palette.black.withOpacity(0.25)
            : color,
      );

  /// LBLS
  // Título grande de cada pestaña
  static TextStyle largeTitleLbl = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.2,
    color: Palette.cumbiaLight,
  );
  static TextStyle titleLbl = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );
  // Título de ShortMessageView
  static TextStyle shortMessageTitleLbl = TextStyle(
    fontSize: 24,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w600,
    color: Palette.black,
  );
  // Texto de ShortMessageView
  static TextStyle shortMessageLbl({double size = 16, Color color}) =>
      TextStyle(
        fontSize: size,
        color: color ?? Palette.black.withOpacity(0.5),
      );

  static TextStyle secondaryLbl = TextStyle(
    fontSize: 15,
    color: Palette.black.withOpacity(0.5),
    fontWeight: FontWeight.w400,
  );

  static TextStyle precioProductos = TextStyle(
    fontSize: 16,
    color: Palette.cumbiaCian,
    fontWeight: FontWeight.w700,
  );

  static TextStyle paragraphLbl = TextStyle(
    fontSize: 13,
    color: Palette.black.withOpacity(0.5),
    fontWeight: FontWeight.w400,
  );

  // Nombre de perfil
  static TextStyle perfilNameLbl = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    color: Palette.black,
  );
  // Títulos de las pestañas
  static TextStyle navTitleLbl = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Palette.black,
  );

  /// TXT
  // Título de TxtField
  static TextStyle txtTitleLbl = TextStyle(
    fontSize: 15,
    color: Palette.black.withOpacity(0.75),
    fontWeight: FontWeight.w600,
  );
  // Texto de campos de texto
  static TextStyle txtTextLbl(
          {Color color = Palette.black,
          double size = 16,
          FontWeight weight = FontWeight.w500}) =>
      TextStyle(
        fontSize: size,
        color: color,
        fontWeight: weight,
      );
  // Placeholder de campos de texto
  static TextStyle placeholderLbl = TextStyle(
    fontSize: 16,
    color: Palette.black.withOpacity(0.35),
  );
  // Placeholder live
  static TextStyle placeholderLiveLbl = TextStyle(
    fontSize: 16,
    color: Palette.white.withOpacity(0.5),
  );
  // Mensaje de verificación de Txts
  static TextStyle validationLbl = TextStyle(
    fontSize: 14,
    color: Palette.red,
  );

  // Configuración Lbl
  static TextStyle configLbl = TextStyle(
    fontSize: 16,
    color: Palette.black.withOpacity(0.85),
  );

  // live lbl
  static TextStyle liveLbl = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Palette.white,
  );
  // Descripción del live
  static TextStyle descriptionLiveLbl = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Palette.black,
  );

  // Espectadores del live
  static TextStyle audienceLiveLbl = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w300,
    color: Palette.white,
  );

  // Título del live
  static TextStyle tittleLiveLbl = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Palette.black,
  );

  // live tiendas lbl
  static TextStyle liveShopLbl = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Palette.black.withOpacity(0.7));
  // live del home lbl
  static TextStyle liveBasicLbl = TextStyle(
    color: Palette.cumbiaDark,
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle ulTransmision = TextStyle(
    color: Palette.darkGrey,
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle ulTransmision2 = TextStyle(
    color: Palette.cumbiaGrey,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle categoriasPerfilTiendas = TextStyle(
    color: Palette.cumbiaSeller,
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
  );

  // titulo de permisos
  static TextStyle permisosTitleLbl = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );

  // en vivo Streamer page
  static TextStyle labelLive = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Palette.white,
  );
  // en vivo usuarios
  static TextStyle usersLive = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Palette.white,
  );

  // título live
  static TextStyle tittleLive = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Palette.white,
    letterSpacing: -1.2,
  );

  // Nombre título profuctos
  static TextStyle nombretituloProductos = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Palette.cumbiaSeller,
  );

  // label live
  static TextStyle labelLivestream = TextStyle(
    fontSize: 14,
    color: Palette.white.withOpacity(0.75),
  );

  static TextStyle liveStyle({
    double size = 12,
    Color color,
    FontWeight fontWeight,
  }) =>
      TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      );

  static TextStyle italicbl({
    double size = 14,
    Color color,
    FontStyle fontStyle,
  }) =>
      TextStyle(
        fontSize: size,
        color: color ?? Palette.black.withOpacity(0.5),
        fontStyle: fontStyle,
      );
  static TextStyle labelPromoter = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Palette.cumbiaDark,
  );
  static TextStyle titleLive = TextStyle(
    color: Palette.black,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  static TextStyle labelAdminUnderline = TextStyle(
    color: Palette.cumbiaDark,
    fontSize: 14,
    decoration: TextDecoration.underline,
  );
  static TextStyle labelAdmin = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Palette.black.withOpacity(0.7),
  );
  static TextStyle labelBoldAdmin = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Palette.black,
  );
  static TextStyle labelBoldAdminCumbia = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Palette.cumbiaDark,
  );

  static TextStyle optional = TextStyle(
    fontSize: 10,
    color: Palette.black.withOpacity(0.7),
  );

  static TextStyle labelRegister = TextStyle(
    fontSize: 14,
    color: Palette.black,
  );
  static TextStyle titleRegister = TextStyle(
    fontSize: 16,
    color: Palette.cumbiaLight,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleProducts = TextStyle(
    fontSize: 16,
    color: Palette.cumbiaSeller,
    fontWeight: FontWeight.bold,
  );
}
