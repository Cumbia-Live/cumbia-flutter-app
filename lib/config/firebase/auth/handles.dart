import 'package:cumbialive/functions/functions.dart';
import 'package:flutter/cupertino.dart';

///============================================================== SIGN UP =========================

enum SignUpError {
  ERROR_INVALID_EMAIL,
  ERROR_WEAK_PASSWORD,
  ERROR_EMAIL_ALREADY_IN_USE,
  ERROR_INVALID_CREDENTIAL,
  ERROR_OPERATION_NOT_ALLOWED,
}

SignUpError signUpErrorFromString(String errorCode) {
  if (errorCode == "ERROR_INVALID_EMAIL") {
    return SignUpError.ERROR_INVALID_EMAIL;
  } else if (errorCode == "ERROR_WEAK_PASSWORD") {
    return SignUpError.ERROR_WEAK_PASSWORD;
  } else if (errorCode == "ERROR_EMAIL_ALREADY_IN_USE") {
    return SignUpError.ERROR_EMAIL_ALREADY_IN_USE;
  } else if (errorCode == "ERROR_INVALID_CREDENTIAL") {
    return SignUpError.ERROR_INVALID_CREDENTIAL;
  } else if (errorCode == "ERROR_OPERATION_NOT_ALLOWED") {
    return SignUpError.ERROR_OPERATION_NOT_ALLOWED;
  }
}

void handleSignUpError(BuildContext context, String errorCode) {
  SignUpError authError = signUpErrorFromString(errorCode);
  switch (authError) {
    case SignUpError.ERROR_INVALID_EMAIL:
      showBasicAlert(context, "Por favor, ingresa un email válido.", "");
      break;
    case SignUpError.ERROR_WEAK_PASSWORD:
      showBasicAlert(context, "Contraseña muy débil.",
          "Por favor, elige una contraseña más segura.");
      break;
    case SignUpError.ERROR_EMAIL_ALREADY_IN_USE:
      showBasicAlert(context, "Ya existe un usuario con este email.",
          "Por favor, elige un email distinto.");
      break;
    case SignUpError.ERROR_INVALID_CREDENTIAL:
      showBasicAlert(context, "Por favor, ingresa un email válido.", "");
      break;
    case SignUpError.ERROR_OPERATION_NOT_ALLOWED:
      showBasicAlert(context, "Registros inhabilitados.",
          "Los registros actualmente se encuentran inhabilitados. Por favor, intenta de nuevo más tarde.");
      break;
    default:
      showBasicAlert(context, "Sin conexión a internet.",
          "Por favor, conecta tu dispositivo a internet e intenta de nuevo.");
      break;
  }
}

///============================================================== SIGN IN =========================

enum SignInError {
  ERROR_INVALID_EMAIL,
  ERROR_USER_NOT_FOUND,
  ERROR_WRONG_PASSWORD,
  ERROR_USER_DISABLED,
  ERROR_TOO_MANY_REQUESTS,
  ERROR_OPERATION_NOT_ALLOWED,
}

SignInError signInErrorFromString(String errorCode) {
  if (errorCode == "ERROR_INVALID_EMAIL") {
    return SignInError.ERROR_INVALID_EMAIL;
  } else if (errorCode == "ERROR_USER_NOT_FOUND") {
    return SignInError.ERROR_USER_NOT_FOUND;
  } else if (errorCode == "ERROR_WRONG_PASSWORD") {
    return SignInError.ERROR_WRONG_PASSWORD;
  } else if (errorCode == "ERROR_USER_DISABLED") {
    return SignInError.ERROR_USER_DISABLED;
  } else if (errorCode == "ERROR_TOO_MANY_REQUESTS") {
    return SignInError.ERROR_TOO_MANY_REQUESTS;
  } else if (errorCode == "ERROR_OPERATION_NOT_ALLOWED") {
    return SignInError.ERROR_OPERATION_NOT_ALLOWED;
  }
}

