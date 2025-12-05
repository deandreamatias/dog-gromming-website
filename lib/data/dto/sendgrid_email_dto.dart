import 'package:dog_gromming_website/data/dto/contact_client_dto.dart';

class SendgridDto {
  final SendgridEmail from;
  final List<SendgridPersonalization> personalizations;
  final String templateId;

  const SendgridDto({
    required this.from,
    required this.personalizations,
    required this.templateId,
  });

  Map<String, dynamic> toJson() => {
    'from': from.toJson(),
    'personalizations': personalizations.isEmpty
        ? []
        : personalizations.map((x) => x.toJson()).toList(),
    'template_id': templateId,
  };
}

class SendgridEmail {
  final String email;

  const SendgridEmail({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class SendgridPersonalization {
  final List<SendgridEmail> to;
  final ContactClientDto templateData;

  const SendgridPersonalization({required this.to, required this.templateData});

  Map<String, dynamic> toJson() => {
    'to': to.isEmpty ? [] : to.map((x) => x.toJson()).toList(),
    'dynamic_template_data': templateData.toJson(),
  };
}
