import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medi_deliver/core/constants.dart';
import 'package:medi_deliver/model/user.dart' as model;
import 'package:medi_deliver/provider/userProvider.dart';
import 'package:medi_deliver/screens/addressPage.dart';
import 'package:medi_deliver/screens/loginPage.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget buildBox(String imagePath, String label, Function() onPressed,
      {double imageWidth = 60,
      double imageHeight = 40,
      double topPadding = 0}) {
    Color boxColor = Colors.white;

    if (label == "Log Out") {
      // Set the color to red for the "Log out" box
      boxColor = Color.fromARGB(255, 251, 231, 230);
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color.fromARGB(255, 234, 234, 234),
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 1, bottom: 1),
        padding: EdgeInsets.only(top: topPadding, bottom: 15),
        decoration: BoxDecoration(
          color: boxColor,

          // border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: imageWidth, // Use the imageWidth parameter
              height: imageHeight,
            ),
            const SizedBox(
              width: 0,
            ),
            DefaultTextStyle(
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: label == "Log Out" ? Colors.red : Colors.black),
              child: Text(" $label",
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: fontFamilyString,
                  )),
            ),
            const Expanded(child: SizedBox()),
            label != "Log Out"
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 10,
                      color: Colors.grey,
                    ),
                    onPressed: onPressed,
                  )
                : const Icon(null),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    model.User? loggedInUser = Provider.of<UserProvider>(context).loggedInUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 40, height: 7),
                    Padding(
                      padding: EdgeInsets.only(top: 7, left: 8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border(
                                    left: BorderSide(
                                  color: buttonColor,
                                  width: 2,
                                )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CachedNetworkImage(
                                  imageUrl: loggedInUser!.profileImage,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 25,
                                    backgroundImage: imageProvider,
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                    color: buttonColor,
                                  ),
                                  errorWidget: (context, url, error) {
                                    return CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage(
                                          'asset/images/profile.png'),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loggedInUser.fullName ?? 'Geust',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: fontFamilyString,
                                    color: buttonColor,
                                  ),
                                ),
                                Text(
                                  loggedInUser.phoneNumber ?? '01068782526',
                                  style: const TextStyle(
                                      color: Colors.black12,
                                      fontFamily: fontFamilyString,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildBox(
                              "asset/images/favourite.png",
                              "Favorites",
                              () {},
                              imageWidth: 60,
                              imageHeight: 40,
                              topPadding: 5,
                            ),

                            // ElevatedButton(onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                            // },  child: Text('View Favorites')),
                            SizedBox(height: 10),
                            buildBox(
                              "asset/images/address.png",
                              "Profile",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddressPage()),
                                );
                              },
                              topPadding: 5,
                            ),

                            ///ElevatedButton(onPressed:(){
                            //    Navigator.push(context, MaterialPageRoute(builder: (context) => AddresScreen()))
                            // }, child: Text("Addres")),
                            SizedBox(height: 10),
                            buildBox(
                              "asset/images/wallet.png",
                              "Wallet",
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Scaffold()),
                                );
                              },
                              topPadding: 5,
                            ),
                            // ElevatedButton(onPressed:(){
                            //    Navigator.push(context, MaterialPageRoute(builder: (context) => WalletScreen()))
                            // }, child: Text("wallet")),
                            SizedBox(height: 10),
                            buildBox(
                              "asset/images/contact.png",
                              "Contact with us",
                              () {},
                              topPadding: 5,
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              },
                              child: buildBox(
                                "asset/images/logOut.png",
                                "Log Out",
                                () {},
                                topPadding: 5,
                              ),
                            )
                            // ),ElevatedButton(onPressed: (){
                            //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                            // }, child: Text("log out"))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
