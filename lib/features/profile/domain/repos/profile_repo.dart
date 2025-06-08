import 'package:social_media_fullstack/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo{
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}