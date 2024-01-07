const alphabet = [
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

const specialChars = ['!', '@', '#', '%', '^', '&', '*', '_', '-', '+', '='];

String encrypt(String val, String key) {
  return encryptMethod(val, key, true);
}

String decrypt(String val, String key) {
  return encryptMethod(val, key, false);
}

String encryptMethod(String val, String key, bool isEncrypt) {
  String text = "";
  final chars = val.split("");

  final keyList = getKeyIndex(key);

  for (var i = 0; i < chars.length; i++) {
    String char = chars[i];

    int keyIndex = i % keyList.length;

    if (char.isNumeric()) {
    } else if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
      int? newIndex = isEncrypt
          ? getNextIndex(alphabet, char, keyList[keyIndex])
          : getPreviousIndex(alphabet, char, keyList[keyIndex]);

      if (newIndex == null) {
        throw Exception("Null next index");
      } else {
        text += alphabet[newIndex];
      }
    } else {
      int? newIndex = isEncrypt
          ? getNextIndex(specialChars, char, keyList[keyIndex])
          : getPreviousIndex(specialChars, char, keyList[keyIndex]);

      if (newIndex == null) {
        text += char;
      } else {
        text += specialChars[newIndex];
      }
    }
  }
  return text;
}

int? getNextIndex(List<Object> array, Object target, int next) {
  // Find the index of the target value in the array
  int targetIndex = array.indexOf(target);

  if (targetIndex == -1) return null;

  return (targetIndex + next) %
      array.length; // Wrap around to the beginning if needed
}

int? getPreviousIndex(List<Object> array, Object target, int previous) {
  // Find the index of the target value in the array
  int targetIndex = array.indexOf(target);

  if (targetIndex == -1) return null;

  return (targetIndex - previous + array.length) %
      array.length; // Wrap around to the end if needed
}

List<int> getKeyIndex(String key) {
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
