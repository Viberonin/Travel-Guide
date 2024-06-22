import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelguide/controllers/user/user_controller.dart';
import 'package:travelguide/repositories/authentication/auth_repo.dart';
import 'package:travelguide/widgets/shimmers/shimmer.dart';
import 'package:travelguide/widgets/images/circular_image.dart';
import 'package:travelguide/constants/image_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController()); 
    final controller = UserController.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left)),
        title: Text("Profile",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
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
                    Obx(
                      () {
                        final networkImage = controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
                        return controller.imageUploading.value
                            ? const TShimmerEffect(width: 150, height: 150, radius: 150)
                            : TCircularImage(image: image, width: 150, height: 150, isNetworkImage: networkImage.isNotEmpty);
                      },
                    ),
                    TextButton(
                      onPressed: controller.imageUploading.value ? () {} : () => controller.uploadUserProfilePicture(),
                      child: Text('Change Profile Picture', style: GoogleFonts.poppins()),
                    ),
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
                          child: Text("Adi Budi",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          // child: const Icon(Iconsax.arrow_right_34, size: 18)
                          child: SizedBox(),
                        ),
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
                          child: Text("adi_budi",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: SizedBox()),
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
                      const Expanded(child: SizedBox()),
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
                          child: Text("adibudi@gmail.com",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: SizedBox(),),
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
                          child: Text("081333067305",
                              style: GoogleFonts.poppins(),
                              overflow: TextOverflow.ellipsis)),
                      const Expanded(
                          child: SizedBox(),),
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
                        style: GoogleFonts.poppins(color: Colors.white)),
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
