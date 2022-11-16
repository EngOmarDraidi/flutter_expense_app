class Icon {
  String? icon;

  Icon(this.icon);

  Icon.fromMap(Map<String, String> data) {
    icon = data['icon'];
  }

  Map<String, String> toMap() {
    return {
      'icon': icon!,
    };
  }
}
