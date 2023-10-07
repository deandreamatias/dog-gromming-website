import 'package:dog_gromming_website/domain/models/contact_client.dart';

class ContactClientDto {
  final String contactMethod;
  final String name;
  final String petName;
  final bool whatsappCheckbox;
  final String petSize;
  final String message;

  const ContactClientDto({
    required this.contactMethod,
    required this.name,
    this.petName = '',
    this.whatsappCheckbox = false,
    this.petSize = '',
    this.message = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'contactMethod': contactMethod,
      'name': name,
      'petName': petName,
      'whatsappCheckbox': whatsappCheckbox,
      'petSize': petSize,
      'message': message,
    };
  }

  factory ContactClientDto.fromDomain(ContactClient contactClient) {
    return ContactClientDto(
      contactMethod: contactClient.contactMethod,
      name: contactClient.name,
      petName: contactClient.petName,
      whatsappCheckbox: contactClient.whatsappCheckbox,
      petSize: contactClient.petSize,
      message: contactClient.message,
    );
  }
}
