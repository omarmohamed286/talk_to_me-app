const String kTokenKey = 'token';

//10.0.2.2 for emulator
//192.168.1.2 for real device
const String kIp = '10.0.2.2';
const String kBaseUrl = 'http://$kIp:3000/api/v1';

const List<String> kLanguages = [
  'English',
  'Arabic',
  'Spanish',
  'Italian',
  'German',
  'French'
];
const List<String> kLevels = ['Beginner', 'Intermediate', 'Advanced'];

enum LayoutMode {
  defaultLayout,
  full,
  hostTopCenter,
  hostCenter,
  fourPeoples,
}

extension LayoutModeExtension on LayoutMode {
  String get text {
    final mapValues = {
      LayoutMode.defaultLayout: 'default',
      LayoutMode.full: 'full',
      LayoutMode.hostTopCenter: 'host top center',
      LayoutMode.hostCenter: 'host center',
      LayoutMode.fourPeoples: 'four peoples',
    };

    return mapValues[this]!;
  }
}
