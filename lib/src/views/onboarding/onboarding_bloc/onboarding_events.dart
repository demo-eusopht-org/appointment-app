abstract class OnBoardingEvents {}

class CreateOnBoardEvent extends OnBoardingEvents {
  final String name;
  final String? profession;
  final String? completeAddress;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final String? location;
  final String? fees;
  final String? whatsappNote;
  final String? footNote;
  final String? userId;
  final String? startTime;
  final String? endTime;
  final String? images;

  CreateOnBoardEvent({
    required this.name,
    this.profession,
    this.completeAddress,
    this.phoneNumber,
    this.email,
    this.website,
    this.location,
    this.fees,
    this.whatsappNote,
    this.footNote,
    this.userId,
    this.startTime,
    this.endTime,
    this.images,
  });
}
