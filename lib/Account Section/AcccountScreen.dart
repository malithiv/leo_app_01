import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leo_app_01/Account%20Section/wallet.dart';
import 'package:leo_app_01/Account%20Section/InviteFriends.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('My Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[400]!, Colors.blue[800]!],
                  ),
                ),

              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildProfileCard(context),
              _buildFeatureCard(context, 'Wallet', FontAwesomeIcons.wallet, () => _navigateToWallet(context)),
              _buildFeatureCard(context, 'Level', FontAwesomeIcons.chartLine, () => _navigateToLevel(context)),
              _buildFeatureCard(context, 'Nobel', FontAwesomeIcons.crown, () => _navigateToNobel(context)),
              _buildFeatureCard(context, 'SVIP', FontAwesomeIcons.gem, () => _navigateToSVIP(context)),
              _buildFeatureCard(context, 'Achievements', FontAwesomeIcons.trophy, () => _navigateToAchievements(context)),
              _buildFeatureCard(context, 'Invite Friends', FontAwesomeIcons.userPlus, () => _navigateToInviteFriends(context)),
              _buildLogoutButton(context),
              SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://picsum.photos/seed/user/200'),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@johndoe',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToEditProfile(context),
              child: Text('Edit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, VoidCallback onPressed) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: FaIcon(icon, color: Colors.blue[700], size: 20),
        ),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _handleLogout(context),
        child: Text('Logout'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  void _navigateToEditProfile(BuildContext context) {
    // Navigate to Edit Profile screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen('Edit Profile')));
  }

  void _navigateToWallet(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletScreen()),
    );
  }

  void _navigateToLevel(BuildContext context) {
    // Navigate to Level screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen('Level')));
  }

  void _navigateToNobel(BuildContext context) {
    // Navigate to Nobel screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen('Nobel')));
  }

  void _navigateToSVIP(BuildContext context) {
    // Navigate to SVIP screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen('SVIP')));
  }

  void _navigateToAchievements(BuildContext context) {
    // Navigate to Achievements screen
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlaceholderScreen('Achievements')));
  }

  void _navigateToInviteFriends(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => InviteFriendsPage()),
    // );
  }

  void _handleLogout(BuildContext context) {
    // Handle logout logic here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                // Perform logout action
                Navigator.of(context).pop();
                // Navigate to login screen or clear user session
              },
            ),
          ],
        );
      },
    );
  }
}

// Placeholder screen for navigation
class PlaceholderScreen extends StatelessWidget {
  final String title;

  PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the $title screen'),
      ),
    );
  }
}