import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import 'upload_images.dart';

class MissingPersonDetailsScreen extends StatefulWidget {
  const MissingPersonDetailsScreen({Key? key}) : super(key: key);

  @override
  _MissingPersonDetailsScreenState createState() => _MissingPersonDetailsScreenState();
}

class _MissingPersonDetailsScreenState extends State<MissingPersonDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'fatherName': TextEditingController(),
    'caste': TextEditingController(),
    'gender': TextEditingController(),
    'height': TextEditingController(),
    'hairColor': TextEditingController(),
    'skinColor': TextEditingController(),
    'disability': TextEditingController(),
    'lastSeenPlace': TextEditingController(),
    'lastSeenTime': TextEditingController(),
    'phoneNumber': TextEditingController(),
  };

  double progressPercent = 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildProgressCard(),
            _buildForm(),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 50),
        Center(
          child: Text(
            'Missing Person',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Divider(
          color: AppColors.primary,
          indent: 100,
          endIndent: 100,
          thickness: 2,
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: 390,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Card(
        elevation: 6,
        color: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Row(
            children: [
              _buildProgressText(),
              _buildProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressText() {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Application Progress',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Enter missing person\'s details\nto continue',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.myRedColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Expanded(
      flex: 1,
      child: CircularPercentIndicator(
        radius: 40,
        lineWidth: 8.0,
        percent: progressPercent,
        animation: true,
        animationDuration: 1000,
        progressColor: AppColors.primary,
        backgroundColor: Colors.teal.shade100,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          "${(progressPercent * 100).toInt()}%",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildSectionTitle('Please complete the form with the accurate details of the missing person'),
              _buildSectionTitle('Missing Person Details:', size: 20),
              ..._buildFormFields(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField('Name', 'Enter Missing Person\'s name', 'name', true),
      _buildTextField('Father\'s Name', 'Enter Missing Person\'s father\'s name', 'fatherName', true),
      _buildTextField('Surname', 'Enter Missing Person\'s surname', 'caste', true),
      _buildTextField('Gender', 'Enter Missing Person\'s gender', 'gender', true),
      _buildTextField('Height', 'Enter Missing Person\'s height (ft)', 'height', true),
      _buildTextField('Skin Color', 'Enter Missing Person\'s skin color', 'skinColor', true),
      _buildTextField('Hair Color', 'Enter Missing Person\'s hair color', 'hairColor', true),
      _buildTextField('Disability (if any)', 'Enter Missing Person\'s disability', 'disability', false),
      _buildTextField('Last Seen Place', 'Where was the person seen last?', 'lastSeenPlace', true),
      _buildTextField('Last Seen Time', 'Enter Missing Person\'s last seen time', 'lastSeenTime', true),
      _buildTextField('Phone Number (optional)', 'Enter Missing Person\'s phone number', 'phoneNumber', false),
    ];
  }

  Widget _buildTextField(String label, String hint, String controllerKey, bool isRequired) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
              children: [
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            labelText: label,
            hintText: hint,
            controller: _controllers[controllerKey]!,
            validator: (value) {
              if (isRequired && (value?.isEmpty ?? true)) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {double size = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: size,
          color: AppColors.myBlackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          height: 45,
          width: 130,
          fontSize: 15,
          borderRadius: 10,
          label: 'Back',
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.primary,
          showBorder: true,
        ),
        CustomElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadImagesScreen(),
              ),
            );
          },
          height: 45,
          width: 130,
          fontSize: 15,
          borderRadius: 10,
          label: 'Next',
        ),
      ],
    );
  }
}
