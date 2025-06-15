import 'package:flutter/material.dart';
import 'package:horoscope/styles/app_colors.dart';
import 'package:horoscope/widgets/text_inputs.dart';
import 'package:horoscope/models/message.dart';
import 'package:uuid/uuid.dart';

class MessagesScreen extends StatefulWidget {
  final String userName;
  final String currentUserId;
  final String receiverId;

  const MessagesScreen({
    required this.userName,
    required this.currentUserId,
    required this.receiverId,
    super.key,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    // Burada gerçek mesajları yükleyebilirsiniz
    _loadMessages();
  }

  void _loadMessages() {
    // Örnek mesajlar
    setState(() {
      _messages.addAll([
        Message(
          id: _uuid.v4(),
          senderId: widget.currentUserId,
          receiverId: widget.receiverId,
          content: 'Merhaba!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Message(
          id: _uuid.v4(),
          senderId: widget.receiverId,
          receiverId: widget.currentUserId,
          content: 'Merhaba, nasılsın?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
        ),
      ]);
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: _uuid.v4(),
      senderId: widget.currentUserId,
      receiverId: widget.receiverId,
      content: _messageController.text.trim(),
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Mesajı kaydettikten sonra en alta kaydır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondaryColor,
              child: Text(
                widget.userName[0].toUpperCase(),
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Text(
                  'Çevrimiçi',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.onlineIndicator,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: AppColors.cardColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return message.senderId == widget.currentUserId
                    ? _buildSentMessage(message.content)
                    : _buildRecieveMessage(message.content);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: _buildMessageInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.chatInputBg,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Mesajınızı yazın...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt, color: AppColors.textSecondary),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: AppColors.textPrimary,
                size: 20,
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildRecieveMessage(String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.secondaryColor,
          child: const Text(
            'A',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.receivedMessageBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              message,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSentMessage(String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.sentMessageBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              message,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.secondaryColor.withOpacity(0.2),
          child: const Icon(
            Icons.person,
            size: 16,
            color: AppColors.secondaryColor,
          ),
        ),
      ],
    ),
  );
}
