import 'dart:async';

import 'package:rxdart/rxdart.dart';

class TeamBloc extends Object with TeamValidators implements BaseBloc {
  final _nameController = BehaviorSubject<String>();
  final _teamCapacityController = StreamController<int>.broadcast();
  ///outputting
  Stream<String> get name => _nameController.stream.transform(nameValidator);

  Stream<int> get teamCapacity =>
      _teamCapacityController.stream.transform(teamCapacityValidator);

  Stream<bool> get submitCheck => CombineLatestStream.combine2(
      name, teamCapacity, (n, t) => true);

  ///for inputting
  Function(String) get nameChanged => _nameController.sink.add;

  Function(int) get teamCapacityChanged {
    return _teamCapacityController.sink.add;
  }

  @override
  void dispose() {
    _nameController?.close();
    _teamCapacityController?.close();
  }
}

///disposer
abstract class BaseBloc {
  void dispose();
}

///validator
mixin TeamValidators {
  var nameValidator =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.trim().isNotEmpty && name.trim().length > 3) {
      sink.add(name.trim());
    } else if (name.trim().length < 4) {
      sink.addError("Team name must contain minimum 4 chars.");
    } else {
      sink.addError("Please provide a team name.");
    }
  });

  var teamCapacityValidator =
      StreamTransformer<int, int>.fromHandlers(handleData: (capacity, sink) {
    ///logic to identify only integer data not even double data.
    if (capacity < 1)
      sink.addError("Team capacity is not in range [1-60].");
    else if (capacity > 60)
      sink.addError("Team capacity is out of range [1-60].");
    else
      sink.add(capacity);
  });

}
