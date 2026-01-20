import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicManager {
  // Get the list of subscribed topics
  Future<List<String>> getSubscribedTopics() async {
    final prefs = await SharedPreferences.getInstance();
    print(
        "topics : ${prefs.getStringList(GbsSystemServerStrings.topicsKey) ?? []}");
    return prefs.getStringList(GbsSystemServerStrings.topicsKey) ?? [];
  }

  // Add a topic to the subscribed list
  Future<void> subscribeToTopic(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> topics = await getSubscribedTopics();
    if (!topics.contains(topic)) {
      topics.add(topic);
      prefs.setStringList(GbsSystemServerStrings.topicsKey, topics);
      FirebaseMessaging.instance.subscribeToTopic(topic);
    }
  }

  // Remove a topic from the subscribed list
  Future<void> unsubscribeFromTopic(String topic) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> topics = await getSubscribedTopics();
    if (topics.contains(topic)) {
      topics.remove(topic);
      prefs.setStringList(GbsSystemServerStrings.topicsKey, topics);
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    }
  }

  Future<void> unsubscribeFromAllTopics() async {
    List<String> topics = await getSubscribedTopics();
    for (var i = 0; i < topics.length; i++) {
      unsubscribeFromTopic(topics[i]);
    }
  }
}
