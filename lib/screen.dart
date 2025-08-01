import 'dart:async';

import 'package:flutter/material.dart';

abstract class ChatEvent {}

class AddChatEvent extends ChatEvent {
  final ChatItem item;

  AddChatEvent({
    required this.item,
  });
}

class ChatBloc {
  final List<ChatItem> _items = [];

  final StreamController<ChatEvent> _eventController =
      StreamController<ChatEvent>();

  Sink<ChatEvent> get eventSink => _eventController.sink;

  final StreamController<List<ChatItem>> _stateController =
      StreamController<List<ChatItem>>();

  Stream<List<ChatItem>> get stateStream => _stateController.stream;

  ChatBloc() {
    _eventController.stream.listen((event) {
      if (event is AddChatEvent) {
        _items.add(event.item);
      }

      _stateController.sink.add(_items);
    });
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc bloc = ChatBloc();

  final Stream<int> stream =
      Stream<int>.periodic(const Duration(seconds: 5), (count) => count)
          .take(5);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startAutoMessage();
    });
    super.initState();
  }

  void startAutoMessage() {
    stream.listen((count) {
      final ChatItem item = ChatItem(
        message: 'Auto message $count',
        isMe: false,
      );
      
      final AddChatEvent event = AddChatEvent(item: item);
      bloc.eventSink.add(event);
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BLoC Pattern'),
      ),
      body: StreamBuilder<List<ChatItem>>(
        stream: bloc.stateStream,
        builder: (context, snapshot) {
          final List<ChatItem> items = snapshot.data ?? [];
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final ChatItem item = items.reversed.toList()[index];
              if (item.isMe) {
                return ChatTile.right(
                  message: item.message,
                );
              } else {
                return ChatTile.left(
                  message: item.message,
                );
              }
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: items.length,
          );
        },
      ),
      bottomNavigationBar: ChatBottomNavigationBar(
        onSend: (message) async {
          final ChatItem item = ChatItem(
            message: message,
          );

          final AddChatEvent event = AddChatEvent(
            item: item,
          );
          bloc.eventSink.add(event);
        },
      ),
    );
  }
}

class ChatItem {
  final String message;
  final bool isMe;

  ChatItem({
    required this.message,
    this.isMe = true,
  });
}

class ChatTile extends StatelessWidget {
  final ChatItem item;

  const ChatTile({
    super.key,
    required this.item,
  });

  factory ChatTile.left({
    required String message,
  }) {
    return ChatTile(
      item: ChatItem(
        message: message,
        isMe: false,
      ),
    );
  }

  factory ChatTile.right({
    required String message,
  }) {
    return ChatTile(
      item: ChatItem(
        message: message,
        isMe: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          item.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (item.isMe) ...[
          const SizedBox(
            width: 80,
          ),
        ],
        Flexible(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: item.isMe ? Colors.blue : Colors.grey,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 8.0,
              ),
              child: Text(
                item.message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
        if (!item.isMe) ...[
          const SizedBox(
            width: 80,
          ),
        ],
      ],
    );
  }
}

class ChatBottomNavigationBar extends StatefulWidget {
  final Function(String) onSend;

  const ChatBottomNavigationBar({
    super.key,
    required this.onSend,
  });

  @override
  State<ChatBottomNavigationBar> createState() =>
      _ChatBottomNavigationBarState();
}

class _ChatBottomNavigationBarState extends State<ChatBottomNavigationBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.black.withValues(alpha: 0.1),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewPaddingOf(context).bottom,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 8.0,
                      ),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    final String message = controller.text;
                    widget.onSend.call(message);
                    controller.clear();
                  },
                  child: const Text('전송'),
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
