class Constants {
  static List<Map<String, dynamic>> get platforms => [
        {"label": "Game Boy", "value": "GB"},
        {"label": "Game Boy Color", "value": "GBC"},
        {"label": "Game Boy Advance", "value": "GBA"},
      ];

  static List<Map<String, dynamic>> get coverTemplates => [
        {
          "platform": "GB",
          'label': 'Silver',
          "value":
              "assets/images/template_gba_001.png"
        },
        {
          "platform": "GBC",
          'label': 'Silver',
          "value":
              "assets/images/template_gba_001.png"
        },
        {
          "platform": "GBA",
          'label': 'Silver',
          "value":
              "assets/images/template_gba_001.png"
        },
      ];
}
