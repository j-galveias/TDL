class PoliceUser{
  final String uid;
  PoliceUser({required this.uid});
}

class PoliceUserData{

  final String uid;
  final int total_reports;
  final int reports_to_be_reviewed;

  PoliceUserData({
    required this.uid,
    required this.total_reports,
    required this.reports_to_be_reviewed,
  });
}