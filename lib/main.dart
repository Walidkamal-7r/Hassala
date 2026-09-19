import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MotivationApp());
}

// ---------------------------------------------------------------------------
// كل النصوص العربية هنا متكتوبة بصيغة \u{...} عمدًا (يونيكود إسكيب)
// عشان تفضل شغالة صح مهما كان الترميز بتاع أي محرر بتلزقها فيه.
// ---------------------------------------------------------------------------
class AR {
  static const setupTitle = '\u{642}\u{628}\u{644} \u{645}\u{627} \u{646}\u{628}\u{62f}\u{623} \u{1f44b}';
  static const nameHint = '\u{627}\u{643}\u{62a}\u{628} \u{627}\u{633}\u{645}\u{643}';
  static const reasonHint =
      '\u{627}\u{643}\u{62a}\u{628} \u{633}\u{628}\u{628} \u{627}\u{644}\u{62a}\u{62d}\u{648}\u{64a}\u{634} (\u{645}\u{62b}\u{627}\u{644}: \u{639}\u{631}\u{628}\u{64a}\u{629}\u{60c} \u{633}\u{641}\u{631}\u{60c} \u{62c}\u{648}\u{627}\u{632})';
  static const startBtn = '\u{627}\u{628}\u{62f}\u{623}';
  static const nameEmptySnack = '\u{645}\u{646} \u{641}\u{636}\u{644}\u{643} \u{627}\u{643}\u{62a}\u{628} \u{627}\u{633}\u{645}\u{643}';
  static const reasonEmptySnack =
      '\u{645}\u{646} \u{641}\u{636}\u{644}\u{643} \u{627}\u{643}\u{62a}\u{628} \u{633}\u{628}\u{628} \u{627}\u{644}\u{62a}\u{62d}\u{648}\u{64a}\u{634}';
  static const lockedLabel = '\u{645}\u{642}\u{641}\u{648}\u{644}';
  static const revealNow = '\u{647}\u{64a}\u{62a}\u{643}\u{634}\u{641} \u{62f}\u{644}\u{648}\u{642}\u{62a}\u{64a}!';
  static const revealHintPrefix = '\u{628}\u{627}\u{642}\u{64a}';
  static const revealHintSuffix = '\u{639}\u{644}\u{634}\u{627}\u{646} \u{64a}\u{62a}\u{643}\u{634}\u{641}';
  static const reasonPrefix = '\u{628}\u{62a}\u{62d}\u{648}\u{634} \u{639}\u{644}\u{634}\u{627}\u{646}:';
  static const moneyIcons = '\u{1f4b0} \u{2b50} \u{2764}\u{fe0f}';
  static const dialogRevealTitle = '\u{1f3af} \u{643}\u{634}\u{641} \u{627}\u{644}\u{645}\u{62c}\u{645}\u{648}\u{639}';
  static const dialogRevealLine1 = '\u{634}\u{637}\u{628}\u{62a}';
  static const dialogRevealLine1b = '\u{631}\u{642}\u{645} \u{644}\u{62d}\u{62f} \u{62f}\u{644}\u{648}\u{642}\u{62a}\u{64a}';
  static const dialogRevealLine2 = '\u{627}\u{644}\u{645}\u{62c}\u{645}\u{648}\u{639}:';
  static const okBtn = '\u{62a}\u{645}\u{627}\u{645}';
  static const dialogDoneTitle = '\u{1f389} \u{62e}\u{644}\u{635}\u{62a} \u{643}\u{644} \u{627}\u{644}\u{623}\u{631}\u{642}\u{627}\u{645}!';
  static const dialogDoneLine1 = '\u{627}\u{644}\u{645}\u{62c}\u{645}\u{648}\u{639} \u{627}\u{644}\u{643}\u{644}\u{64a}:';
  static const dialogDoneLine2 = '\u{647}\u{646}\u{628}\u{62f}\u{623} \u{644}\u{648}\u{62d}\u{629} \u{62c}\u{62f}\u{64a}\u{62f}\u{629} \u{62a}\u{627}\u{646}\u{64a}';
  static const restartBtn = '\u{64a}\u{644}\u{627} \u{646}\u{628}\u{62f}\u{623} \u{645}\u{646} \u{62c}\u{62f}\u{64a}\u{62f}';
  static const footerA = '\u{634}\u{637}\u{628}\u{62a}';
  static const footerB = '\u{645}\u{646}';
  static const footerC = '\u{2022} \u{62c}\u{648}\u{644}\u{627}\u{62a} \u{643}\u{627}\u{645}\u{644}\u{629}:';
  static const loadingText = '\u{644}\u{62d}\u{638}\u{629} \u{628}\u{633}...';
}

// ---------------------------------------------------------------------------
// مفاتيح التخزين الدائم (SharedPreferences) - بيفضل محفوظ حتى لو قفلت التطبيق
// ---------------------------------------------------------------------------
class StoreKeys {
  static const name = 'user_name';
  static const reason = 'saving_reason';
  static const crossed = 'board_crossed';
  static const tapCount = 'board_tap_count';
  static const crossedSum = 'board_crossed_sum';
  static const rounds = 'board_rounds_completed';
}

