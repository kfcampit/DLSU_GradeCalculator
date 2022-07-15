double solveForGPA(List<double> units, List<double> grades) {
  double temp = 0;
  for (int i = 0; i < grades.length; i++) {
    temp += units[i] * grades[i];
  }

  return (temp / units.reduce((a, b) => a + b));
}

double solveCoursePercentage(List<double> units, List<double> grades) {
  double temp = 0;
  for (int i = 0; i < grades.length; i++) {
    temp += units[i] * grades[i];
  }
  return temp;
}

final Map<int, List<double>> gradingMatrix = {
  75: [75, 78, 81, 84, 88, 92, 96],
  70: [70, 74, 78, 83, 88, 92, 96],
  65: [65, 70, 75, 80, 85, 90, 95],
  60: [60, 66, 71, 77, 83, 88, 94],
  55: [55, 62, 69, 76, 83, 90, 95],
  50: [50, 58, 66, 74, 82, 90, 95],
  45: [45, 53, 61, 68, 76, 85, 94],
  40: [40, 49, 58, 67, 76, 85, 94],
};

double solveCourseGrade(double percentGrade, double passingGrade) {
  List<double> interval = gradingMatrix[passingGrade]!;
  double grade = 4.0;

  if (percentGrade < passingGrade) return 0;

  for (double range in interval.reversed) {
    if (percentGrade >= range) return grade;
    grade -= 0.5;
  }

  return 1.0;
}