void handleSignInError(BuildContext context, String errorCode) {
  SignInError authError = signInErrorFromString(errorCode);
  switch (authError) {
    case SignInError.ERROR_INVALID_EMAIL:
      showBasicAlert(context, "Por favor, ingresa un email válido.", "");
      break;
    case SignInError.ERROR_USER_NOT_FOUND:
      showBasicAlert(context, "Usuario inexistente.",
          "Por favor, regístrate o inicia sesión con un usuario existente.");
      break;
    case SignInError.ERROR_WRONG_PASSWORD:
      showBasicAlert(context, "Contraseña incorrecta.",
          "Por favor, ingresa la contraseña correcta.");
      break;
    case SignInError.ERROR_USER_DISABLED:
      showBasicAlert(context, "Usuario inhabilitado.",
          "Por favor, inicia sesión con un usuario habilitado.");
      break;
    case SignInError.ERROR_TOO_MANY_REQUESTS:
      showBasicAlert(context, "Demasiados intentos.",
          "Por favor, intenta de nuevo más tarde.");
      break;
    case SignInError.ERROR_OPERATION_NOT_ALLOWED:
      showBasicAlert(context, "Inicios de sesión inhabilitados.",
          "Los inicios de sesión actualmente se encuentran inhabilitados. Por favor, intenta de nuevo más tarde.");
      break;
    default:
      showBasicAlert(context, "Sin conexión a internet.",
          "Por favor, conecta tu dispositivo a internet e intenta de nuevo.");
      break;
  }
}

///============================================================== SIGN OUT =========================

void handleSignOutError(BuildContext context) {
  showBasicAlert(
    context,
    "Error desconocido.",
    "Por favor, intenta de nuevo más tarde.",
  );
}

///============================================================== RESER PASSW =====================

enum ResetPasswordError {
  ERROR_INVALID_EMAIL,
  ERROR_USER_NOT_FOUND,
  ERROR_TOO_MANY_REQUESTS,
  ERROR_OPERATION_NOT_ALLOWED,
}

ResetPasswordError resetPasswordErrorFromString(String errorCode) {
  if (errorCode == "ERROR_INVALID_EMAIL") {
    return ResetPasswordError.ERROR_INVALID_EMAIL;
  } else if (errorCode == "ERROR_USER_NOT_FOUND") {
    return ResetPasswordError.ERROR_USER_NOT_FOUND;
  } else if (errorCode == "ERROR_TOO_MANY_REQUESTS") {
    return ResetPasswordError.ERROR_TOO_MANY_REQUESTS;
  } else if (errorCode == "ERROR_OPERATION_NOT_ALLOWED") {
    return ResetPasswordError.ERROR_OPERATION_NOT_ALLOWED;
  }
}

void handleResetPasswordError(BuildContext context, String errorCode) {
  ResetPasswordError authError = resetPasswordErrorFromString(errorCode);
  switch (authError) {
    case ResetPasswordError.ERROR_INVALID_EMAIL:
      showBasicAlert(context, "Por favor, ingresa un email válido.", "");
      break;
    case ResetPasswordError.ERROR_USER_NOT_FOUND:
      showBasicAlert(context, "Usuario inexistente.",
          "Por favor, ingresa el email de un usuario existente.");
      break;
    case ResetPasswordError.ERROR_TOO_MANY_REQUESTS:
      showBasicAlert(context, "Demasiados intentos.",
          "Por favor, intenta de nuevo más tarde.");
      break;
    case ResetPasswordError.ERROR_OPERATION_NOT_ALLOWED:
      showBasicAlert(context, "Recuperación de contraseña inhabilitado.",
          "Las recuperaciones de contraseña actualmente se encuentran inhabilitadas. Por favor, intenta de nuevo más tarde.");
      break;
    default:
      showBasicAlert(context, "Sin conexión a internet.",
          "Por favor, conecta tu dispositivo a internet e intenta de nuevo.");
      break;
  }
}
