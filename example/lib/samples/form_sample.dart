import 'package:example/lib/ThemeConfigurator.dart';
import 'package:example/lib/back_button.dart';
import 'package:example/lib/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class FormSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: Colors.grey,
        variantColor: Colors.black38,
        depth: 8,
        intensity: 0.65,
      ),
      usedTheme: UsedTheme.LIGHT,
      child: Scaffold(
        body: NeumorphicBackground(
          padding: EdgeInsets.all(12),
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class __PageState extends State<_Page> {
  String firstName;
  String lastName;
  double age = 12;
  Gender gender;
  Set<String> rides = Set();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TopBar(
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Neumorphic(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(12)),
          style: NeumorphicStyle(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _AvatarField(),
              SizedBox(height: 8,),
              _TextField(
                label: "First name",
                hint: "",
                onChanged: (firstName) {
                  setState(() {
                    this.firstName = firstName;
                  });
                },
              ),
              SizedBox(height: 8,),
              _TextField(
                label: "Last name",
                hint: "",
                onChanged: (lastName) {
                  setState(() {
                    this.lastName = lastName;
                  });
                },
              ),
              SizedBox(height: 8,),
              _AgeField(
                age: this.age,
                onChanged: (age) {
                  setState(() {
                    this.age = age;
                  });
                },
              ),
              SizedBox(height: 8,),
              _GenderField(
                gender: gender,
                onChanged: (gender) {
                  setState(() {
                    this.gender = gender;
                  });
                },
              ),
              SizedBox(height: 8,),
              _RideField(
                rides: this.rides,
                onChanged: (rides) {
                  setState(() {
                    this.rides = rides;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.circle(),
        padding: EdgeInsets.all(10),
        style: NeumorphicStyle(
          depth: NeumorphicTheme.embossDepth(context),
        ),
        child: Icon(
          Icons.insert_emoticon,
          size: 120,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _AgeField extends StatelessWidget {
  final double age;
  final ValueChanged<double> onChanged;

  _AgeField({@required this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: NeumorphicSlider(
                  min: 8,
                  max: 75,
                  value: this.age,
                  onChanged: (value) {
                    this.onChanged(value);
                  },
                ),
              ),
            ),
            Text("${this.age.floor()}"),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final String hint;

  final ValueChanged<String> onChanged;
  final TextEditingController _controller = TextEditingController();

  _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            this.label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          boxShape: NeumorphicBoxShape.stadium(),
          style: NeumorphicStyle(depth: NeumorphicTheme.embossDepth(context)),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
          child: TextField(
            onChanged: this.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: this.hint),
          ),
        )
      ],
    );
  }
}

class _GenderField extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const _GenderField({
    @required this.gender,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Gender",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.MALE,
              child: Icon(Icons.account_box),
              onChanged: (value) => this.onChanged(value),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.FEMALE,
              child: Icon(Icons.pregnant_woman),
              onChanged: (value) => this.onChanged(value),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: this.gender,
              padding: EdgeInsets.all(20),
              boxShape: NeumorphicBoxShape.circle(),
              value: Gender.NON_BINARY,
              child: Icon(Icons.supervised_user_circle),
              onChanged: (value) => this.onChanged(value),
            ),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _RideField extends StatelessWidget {
  final Set<String> rides;
  final ValueChanged<Set<String>> onChanged;

  const _RideField({
    @required this.rides,
    @required this.onChanged,
  });

  void _toggle(bool selected, String element) {
    if (selected) {
      this.rides.add(element);
    } else {
      this.rides.remove(element);
    }
    this.onChanged(this.rides);
  }

  Widget _buildCheck(String text, String value){
    return Row(
      children: <Widget>[
        Text("$text :"),
        SizedBox(width: 12),
        NeumorphicCheckbox(
          value: rides.contains(value),
          padding: EdgeInsets.all(20),
          onChanged: (selected) {
            _toggle(selected, value);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Rides",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 20),
            _buildCheck("Car", "car"),
            SizedBox(width: 12),
            _buildCheck("Bike", "bike"),
            SizedBox(width: 12),
            _buildCheck("Plane", "plane"),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}