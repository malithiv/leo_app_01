//
// import 'package:flutter/material.dart';
// import 'package:zego_zimkit/zego_zimkit.dart';
//
// class ChatScreen1 extends StatefulWidget {
//   final String userId;
//   final String username;
//
//
//   ChatScreen1({required this.userId, required this.username});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen1> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeZegoCloud();
//   }
//
//   Future<void> _initializeZegoCloud() async {
//     try {
//       await ZIMKit().connectUser(
//         id: widget.userId,
//         name: widget.username,
//       );
//     } catch (e) {
//       print('Error connecting to Zego Cloud: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to connect to chat service')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Conversations'),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.chat),
//               onPressed: () => _showNewChatDialog(),
//             ),
//           ],
//         ),
//         body: ZIMKitConversationListView(
//           onPressed: (context, conversation, defaultAction) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ZIMKitMessageListPage(
//                   conversationID: conversation.id,
//                   conversationType: conversation.type,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   void _showNewChatDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Start New Chat'),
//         content: TextField(
//           decoration: InputDecoration(
//             hintText: 'Enter user ID',
//           ),
//           onSubmitted: (value) {
//             Navigator.pop(context);
//             _startChatWithUser(value);
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               String value = (context.findRenderObject() as dynamic)
//                   .child
//                   .child
//                   .child[1]
//                   .child
//                   .controller
//                   .text;
//               Navigator.pop(context);
//               _startChatWithUser(value);
//             },
//             child: Text('Start Chat'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _startChatWithUser(String userId) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ZIMKitMessageListPage(
//           conversationID: userId,
//           conversationType: ZIMConversationType.peer,
//         ),
//       ),
//     );
//   }
// }