// Is called by ContactScreen and use the model from ContactFormRequestModel and files
import 'package:flutter/material.dart';
import '../api/contact_form_api.dart';
import '../widgets/files_picker_widget.dart';
import '../models/contact_form_request_model.dart';

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
    List<PickedFile>? files,
    required TextEditingController messageController,
    required Function(bool) setIsSending, // Manages the loading state in the UI (e.g. disabling the button, showing a loading indicator)
    required Function(bool) setMessageSendingValidated, // Give the information if the message was sent (true/false) to the parent
  }) async {

    // If form fields invalid, stop sending. Reset loading state and abort
    if (!formKey.currentState!.validate()) {
      setIsSending(false);
      return;
    }

    final request = ContactFormRequestModel(
      requestType: requestTypeController?.text.isEmpty ?? true ? null : requestTypeController!.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      company: companyController.text,
      email: emailController.text,
      phone: phoneController.text,
      typeWork: typeWork,
      startDate: startDateController?.text.isEmpty ?? true ? null : startDateController!.text,
      address: addressController?.text.isEmpty ?? true ? null : addressController!.text,
      message: messageController.text,
      files: files,
    );

    try {
      // Send the request to the API
      final responseData = await ContactFormApi.send(request);
      
      // If the API indicates success, send true to the parent to display the success animation in SuccessPopupComponent
      if (responseData) {
        setMessageSendingValidated(true);
      }
    } catch (error) { // On error, show a SnackBar with the error message (ensure context is still mounted)
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error : ${error.toString()}')),
      );
    } finally {
      setIsSending(false); // Always reset loading state at the end. End the loading state in the UI that comes from the beginning of the captcha in MyCaptchaWidget
    }
  }
}

