class ContactFormRequest {
  ContactFormRequest({
    this.requestType,
    required this.lastName,
    required this.firstName,
    required this.company,
    required this.email,
    required this.phone,
    this.typeWork,
    this.startDate,
    this.address,
    required this.message,
  });

  final String? requestType;
  final String lastName;
  final String firstName;
  final String company;
  final String email;
  final String phone;
  final List<String>? typeWork;
  final String? startDate;
  final String? address;
  final String message;

  Map<String, dynamic> toJson() {
    return {
      if (requestType != null) 'requestType': requestType,
      'lastName': lastName,
      'firstName': firstName,
      'company': company,
      'email': email,
      'phone': phone,
      if (typeWork != null) 'typeWork': typeWork,
      if (startDate != null) 'startDate': startDate,
      if (address != null) 'address': address,
      'message': message,
    };
  }
}
