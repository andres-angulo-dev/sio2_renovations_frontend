import 'package:flutter/material.dart';
import '../utils/global_colors.dart';

class ProfessionalContactForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
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
    required this.phoneController,
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
              Expanded( 
                child: _buildTextField( // Lastname
                  controller: widget.lastNameController,
                  labelText: 'Nom *',
                  icon: Icons.person_outline,
                  validator: (value) => value == null || value.isEmpty
                    ? 'Veuillez renseigner votre nom'
                    : null,
                ),
              ),
              Expanded( 
                child: _buildTextField( //name
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
          Row(
            children: [
              Expanded(
                child: _buildTextField( // Email
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
              ),
              Expanded( 
                child: _buildTextField( // Phone
                  controller: widget.phoneController,
                  labelText: 'Téléphone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    final onlyDigits = RegExp(r'^[0-9]+$');
                    return onlyDigits.hasMatch(value) ? null : 'Numéros uniquement';
                  }
                ),
              ),
            ],
          ),
          _buildTextField( // Message
            controller: widget.messageController,
            labelText: 'Message *',
            icon: Icons.message,
            maxLines: 6,
            validator: (value) =>
              value == null || value.isEmpty ? 'Veuillez écrire un message' : null,
          ),
          const SizedBox(height: 5.0),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              ) 
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator, // Validation function for the text field.
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: icon != null ? Icon(icon) : null, // Add an icon if provided.
          filled: true,
          fillColor: WidgetStateColor.resolveWith((states) { // Background color for the text field.
            if (states.contains(WidgetState.hovered)) { 
              return GlobalColors.secondColor.withValues(alpha: 0.03); // Color on hover
            }
            return GlobalColors.firstColor; // Normal color
          }),
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
