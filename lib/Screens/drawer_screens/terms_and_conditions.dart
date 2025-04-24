import 'package:flutter/material.dart';
import 'package:locat_lost/Widgets/custom_appBar.dart';
import 'package:locat_lost/colors.dart';
import 'package:locat_lost/Widgets/custom_button.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();

}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(text: 'Terms & Conditions', onPressed: (){
        Navigator.pop(context);
      }),

      backgroundColor: AppColors.secondary,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SectionTitle('Why LocateLost Exists'),
                    SectionBody(
                        'Our mission is to reunite missing children with their families using advanced facial recognition. We are not an official rescue or law enforcement body — just a bridge.'),

                    SectionTitle('Your Responsibility'),
                    SectionBody(
                        'Provide accurate info. Misleading or harmful use will result in account ban and possible legal action.'),

                    SectionTitle('Our Role'),
                    SectionBody(
                        'We are tech facilitators — not involved in any personal communication or verification. The developer holds zero legal responsibility for misuse.'),

                    SectionTitle('Use of AI'),
                    SectionBody(
                        'Face matching is automated and may not always be accurate. Treat all matches as leads, not confirmations.'),

                    SectionTitle('Privacy Matters'),
                    SectionBody(
                        'Your data is processed only for matching purposes and never shared or sold. Photos and details are secured.'),

                    SectionTitle('What We Don’t Guarantee'),
                    SectionBody(
                        'We cannot promise a successful match or reunion. Please always report missing/found cases to local authorities.'),

                    SectionTitle('Modifications & Updates'),
                    SectionBody(
                        'These terms may evolve. Continued use means you accept any updated version.')
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: agreed,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      agreed = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    'I have read and agree to the Terms & Conditions.',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomButton(
              label: 'Continue',
              size: 'large',
              border: false,
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.secondary,
              onPressed: () {
                if (agreed) {
                  Navigator.pop(context); // or push to next screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please agree to the Terms & Conditions.'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SectionBody extends StatelessWidget {
  final String text;
  const SectionBody(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black87,
        height: 1.6,
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:locat_lost/colors.dart';
//
// class TermsAndConditions extends StatelessWidget {
//   const TermsAndConditions({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         title: const Text('Terms and Conditions'),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             SectionTitle('1. Purpose of the App'),
//             SectionBody(
//                 'LocateLost is a platform to assist in reuniting missing children using facial recognition. It does not guarantee recovery but aids discovery.'
//             ),
//             SectionTitle('2. Role of the Developer'),
//             SectionBody(
//                 'The developer is not responsible for the accuracy of submitted data, communication between parties, or any outcomes resulting from app use.'
//             ),
//             SectionTitle('3. User Responsibilities'),
//             SectionBody(
//                 'Users must provide truthful information, not misuse the platform, and refrain from any harmful or illegal activity. Misuse may lead to account termination and legal action.'
//             ),
//             SectionTitle('4. Data Privacy and Handling'),
//             SectionBody(
//                 'All data is securely processed for matching purposes only and is not sold or publicly shared. Facial recognition is automated.'
//             ),
//             SectionTitle('5. Limitations of Facial Recognition'),
//             SectionBody(
//                 'Matching may result in errors. The app should not be solely relied on for child identification.'
//             ),
//             SectionTitle('6. No Guarantee of Reunion'),
//             SectionBody(
//                 'LocateLost does not guarantee the reunion of missing children. Users are encouraged to report cases to the police.'
//             ),
//             SectionTitle('7. Legal Liability'),
//             SectionBody(
//                 'The developer is not liable for app misuse, emotional distress, or outcomes from user actions.'
//             ),
//             SectionTitle('8. Account Termination'),
//             SectionBody(
//                 'Violation of these terms may result in account suspension or deletion.'
//             ),
//             SectionTitle('9. Modifications to Terms'),
//             SectionBody(
//                 'Terms may be updated at any time. Continued use implies acceptance of the latest terms.'
//             ),
//             SectionTitle('10. Contact'),
//             SectionBody(
//                 'For support or to report abuse, contact: support@locatelost.app'
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SectionTitle extends StatelessWidget {
//   final String text;
//   const SectionTitle(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: AppColors.primary,
//         ),
//       ),
//     );
//   }
// }
//
// class SectionBody extends StatelessWidget {
//   final String text;
//   const SectionBody(this.text, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 15,
//         color: Colors.black87,
//         height: 1.5,
//       ),
//     );
//   }
// }
