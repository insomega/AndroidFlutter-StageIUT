class GbsystemTopicModel {
  final String TOPICS;

  const GbsystemTopicModel({
    required this.TOPICS,
  });

  static GbsystemTopicModel fromJson(json) {
    return GbsystemTopicModel(
      TOPICS: json["TOPICS"],
    );
  }

  static List<GbsystemTopicModel> convertDynamictoList(
      List<dynamic> topicsDynamic) {
    List<GbsystemTopicModel> listTopics = [];
    for (var i = 0; i < topicsDynamic.length; i++) {
      listTopics.add(GbsystemTopicModel.fromJson(topicsDynamic[i]));
    }
    return listTopics;
  }
}
