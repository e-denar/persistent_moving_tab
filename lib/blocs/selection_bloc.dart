import 'dart:async';

class SelectionBloc {
  SelectionBloc({
    int selectedIndex = 0,
  }) : _selectedIndex = selectedIndex {
    _controller.stream.listen((i) {
      _selectedIndex = i;
    });
  }

  int _selectedIndex;
  final StreamController<int> _controller = StreamController<int>.broadcast();

  set index(int i) => _controller.sink.add(i);
  get index => _selectedIndex;

  Stream<int> get indexStream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
