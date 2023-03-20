import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:textfield_validations/validators.dart';

class TextFieldValidationPage extends StatefulWidget {
  const TextFieldValidationPage({super.key});

  @override
  State<TextFieldValidationPage> createState() =>
      _TextFieldValidationPageState();
}

class _TextFieldValidationPageState extends State<TextFieldValidationPage> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<String> genderList = [
    "",
    "male",
    "female",
  ];

  String? dropDownValue;
  String birthDate = "";
  int? age;
  bool minor = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextFields"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTexField(
                  title: "Full Name",
                  validator: (value) => Validators.validatePersonName(value),
                ),
                _buildTexField(
                  title: "Email Address",
                  validator: (value) => Validators.validateEmail(value),
                ),
                _buildTexField(
                  title: "Mobile Number",
                  validator: (value) => Validators.validatePhoneNumber(value),
                ),
                const SizedBox(height: 10),
                _buildDateOfBirthField(context),
                const SizedBox(height: 10),
                _buildAgeField(),
                const SizedBox(height: 10),
                _buildGenderField(),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submit Success')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill up required fields')),
                      );
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gender",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 200,
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              validator: (value) => Validators.validateDropDown(value),
              value: dropDownValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'female',
                  child: Text('Female'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeField() {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Age",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            controller: controller,
            readOnly: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              } else if (int.parse(value).toInt() < 18) {
                return "Age must be greater than or equal to 18 years old";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Date Of Birth",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    selectDate(context);
                  },
                  child: const Icon(Icons.calendar_month_outlined),
                ),
                Text(
                  birthDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTexField(
      {required String title, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    var inputFormat = DateFormat('MM/dd/yyyy');
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      var days = DateTime.now().difference(selectedDate).inDays;
      setState(() {
        birthDate = inputFormat.format(selectedDate);
        age = days ~/ 365;
        controller.text = age.toString();
      });
    }
  }
}
