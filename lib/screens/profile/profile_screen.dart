import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        title: Text("Profile", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/profile.png"),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("Change Profile Picture",
                            style: GoogleFonts.poppins())),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              const SizedBox(height: 16.0),
              Text("Profile Information",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0 / 1.5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Name",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                          flex: 5,
                          child: Text("Naruto Uzumaki",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: const Icon(Iconsax.arrow_right_34, size: 18)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0 / 1.5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Username",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                          flex: 5,
                          child: Text("naruto_uzumaki",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: const Icon(Iconsax.arrow_right_34, size: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              const SizedBox(height: 16.0),
              Text("Personal Information",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0 / 1.5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("User ID",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                          flex: 5,
                          child: Text("49761",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(child: const Icon(Iconsax.copy, size: 18)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0 / 1.5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Email",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                          flex: 5,
                          child: Text("naruto@gmail.com",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: const Icon(Iconsax.arrow_right_34, size: 18)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0 / 1.5),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("Phone Number",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      Expanded(
                          flex: 5,
                          child: Text("081294728192",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: const Icon(Iconsax.arrow_right_34, size: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            child: TextButton(
                              onPressed: () {
                                AuthenticationRepository.instance.logout();
                              },
                              child: Text("LOGOUT",
                                  style:
                                      GoogleFonts.poppins(color: Colors.white)),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
