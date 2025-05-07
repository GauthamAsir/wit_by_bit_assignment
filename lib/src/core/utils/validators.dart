

class Validator {
  static RegExp mobilePattern = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');

  static RegExp allowAlphaAndDigits = RegExp('[0-9a-zA-Z]');

  static RegExp textOnly = RegExp(r'[a-zA-Z]');
  static RegExp textOnlyWithSpaces = RegExp(r'[a-zA-Z ]');
  static RegExp only2DecimalPlace = RegExp(r'^\d+\.?\d{0,2}');

  static RegExp emojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}' // Emoticons
    r'\u{1F300}-\u{1F5FF}' // Misc Symbols and Pictographs
    r'\u{1F680}-\u{1F6FF}' // Transport & Map Symbols
    r'\u{1F700}-\u{1F77F}' // Alchemical Symbols
    r'\u{1F780}-\u{1F7FF}' // Geometric Shapes Extended
    r'\u{1F800}-\u{1F8FF}' // Supplemental Arrows-C
    r'\u{1F900}-\u{1F9FF}' // Supplemental Symbols and Pictographs
    r'\u{1FA00}-\u{1FA6F}' // Chess Symbols
    r'\u{1FA70}-\u{1FAFF}' // Symbols and Pictographs Extended-A
    r'\u{2600}-\u{26FF}'   // Miscellaneous Symbols
    r'\u{2700}-\u{27BF}'   // Dingbats
    r'\u{FE00}-\u{FE0F}'   // Variation Selectors
    r'\u{1F1E0}-\u{1F1FF}]', // Flags (iOS)
    unicode: true,
  );

  static bool isEmailValid(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.{6,})').hasMatch(password);
  }

}
