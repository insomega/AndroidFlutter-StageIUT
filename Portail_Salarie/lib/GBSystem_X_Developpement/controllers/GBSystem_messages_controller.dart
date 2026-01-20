import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_message_model.dart';

class GBSystemMessagesController extends GetxController {
  Rx<List<MessageModel>?>? _allMessages = Rx<List<MessageModel>?>([]);
  Rx<List<MessageModel>?>? _messagesMe = Rx<List<MessageModel>?>([]);
  Rx<List<MessageModel>?>? _messagesAdverse = Rx<List<MessageModel>?>([]);

  set setMessage(MessageModel Message) {
    _allMessages?.value?.add(Message);
    update();
  }

  set setMessageToLeft(MessageModel Message) {
    _allMessages?.value?.insert(0, Message);
    update();
  }

  set setMessageToRight(MessageModel Message) {
    _allMessages?.value?.insert(_allMessages!.value!.length, Message);
    update();
  }

  set setAllMessage(List<MessageModel>? Messages) {
    _allMessages?.value = Messages;
    update();
  }

  void deleteMessage(MessageModel? message) {
    if (message != null) {
      _allMessages?.value?.remove(message);
    }
  }

  void inverseListMessages() {
    Rx<List<MessageModel>?>? _allMessagesHelper = Rx<List<MessageModel>?>([]);
    for (var i = 0; i < (_allMessages?.value?.length ?? 0); i++) {
      _allMessagesHelper.value?[(_allMessages?.value?.length ?? 0) - i] =
          _allMessages!.value![i];
    }
    _allMessages = _allMessagesHelper;
    update();
  }

  set setListMessagesToLeft(List<MessageModel>? Messages) {
    _allMessages?.value?.insertAll(0, Messages ?? []);

    update();
  }

  bool checkMessageAlreadyExist({required MessageModel message}) {
    bool check = false;
    for (var i = 0; i < (_allMessages?.value?.length ?? 0); i++) {
      if (_allMessages?.value![i].EVT_IDF == message.EVT_IDF) {
        check = true;
      }
    }
    return check;
  }

  List<MessageModel>? getListFiltred({required List<MessageModel>? messages}) {
    List<MessageModel>? filtredMessages = [];
    for (var i = 0; i < (messages?.length ?? 0); i++) {
      if (!checkMessageAlreadyExist(message: messages![i])) {
        filtredMessages.add(messages[i]);
      }
    }
    return filtredMessages;
  }

  Rx<List<MessageModel>?>? get getAllMessages => _allMessages;
  Rx<List<MessageModel>?>? get getAllMessagesMe => _messagesMe;
  Rx<List<MessageModel>?>? get getAllMessagesAdverse => _messagesAdverse;
}
