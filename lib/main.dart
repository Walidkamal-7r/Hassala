import 'package:flutter/material.dart';

void main() {
  runApp(const MotivationApp());
}

class MotivationApp extends StatelessWidget {
  const MotivationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ø¬Ù…Ù„ØªÙƒ Ø§Ù„ØªØ­ÙÙŠØ²ÙŠØ©',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C1A18),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8C99B),
          brightness: Brightness.dark,
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: SetupScreen(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ø´Ø§Ø´Ø© Ø¥Ø¯Ø®Ø§Ù„ Ø§Ù„Ø§Ø³Ù… ÙˆØ§Ù„Ø¬Ù…Ù„Ø© Ø§Ù„ØªØ­ÙÙŠØ²ÙŠØ©
// ---------------------------------------------------------------------------
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sentenceController.dispose();
    super.dispose();
  }

  void _start() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ø§ÙƒØªØ¨ Ø§Ø³Ù…Ùƒ Ø§Ù„Ø£ÙˆÙ„')),
      );
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BoardScreen(
          name: name,
          sentence: _sentenceController.text.trim().isEmpty
              ? 'Ø¬Ù…Ù„ØªÙƒ Ø§Ù„ØªØ­ÙÙŠØ²ÙŠØ©'
              : _sentenceController.text.trim(),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      filled: true,
      fillColor: Colors.white10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Ù‚Ø¨Ù„ Ù…Ø§ Ù†Ø¨Ø¯Ø£ ðŸ‘‹',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: _decoration('Ø§ÙƒØªØ¨ Ø§Ø³Ù…Ùƒ'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _sentenceController,
                textAlign: TextAlign.right,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: _decoration('Ø§ÙƒØªØ¨ Ø¬Ù…Ù„ØªÙƒ Ø§Ù„ØªØ­ÙÙŠØ²ÙŠØ©'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8C99B),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _start,
                  child: const Text(
                    'Ø§Ø¨Ø¯Ø£',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ø£Ø±Ù‚Ø§Ù… Ø§Ù„Ù„ÙˆØ­Ø© (Ù†ÙØ³ ØªÙˆØ²ÙŠØ¹ Ø§Ù„ØµÙˆØ±Ø© Ø§Ù„Ø£ØµÙ„ÙŠØ© - Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹ Ø§Ù„ÙƒÙ„ÙŠ = 5000)
// ---------------------------------------------------------------------------
const List<int> kBoardNumbers = [
  5, 20, 10, 20, 5, 5, 200, 5, 10, 20,
  10, 5, 10, 20, 10, 50, 50, 200, 5, 5,
  50, 5, 5, 5, 5, 20, 5, 200, 200, 5,
  10, 5, 5, 50, 5, 5, 200, 5, 20, 5,
  10, 10, 5, 50, 5, 20, 50, 5, 50, 20,
  5, 5, 10, 10, 200, 5, 10, 10, 5, 20,
  100, 5, 10, 5, 50, 200, 10, 5, 5, 200,
  5, 50, 100, 20, 10, 200, 5, 5, 200, 5,
  5, 5, 5, 10, 5, 5, 5, 10, 10, 200,
  5, 20, 50, 5, 20, 200, 20, 10, 10, 20,
  200, 5, 5, 100, 50, 5, 100, 20, 5, 50,
  10, 5, 10, 5, 200, 5, 10, 5, 5, 5,
  20, 5, 5, 5, 10, 100, 5, 200, 10, 50,
];

const int kColumns = 10;
const int kRevealEvery = 7; // ÙƒÙ„ Ù§ Ø´Ø·Ø¨Ø§Øª ÙŠØªÙƒØ´Ù Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹

// ---------------------------------------------------------------------------
// Ø´Ø§Ø´Ø© Ø§Ù„Ù„ÙˆØ­Ø© Ù†ÙØ³Ù‡Ø§
// ---------------------------------------------------------------------------
class BoardScreen extends StatefulWidget {
  final String name;
  final String sentence;

  const BoardScreen({super.key, required this.name, required this.sentence});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late List<bool> _crossed;
  int _tapCount = 0;
  int _crossedSum = 0;
  int _roundsCompleted = 0;

  final int _total = kBoardNumbers.fold(0, (a, b) => a + b);

  @override
  void initState() {
    super.initState();
    _crossed = List.filled(kBoardNumbers.length, false);
  }

  void _onTapNumber(int index) {
    if (_crossed[index]) return; // ÙƒÙ„ Ø±Ù‚Ù… ÙŠØªØ´Ø·Ø¨ Ù…Ø±Ø© ÙˆØ§Ø­Ø¯Ø© Ø¨Ø³

    setState(() {
      _crossed[index] = true;
      _crossedSum += kBoardNumbers[index];
      _tapCount++;
    });

    // ÙƒØ´Ù Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹ ÙƒÙ„ Ù§ Ø´Ø·Ø¨Ø§Øª
    if (_tapCount % kRevealEvery == 0) {
      _showRevealDialog();
      return; // Ù†Ù†ØªØ¸Ø± Ø¥ØºÙ„Ø§Ù‚ Ø§Ù„Ø¯ÙŠØ§Ù„ÙˆØ¬ØŒ ÙˆØ¨Ø¹Ø¯ÙŠÙ† Ù†ØªØ£ÙƒØ¯ Ù„Ùˆ Ø§Ù„Ù„ÙˆØ­Ø© Ø®Ù„ØµØª
    }

    _checkIfBoardComplete();
  }

  void _showRevealDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF2A2622),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'ðŸŽ¯ ÙƒØ´Ù Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Ø´Ø·Ø¨Øª $_tapCount Ø±Ù‚Ù… Ù„Ø­Ø¯ Ø¯Ù„ÙˆÙ‚ØªÙŠ\nØ§Ù„Ù…Ø¬Ù…ÙˆØ¹: $_crossedSum',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE8C99B),
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _checkIfBoardComplete();
            },
            child: const Text('ØªÙ…Ø§Ù…'),
          ),
        ],
      ),
    );
  }

  void _checkIfBoardComplete() {
    final allCrossed = _crossed.every((c) => c);
    if (!allCrossed) return;

    Future.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF2A2622),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'ðŸŽ‰ Ø®Ù„ØµØª ÙƒÙ„ Ø§Ù„Ø£Ø±Ù‚Ø§Ù…!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹ Ø§Ù„ÙƒÙ„ÙŠ: $_total\nÙ‡Ù†Ø¨Ø¯Ø£ Ù„ÙˆØ­Ø© Ø¬Ø¯ÙŠØ¯Ø© ØªØ§Ù†ÙŠ',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE8C99B),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _crossed = List.filled(kBoardNumbers.length, false);
                  _tapCount = 0;
                  _crossedSum = 0;
                  _roundsCompleted++;
                });
              },
              child: const Text('ÙŠÙ„Ø§ Ù†Ø¨Ø¯Ø£ Ù…Ù† Ø¬Ø¯ÙŠØ¯'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final untilReveal = kRevealEvery - (_tapCount % kRevealEvery);
    final showCounterHint = untilReveal == kRevealEvery ? 0 : untilReveal;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF211E1B),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Ø§Ù„Ù‡ÙŠØ¯Ø±: Ù‚ÙÙ„ Ø§Ù„Ù…Ø¬Ù…ÙˆØ¹ Ø¹Ù„Ù‰ Ø§Ù„Ø´Ù…Ø§Ù„ + Ø§Ù„Ø§Ø³Ù… Ø¹Ù„Ù‰ Ø§Ù„ÙŠÙ…ÙŠÙ†
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.lock, color: Colors.white54, size: 18),
                            SizedBox(width: 4),
                            Text(
                              'Ù…Ù‚ÙÙˆÙ„',
                              style: TextStyle(color: Colors.white54, fontSize: 14),
                            ),
                          ],
                        ),
                        if (_tapCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              showCounterHint == 0
                                  ? 'Ù‡ÙŠØªÙƒØ´Ù Ø¯Ù„ÙˆÙ‚ØªÙŠ!'
                                  : 'Ø¨Ø§Ù‚ÙŠ $showCounterHint Ø¹Ù„Ø´Ø§Ù† ÙŠØªÙƒØ´Ù',
                              style: const TextStyle(color: Colors.white38, fontSize: 11),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.sentence,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFE8C99B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('ðŸ’° â­ â¤ï¸', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final cellSize = (constraints.maxWidth - (kColumns - 1) * 6) / kColumns;
                      return SingleChildScrollView(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: List.generate(kBoardNumbers.length, (index) {
                            final crossed = _crossed[index];
                            return GestureDetector(
                              onTap: () => _onTapNumber(index),
                              child: Container(
                                width: cellSize,
                                height: cellSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: crossed
                                      ? Colors.white24
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: crossed ? Colors.white24 : Colors.white70,
                                    width: 1.2,
                                  ),
                                ),
                                child: Text(
                                  '${kBoardNumbers[index]}',
                                  style: TextStyle(
                                    color: crossed ? Colors.white38 : Colors.white,
                                    fontSize: cellSize * 0.34,
                                    fontWeight: FontWeight.bold,
                                    decoration: crossed
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ø´Ø·Ø¨Øª $_tapCount Ù…Ù† ${kBoardNumbers.length} â€¢ Ø¬ÙˆÙ„Ø§Øª ÙƒØ§Ù…Ù„Ø©: $_roundsCompleted',
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
