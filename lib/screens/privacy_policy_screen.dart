import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:tafweed/constants.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.terms_and_privacy),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              AppLocalizations.of(context)!.privacy_policy,
              style: TextStyle(
                color: mainColor,
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              AppLocalizations.of(context)!.personal_information,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.privacy_policy_description,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.contact_information,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.contact_information_description,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.information_protection_and_storage,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.information_protection_and_storage_description,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.general_terms,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.general_terms_description,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.terms_of_use,
              style: TextStyle(
                color: mainColor,
                fontSize: 26,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              AppLocalizations.of(context)!.terms_and_conditions,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.service_providers,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.app_management,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.service_description,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.service_description_content,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.nature_of_contract,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.nature_of_contract_content,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.payment_method,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.payment_method_content,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.cancellation,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.cancellation_content,
              style: TextStyle(),
            ),
            SizedBox(height: 20,),
            Text(
              AppLocalizations.of(context)!.compensation,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Divider(height: 20, color: Colors.grey[300],),
            Text(
              AppLocalizations.of(context)!.compensation_content,
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}