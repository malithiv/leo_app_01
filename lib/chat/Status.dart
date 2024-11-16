import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final List<Map<String, dynamic>> myStatuses = [];
  final List<Map<String, dynamic>> recentUpdates = [
    {
      "username": "User 1",
      "time": "Today, 12:01 PM",
      "stories": [
        StoryItem.text(
          title: "Hello, this is User 1!",
          backgroundColor: Colors.blueAccent,
        ),
        StoryItem.pageImage(
          url: "https://picsum.photos/seed/user1story1/300",
          caption:  Text(
            "Still sampling",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          controller: StoryController(),
        ),
        StoryItem.pageVideo(
          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4",
          caption:  Text(
            "Still sampling",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          controller: StoryController(),
        ),
      ],
    },
    {
      "username": "User 2",
      "time": "Today, 12:02 PM",
      "stories": [
        StoryItem.pageImage(
          url: "https://picsum.photos/seed/user2story1/300",
          caption:  Text(
            "Still sampling",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          controller: StoryController(),
        ),
      ],
    },
  ];

  void _addStatus() {
    setState(() {
      myStatuses.add(
        {
          "title": "This is my status",
          "stories": [
            StoryItem.text(
              title: "Just added my first status!",
              backgroundColor: Colors.teal,
            ),
            StoryItem.pageImage(
              url: "https://picsum.photos/seed/myNewStatus/300",
              caption:  Text(
                "Still sampling",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              controller: StoryController(),
            ),
          ],
        },
      );
    });
  }

  void _viewStatus(List<StoryItem> stories) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StoryViewPage(stories: stories),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: myStatuses.isNotEmpty
                      ? NetworkImage(
                      "https://picsum.photos/seed/myNewStatus/300")
                      : NetworkImage("https://picsum.photos/seed/myStatus/300"),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: _addStatus,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            title: Text('My Status'),
            subtitle: Text(myStatuses.isNotEmpty
                ? 'Tap to view your status'
                : 'Tap to add status update'),
            onTap: myStatuses.isNotEmpty
                ? () => _viewStatus(myStatuses[0]["stories"])
                : null,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Recent updates',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentUpdates.length,
            itemBuilder: (context, index) {
              final update = recentUpdates[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      update["stories"][0].url ?? "https://picsum.photos/300"),
                ),
                title: Text(update["username"]),
                subtitle: Text(update["time"]),
                onTap: () => _viewStatus(update["stories"]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class StoryViewPage extends StatelessWidget {
  final List<StoryItem> stories;

  const StoryViewPage({required this.stories});

  @override
  Widget build(BuildContext context) {
    final controller = StoryController();

    return Scaffold(
      body: StoryView(
        storyItems: stories,
        controller: controller,
        repeat: false,
        onComplete: () {
          Navigator.pop(context);
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
