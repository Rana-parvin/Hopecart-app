import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  late stt.SpeechToText _speech;
  //boolean that indicates whether the speech to text engine was
  //successfully initailized and is usable on the device
  bool _SpeechEngineAvailable = false;
  bool _isListening = false;
  String _transcript = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _SpeechEngineAvailable = await _speech.initialize(
      onStatus: _onStatus,
      onError: _onError,
    );
    setState(() {});
  }

  void _onStatus(String status) {
    // status values: "listening", "notListening", "done" etc.
    final listening = status == 'listening';
    if (!mounted) return;
    setState(() {
      _isListening = listening;
    });
  }

  void _onError(stt.SpeechRecognitionError error) {
    // handle or log error as required
    if (!mounted) return;
    setState(() {
      _isListening = false;
    });
  }

  void _startListening() {
    if (!_SpeechEngineAvailable) return;
    _speech.listen(
      onResult: (result) {
        if (!mounted) return;
        setState(() {
          _transcript = result.recognizedWords;
        });
      },
      // listenMode: stt.ListenMode.confirmation,
      // cancelOnError: true,
    );
    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() {
    if (!_isListening) return;
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  /// Clears the previous transcript and immediately starts a new recording.
  void _recordAgain() {
    if (!_SpeechEngineAvailable) return;
    setState(() {
      _transcript = '';
    });
    // Ensure any previous session is stopped before starting again
    if (_isListening) {
      _speech.stop();
    }
    // small delay can help on some devices; adjust/remove if unnecessary
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      _startListening();
    });
  }

  void _clearTranscript() {
    setState(() {
      _transcript = '';
    });
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear transcript',
            onPressed: _transcript.isEmpty ? null : _clearTranscript,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _transcript.isEmpty
                      ? 'Tap mic to start recording'
                      : _transcript,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                ElevatedButton.icon(
                  icon: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: Colors.black,
                  ),
                  label: Text(
                    _isListening ? 'Stop' : 'Record',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: _SpeechEngineAvailable ? _toggleListening : null,
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.replay, color: Colors.black),
                  label: const Text(
                    'Record Again',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: _SpeechEngineAvailable ? _recordAgain : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Text(
            //   _SpeechEngineAvailable
            //       ? (_isListening ? 'Listening...' : 'Ready')
            //       : 'Speech not available',
            //   style: const TextStyle(fontSize: 12, color: Colors.grey),
            // ),
            Builder(
              builder: (_) {
                final statustext = !_SpeechEngineAvailable
                    ? 'speech not available'
                    : _isListening
                    ? 'Listening'
                    : (_transcript.isEmpty
                          ? 'Ready-Tap mic to start'
                          : 'Ready');
                return Text(
                  statustext,
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.blueGrey),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _SpeechEngineAvailable ? _toggleListening : null,
        child: Icon(_isListening ? Icons.stop : Icons.mic, color: Colors.black),
      ),
    );
  }
}
