// Customer contact form with dropdown, type work options, circle progress bar inside button submit
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../components/my_hover_route_navigator.dart';
import '../utils/global_colors.dart';
import '../utils/global_others.dart';
import '../utils/global_screen_sizes.dart';

class CustomerContactForm extends StatefulWidget {
  const CustomerContactForm({
    super.key,
    required this.formKey,
    required this.requestTypeController,
    required this.lastNameController,
    required this.firstNameController,
    required this.companyController,
    required this.emailController,
    required this.phoneController,
    required this.typeWork,
    required this.showTypeWorkError,
    required this.startDateController,
    required this.addressController,
    required this.messageController,
    required this.isSending,
    required this.hasAcceptedConditions,
    required this.showConsentError,
    required this.onAcceptConditionsChanged,
    required this.sendEmail,

  });
  
  final GlobalKey<FormState> formKey;
  final TextEditingController requestTypeController;
  final TextEditingController lastNameController;
  final TextEditingController firstNameController;
  final TextEditingController companyController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final ValueNotifier<List<String>> typeWork; // A reactive list that holds the types of work selected by the user. Updated when they interact with the FilterChips and observed for changes during form submission.
  final bool showTypeWorkError;
  final TextEditingController startDateController;
  final TextEditingController addressController;
  final TextEditingController messageController;
  final bool isSending;
  final bool hasAcceptedConditions;
  final bool showConsentError;
  final ValueChanged<bool> onAcceptConditionsChanged;
  final VoidCallback sendEmail;

  @override  
  CustomerContactFormState createState() => CustomerContactFormState();
}