class MotivationApp extends StatelessWidget {
  const MotivationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motivation Board',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C1A18),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8C99B),
          brightness: Brightness.dark,
        ),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: AppRoot(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// نقطة الدخول: بتقرر تفتح شاشة الإعداد ولا شاشة اللوحة على طول
// حسب لو فيه اسم وسبب محفوظين قبل كده
// ---------------------------------------------------------------------------
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  bool _loading = true;
  String? _name;
  String? _reason;

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString(StoreKeys.name);
      _reason = prefs.getString(StoreKeys.reason);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: Text(
            AR.loadingText,
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
      );
    }

    final hasProfile =
        _name != null && _name!.trim().isNotEmpty && _reason != null && _reason!.trim().isNotEmpty;

    if (!hasProfile) {
      return const SetupScreen();
    }

    return BoardScreen(name: _name!, reason: _reason!);
  }
}

// ---------------------------------------------------------------------------
// شاشة إدخال الاسم وسبب التحويش - بتظهر مرة واحدة بس أول ما تفتح التطبيق
// ---------------------------------------------------------------------------
class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _nameController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    final name = _nameController.text.trim();
    final reason = _reasonController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AR.nameEmptySnack)),
      );
      return;
    }
    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AR.reasonEmptySnack)),
      );
      return;
    }

    setState(() => _saving = true);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(StoreKeys.name, name);
    await prefs.setString(StoreKeys.reason, reason);

    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BoardScreen(name: name, reason: reason),
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
                AR.setupTitle,
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
                decoration: _decoration(AR.nameHint),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _reasonController,
                textAlign: TextAlign.right,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: _decoration(AR.reasonHint),
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
                  onPressed: _saving ? null : _start,
                  child: _saving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                      : const Text(
                          AR.startBtn,
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
// أرقام اللوحة (نفس توزيع الصورة الأصلية - المجموع الكلي = 5000)
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
const int kRevealEvery = 7; // كل ٧ شطبات يتكشف المجموع

// ---------------------------------------------------------------------------
// شاشة اللوحة نفسها - بتحمّل وتحفظ حالتها بالكامل في التخزين الدائم
// ---------------------------------------------------------------------------
class BoardScreen extends StatefulWidget {
  final String name;
  final String reason;

  const BoardScreen({super.key, required this.name, required this.reason});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  List<bool> _crossed = List.filled(kBoardNumbers.length, false);
  int _tapCount = 0;
  int _crossedSum = 0;
  int _roundsCompleted = 0;
  bool _ready = false;

  final int _total = kBoardNumbers.fold(0, (a, b) => a + b);

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCrossed = prefs.getString(StoreKeys.crossed);

    setState(() {
      if (savedCrossed != null && savedCrossed.length == kBoardNumbers.length) {
        _crossed = savedCrossed.split('').map((c) => c == '1').toList();
      }
      _tapCount = prefs.getInt(StoreKeys.tapCount) ?? 0;
      _crossedSum = prefs.getInt(StoreKeys.crossedSum) ?? 0;
      _roundsCompleted = prefs.getInt(StoreKeys.rounds) ?? 0;
      _ready = true;
    });
  }

  Future<void> _persistState() async {
    final prefs = await SharedPreferences.getInstance();
    final crossedString = _crossed.map((c) => c ? '1' : '0').join();
    await prefs.setString(StoreKeys.crossed, crossedString);
    await prefs.setInt(StoreKeys.tapCount, _tapCount);
    await prefs.setInt(StoreKeys.crossedSum, _crossedSum);
    await prefs.setInt(StoreKeys.rounds, _roundsCompleted);
  }

  void _onTapNumber(int index) {
    if (_crossed[index]) return; // كل رقم يتشطب مرة واحدة بس

    setState(() {
      _crossed[index] = true;
      _crossedSum += kBoardNumbers[index];
      _tapCount++;
    });
    _persistState();

    if (_tapCount % kRevealEvery == 0) {
      _showRevealDialog();
      return;
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
          AR.dialogRevealTitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '${AR.dialogRevealLine1} $_tapCount ${AR.dialogRevealLine1b}\n${AR.dialogRevealLine2} $_crossedSum',
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
            child: const Text(AR.okBtn),
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
            AR.dialogDoneTitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            '${AR.dialogDoneLine1} $_total\n${AR.dialogDoneLine2}',
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
              onPressed: () async {
                Navigator.of(context).pop();
                setState(() {
                  _crossed = List.filled(kBoardNumbers.length, false);
                  _tapCount = 0;
                  _crossedSum = 0;
                  _roundsCompleted++;
                });
                await _persistState();
              },
              child: const Text(AR.restartBtn),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(
        body: Center(
          child: Text(
            AR.loadingText,
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
        ),
      );
    }

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
                              AR.lockedLabel,
                              style: TextStyle(color: Colors.white54, fontSize: 14),
                            ),
                          ],
                        ),
                        if (_tapCount > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              showCounterHint == 0
                                  ? AR.revealNow
                                  : '${AR.revealHintPrefix} $showCounterHint ${AR.revealHintSuffix}',
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
                  '${AR.reasonPrefix} ${widget.reason}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFFE8C99B),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(AR.moneyIcons, style: TextStyle(fontSize: 16)),
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
                                  color: crossed ? Colors.white24 : Colors.transparent,
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
                                    decoration: crossed ? TextDecoration.lineThrough : TextDecoration.none,
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
                  '${AR.footerA} $_tapCount ${AR.footerB} ${kBoardNumbers.length} ${AR.footerC} $_roundsCompleted',
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
