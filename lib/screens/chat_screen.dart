import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horoscope/screens/messages.dart';
import 'package:horoscope/styles/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scroll = ScrollController();
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  // Mock data for chats
  final List<Map<String, dynamic>> _mockChats = [
    {
      'id': 'chat1',
      'participants': ['user1', 'user2'],
      'lastMessage': 'Ben de iyiyim, teşekkürler!',
      'lastMessageTime': DateTime.now().subtract(
        const Duration(hours: 1, minutes: 50),
      ),
      'unreadCount': 2,
      'user': {
        'id': 'user2',
        'name': 'Recep',
        'photoUrl': 'https://picsum.photos/seed/recep/200',
        'email': 'recep@example.com',
      },
    },
    {
      'id': 'chat2',
      'participants': ['user1', 'user3'],
      'lastMessage': 'Tabii, nerede buluşalım?',
      'lastMessageTime': DateTime.now().subtract(
        const Duration(hours: 2, minutes: 55),
      ),
      'unreadCount': 0,
      'user': {
        'id': 'user3',
        'name': 'Özgür',
        'photoUrl': 'https://picsum.photos/seed/ozgur/200',
        'email': 'ozgur@example.com',
      },
    },
  ];

  // Mock data for stories
  final List<Map<String, String>> _stories = [
    {'name': 'Recep', 'avatar': 'https://picsum.photos/seed/begum/200'},
    {'name': 'Hakan', 'avatar': 'https://picsum.photos/seed/minel/200'},
    {'name': 'Eren', 'avatar': 'https://picsum.photos/seed/ahsen/200'},
    {'name': 'Dilan', 'avatar': 'https://picsum.photos/seed/recep/200'},
    {'name': 'Özgür', 'avatar': 'https://picsum.photos/seed/ozgur/200'},
    {'name': 'Mami', 'avatar': 'https://picsum.photos/seed/zeynep/200'},
  ];

  @override
  void dispose() {
    _textController.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String receiverId, String message) async {
    if (message.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen bir mesaj girin.'),
          backgroundColor: Color.fromARGB(255, 107, 7, 0),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Mock message sending
      await Future.delayed(const Duration(milliseconds: 500));

      // Update the chat in mock data
      final chatIndex = _mockChats.indexWhere(
        (chat) => chat['participants'].contains(receiverId),
      );

      if (chatIndex != -1) {
        setState(() {
          _mockChats[chatIndex]['lastMessage'] = message;
          _mockChats[chatIndex]['lastMessageTime'] = DateTime.now();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF49246E), Color(0xFF121016)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Text(
            'Sohbetler',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 110),
        child: Column(
          children: [
            // Stories/Carousel
            SizedBox(
              height: 104,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _stories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) {
                  final story = _stories[i];
                  return Column(
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.4),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7B4EF1), Color(0xFFD65EFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            story['avatar']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        story['name']!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Search Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Ara',
                  fillColor: AppColors.cardColor.withOpacity(.3),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Chat List
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: _mockChats.length,
                itemBuilder: (context, i) {
                  final chat = _mockChats[i];
                  final userData = chat['user'] as Map<String, dynamic>;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {},
                            icon: Icons.archive,
                            label: 'Arşivle',
                            backgroundColor: AppColors.secondaryColor,
                          ),
                          SlidableAction(
                            onPressed: (_) {},
                            icon: Icons.delete,
                            label: 'Sil',
                            backgroundColor: AppColors.accentColor,
                          ),
                        ],
                      ),
                      child: Card(
                        color: AppColors.cardColor.withOpacity(.6),
                        elevation: 0,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MessagesScreen(
                                      userName: userData['name'] ?? 'Kullanıcı',
                                      currentUserId:
                                          'user1', // Mock current user ID
                                      receiverId: userData['id'],
                                    ),
                              ),
                            );
                          },
                          leading: Hero(
                            tag: userData['name'] ?? 'user',
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                userData['photoUrl'] ??
                                    'https://picsum.photos/200',
                              ),
                            ),
                          ),
                          title: Text(
                            userData['name'] ?? 'Kullanıcı',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            chat['lastMessage'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _formatTime(
                                  chat['lastMessageTime'] as DateTime,
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 4),
                              if (chat['unreadCount'] != null &&
                                  chat['unreadCount'] > 0)
                                badges.Badge(
                                  badgeContent: Text(
                                    chat['unreadCount'].toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  child: const Icon(Icons.circle, size: 8),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays == 0) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Dün';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} gün önce';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
