class Encrypter {
  const Encrypter._();
  static final numbers = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];
  static final alphabet = [
    "I",
    "W",
    "e",
    "N",
    "j",
    "A",
    "M",
    "h",
    "l",
    "z",
    "f",
    "G",
    "o",
    "K",
    "n",
    "u",
    "b",
    "v",
    "k",
    "g",
    "L",
    "C",
    "a",
    "H",
    "t",
    "X",
    "y",
    "Q",
    "E",
    "P",
    "x",
    "Y",
    "q",
    "Z",
    "c",
    "p",
    "V",
    "s",
    "O",
    "r",
    "m",
    "S",
    "T",
    "U",
    "i",
    "B",
    "d",
    "F",
    "R",
    "D",
    "w",
    "J"
  ];

  static final specialChars = [
    '!',
    '@',
    '#',
    '%',
    '^',
    '&',
    '*',
    '_',
    '-',
    '+',
    '='
  ];

  static String encrypt(String val, String key) {
    return _encryptMethod(val, key, true);
  }

  static String decrypt(String val, String key) {
    return _encryptMethod(val, key, false);
  }

  static String _encryptMethod(String val, String key, bool isEncrypt) {
    String text = "";
    final chars = val.split("");

    final keyList = _getKeyIndex(key);

    for (var i = 0; i < chars.length; i++) {
      String char = chars[i];

      int keyIndex = i % keyList.length;

      if (char.isNumeric()) {
        int? newIndex = isEncrypt
            ? _getNextIndex(numbers, char, keyList[keyIndex])
            : _getPreviousIndex(numbers, char, keyList[keyIndex]);

        if (newIndex == null) {
          throw Exception("Null next index");
        } else {
          text += numbers[newIndex];
        }
      } else if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
        int? newIndex = isEncrypt
            ? _getNextIndex(alphabet, char, keyList[keyIndex])
            : _getPreviousIndex(alphabet, char, keyList[keyIndex]);

        if (newIndex == null) {
          throw Exception("Null next index");
        } else {
          text += alphabet[newIndex];
        }
      } else {
        int? newIndex = isEncrypt
            ? _getNextIndex(specialChars, char, keyList[keyIndex])
            : _getPreviousIndex(specialChars, char, keyList[keyIndex]);

        if (newIndex == null) {
          text += char;
        } else {
          text += specialChars[newIndex];
        }
      }
    }
    return text;
  }

  static int? _getNextIndex(List<Object> array, Object target, int next) {
    // Find the index of the target value in the array
    int targetIndex = array.indexOf(target);

    if (targetIndex == -1) return null;

    return (targetIndex + next) %
        array.length; // Wrap around to the beginning if needed
  }

  static int? _getPreviousIndex(
      List<Object> array, Object target, int previous) {
    // Find the index of the target value in the array
    int targetIndex = array.indexOf(target);

    if (targetIndex == -1) return null;

    return (targetIndex - previous + array.length) %
        array.length; // Wrap around to the end if needed
  }

  static List<int> _getKeyIndex(String key) {
    final List<int> index = [];

    final list = key.split("");

    for (var char in list) {
      if (char.isNumeric()) {
        index.add(int.parse(char));
      } else {
        int i = alphabet.indexWhere((element) => element == char) + 1;
        index.add(i);
      }
    }

    return index;
  }
}

extension ExtString on String {
  bool isNumeric() {
    return int.tryParse(this) != null;
  }

  bool isUpperCase() {
    int ascii = codeUnitAt(0);
    return ascii >= 65 && ascii <= 90;
  }

  bool isLowerCase() {
    int ascii = codeUnitAt(0);
    return ascii >= 97 && ascii <= 122;
  }
}
