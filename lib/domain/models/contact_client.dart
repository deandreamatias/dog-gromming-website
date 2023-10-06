// ignore_for_file: public_member_api_docs, sort_constructors_first
class ContactClient {
  final String contactMethod;
  final String name;
  final String petName;
  final bool whatsappCheckbox;
  final String petSize;
  final String message;
  final bool privacyPolicyCheckbox;

  const ContactClient({
    required this.contactMethod,
    required this.name,
    this.petName = '',
    this.whatsappCheckbox = false,
    this.petSize = '',
    this.message = '',
    required this.privacyPolicyCheckbox,
  });

  @override
  String toString() {
    return '''ContactClient(contactMethod: $contactMethod, name: $name, petName: $petName, whatsappCheckbox: $whatsappCheckbox, petSize: $petSize, message: $message, privacyPolicyCheckbox: $privacyPolicyCheckbox)''';
  }
}
