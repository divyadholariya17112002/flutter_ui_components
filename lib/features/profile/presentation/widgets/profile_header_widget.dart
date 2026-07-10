import 'package:flutter/material.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: profile.avatarUrl != null
              ? NetworkImage(profile.avatarUrl!)
              : null,
          child: profile.avatarUrl == null
              ? const Icon(Icons.person, size: 48)
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          profile.fullName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          profile.email,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
