class GradeCalculator {
  double participationAndAttendanceWeight = 0.10;
  double homeworkWeight = 0.20;
  double groupPresentationWeight = 0.10;
  double midtermExam1Weight = 0.10;
  double midtermExam2Weight = 0.20;
  double finalProjectWeight = 0.30;

  double calculateFinalGrade({
    required double participationAndAttendance,
    required List<double> homeworkAssignments,
    required double groupPresentation,
    required double midtermExam1,
    required double midtermExam2,
    required double finalProject,
  }) {
    if (participationAndAttendance < 0 ||
        participationAndAttendance > 100 ||
        groupPresentation < 0 ||
        groupPresentation > 100 ||
        midtermExam1 < 0 ||
        midtermExam1 > 100 ||
        midtermExam2 < 0 ||
        midtermExam2 > 100 ||
        finalProject < 0 ||
        finalProject > 100) {
      throw ArgumentError("Grades must be between 0 and 100.");
    }

    for (var grade in homeworkAssignments) {
      if (grade < 0 || grade > 100) {
        throw ArgumentError("Homework grades must be between 0 and 100.");
      }
    }

    double homeworkAverage = 0;
    if (homeworkAssignments.isNotEmpty) {
      homeworkAverage = homeworkAssignments.reduce((a, b) => a + b) / homeworkAssignments.length;
    }

    double finalGrade =
        (participationAndAttendance * participationAndAttendanceWeight) +
            (homeworkAverage * homeworkWeight) +
            (groupPresentation * groupPresentationWeight) +
            (midtermExam1 * midtermExam1Weight) +
            (midtermExam2 * midtermExam2Weight) +
            (finalProject * finalProjectWeight);

    return finalGrade;
  }
}