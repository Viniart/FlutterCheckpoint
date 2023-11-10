class Subscription {
  final String name;
  final String description;
  final String htmlUrl;

  Subscription(this.name, this.description, this.htmlUrl);

  Map<String, dynamic> toJson() =>
      {'name': name, 'html_url': htmlUrl};

  Subscription.fromJson(Map json)
      : name = json['name'],
        description = json['description'] ?? '',
        htmlUrl = json['html_url'];
}
