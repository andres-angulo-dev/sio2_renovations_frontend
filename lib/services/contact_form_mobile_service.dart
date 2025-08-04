// Version without the unnecessary lines in the sent message (formatting of null values)
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import '../utils/global_others.dart';

class ContactFormService {
  static Future<void> submitContactForm({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    TextEditingController? requestTypeController,                
    required TextEditingController lastNameController,
    required TextEditingController firstNameController,
    required TextEditingController companyController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    List<String>? typeWork,               
    TextEditingController? startDateController,                    
    TextEditingController? addressController,                     
    required TextEditingController messageController,
    required Function(bool) setIsSending, // Manages the loading state in the UI (e.g. disabling the button, showing a loading indicator)
    required Function(bool) setMessageSendingValidated // Give the information if the message was sent (true/false) to the parent
  }) async {

    final formattedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

    // If form fields invalid, stop sending. Reset loading state and abort
    if (!formKey.currentState!.validate()) {
      setIsSending(false);
      return;
    }

    final smtpServer = SmtpServer(
      dotenv.env['SMTP_HOST']!,
      port: int.parse(dotenv.env['SMTP_PORT']!),
      ssl: true,
      ignoreBadCertificate: true,
      username: dotenv.env['SMTP_USERNAME'],
      password: dotenv.env['SMTP_PASSWORD'],
    );

    final messageToCompany = _buildMessageToCompany(
      requestTypeController: requestTypeController, 
      lastNameController: lastNameController, 
      firstNameController: firstNameController, 
      companyController: companyController, 
      emailController: emailController, 
      phoneController: phoneController, 
      typeWork: typeWork ?? [], 
      startDateController: startDateController, 
      addressController: addressController, 
      messageController: messageController
    );

    final messageCopyToCustomer = _buildMessageCopyToCustomer(
      requestTypeController: requestTypeController, 
      lastNameController: lastNameController, 
      firstNameController: firstNameController, 
      companyController: companyController, 
      emailController: emailController, 
      phoneController: phoneController, 
      typeWork: typeWork ?? [], 
      startDateController: startDateController, 
      addressController: addressController, 
      messageController: messageController, 
      formattedDate: formattedDate
    );

    try {
      await send(messageToCompany, smtpServer); // Send the request
      await send(messageCopyToCustomer, smtpServer); // Send the copy to customer
      
      // After the success of the messages sent, send true to the parent to display the success animation in SuccessPopupComponent
      setMessageSendingValidated(true);
      
    } on MailerException catch (error) {

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${error.toString()}'))
      );
    } finally {
      
      setIsSending (false); // Always reset loading state at the end
    }
  }

  // Utility to format a text line
  static String formatLine(String label, String? value) {
    if (value == null || value.trim().isEmpty) return '';
    return '$label: $value\n';
  }

  // Utility to format a html line
  static String formatHtmlLine(String label, String? value) {
    if (value == null || value.trim().isEmpty) return '';
    return '<li><strong>$label:</strong> $value</li>';
  }

  static Message _buildMessageToCompany({
    TextEditingController? requestTypeController,
    required TextEditingController lastNameController,
    required TextEditingController firstNameController,
    required TextEditingController companyController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required List<String> typeWork,
    TextEditingController? startDateController,
    TextEditingController? addressController,
    required TextEditingController messageController,
  }) {
    final buffer = StringBuffer();

    // Message TEXT
    buffer.write(formatLine('Request type', requestTypeController?.text));
    buffer.write(formatLine('First name', firstNameController.text));
    buffer.write(formatLine('Last name', lastNameController.text));
    buffer.write(formatLine('Name of company', companyController.text));
    buffer.write(formatLine('Email', emailController.text));
    buffer.write(formatLine('Phone number', phoneController.text));
    if (typeWork.isNotEmpty) {
      buffer.write(formatLine('Type of work', typeWork.join(', ')));
    }
    buffer.write(formatLine('Start date', startDateController?.text));
    buffer.write(formatLine('Project address', addressController?.text));
    buffer.writeln('\nMessage:\n${messageController.text}');

    return Message()
      ..from = Address(emailController.text, '${firstNameController.text} ${lastNameController.text}')
      ..recipients.add(dotenv.env['SMTP_COMPANY_MAIL']!)
      ..subject = 'New contact message by ${firstNameController.text} ${lastNameController.text}'
      ..text = buffer.toString().trim();
  }

  static Message _buildMessageCopyToCustomer({
    TextEditingController? requestTypeController,
    required TextEditingController lastNameController,
    required TextEditingController firstNameController,
    required TextEditingController companyController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required List<String> typeWork,
    TextEditingController? startDateController,
    TextEditingController? addressController,
    required TextEditingController messageController,
    required String formattedDate,
  }) {
    final textBuffer = StringBuffer();
    final htmlBuffer = StringBuffer();

    // Message TEXT
    textBuffer.write(formatLine('Request type', requestTypeController?.text));
    textBuffer.write(formatLine('Name of company', companyController.text));
    textBuffer.write(formatLine('Phone number', phoneController.text));
    if (typeWork.isNotEmpty) {
      textBuffer.write(formatLine('Type of work', typeWork.join(', ')));
    }
    textBuffer.write(formatLine('Start date', startDateController?.text));
    textBuffer.write(formatLine('Project address', addressController?.text));
    textBuffer.writeln('\nMessage:\n${messageController.text}');
    // Message HTML
    htmlBuffer.write(formatHtmlLine('Request type', requestTypeController?.text));
    htmlBuffer.write(formatHtmlLine('Name of company', companyController.text));
    htmlBuffer.write(formatHtmlLine('Phone number', phoneController.text));
    if (typeWork.isNotEmpty) {
      htmlBuffer.write(formatHtmlLine('Type of work', typeWork.join(', ')));
    }
    htmlBuffer.write(formatHtmlLine('Start date', startDateController?.text));
    htmlBuffer.write(formatHtmlLine('Project address', addressController?.text));

    return Message()
      ..from = Address(dotenv.env['SMTP_COMPANY_MAIL']!, '${GlobalPersonalData.companyName} Customer Service')
      ..recipients.add(emailController.text)
      ..subject = 'Your request has been successfully received by our service'
      ..text = 
        'Hello ${firstNameController.text} ${lastNameController.text},\n\n'
        'Thank you for your request.\n\n'
        'If you have a follow-up question or additional information, please reply to this email and it will be added to your original submission.\n'
        'We strive to respond to all email inquiries as quickly as possible, typically within two business days.\n\n'
        'Sincerely,\n'
        'Your ${GlobalPersonalData.companyName} customer service team.\n\n'
        '_____________________________________________________\n\n'
        'Your original enquery submitted on ${GlobalPersonalData.website} on $formattedDate:\n\n'
        '${textBuffer.toString().trim()}'
        'Message:\n'
        '${messageController.text}'
      ..headers = {
        'Reply-To': dotenv.env['SMTP_COMPANY_MAIL'],
      }
      ..html = '''
        <div style="font-family: Arial, sans-serif; line-height: 1.6;">
          <p>Hello <strong>${firstNameController.text} ${lastNameController.text}</strong>,</p>
          <p>Thank you for your request.</p>
          <p>If you have a follow-up question or additional information, please reply to this email and it will be added to your original submission.<br>
          We strive to respond to all email inquiries as quickly as possible, typically within two business days.</p>
          <p>Sincerely,<br>
          Your <strong>${GlobalPersonalData.companyName}</strong> customer service team.</p>
          <hr>
          <p><em>Your original enquiry submitted on ${GlobalPersonalData.website} on $formattedDate:</em></p>
          <ul>
            ${htmlBuffer.toString()}
          </ul>
          <p><strong>Message:</strong><br>
          ${messageController.text}</p>
        </div>
      ''';
  }  
}

