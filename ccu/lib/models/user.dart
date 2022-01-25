class User{
  final String uid;
  User({required this.uid});
}

class UserData{

  final String uid;
  final String name;
  final String licensePlate;
  final String last_report;
  final int dailyReports;
  final int totalReports;
  final int rewardPoints;
  final int licensePoints;
  final int approved;

  UserData({
    required this.uid,
    required this.name,
    required this.licensePlate,
    required this.dailyReports,
    required this.totalReports,
    required this.rewardPoints,
    required this.licensePoints,
    required this.approved,
    required this.last_report,
  });
}