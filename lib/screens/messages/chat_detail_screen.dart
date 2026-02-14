import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'video_call_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const ChatDetailScreen({
    super.key,
    required this.doctorName,
    required this.doctorImage,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    // Initial messages
    _messages.addAll([
      ChatMessage(
        text: 'Hi ${widget.doctorName}, good morning',
        isSentByMe: true,
        time: '10:20',
      ),
      ChatMessage(
        text: 'Hello, good morning\nHow can I help you what?',
        isSentByMe: false,
        time: '10:21',
      ),
      ChatMessage(
        text: 'I have much pain in the teeth.\nplease suggest me',
        isSentByMe: true,
        time: '10:22',
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.doctorImage,
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.doctorName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallScreen(
                    doctorName: widget.doctorName,
                    doctorImage: widget.doctorImage,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildChatBubble(_messages[index]);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            message.isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSentByMe)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  widget.doctorImage,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: message.isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: message.isSentByMe
                        ? AppColors.secondary
                        : AppColors.lightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(message.isSentByMe ? 16 : 4),
                      bottomRight: Radius.circular(message.isSentByMe ? 4 : 16),
                    ),
                  ),
                  child: message.imageUrl != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            message.imageUrl!,
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 200,
                                height: 150,
                                color: AppColors.lightGrey,
                                child: const Center(
                                  child: Text('🦷', style: TextStyle(fontSize: 80)),
                                ),
                              );
                            },
                          ),
                        )
                      : Text(
                          message.text,
                          style: TextStyle(
                            color: message.isSentByMe
                                ? Colors.white
                                : AppColors.black,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                ),
                if (message.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                    child: Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.grey.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type Something...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            _buildActionButton(Icons.attach_file, AppColors.secondary),
            const SizedBox(width: 8),
            _buildActionButton(Icons.camera_alt, AppColors.secondary),
            const SizedBox(width: 8),
            _buildActionButton(Icons.send, AppColors.secondary, onTap: _sendMessage),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isSentByMe: true,
          time: TimeOfDay.now().format(context),
        ),
      );
      _messageController.clear();
    });

    // Simulate doctor response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: 'I understand. Let me check your symptoms and suggest appropriate treatment.',
              isSentByMe: false,
              time: TimeOfDay.now().format(context),
            ),
          );
        });
      }
    });
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.imageUrl,
  });
}