class ContactFormData {
  final TextEditingController? requestTypeController;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController companyController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final List<String>? typeWork;
  final TextEditingController? startDateController;
  final TextEditingController? addressController;
  final TextEditingController messageController;

  ContactFormData({
    this.requestTypeController,
    required this.lastNameController,
    required this.firstNameController,
    required this.companyController,
    required this.emailController,
    required this.phoneController,
    this.typeWork,
    this.startDateController,
    this.addressController,
    required this.messageController,
  });
}



// // Version with null values in the message
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// import 'package:intl/intl.dart';
// import '../utils/global_others.dart';

// class ContactFormService {
//   static Future<void> submitContactForm({
//     required GlobalKey<FormState> formKey,
//     required BuildContext context,
//     TextEditingController? requestTypeController,                
//     required TextEditingController lastNameController,
//     required TextEditingController firstNameController,
//     required TextEditingController companyController,
//     required TextEditingController emailController,
//     required TextEditingController phoneController,
//     List<String>? typeWork,               
//     TextEditingController? startDateController,                    
//     TextEditingController? addressController,                     
//     required TextEditingController messageController,
//     required Function(bool) setIsSending, // Manages the loading state in the UI (e.g. disabling the button, showing a loading indicator)
//     required Function(bool) setMessageSendingValidated // Give the information if the message was sent (true/false) to the parent
//   }) async {

