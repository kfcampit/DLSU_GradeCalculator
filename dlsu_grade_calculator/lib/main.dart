import 'package:dlsu_grade_calculator/compute.dart';
import 'package:dlsu_grade_calculator/custom_widgets.dart';
import 'package:dlsu_grade_calculator/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int tabOneNumCourses = 0;
int tabTwoNumCourses = 0;

double tabOneGPA = 0.0;
double tabTwoPercentGrade = 0.0;
double tabTwoFinalGrade = 0.0;

void main() {
  runApp(const GradeCalculator());
}

class GradeCalculator extends StatelessWidget {
  const GradeCalculator({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grade Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String dropDownValue = '60';
  var items = ['75', '70', '65', '60', '55', '50', '45', '40'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 40,
            ),
            Expanded(
                child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Colors.white,
                    labelStyle: primaryStyle(22, Colors.white, FontWeight.w600),
                    indicatorColor: primaryColor,
                    indicatorWeight: 2,
                    tabs: const [Tab(text: "Term"), Tab(text: "Course")],
                  ),
                  Expanded(
                      child: TabBarView(
                    children: [tabOne(), tabTwo()],
                  ))
                ],
              ),
            ))
          ],
        ));
  }

//TAB ONE UI
  Widget tabOne() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text('Course',
                            textAlign: TextAlign.center,
                            style: primaryStyle(
                                18, primaryTextColor, FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Units',
                            textAlign: TextAlign.center,
                            style: primaryStyle(
                                18, primaryTextColor, FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text('Grade',
                            textAlign: TextAlign.center,
                            style: primaryStyle(
                                18, primaryTextColor, FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(' ',
                            textAlign: TextAlign.center,
                            style: primaryStyle(
                                18, primaryTextColor, FontWeight.w600)),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    color: primaryTextColor,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              tabOneInputRows(),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 8, 0, 8),
                                child: roundedButton(
                                    "Add",
                                    primaryColor,
                                    8,
                                    primaryStyle(
                                        14, Colors.white, FontWeight.w600),
                                    120,
                                    30, () {
                                  setState(() {
                                    if (tabOneNumCourses < 14) {
                                      tabOneNumCourses++;
                                    }
                                  });
                                  tabOneCourseControllers
                                      .add(TextEditingController());
                                  tabOneUnitControllers
                                      .add(TextEditingController());
                                  tabOneGradeControllers
                                      .add(TextEditingController());
                                }),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                          child: SizedBox.fromSize(
                            size: const Size(60, 60),
                            child: ClipOval(
                              child: Material(
                                color: primaryColor,
                                child: InkWell(
                                  onTap: () {
                                    List<double> units = [];
                                    List<double> grades = [];

                                    for (int i = 0; i < tabOneNumCourses; i++) {
                                      units.add(double.parse(
                                          tabOneUnitControllers[i].text));
                                      grades.add(double.parse(
                                          tabOneGradeControllers[i].text));
                                    }

                                    setState(() {
                                      tabOneGPA = solveForGPA(units, grades);
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Icon(
                                        Icons.calculate,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 2,
                        child: Text('GPA:',
                            textAlign: TextAlign.end,
                            style: primaryStyle(
                                20, primaryTextColor, FontWeight.w600)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(tabOneGPA.toStringAsFixed(3),
                            textAlign: TextAlign.center,
                            style: secondaryStyle(
                                20, primaryColor, FontWeight.w600)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget tabOneInputRows() {
    List<Widget> rows = [];

    for (int i = 0; i < tabOneNumCourses; i++) {
      rows.add(tabOneSingleRow(tabOneCourseControllers[i],
          tabOneUnitControllers[i], tabOneGradeControllers[i], i));
    }

    return Column(
      children: rows,
    );
  }

  Widget tabOneSingleRow(TextEditingController course,
      TextEditingController units, TextEditingController grade, int i) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: course,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'CALENG1',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: units,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: '3.0',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryTextColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: grade,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: '3.5',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryTextColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Color(0xFFFF0000),
              size: 24,
            ),
            onPressed: () {
              setState(() {
                tabOneNumCourses--;
                tabOneCourseControllers.removeAt(i);
                tabOneUnitControllers.removeAt(i);
                tabOneGradeControllers.removeAt(i);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget tabTwo() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 2),
                      child: Container(
                        width: 100,
                        height: 100,
                        constraints: const BoxConstraints(
                          maxHeight: 48,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text('Passing Grade:',
                                    textAlign: TextAlign.end,
                                    style: primaryStyle(
                                        16, primaryTextColor, FontWeight.w600)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 0),
                                    child: DropdownButton<String>(
                                      value: dropDownValue,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        size: 16,
                                      ),
                                      elevation: 2,
                                      style: secondaryStyle(
                                          16, primaryColor, FontWeight.w500),
                                      underline: Container(
                                        height: 2,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropDownValue = newValue!;
                                        });
                                      },
                                      items: items
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 2, 20, 20),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 16, 8, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text('Category',
                                          textAlign: TextAlign.center,
                                          style: primaryStyle(
                                              18,
                                              primaryTextColor,
                                              FontWeight.w600)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text('Weight',
                                          textAlign: TextAlign.center,
                                          style: primaryStyle(
                                              18,
                                              primaryTextColor,
                                              FontWeight.w600)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text('Grade',
                                          textAlign: TextAlign.center,
                                          style: primaryStyle(
                                              18,
                                              primaryTextColor,
                                              FontWeight.w600)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(' ',
                                          textAlign: TextAlign.center,
                                          style: primaryStyle(
                                              18,
                                              primaryTextColor,
                                              FontWeight.w600)),
                                    ),
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                  color: primaryTextColor,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            tabTwoInputRows(),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 8, 0, 8),
                                              child: roundedButton(
                                                  "Add",
                                                  primaryColor,
                                                  8,
                                                  primaryStyle(14, Colors.white,
                                                      FontWeight.w600),
                                                  120,
                                                  30, () {
                                                setState(() {
                                                  if (tabTwoNumCourses < 14) {
                                                    tabTwoNumCourses++;
                                                  }
                                                });
                                                tabTwoCategoryControllers.add(
                                                    TextEditingController());
                                                tabTwoWeightControllers.add(
                                                    TextEditingController());
                                                tabTwoGradeControllers.add(
                                                    TextEditingController());
                                              }),
                                            ),
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(8, 0, 0, 0),
                                        child: SizedBox.fromSize(
                                          size: const Size(60, 60),
                                          child: ClipOval(
                                            child: Material(
                                              color: primaryColor,
                                              child: InkWell(
                                                onTap: () {
                                                  List<double> weights = [];
                                                  List<double> grades = [];

                                                  for (int i = 0;
                                                      i < tabTwoNumCourses;
                                                      i++) {
                                                    weights.add(double.parse(
                                                            tabTwoWeightControllers[
                                                                    i]
                                                                .text) /
                                                        100);
                                                    grades.add(double.parse(
                                                            tabTwoGradeControllers[
                                                                    i]
                                                                .text) /
                                                        100);
                                                  }

                                                  setState(() {
                                                    tabTwoPercentGrade =
                                                        solveCoursePercentage(
                                                            weights, grades);
                                                    tabTwoFinalGrade =
                                                        solveCourseGrade(
                                                            tabTwoPercentGrade *
                                                                100,
                                                            double.parse(
                                                                dropDownValue));
                                                  });
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const <Widget>[
                                                    Icon(
                                                      Icons.calculate,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text('Percent Grade:',
                                                    textAlign: TextAlign.end,
                                                    style: primaryStyle(
                                                        14,
                                                        primaryTextColor,
                                                        FontWeight.w600)),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "${(tabTwoPercentGrade * 100).toStringAsFixed(2)} %",
                                                    textAlign: TextAlign.center,
                                                    style: secondaryStyle(
                                                        14,
                                                        primaryColor,
                                                        FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 4, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text('Final Grade:',
                                                      textAlign: TextAlign.end,
                                                      style: primaryStyle(
                                                          16,
                                                          primaryTextColor,
                                                          FontWeight.w600)),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      tabTwoFinalGrade
                                                          .toStringAsFixed(1),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: secondaryStyle(
                                                          16,
                                                          primaryColor,
                                                          FontWeight.w600)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tabTwoInputRows() {
    List<Widget> rows = [];

    for (int i = 0; i < tabTwoNumCourses; i++) {
      rows.add(tabTwoSingleRow(tabTwoCategoryControllers[i],
          tabTwoWeightControllers[i], tabTwoGradeControllers[i], i));
    }

    return Column(
      children: rows,
    );
  }

  Widget tabTwoSingleRow(TextEditingController category,
      TextEditingController weight, TextEditingController grade, int i) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: category,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Finals',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: weight,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: '25',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryTextColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            controller: grade,
            autofocus: true,
            obscureText: false,
            decoration: InputDecoration(
              hintText: '90',
              hintStyle:
                  secondaryStyle(16, secondaryTextColor, FontWeight.normal),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            style: secondaryStyle(16, primaryTextColor, FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Color(0xFFFF0000),
              size: 24,
            ),
            onPressed: () {
              setState(() {
                tabTwoNumCourses--;
                tabTwoCategoryControllers.removeAt(i);
                tabTwoWeightControllers.removeAt(i);
                tabTwoGradeControllers.removeAt(i);
              });
            },
          ),
        ),
      ],
    );
  }
}
