
class Student {
  final String id;
  final String userType;
  final String teamId;
  final String supervisorId;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String hallTicketNumber;
  final String gender;
  final String branch;
  final String role;//student role -> team leader, team Member
  final String profileImageUrl;

  Student({
    this.id,
    this.userType,
    this.teamId,
    this.supervisorId,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.hallTicketNumber,
    this.gender,
    this.branch,
    this.role,
    this.profileImageUrl,
  });
}
