import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CallPage.dart';

class ChatScreen1 extends StatefulWidget {
  final String userId = "0034";
  final String username = "venura";



  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen1> {
  @override
  void initState() {
    super.initState();
    //_initializeZegoCloud();
  }

  Future<void> _initializeZegoCloud() async {
    try {
      final userId = widget.userId ?? '001'; // Fallback to a default value
      final userName = widget.username ?? 'Default Name';

      if (userId.isEmpty || userName.isEmpty) {
        throw Exception('User ID or User Name is missing!');
      }

      await ZIMKit().connectUser(
        id: userId,
        name: userName,
      );
    } catch (e) {
      print('Error connecting to Zego Cloud: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect to chat service: $e')),
      );
    }
  }


  Future<void> _fetchAndSetUserAvatar() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId') ?? '';
      if (userId.isEmpty) return;

      final response = await http.get(
        Uri.parse('http://145.223.21.62:8090/api/collections/users/records/$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final avatarUrl = data['avatar'] != null
            ? 'http://145.223.21.62:8090/api/files/${data['collectionId']}/${data['id']}/${data['avatar']}'
            : null;

        if (avatarUrl != null) {
          await ZIMKit().updateUserInfo(avatarUrl: avatarUrl, name: widget.username);
        }
      }
    } catch (e) {
      print('Error fetching user avatar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          actions: [
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () => _showNewChatDialog(),
            ),
          ],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(
                  conversationId: conversation.id,
                  conversationType: conversation.type,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showNewChatDialog() {
    final TextEditingController userIdController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Start New Chat'),
        content: TextField(
          controller: userIdController,
          decoration: InputDecoration(
            hintText: 'Enter user ID',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (userIdController.text.trim().isNotEmpty) {
                _startChatWithUser(userIdController.text.trim());
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter a valid user ID')),
                );
              }
            },
            child: Text('Start Chat'),
          ),
        ],
      ),
    );
  }

  void _startChatWithUser(String userId) async {
    try {
      // Validate user ID before proceeding
      await ZIMKit().connectUser(id: userId, name: 'New User');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessageScreen(
            conversationId: userId,
            conversationType: ZIMConversationType.peer,
          ),
        ),
      );
    } catch (e) {
      print('Error starting chat with user $userId: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to start chat: $e')),
      );
    }
  }

}
class MessageScreen extends StatelessWidget {
  final String conversationId;
  final ZIMConversationType conversationType;

  const MessageScreen({
    required this.conversationId,
    required this.conversationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          // Video Call Button
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(
                    callID: conversationId,
                    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
                  ),
                ),
              );
            },
          ),
          // Voice Call Button
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallPage(
                    callID: conversationId,
                    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ZIMKitMessageListPage(
        conversationID: conversationId,
        conversationType: conversationType,
      ),
    );
  }
}

