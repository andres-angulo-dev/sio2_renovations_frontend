import 'package:flutter/material.dart';
import '../api/contact_form_api.dart';
import '../models/contact_form_request.dart';

class ContactFormService {
  static Future<void> submitContactForm({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TextEditingController requestTypeController,                
    required TextEditingController lastNameController,
    required TextEditingController firstNameController,
    required TextEditingController companyController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    List<String>? typeWork,               
    required TextEditingController startDateController,                    
    required TextEditingController addressController,                     
    required TextEditingController messageController,
    required VoidCallback showSuccessDialog,
    required Function(bool) setIsSending,
  }) async {
    // Show loading state in UI (e.g. disable button, show spinner)
    setIsSending(true);

    // If form fields invalid, stop sending. Reset loading state and abort
    if (!formKey.currentState!.validate()) {
      setIsSending(false);
      return;
    }

    final request = ContactFormRequest(
      requestType: requestTypeController.text.isEmpty ? null : requestTypeController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      company: companyController.text,
      email: emailController.text,
      phone: phoneController.text,
      typeWork: typeWork,
      startDate: startDateController.text.isEmpty ? null : startDateController.text,
      address: addressController.text.isEmpty ? null : addressController.text,
      message: messageController.text,
    );

    try {
      // Send the request to the API
      final responseData = await ContactFormApi.send(request);
      // If the API indicates success, show the success dialog
      if (responseData) {
        showSuccessDialog();
      }
    } catch (error) { // On error, show a SnackBar with the error message (ensure context is still mounted)
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : ${error.toString()}')),
      );
    } finally {
      setIsSending(false); // Always reset loading state at the end
    }
  }
}
