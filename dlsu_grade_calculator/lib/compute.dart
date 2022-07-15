double solveForGPA(List<double> units, List<double> grades) {
  double temp = 0;
  for (int i = 0; i < grades.length; i++) {
    temp += units[i] * grades[i];
  }

  return (temp / units.reduce((a, b) => a + b));
}
