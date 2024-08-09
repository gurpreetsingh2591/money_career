/// data : {"feedItems":[{"heroImage":{"url":"https://media.graphassets.com/87RLHdWTO2UdRvnU0b29","id":"cl3iiannu1t4l0elcaqny2adb"},"title":"House of Commons Reverses Welfare Amendments","postImageContent":"Critics claim the reforms will have a major impact on vulnerable unemployed benefits claimants, such as the sick and disabled. The Labour Party has said it will consult lawyers over the legality of the Government's tactics. ","midContentImage":{"url":"https://media.graphassets.com/aDtHtymkRuuAzvgqRqdT"},"preImageContent":"The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\n## Reversal from Government\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years.The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years.","youTubeUrl":null,"showToCarers":true,"showToClients":true},{"heroImage":{"url":"https://media.graphassets.com/lnDVKh5LTVuHmOn3vwA4","id":"cl3iifaj91sxs0bmi4e741zqa"},"title":"Salford Council delays cuts","postImageContent":"## Services Changing\nChanges to services for children with hearing loss will be considered by a panel of parents and officials. The elderly day centres will remain open for the next year while plans for the buildings that house them are reviewed. ","midContentImage":null,"preImageContent":"Salford Council will delay plans to cut support services for deaf children and close elderly day centres. The council had intended to reduce the number of support teachers for deaf children and shut down three of the city's elderly day centres Humphrey Booth in Ordsall, Craig Hall in Irlam and Brierley House in Little Hulton.","youTubeUrl":"https://www.youtube.com/watchvG2UAK7su5R4","showToCarers":true,"showToClients":true}]}

class NewsListModel {
  NewsListModel({
    Data? data,
  }) {
    _data = data!;
  }

  NewsListModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
  NewsListModel copyWith({
    Data? data,
  }) =>
      NewsListModel(
        data: data ?? _data,
      );
  Data get data => _data!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data!.toJson();
    }
    return map;
  }
}

/// feedItems : [{"heroImage":{"url":"https://media.graphassets.com/87RLHdWTO2UdRvnU0b29","id":"cl3iiannu1t4l0elcaqny2adb"},"title":"House of Commons Reverses Welfare Amendments","postImageContent":"Critics claim the reforms will have a major impact on vulnerable unemployed benefits claimants, such as the sick and disabled. The Labour Party has said it will consult lawyers over the legality of the Government's tactics. ","midContentImage":{"url":"https://media.graphassets.com/aDtHtymkRuuAzvgqRqdT"},"preImageContent":"The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\n## Reversal from Government\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years.The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years.","youTubeUrl":null,"showToCarers":true,"showToClients":true},{"heroImage":{"url":"https://media.graphassets.com/lnDVKh5LTVuHmOn3vwA4","id":"cl3iifaj91sxs0bmi4e741zqa"},"title":"Salford Council delays cuts","postImageContent":"## Services Changing\nChanges to services for children with hearing loss will be considered by a panel of parents and officials. The elderly day centres will remain open for the next year while plans for the buildings that house them are reviewed. ","midContentImage":null,"preImageContent":"Salford Council will delay plans to cut support services for deaf children and close elderly day centres. The council had intended to reduce the number of support teachers for deaf children and shut down three of the city's elderly day centres Humphrey Booth in Ordsall, Craig Hall in Irlam and Brierley House in Little Hulton.","youTubeUrl":"https://www.youtube.com/watchvG2UAK7su5R4","showToCarers":true,"showToClients":true}]

class Data {
  Data({
    List<FeedItems>? feedItems,
  }) {
    _feedItems = feedItems!;
  }

