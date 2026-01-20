import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_message_model.dart';

class GBSystemListMessagesWithCountModel {
  final List<MessageModel>? listMessages;
  final int? count;

  GBSystemListMessagesWithCountModel({
    required this.listMessages,
    required this.count,
  });
}
