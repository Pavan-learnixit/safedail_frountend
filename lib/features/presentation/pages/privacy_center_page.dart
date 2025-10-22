import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/privacy_bloc.dart';

class PrivacyCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrivacyBloc()..add(LoadPrivacySettings()),
      child: Scaffold(
        appBar: AppBar(title: Text('Privacy Center')),
        body: BlocBuilder<PrivacyBloc, PrivacyState>(
          builder: (context, state) {
            if (state.settings.isNotEmpty) {
              return ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildSwitchTile(
                    context,
                    key: 'availability',
                    title: 'Availability',
                    subtitle: 'Show others you’re busy during calls',
                    value: state.settings['availability'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'profile_notifications',
                    title: 'Profile View Notifications',
                    subtitle: 'Get notified when someone views your profile',
                    value: state.settings['profile_notifications'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'view_privately',
                    title: 'View Profiles Privately',
                    subtitle: 'Don’t notify others when you view their profile',
                    value: state.settings['view_privately'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'search_privately',
                    title: 'Search Profiles Privately',
                    subtitle: 'Don’t notify others when you search their profile',
                    value: state.settings['search_privately'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'ad_personalization',
                    title: 'Control How Ads Appear to You',
                    subtitle: 'Use profile and device data to personalize ads',
                    value: state.settings['ad_personalization'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'share_fraud',
                    title: 'Share Fraud Messages Automatically',
                    subtitle: 'Help protect others by sharing detected fraud messages',
                    value: state.settings['share_fraud'] ?? false,
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'social_graph',
                    title: 'Social Graph',
                    subtitle: 'Analyze call patterns to improve spam detection',
                    value: state.settings['social_graph'] ?? false,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/privacyInfo');
                    },
                    child: Text('More Information'),
                  ),
                  _buildSwitchTile(
                    context,
                    key: 'verified business call logs',
                    title: 'verified business call logs',
                    subtitle: 'Share call log of verified business call I receive with such verified business for its internal analytics purposes. ',
                    value: state.settings['verified business call logs'] ?? false,
                  ),
                  ListTile(
                    leading: Icon(Icons.manage_accounts),
                    title: Text('Manage My Data'),
                    onTap: () => Navigator.pushNamed(context, '/manageData'),
                  ),
                  ListTile(
                    leading: Icon(Icons.download),
                    title: Text('Download My Profile Data'),
                    onTap: () => Navigator.pushNamed(context, '/downloadData'),
                  ),
                  ListTile(
                    leading: Icon(Icons.comment),
                    title: Text('Manage Comments'),
                    onTap: () => Navigator.pushNamed(context, '/manageComments'),
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Rectify My Data'),
                    onTap: () => Navigator.pushNamed(context, '/rectifyData'),
                  ),
                  ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('Authorised Apps'),
                    onTap: () => Navigator.pushNamed(context, '/authorizedApps'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Change My Phone Number'),
                    onTap: () => Navigator.pushNamed(context, '/changePhone'),
                  ),
                  ListTile(
                    leading: Icon(Icons.delete_forever),
                    title: Text('Deactivate My Account'),
                    onTap: () => Navigator.pushNamed(context, '/deactivateAccount'),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text('Privacy Policy'),
                    onTap: () => Navigator.pushNamed(context, '/privacyPolicy'),
                  ),
                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text('Publication Certificate'),
                    onTap: () => Navigator.pushNamed(context, '/publicationCertificate'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Changes may take some time to be applied.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
      BuildContext context, {
        required String key,
        required String title,
        required String subtitle,
        required bool value,
      }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (newValue) {
        context.read<PrivacyBloc>().add(TogglePrivacySetting(key, newValue));
      },
    );
  }
}
