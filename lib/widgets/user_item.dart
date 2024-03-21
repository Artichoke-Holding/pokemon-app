import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/user.dart'; // Adjust the path to your User model

class UserListItem extends StatelessWidget {
  final User user;

  UserListItem({Key? key, required this.user}) : super(key: key);

  void showUserDetailDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      user.avatar ?? 'default_image_url',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${user.name?.first ?? 'N/A'} ${user.name?.last ?? 'N/A'}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  _buildDetailRow(
                    'Nickname',
                    '${user.name?.first ?? 'N/A'} ${user.name?.last ?? 'N/A'}',
                  ),
                  _buildDetailRow('Company', user.job?.company ?? 'N/A'),
                  _buildDetailRow('Email', user.firstEmail ?? 'N/A'),
                  _buildDetailRow('Location',
                      '${user.location?.country ?? 'N/A'}, ${user.location?.city ?? 'N/A'}'),
                  _buildDetailRow('Web', user.website ?? 'N/A'),
                  // Add more rows as needed
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void _makePhoneCall(String? fullPhoneNumber) async {
      if (fullPhoneNumber != null) {
        String phoneNumber = fullPhoneNumber.split(' x')[0];
        print(phoneNumber);
        if (await canLaunchUrl(Uri.parse('tel:$phoneNumber'))) {
          await launchUrl(Uri.parse('tel:$phoneNumber'));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cannot make a phone call to this number')),
          );
        }
      }
    }

    return InkWell(
        onTap: () {
          showUserDetailDialog(context, user);
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: user.avatar ?? 'default_image_url',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${user.name?.first ?? 'N/A'} ${user.name?.last ?? 'N/A'}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          InkWell(
                            onTap: () => _makePhoneCall(user.phoneNumber),
                            child: Icon(Icons.phone_enabled_outlined),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(user.job?.title ?? 'N/A',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          )),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text(user.location?.city ?? 'N/A'),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.email_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              user.firstEmail ?? 'N/A',
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
