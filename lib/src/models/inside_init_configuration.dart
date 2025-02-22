class InsideInitConfiguration {
  String domainURL = "";
  String accountKey = "";
  String mobileSiteURL = "";
  String appName = "";
  String? subsiteId;

  InsideInitConfiguration({
    required this.domainURL,
    required this.accountKey,
    required this.mobileSiteURL,
    required this.appName,
    this.subsiteId = "",
  });

  InsideInitConfiguration.fromJson(Map<String, dynamic> json) {
    domainURL = json['domainURL'];
    accountKey = json['accountKey'];
    mobileSiteURL = json['mobileSiteURL'];
    appName = json['appName'];
    subsiteId = json['subsiteId'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domainURL'] = domainURL;
    data['accountKey'] = accountKey;
    data['mobileSiteURL'] = mobileSiteURL;
    data['appName'] = appName;
    data['subsiteId'] = subsiteId;
    return data;
  }

  void verifyConfiguration() {
    if (domainURL == "") {
      throw ("domainURL could not be blank");
    }
    if (accountKey == "") {
      throw ("accountKey could not be blank");
    }
    if (mobileSiteURL == "") {
      throw ("mobileSiteURL could not be blank");
    }
    if (appName == "") {
      throw ("appName could not be blank");
    }
  }
}
