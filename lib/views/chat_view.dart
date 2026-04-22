import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/custom_chat_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  static const String id = "ChatView";

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    void sendMessage() {
      if (controller.text.trim().isEmpty) return; // Prevent empty messages

      messages.add(
        {
          KMessagesCollection: controller.text,
          KDate: DateTime.now(),
          "id": email
        },
      );
      controller.clear();
      scrollController.animateTo(
        0,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KDate, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: KPrimaryColor,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    child: Image.asset(
                      KLogo,
                    ),
                  ),
                  Text("Chat")
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleForFriend(
                              message: messagesList[index],
                            );
                    },
                    controller: scrollController,
                  ),
                ),
                customChatField(
                  onSubmitted: (value) => sendMessage(),
                  controller: controller,
                  onPressed: sendMessage,
                )
              ],
            ),
          );
        } else {
          return Text("Loading");
        }
      },
    );
  }
}
