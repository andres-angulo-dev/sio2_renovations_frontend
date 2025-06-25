import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class ProfessionalContactForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController companyController;
  final TextEditingController messageController;
  final bool isSending;
  final VoidCallback onSend;

  const ProfessionalContactForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.companyController,
    required this.messageController,
    required this.isSending,
    required this.onSend,
  });

  @override  
  ProfessionalContactFormState createState() => ProfessionalContactFormState();
}

class ProfessionalContactFormState extends State<ProfessionalContactForm> {
 bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded( // Lastname
                child: _buildTextField(
                  controller: widget.lastNameController,
                  labelText: 'Nom *',
                  icon: Icons.person_outline,
                  validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez renseigner votre nom'
                    : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded( //name
                child: _buildTextField(
                  controller: widget.firstNameController,
                  labelText: 'Prénom *',
                  icon: Icons.person,
                  validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez renseigner votre prénom'
                    : null,
                ),
              ),
            ],
          ),
          _buildTextField( // Company name
            controller: widget.companyController,
            labelText: 'Société',
            icon: Icons.business,
            validator: (value) => null,
          ),
          _buildTextField( // Email
            controller: widget.emailController,
            labelText: 'E-mail *',
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un e-mail valide';
              }
              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
              return emailRegex.hasMatch(value) ? null : 'Format d’email invalide';
            },
          ),
          _buildTextField( // MEssage
            controller: widget.messageController,
            labelText: 'Message *',
            icon: Icons.message,
            maxLines: 6,
            validator: (value) =>
              value == null || value.isEmpty ? 'Veuillez écrire un message' : null,
          ),
          const SizedBox(height: 24.0),
          Text(
            '* Obligatoire',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24.0),
          widget.isSending
            ? const Center(child: CircularProgressIndicator()) // Show a loading indicator if the email is being sent.
            : Align( // Prevents the button from taking the full horizontal width of the ListView.
                alignment: Alignment.centerLeft,
                child: MouseRegion( 
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: SizedBox( // Button 
                    width: 200.0,
                    height: 48.0,
                    child: ElevatedButton(
                      onPressed: widget.onSend,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ),
                          const SizedBox(width: 8),
                          Text(
                            'ENVOYER',
                            style: TextStyle(
                              color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                )
              ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
  }) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator, // Validation function for the text field.
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null ? Icon(icon) : null, // Add an icon if provided.
          filled: true,
          fillColor: GlobalColors.firstColor, // Background color for the text field.
          labelStyle: TextStyle(color: GlobalColors.secondColor), // Style for the label text.
          enabledBorder: OutlineInputBorder( // Style of the border
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.0),      
          ),
          focusedBorder: OutlineInputBorder( // Style of the border when focused.
            borderSide: BorderSide(color: GlobalColors.secondColor), 
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