//     final formattedDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

//     // If form fields invalid, stop sending. Reset loading state and abort
//     if (!formKey.currentState!.validate()) {
//       setIsSending(false);
//       return;
//     }

//     final smtpServer = SmtpServer(
//       dotenv.env['SMTP_HOST']!,
//       port: int.parse(dotenv.env['SMTP_PORT']!),
//       ssl: true,
//       ignoreBadCertificate: true,
//       username: dotenv.env['SMTP_USERNAME'],
//       password: dotenv.env['SMTP_PASSWORD'],
//     );

//     final messageToCompany = _buildMessageToCompany(
//       requestTypeController: requestTypeController, 
//       lastNameController: lastNameController, 
//       firstNameController: firstNameController, 
//       companyController: companyController, 
//       emailController: emailController, 
//       phoneController: phoneController, 
//       typeWork: typeWork ?? [], 
//       startDateController: startDateController, 
//       addressController: addressController, 
//       messageController: messageController
//     );

//     final messageCopyToCustomer = _buildMessageCopyToCustomer(
//       requestTypeController: requestTypeController, 
//       lastNameController: lastNameController, 
//       firstNameController: firstNameController, 
//       companyController: companyController, 
//       emailController: emailController, 
//       phoneController: phoneController, 
//       typeWork: typeWork ?? [], 
//       startDateController: startDateController, 
//       addressController: addressController, 
//       messageController: messageController, 
//       formattedDate: formattedDate
//     );

//     try {
//       await send(messageToCompany, smtpServer); // Send the request
//       await send(messageCopyToCustomer, smtpServer); // Send the copy to customer
      
//       // After the success of the messages sent, send true to the parent to display the success animation in SuccessPopupComponent
//       setMessageSendingValidated(true);
      
//     } on MailerException catch (error) {

//       if (!context.mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error : ${error.toString()}'))
//       );
//     } finally {

//       setIsSending (false); // Always reset loading state at the end
//     }
//   }

//   static Message _buildMessageToCompany({
//     required TextEditingController? requestTypeController,
//     required TextEditingController lastNameController,
//     required TextEditingController firstNameController,
//     required TextEditingController companyController,
//     required TextEditingController emailController,
//     required TextEditingController phoneController,
//     required List<String> typeWork,
//     required TextEditingController? startDateController,
//     required TextEditingController? addressController,
//     required TextEditingController messageController,
//   }) {
//     return Message()
//       ..from = Address(emailController.text, '${firstNameController.text} ${lastNameController.text}')
//       ..recipients.add(dotenv.env['SMTP_COMPANY_MAIL']!)
//       ..subject = 'New contact message by ${firstNameController.text} ${lastNameController.text}'
//       ..text =
//         'Request type: ${requestTypeController?.text.isEmpty ?? true ? '' : requestTypeController!.text}\n'
//         'First name: ${firstNameController.text}\n'
//         'Last name: ${lastNameController.text}\n'
//         'Name of company: ${companyController.text}\n'
//         'Email: ${emailController.text}\n'
//         'Phone number: ${phoneController.text}\n'
//         'Type of work: ${typeWork.isEmpty ? '' : typeWork.join(', ')}\n'
//         'Start date: ${startDateController?.text.isEmpty ?? true ? '' : startDateController!.text}\n'
//         'Projetct address: ${addressController?.text.isEmpty ?? true ? '' : addressController!.text}\n\n'
//         'Message:\n'
//         '${messageController.text}';
//   }

