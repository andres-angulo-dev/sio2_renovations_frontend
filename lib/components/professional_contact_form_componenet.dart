import 'package:flutter/material.dart';
import '../widgets/my_hover_route_navigator_widget.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class ProfessionalContactFormComponent extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController companyController;
  final TextEditingController messageController;
  final bool isSending;
  final bool hasAcceptedConditions;
  final bool showConsentError;
  final ValueChanged<bool> onAcceptConditionsChanged;
  final VoidCallback sendEmail;

  const ProfessionalContactFormComponent({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.companyController,
    required this.messageController,
    required this.isSending,
    required this.hasAcceptedConditions,
    required this.onAcceptConditionsChanged,
    required this.showConsentError,
    required this.sendEmail,
  });

  @override  
  ProfessionalContactFormComponentState createState() => ProfessionalContactFormComponentState();
}

class ProfessionalContactFormComponentState extends State<ProfessionalContactFormComponent> {
 bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
  bool mobile = GlobalScreenSizes.isMobileScreen(context);

    return Form(
      key: widget.formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Full name
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
                  labelText: 'Prénom',
                  icon: Icons.person,
                  validator: (value) => null,
                ),
              ),
            ],
          ),
          // Company name
          _buildTextField( 
            controller: widget.companyController,
            labelText: 'Société',
            icon: Icons.business,
            validator: (value) => null,
          ),
          // The coordinates
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
          // Message
          _buildTextField(
            controller: widget.messageController,
            labelText: 'Message *',
            icon: Icons.message,
            maxLines: 6,
            validator: (value) =>
              value == null || value.isEmpty ? 'Veuillez saisir votre message' : null,
          ),
          const SizedBox(height: 5.0),
          Text(
            '*Ces champs sont obligatoires',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24.0),
          // Checkbox conditions
          CheckboxListTile(
            value: widget.hasAcceptedConditions,
            onChanged: widget.isSending
                ? null  // Disabled during sending
                : (value) {
                  widget.onAcceptConditionsChanged(value ??  false);
                },
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: GlobalColors.orangeColor,
            title: Text(
              'En soumettant ce formulaire, je consens aux conditions de collecte et d’utilisation des données*',
              style: TextStyle(
                color: GlobalColors.secondColor,
                fontSize: mobile ? GlobalSize.mobileItalicText : GlobalSize.webItalicText,
              ),
            ),
          ),
          if (widget.showConsentError)
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              'Veuillez accepter les conditions avant de continuer.',
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          // Button circular progress indicator + "SENDING..."
          if (widget.isSending)
          Row(
            children: [
              Align( // Prevents the button from taking the full horizontal width of the ListView
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
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalColors.dividerColor1 ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 16.0,
                              height: 16.0,
                              child: CircularProgressIndicator(
                                color: GlobalColors.orangeColor,
                              )
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'ENVOI...',
                              style: TextStyle(
                                color: GlobalColors.secondColor ,
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
              const SizedBox(width: 10.0),
              // Icon captcha
              Container(
                width: 45.0,
                height: 45.0,
                padding: EdgeInsets.all(7.0),
                color: GlobalColors.firstColor,
                child: Image.asset(
                  GlobalImages.iconCaptcha,
                  semanticLabel: 'Captcha security icon',
                ) 
              )
            ],
          )
          // Button "SEND"
          else 
          Row(
            children: [
              Align( // Prevents the button from taking the full horizontal width of the ListView.
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
                        onPressed: widget.sendEmail,
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
              const SizedBox(width: 10.0),
              // Icon captcha
              Container(
                width: 45.0,
                height: 45.0,
                padding: EdgeInsets.all(7.0),
                color: GlobalColors.firstColor,
                child: Image.asset(
                  GlobalImages.iconCaptcha,
                  semanticLabel: 'Captcha security icon',
                ) 
              )
            ],
          ),
          const SizedBox(height: 5.0),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: mobile ? GlobalSize.mobileItalicText : GlobalSize.webItalicText,
                color: GlobalColors.fifthColor,
              ),
              children: [
                TextSpan(
                  text: '*Les informations que vous nous communiquez via ce formulaire font l’objet d’un traitement informatique, destiné exclusivement à ${GlobalPersonalData.companyName}, dans le but de gérer vos demandes et d’assurer le suivi de notre relation. Elles sont accessibles uniquement par nos équipes internes habilitées et, si nécessaire, par nos prestataires techniques, dans le respect strict de la confidentialité. '
                  'Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez à tout moment d’un droit d’accès, de rectification, de suppression ou de limitation du traitement de vos données. Vous pouvez également exercer votre droit à la portabilité, ainsi que définir des directives relatives à leur conservation post-mortem. '
                  'Vos données sont conservées pendant une durée maximale de trois ans à compter du dernier échange. Pour exercer vos droits, contactez-nous à l’adresse suivante : ${GlobalPersonalData.email}. En cas de désaccord non résolu, vous avez également la possibilité de saisir la CNIL. '
                  'Pour en savoir plus, consultez notre '
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  child: MyHoverRouteNavigatorWidget(
                    routeName: '/privacyPolicy', 
                    text: 'Politique de confidentialité',
                    mobile: mobile,
                    color: GlobalColors.orangeColor.withValues(alpha: 0.5),
                    hoverColor: GlobalColors.secondColor.withValues(alpha: 0.5),
                    mobileSize: GlobalSize.mobileItalicText,
                    webSize: GlobalSize.webItalicText,
                    italic: true,
                  ) 
                )
              ]
            )
          )
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
