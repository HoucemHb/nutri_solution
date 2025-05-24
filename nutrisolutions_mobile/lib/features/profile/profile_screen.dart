import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:nutrisolutions_mobile/core/constants/app_constants.dart';
import 'package:nutrisolutions_mobile/core/theme/app_colors.dart';
import 'package:nutrisolutions_mobile/core/utils/app_utils.dart';
import 'package:nutrisolutions_mobile/data/models/client_model.dart';
import 'package:nutrisolutions_mobile/data/providers/auth_provider.dart';
import 'package:nutrisolutions_mobile/data/providers/client_provider.dart';

final userIdProvider = FutureProvider<String?>((ref) async {
  return ref.read(authServiceProvider).getUserId();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ClientInfoItem> clientInfos;
    final userIdAsync = ref.watch(userIdProvider);

    return userIdAsync.when(
      data: (userId) {
        if (userId == null || userId.isEmpty) {
          return const Center(child: Text('User not found'));
        }

        final profileAsync = ref.watch(clientByIdProvider(userId));
        return profileAsync.when(
          data: (profile) => Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/profile-bg.png',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: AppColors.primaryColor),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: Image.network(
                                  width: 100,
                                  height: 100,
                                  AppApi.baseUrl + profile.profilePictureUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGray,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/images/edit.png',
                                        fit: BoxFit.contain,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          Text(
                            profile.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            'Client',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  children: [
                    PersonalInfo(profile: profile),
                    HealthInfo(profile: profile),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Recettes préférées',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: AppColors.brown),
                          ),
                          const Gap(10),
                          for (int i = 0;
                              i < profile.favoriteRecipes.length;
                              i++)
                            ListTile(
                              leading: ClipOval(
                                child: Image.network(
                                  width: 60,
                                  height: 60,
                                  AppApi.baseUrl +
                                      profile.favoriteRecipes[i].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(profile.favoriteRecipes[i].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.primaryColor,
                                      )),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stackTrace) => Center(
        child: Text('Error getting user ID: $error'),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class HealthInfo extends StatelessWidget {
  final ClientModel profile;
  const HealthInfo({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Données de Santé',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.brown),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset('assets/images/height.svg'),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Row(
                            children: [
                              const Text('Height'),
                              Text(
                                profile.height != null
                                    ? ' ${profile.height} cm'
                                    : ' N/A',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(20),
                    Stack(
                      children: [
                        SvgPicture.asset('assets/images/weight.svg'),
                        Positioned(
                            bottom: 10,
                            left: 10,
                            child: Row(
                              children: [
                                const Text('Weight',
                                    style: TextStyle(fontSize: 12)),
                                Text(
                                  profile.weight != null
                                      ? ' ${profile.weight} Kg'
                                      : ' N/A',
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                const Gap(10),
                Stack(
                  children: [
                    SvgPicture.asset('assets/images/bmi.svg'),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Body mass index (BMI)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                            const Gap(15),
                            Row(
                              children: [
                                Text(
                                  AppUtils.getBMI(
                                          profile.weight, profile.height)
                                      .toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppColors.white),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGray,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    AppUtils.getBMIStatus(
                                      AppUtils.getBMI(
                                          profile.weight, profile.height),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: AppColors.primaryColor,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Gap(10),
                Text(
                  'Upcoming Appointment',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: AppColors.brown),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: profile.reservedSlots.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                  '${DateFormat('MMM d, y').format(profile.reservedSlots[profile.reservedSlots.length - 1].date)} at ${profile.reservedSlots[profile.reservedSlots.length - 1].time}h'),
                            ),
                            if (profile.reservedSlots.isNotEmpty)
                              Text(profile
                                  .reservedSlots[
                                      profile.reservedSlots.length - 1]
                                  .nutritionistName),
                          ],
                        )
                      : Text(
                          'You have no upcoming appointments',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.brown,
                                  ),
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  final ClientModel profile;
  const PersonalInfo({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Personal Information',
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.brown),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(FontAwesomeIcons.user,
                      color: AppColors.primaryColor),
                  title: Text(profile.gender ?? 'N/A'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.cakeCandles,
                      color: AppColors.primaryColor),
                  title: Text('${profile.getClientAge()} years'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.envelope,
                      color: AppColors.primaryColor),
                  title: Text(profile.email ?? 'N/A'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.phone,
                      color: AppColors.primaryColor),
                  title: Text(profile.phoneNumber ?? 'N/A'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ClientInfoItem {
  final IconData icon;
  final String param;
  final String label;

  ClientInfoItem({
    required this.icon,
    required this.param,
    required this.label,
  });
}
