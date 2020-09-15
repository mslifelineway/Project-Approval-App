
class Team {
  ///this ID will be generated according to HOD branch with some random digits (ex- CSE7312)
  final String id;
  final String name;

  ///capacity - is the length of team how many members can be added
  final int capacity;

  ///this will be same as capacity initially
  final int memberRequired;

  ///to get timestamp use - date DateTime.Now()
  final DateTime dateTime;
  final String supervisorId;

  Team({
    this.id,
    this.name,
    this.capacity,
    this.memberRequired,
    this.dateTime,
    this.supervisorId,
  });
}