class CustomerContactFormState extends State<CustomerContactForm> {
  // Triggered whenever the text in requestTypeController changes
  late final VoidCallback _updateRequestTypeOnClick;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
   _updateRequestTypeOnClick = () => setState(() {}); // Initialize the callback to call setState(), forcing the widget to rebuild
    widget.requestTypeController.addListener(_updateRequestTypeOnClick); // Register the listener on the controller to observe text updates
  }

  @override
  void dispose() {
    widget.requestTypeController.removeListener(_updateRequestTypeOnClick); // Remove listener to prevent memory leaks
    super.dispose();
  }

  final List<String> _typeWorkOptions = [
    'Rénovation totale',
    'Murs (revêtements, peinture...)',
    'Menuiseries (placards, cuisine...)',
    'Électricité',
    'Sols (parquet, moquette, carrelage...)',
    'Maçonnerie, cloisons, isolation',
    'Plomberie, chauffage',
    'Autre',
  ];

  final List<String> items = [
    'Projet de rénovation (devis, estimations...)',
    'Questions sur nos prestations',
    'Autre',
  ];

  @override
  Widget build(BuildContext context) {
  bool mobile = GlobalScreenSizes.isMobileScreen(context);

    return Form(
      key: widget.formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Type of request
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: _buildDropdownDecoration('Votre demande concerne ... *'),
              value: widget.requestTypeController.text.isEmpty ? null : widget.requestTypeController.text,
              items: items.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14.0),
                )
              )).toList(),
              onChanged: (value) {
                widget.requestTypeController.text = value ?? '';
              },
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) => value == null 
                ? 'Veuillez sélectionner une option' 
                : null,
            ),
          ),
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
                )
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
                      return 'Veuillez saisir une adresse e-mail';
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
                    return onlyDigits.hasMatch(value) ? null : 'Format invalide, veuillez saisir des chiffres uniquement';
                  }
                ),
              ),
            ],
          ),
          // Added if the resquest is a renovaiton project
          if (widget.requestTypeController.text == 'Projet de rénovation (devis, estimations...)') ...[
            SizedBox(height: 30.0),
            SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Nature des travaux *',
                      style: TextStyle(
                        color: GlobalColors.secondColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: _typeWorkOptions.map((label) { //  For each label in the list of available work options (_typeWorkOptions), we map it into a FilterChip widget
                      final selected = widget.typeWork.value.contains(label); // Check if the current label is part of the selected options
                      return FilterChip(
                        label: Text(label),
                        selected: selected, // Whether the chip appears selected (highlighted)
                        onSelected: (value) { // When the chip is tapped
                          final newList = [...widget.typeWork.value]; // Create a new list
                          value ? newList.add(label) : newList.remove(label); // If tapped to select, add it; if tapped to deselect, remove it
                          setState(() => widget.typeWork.value = newList); // Update 
                        },
                        selectedColor: GlobalColors.orangeColor.withValues(alpha: 0.2),
                        checkmarkColor: GlobalColors.orangeColor,
                      );
                    }).toList(),
                  ),
                  if (widget.showTypeWorkError) ...[ // OPTIONNELLE 
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Veuillez choisir au moins une option pour mieux comprendre votre demande',
                        style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                  ],
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            _buildTextField(
              controller: widget.startDateController,
              labelText: 'Date ou période de démarrage souhaitée *',
              icon: Icons.calendar_month,
              validator: (value) => value == null || value.isEmpty 
                ? 'Veuillez renseigner ce champ' 
                : null,
            ),
            _buildTextField(
              controller: widget.addressController,
              labelText: 'Localisation du projet *',
              icon: Icons.location_on,
              validator: (value) => value == null || value.isEmpty 
                ? 'Ce champ est requis' 
                : null,
            ),
            SizedBox(height: 30.0),
          ],
           // Message
          _buildTextField(
            controller: widget.messageController,
            labelText: 'Message *',
            icon: Icons.message,
            maxLines: 6,
            validator: (value) => value == null || value.isEmpty 
              ? 'Veuillez saisir votre message' 
              : null,
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              '*Ces champs sont obligatoires',
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          // Checkbox
          CheckboxListTile(
            value: widget.hasAcceptedConditions,
            onChanged: widget.isSending
                ? null  // disabled during sending
                : (value) {
                  widget.onAcceptConditionsChanged(value ?? false);
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
                  fontSize: 13,
                ),
              ),
            ),
          
          const SizedBox(height: 20.0),
          if (widget.isSending)
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
            )
          else 
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
          const SizedBox(height: 5.0),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: mobile ? GlobalSize.mobileItalicText : GlobalSize.webItalicText,
                color: GlobalColors.fiveColor,
              ),
              children: [
                TextSpan(
                  text: '*Les informations que vous nous communiquez via ce formulaire font l’objet d’un traitement informatique, destiné exclusivement à SiO 2 Rénovations, dans le but de gérer vos demandes et d’assurer le suivi de notre relation. Elles sont accessibles uniquement par nos équipes internes habilitées et, si nécessaire, par nos prestataires techniques, dans le respect strict de la confidentialité.'
                  'Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez à tout moment d’un droit d’accès, de rectification, de suppression ou de limitation du traitement de vos données. Vous pouvez également exercer votre droit à la portabilité, ainsi que définir des directives relatives à leur conservation post-mortem.'
                  'Vos données sont conservées pendant une durée maximale de trois ans à compter du dernier échange. Pour exercer vos droits, contactez-nous à l’adresse suivante : contact@sio2renovations.com. En cas de désaccord non résolu, vous avez également la possibilité de saisir la CNIL.'
                  'Pour en savoir plus, consultez notre '
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  child: MyHoverRouteNavigator(
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

  InputDecoration _buildDropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: GlobalColors.firstColor,
      labelStyle: TextStyle(color: GlobalColors.secondColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: GlobalColors.secondColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

}




// // Customer contact form with dropdown, type work options and circular progress indicator outside button of button "SUBMIT" 
// import 'package:flutter/material.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import '../components/my_hover_route_navigator.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_screen_sizes.dart';

// class CustomerContactForm extends StatefulWidget {
//   const CustomerContactForm({
//     super.key,
//     required this.formKey,
//     required this.requestTypeController,
//     required this.lastNameController,
//     required this.firstNameController,
//     required this.companyController,
//     required this.emailController,
//     required this.phoneController,
//     required this.typeWork,
//     required this.showTypeWorkError,
//     required this.startDateController,
//     required this.addressController,
//     required this.messageController,
//     required this.isSending,
//     required this.sendEmail,

//   });
  
//   final GlobalKey<FormState> formKey;
//   final TextEditingController requestTypeController;
//   final TextEditingController lastNameController;
//   final TextEditingController firstNameController;
//   final TextEditingController companyController;
//   final TextEditingController emailController;
//   final TextEditingController phoneController;
//   final ValueNotifier<List<String>> typeWork; // A reactive list that holds the types of work selected by the user. Updated when they interact with the FilterChips and observed for changes during form submission.
//   final bool showTypeWorkError;
//   final TextEditingController startDateController;
//   final TextEditingController addressController;
//   final TextEditingController messageController;
//   final bool isSending;
//   final VoidCallback sendEmail;

//   @override  
//   CustomerContactFormState createState() => CustomerContactFormState();
// }

// class CustomerContactFormState extends State<CustomerContactForm> {
//   // Triggered whenever the text in requestTypeController changes
//   late final VoidCallback _updateRequestTypeOnClick;
//   bool _isHovered = false;

//   @override
//   void initState() {
//     super.initState();
//    _updateRequestTypeOnClick = () => setState(() {}); // Initialize the callback to call setState(), forcing the widget to rebuild
//     widget.requestTypeController.addListener(_updateRequestTypeOnClick); // Register the listener on the controller to observe text updates
//   }

//   @override
//   void dispose() {
//     widget.requestTypeController.removeListener(_updateRequestTypeOnClick); // Remove listener to prevent memory leaks
//     super.dispose();
//   }

//   final List<String> _typeWorkOptions = [
//     'Rénovation totale',
//     'Murs (revêtements, peinture...)',
//     'Menuiseries (placards, cuisine...)',
//     'Électricité',
//     'Sols (parquet, moquette, carrelage...)',
//     'Maçonnerie, cloisons, isolation',
//     'Plomberie, chauffage',
//     'Autre',
//   ];

//   final List<String> items = [
//     'Projet de rénovation (devis, estimations...)',
//     'Questions sur nos prestations',
//     'Autre',
//   ];

//   @override
//   Widget build(BuildContext context) {
//   bool mobile = GlobalScreenSizes.isMobileScreen(context);

//     return Form(
//       key: widget.formKey,
//       child: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           // Type of request
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: DropdownButtonFormField2<String>(
//               isExpanded: true,
//               decoration: _buildDropdownDecoration('Votre demande concerne ... *'),
//               value: widget.requestTypeController.text.isEmpty ? null : widget.requestTypeController.text,
//               items: items.map((item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: const TextStyle(fontSize: 14.0),
//                 )
//               )).toList(),
//               onChanged: (value) {
//                 widget.requestTypeController.text = value ?? '';
//               },
//               dropdownStyleData: DropdownStyleData(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               validator: (value) => value == null 
//                 ? 'Veuillez sélectionner une option' 
//                 : null,
//             ),
//           ),
//           // Full name
//           Row(
//             children: [
//               Expanded( 
//                 child: _buildTextField( // Lastname
//                   controller: widget.lastNameController,
//                   labelText: 'Nom *',
//                   icon: Icons.person_outline,
//                   validator: (value) => value == null || value.isEmpty
//                     ? 'Veuillez renseigner votre nom'
//                     : null,
//                 ),
//               ),
//               Expanded( 
//                 child: _buildTextField( //name
//                   controller: widget.firstNameController,
//                   labelText: 'Prénom',
//                   icon: Icons.person,
//                   validator: (value) => null,
//                 )
//               ),
//             ],
//           ),
//           // Company name
//           _buildTextField( 
//             controller: widget.companyController,
//             labelText: 'Société',
//             icon: Icons.business,
//             validator: (value) => null,
//           ),
//           // The coordinates
//           Row(
//             children: [
//               Expanded(
//                 child: _buildTextField( // Email
//                   controller: widget.emailController,
//                   labelText: 'E-mail *',
//                   keyboardType: TextInputType.emailAddress,
//                   icon: Icons.email,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez saisir une adresse e-mail';
//                     }
//                     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                     return emailRegex.hasMatch(value) ? null : 'Format d’email invalide';
//                   },
//                 ),
//               ),
//               Expanded( 
//                 child: _buildTextField( // Phone
//                   controller: widget.phoneController,
//                   labelText: 'Téléphone',
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return null;
//                     final onlyDigits = RegExp(r'^[0-9]+$');
//                     return onlyDigits.hasMatch(value) ? null : 'Format invalide, veuillez saisir des chiffres uniquement';
//                   }
//                 ),
//               ),
//             ],
//           ),
//           // Added if the resquest is a renovaiton project
//           if (widget.requestTypeController.text == 'Projet de rénovation (devis, estimations...)') ...[
//             SizedBox(height: 30.0),
//             SizedBox(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       'Nature des travaux *',
//                       style: TextStyle(
//                         color: GlobalColors.secondColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5.0),
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 8,
//                     children: _typeWorkOptions.map((label) { //  For each label in the list of available work options (_typeWorkOptions), we map it into a FilterChip widget
//                       final selected = widget.typeWork.value.contains(label); // Check if the current label is part of the selected options
//                       return FilterChip(
//                         label: Text(label),
//                         selected: selected, // Whether the chip appears selected (highlighted)
//                         onSelected: (value) { // When the chip is tapped
//                           final newList = [...widget.typeWork.value]; // Create a new list
//                           value ? newList.add(label) : newList.remove(label); // If tapped to select, add it; if tapped to deselect, remove it
//                           setState(() => widget.typeWork.value = newList); // Update 
//                         },
//                         selectedColor: GlobalColors.orangeColor.withValues(alpha: 0.2),
//                         checkmarkColor: GlobalColors.orangeColor,
//                       );
//                     }).toList(),
//                   ),
//                   if (widget.showTypeWorkError) ...[ // OPTIONNELLE 
//                     const SizedBox(height: 6),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         'Veuillez choisir au moins une option pour mieux comprendre votre demande',
//                         style: TextStyle(
//                           color: Colors.red[900],
//                           fontSize: 13,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6.0),
//                   ],
//                   SizedBox(height: 15.0),
//                 ],
//               ),
//             ),
//             _buildTextField(
//               controller: widget.startDateController,
//               labelText: 'Date ou période de démarrage souhaitée *',
//               icon: Icons.calendar_month,
//               validator: (value) => value == null || value.isEmpty 
//                 ? 'Veuillez renseigner ce champ' 
//                 : null,
//             ),
//             _buildTextField(
//               controller: widget.addressController,
//               labelText: 'Localisation du projet *',
//               icon: Icons.location_on,
//               validator: (value) => value == null || value.isEmpty 
//                 ? 'Ce champ est requis' 
//                 : null,
//             ),
//             SizedBox(height: 30.0),
//           ],
//            // Message
//           _buildTextField(
//             controller: widget.messageController,
//             labelText: 'Message *',
//             icon: Icons.message,
//             maxLines: 6,
//             validator: (value) => value == null || value.isEmpty 
//               ? 'Veuillez saisir votre message' 
//               : null,
//           ),
//           const SizedBox(height: 5.0),
//           Text(
//             '* Ces champs sont obligatoires',
//             style: TextStyle(
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           const SizedBox(height: 24.0),
//           if (widget.isSending) ...[
//             const Center(
//               child: CircularProgressIndicator(
//                 color: GlobalColors.orangeColor,
//               )
//             ), // Show a loading indicator if the email is being sent.
//             const SizedBox(height: 30.0),
//           ] else ...[
//             Align( // Prevents the button from taking the full horizontal width of the ListView.
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: MouseRegion( 
//                   onEnter: (_) => setState(() => _isHovered = true),
//                   onExit: (_) => setState(() => _isHovered = false),
//                   child: SizedBox( // Button 
//                     width: 200.0,
//                     height: 48.0,
//                     child: ElevatedButton(
//                       onPressed: widget.sendEmail,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.send, color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ),
//                           const SizedBox(width: 8),
//                           Text(
//                             'ENVOYER',
//                             style: TextStyle(
//                               color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 )
//               ) 
//             ),
//           ],
//           const SizedBox(height: 5.0),
//           RichText(
//             text: TextSpan(
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: mobile ? GlobalSize.mobileItalicText : GlobalSize.webItalicText,
//                 color: GlobalColors.fiveColor,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Les informations que vous nous communiquez via ce formulaire font l’objet d’un traitement informatique, destiné exclusivement à SiO 2 Rénovations, dans le but de gérer vos demandes et d’assurer le suivi de notre relation. Elles sont accessibles uniquement par nos équipes internes habilitées et, si nécessaire, par nos prestataires techniques, dans le respect strict de la confidentialité.'
//                   'Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez à tout moment d’un droit d’accès, de rectification, de suppression ou de limitation du traitement de vos données. Vous pouvez également exercer votre droit à la portabilité, ainsi que définir des directives relatives à leur conservation post-mortem.'
//                   'Vos données sont conservées pendant une durée maximale de trois ans à compter du dernier échange. Pour exercer vos droits, contactez-nous à l’adresse suivante : contact@sio2renovations.com. En cas de désaccord non résolu, vous avez également la possibilité de saisir la CNIL.'
//                   'Pour en savoir plus, consultez notre '
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                   ),
//                   child: MyHoverRouteNavigator(
//                     routeName: '/privacyPolicy', 
//                     text: 'Politique de confidentialité',
//                     mobile: mobile,
//                     color: GlobalColors.orangeColor.withValues(alpha: 0.5),
//                     hoverColor: GlobalColors.secondColor.withValues(alpha: 0.5),
//                     mobileSize: GlobalSize.mobileItalicText,
//                     webSize: GlobalSize.webItalicText,
//                     italic: true,
//                   ) 
//                 )
//               ]
//             )
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String labelText,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     IconData? icon,
//   }) {

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         validator: validator, // Validation function for the text field.
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: icon != null ? Icon(icon) : null, // Add an icon if provided.
//           filled: true,
//           fillColor: WidgetStateColor.resolveWith((states) { // Background color for the text field.
//             if (states.contains(WidgetState.hovered)) { 
//               return GlobalColors.secondColor.withValues(alpha: 0.03); // Color on hover
//             }
//             return GlobalColors.firstColor; // Normal color
//           }),
//           labelStyle: TextStyle(color: GlobalColors.secondColor), // Style for the label text.
//           enabledBorder: OutlineInputBorder( // Style of the border
//             borderSide: BorderSide(color: Colors.transparent),
//             borderRadius: BorderRadius.circular(8.0),      
//           ),
//           focusedBorder: OutlineInputBorder( // Style of the border when focused.
//             borderSide: BorderSide(color: GlobalColors.secondColor), 
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _buildDropdownDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: GlobalColors.firstColor,
//       labelStyle: TextStyle(color: GlobalColors.secondColor),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.transparent),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: GlobalColors.secondColor),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//     );
//   }

// }





// // Simple customer contact form (without any option)
// import 'package:flutter/material.dart';
// import 'package:sio2_renovations_frontend/components/my_hover_route_navigator.dart';
// import '../utils/global_colors.dart';
// import '../utils/global_others.dart';
// import '../utils/global_screen_sizes.dart';

// class CustomerContactForm extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   final TextEditingController firstNameController;
//   final TextEditingController lastNameController;
//   final TextEditingController emailController;
//   final TextEditingController phoneController;
//   final TextEditingController companyController;
//   final TextEditingController messageController;
//   final bool isSending;
//   final VoidCallback sendEmail;

//   const CustomerContactForm({
//     super.key,
//     required this.formKey,
//     required this.firstNameController,
//     required this.lastNameController,
//     required this.emailController,
//     required this.phoneController,
//     required this.companyController,
//     required this.messageController,
//     required this.isSending,
//     required this.sendEmail,
//   });

//   @override  
//   CustomerContactFormState createState() => CustomerContactFormState();
// }

// class CustomerContactFormState extends State<CustomerContactForm> {
//  bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//   bool mobile = GlobalScreenSizes.isMobileScreen(context);

//     return Form(
//       key: widget.formKey,
//       child: ListView(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           Row(
//             children: [
//               Expanded( 
//                 child: _buildTextField( // Lastname
//                   controller: widget.lastNameController,
//                   labelText: 'Nom *',
//                   icon: Icons.person_outline,
//                   validator: (value) => value == null || value.isEmpty
//                     ? 'Veuillez renseigner votre nom'
//                     : null,
//                 ),
//               ),
//               Expanded( 
//                 child: _buildTextField( //name
//                   controller: widget.firstNameController,
//                   labelText: 'Prénom *',
//                   icon: Icons.person,
//                   validator: (value) => value == null || value.isEmpty
//                     ? 'Veuillez renseigner votre prénom'
//                     : null,
//                 ),
//               ),
//             ],
//           ),
//           _buildTextField( // Company name
//             controller: widget.companyController,
//             labelText: 'Société',
//             icon: Icons.business,
//             validator: (value) => null,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: _buildTextField( // Email
//                   controller: widget.emailController,
//                   labelText: 'E-mail *',
//                   keyboardType: TextInputType.emailAddress,
//                   icon: Icons.email,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Veuillez entrer un e-mail valide';
//                     }
//                     final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//                     return emailRegex.hasMatch(value) ? null : 'Format d’email invalide';
//                   },
//                 ),
//               ),
//               Expanded( 
//                 child: _buildTextField( // Phone
//                   controller: widget.phoneController,
//                   labelText: 'Téléphone',
//                   icon: Icons.phone,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) return null;
//                     final onlyDigits = RegExp(r'^[0-9]+$');
//                     return onlyDigits.hasMatch(value) ? null : 'Numéros uniquement';
//                   }
//                 ),
//               ),
//             ],
//           ),
//           _buildTextField( // Message
//             controller: widget.messageController,
//             labelText: 'Message *',
//             icon: Icons.message,
//             maxLines: 6,
//             validator: (value) =>
//               value == null || value.isEmpty ? 'Veuillez écrire un message' : null,
//           ),
//           const SizedBox(height: 5.0),
//           Text(
//             '* Obligatoire',
//             style: TextStyle(
//               fontStyle: FontStyle.italic,
//             ),
//           ),
//           const SizedBox(height: 24.0),
//           widget.isSending
//           ? const Center(child: CircularProgressIndicator()) // Show a loading indicator if the email is being sent.
//           : Align( // Prevents the button from taking the full horizontal width of the ListView.
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: MouseRegion( 
//                 onEnter: (_) => setState(() => _isHovered = true),
//                 onExit: (_) => setState(() => _isHovered = false),
//                 child: SizedBox( // Button 
//                   width: 200.0,
//                   height: 48.0,
//                   child: ElevatedButton(
//                     onPressed: widget.sendEmail,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isHovered ? GlobalColors.thirdColor : GlobalColors.firstColor ,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.send, color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ),
//                         const SizedBox(width: 8),
//                         Text(
//                           'ENVOYER',
//                           style: TextStyle(
//                             color: _isHovered ? GlobalColors.firstColor : GlobalColors.secondColor ,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               )
//             ) 
//           ),
//           const SizedBox(height: 5.0),
//           RichText(
//             text: TextSpan(
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 fontSize: mobile ? GlobalSize.mobileItalicText : GlobalSize.webItalicText,
//                 color: GlobalColors.fiveColor,
//               ),
//               children: [
//                 TextSpan(
//                   text: 'Les informations que vous nous communiquez via ce formulaire font l’objet d’un traitement informatique, destiné exclusivement à SiO 2 Rénovations, dans le but de gérer vos demandes et d’assurer le suivi de notre relation. Elles sont accessibles uniquement par nos équipes internes habilitées et, si nécessaire, par nos prestataires techniques, dans le respect strict de la confidentialité.'
//                   'Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez à tout moment d’un droit d’accès, de rectification, de suppression ou de limitation du traitement de vos données. Vous pouvez également exercer votre droit à la portabilité, ainsi que définir des directives relatives à leur conservation post-mortem.'
//                   'Vos données sont conservées pendant une durée maximale de trois ans à compter du dernier échange. Pour exercer vos droits, contactez-nous à l’adresse suivante : contact@sio2renovations.com. En cas de désaccord non résolu, vous avez également la possibilité de saisir la CNIL.'
//                   'Pour en savoir plus, consultez notre '
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                   ),
//                   child: MyHoverRouteNavigator(
//                     routeName: '/privacyPolicy', 
//                     text: 'Politique de confidentialité',
//                     mobile: mobile,
//                     color: GlobalColors.orangeColor.withValues(alpha: 0.5),
//                     mobileSize: GlobalSize.mobileItalicText,
//                     webSize: GlobalSize.webItalicText,
//                     italic: true,
//                   ) 
//                 )
//               ]
//             )
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String labelText,
//     required String? Function(String?) validator,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     IconData? icon,
//   }) {

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         validator: validator, // Validation function for the text field.
//         decoration: InputDecoration(
//           labelText: labelText,
//           prefixIcon: icon != null ? Icon(icon) : null, // Add an icon if provided.
//           filled: true,
//           fillColor: WidgetStateColor.resolveWith((states) { // Background color for the text field.
//             if (states.contains(WidgetState.hovered)) { 
//               return GlobalColors.secondColor.withValues(alpha: 0.03); // Color on hover
//             }
//             return GlobalColors.firstColor; // Normal color
//           }),
//           labelStyle: TextStyle(color: GlobalColors.secondColor), // Style for the label text.
//           enabledBorder: OutlineInputBorder( // Style of the border
//             borderSide: BorderSide(color: Colors.transparent),
//             borderRadius: BorderRadius.circular(8.0),      
//           ),
//           focusedBorder: OutlineInputBorder( // Style of the border when focused.
//             borderSide: BorderSide(color: GlobalColors.secondColor), 
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