//   static Message _buildMessageCopyToCustomer({
//     required TextEditingController? requestTypeController,
//     required TextEditingController lastNameController,
//     required TextEditingController firstNameController,
//     required TextEditingController companyController,
//     required TextEditingController emailController,
//     required TextEditingController phoneController,
//     required List<String> typeWork,
//     required TextEditingController? startDateController,
//     required TextEditingController? addressController,
//     required TextEditingController messageController,
//     required String formattedDate,
//   }) {
//     return Message()
//       ..from = Address(dotenv.env['SMTP_COMPANY_MAIL']!, '${GlobalPersonalData.companyName} Customer Service')
//       ..recipients.add(emailController.text)
//       ..subject = 'Your request has been successfully received by our service'
//       ..text =
//         'Hello ${firstNameController.text} ${lastNameController.text},\n\n'
//         'Thank you for your request.\n\n'
//         'If you have a follow-up question or additional information, please reply to this email and it will be added to your original submission.\n'
//         'We strive to respond to all email inquiries as quickly as possible, typically within two business days.\n\n'
//         'Sincerely,\n'
//         'Your ${GlobalPersonalData.companyName} customer service team.'
//         '\n\n'
//         '_____________________________________________________\n\n'
//         'Your original enquery submitted on ${GlobalPersonalData.website} on $formattedDate:'
//         '\n\n'
//         'Request type: ${requestTypeController?.text.isEmpty ?? true ? '' : requestTypeController!.text}\n'
//         'Name of company: ${companyController.text}\n'
//         'Phone number: ${phoneController.text}\n'
//         'Type of work: ${typeWork.isEmpty ? '' : typeWork.join(', ')}\n'
//         'Start date: ${startDateController?.text.isEmpty ?? true ? '' : startDateController!.text}\n'
//         'Projetct address: ${addressController?.text.isEmpty ?? true ? '' : addressController!.text}\n\n'
//         'Message:\n'
//         '${messageController.text}'
//       ..headers = {
//         'Reply-To': dotenv.env['SMTP_COMPANY_MAIL'],
//       }
//       ..html = '''
//         <div style="font-family: Arial, sans-serif; line-height: 1.6;">
//           <p>Hello <strong>${firstNameController.text} ${lastNameController.text}</strong>,</p>
//           <p>Thank you for your request.</p>
//           <p>If you have a follow-up question or additional information, please reply to this email and it will be added to your original submission.<br>
//           We strive to respond to all email inquiries as quickly as possible, typically within two business days.</p>
//           <p>Sincerely,<br>
//           Your <strong>${GlobalPersonalData.companyName}</strong> customer service team.</p>
//           <hr>
//           <p><em>Your original enquiry submitted on ${GlobalPersonalData.website} on $formattedDate:</em></p>
//           <ul>
//             <li><strong>Request type:</strong> ${requestTypeController?.text.isEmpty ?? true ? '' : requestTypeController!.text}</li>
//             <li><strong>Name of company:</strong> ${companyController.text}</li>
//             <li><strong>Phone number:</strong> ${phoneController.text}</li>
//             <li><strong>Type of work:</strong> ${typeWork.isEmpty ? '' : typeWork.join(', ')}</li>
//             <li><strong>Start date:</strong> ${startDateController?.text.isEmpty ?? true ? '' : startDateController!.text}</li>
//             <li><strong>Project address:</strong> ${addressController?.text.isEmpty ?? true ? '' : addressController!.text}</li>
//           </ul>
//           <p><strong>Message:</strong><br>
//           ${messageController.text}</p>
//         </div>
//       ''';
//   }  
// }

// class ContactFormData {
//   final TextEditingController? requestTypeController;
//   final TextEditingController lastNameController;
//   final TextEditingController firstNameController;
//   final TextEditingController companyController;
//   final TextEditingController emailController;
//   final TextEditingController phoneController;
//   final List<String>? typeWork;
//   final TextEditingController? startDateController;
//   final TextEditingController? addressController;
//   final TextEditingController messageController;

//   ContactFormData({
//     this.requestTypeController,
//     required this.lastNameController,
//     required this.firstNameController,
//     required this.companyController,
//     required this.emailController,
//     required this.phoneController,
//     this.typeWork,
//     this.startDateController,
//     this.addressController,
//     required this.messageController,
//   });
// }