  Data.fromJson(dynamic json) {
    if (json['feedItems'] != null) {
      _feedItems = [];
      json['feedItems'].forEach((v) {
        _feedItems?.add(FeedItems.fromJson(v));
      });
    }
  }
  List<FeedItems>? _feedItems;
  Data copyWith({
    List<FeedItems>? feedItems,
  }) =>
      Data(
        feedItems: feedItems ?? _feedItems,
      );
  List<FeedItems>? get feedItems => _feedItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_feedItems != null) {
      map['feedItems'] = _feedItems!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// heroImage : {"url":"https://media.graphassets.com/87RLHdWTO2UdRvnU0b29","id":"cl3iiannu1t4l0elcaqny2adb"}
/// title : "House of Commons Reverses Welfare Amendments"
/// postImageContent : "Critics claim the reforms will have a major impact on vulnerable unemployed benefits claimants, such as the sick and disabled. The Labour Party has said it will consult lawyers over the legality of the Government's tactics. "
/// midContentImage : {"url":"https://media.graphassets.com/aDtHtymkRuuAzvgqRqdT"}
/// preImageContent : "The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\n## Reversal from Government\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years.The Government has rejected changes made to the controversial Welfare Reform Bill in the House of Lords. The House of Lords made a number of amendments to the Bill, including excluding child benefits from the **£26,000** cap on annual benefits.\n\nHowever, the Government reversed this, and other amendments, and will now use a rule allowing the Commons to decide on bills with large financial implications to prevent any further amendments. The Bill represents the biggest revamp of the benefits system for 60 years."
/// youTubeUrl : null
/// showToCarers : true
/// showToClients : true

class FeedItems {
  FeedItems({
    HeroImage? heroImage,
    String? title,
    String? postImageContent,
    MidContentImage? midContentImage,
    String? preImageContent,
    dynamic youTubeUrl,
    bool? showToCarers,
    bool? showToClients,
  }) {
    _heroImage = heroImage!;
    _title = title!;
    _postImageContent = postImageContent!;
    _midContentImage = midContentImage!;
    _preImageContent = preImageContent!;
    _youTubeUrl = youTubeUrl;
    _showToCarers = showToCarers!;
    _showToClients = showToClients!;
  }

  FeedItems.fromJson(dynamic json) {
    _heroImage = json['heroImage'] != null ? HeroImage.fromJson(json['heroImage']) : null;
    _title = json['title'];
    _postImageContent = json['postImageContent'];
    _midContentImage = json['midContentImage'] != null ? MidContentImage.fromJson(json['midContentImage']) : null;
    _preImageContent = json['preImageContent'];
    _youTubeUrl = json['youTubeUrl'];
    _showToCarers = json['showToCarers'];
    _showToClients = json['showToClients'];
  }
  HeroImage? _heroImage;
  String? _title;
  String? _postImageContent;
  MidContentImage? _midContentImage;
  String? _preImageContent;
  dynamic _youTubeUrl;
  bool? _showToCarers;
  bool? _showToClients;
  FeedItems copyWith({
    HeroImage? heroImage,
    String? title,
    String? postImageContent,
    MidContentImage? midContentImage,
    String? preImageContent,
    dynamic youTubeUrl,
    bool? showToCarers,
    bool? showToClients,
  }) =>
      FeedItems(
        heroImage: heroImage ?? _heroImage,
        title: title ?? _title,
        postImageContent: postImageContent ?? _postImageContent,
        midContentImage: midContentImage ?? _midContentImage,
        preImageContent: preImageContent ?? _preImageContent,
        youTubeUrl: youTubeUrl ?? _youTubeUrl,
        showToCarers: showToCarers ?? _showToCarers,
        showToClients: showToClients ?? _showToClients,
      );
  HeroImage get heroImage => _heroImage!;
  String get title => _title!;
  String get postImageContent => _postImageContent!;
  MidContentImage get midContentImage => _midContentImage!;
  String get preImageContent => _preImageContent!;
  dynamic get youTubeUrl => _youTubeUrl;
  bool get showToCarers => _showToCarers!;
  bool get showToClients => _showToClients!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_heroImage != null) {
      map['heroImage'] = _heroImage!.toJson();
    }
    map['title'] = _title;
    map['postImageContent'] = _postImageContent;
    if (_midContentImage != null) {
      map['midContentImage'] = _midContentImage!.toJson();
    }
    map['preImageContent'] = _preImageContent;
    map['youTubeUrl'] = _youTubeUrl;
    map['showToCarers'] = _showToCarers;
    map['showToClients'] = _showToClients;
    return map;
  }
}

/// url : "https://media.graphassets.com/aDtHtymkRuuAzvgqRqdT"

class MidContentImage {
  MidContentImage({
    String? url,
  }) {
    _url = url;
  }

  MidContentImage.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
  MidContentImage copyWith({
    String? url,
  }) =>
      MidContentImage(
        url: url ?? _url,
      );
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }
}

/// url : "https://media.graphassets.com/87RLHdWTO2UdRvnU0b29"
/// id : "cl3iiannu1t4l0elcaqny2adb"

class HeroImage {
  HeroImage({
    String? url,
    String? id,
  }) {
    _url = url!;
    _id = id!;
  }

  HeroImage.fromJson(dynamic json) {
    _url = json['url'];
    _id = json['id'];
  }
  String? _url;
  String? _id;
  HeroImage copyWith({
    String? url,
    String? id,
  }) =>
      HeroImage(
        url: url ?? _url,
        id: id ?? _id,
      );
  String get url => _url!;
  String get id => _id!;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['id'] = _id;
    return map;
  }
}
