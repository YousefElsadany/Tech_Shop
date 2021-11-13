import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/cubit.dart';
import 'package:tech_shop/layout/ShopApp/Cubit/states.dart';
import 'package:tech_shop/shared/componants/componants.dart';
import 'package:tech_shop/shared/style/colors.dart';


class AddLocationScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  final bool isEdit;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? details;
  final String? notes;
  AddLocationScreen({
    required this.isEdit,
    this.addressId,
    this.name,
    this.city,
    this.region,
    this.details,
    this.notes,
  });

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    if (isEdit) {
      nameController.text = name!;
      cityController.text = city!;
      regionController.text = region!;
      detailsController.text = details!;
      notesController.text = notes!;
    }
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: fullBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Add New Adderess'),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: fullBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: fullBackgroundColor,
            leading: Container(),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('CANCEL'),
              ),
            ],
          ),
          body: state is ShopLoadingGetSettingsState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                buildAdderessFeild(
                                    text: 'Name',
                                    controller: nameController,
                                    inputType: TextInputType.name,
                                    title: 'Example “ My Location ”',
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name must not be empty';
                                      }
                                    }),
                                SizedBox(
                                  height: 15.0,
                                ),
                                buildAdderessFeild(
                                    text: 'City',
                                    controller: cityController,
                                    inputType: TextInputType.text,
                                    title: 'Example “ Cairo ”',
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'City must not be empty';
                                      }
                                    }),
                                SizedBox(
                                  height: 15.0,
                                ),
                                buildAdderessFeild(
                                    text: 'Region',
                                    controller: regionController,
                                    inputType: TextInputType.text,
                                    title: 'Example “ Nasr City ”',
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Region must not be empty';
                                      }
                                    }),
                                SizedBox(
                                  height: 15.0,
                                ),
                                buildAdderessFeild(
                                    text: 'Details',
                                    controller: detailsController,
                                    inputType: TextInputType.text,
                                    title: 'Enter Your Location Details',
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name must not be empty';
                                      }
                                    }),
                                SizedBox(
                                  height: 15.0,
                                ),
                                buildAdderessFeild(
                                    text: 'Notes',
                                    controller: notesController,
                                    inputType: TextInputType.text,
                                    title: 'Enter Notes',
                                    validate: (value) {
                                      if (value!.length > 100) {
                                        return 'Notes must be at least 100 character';
                                      }
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          // Spacer(),
                          customButtom(
                            buttomCollor: shopColor,
                            text: 'SAVE',
                            press: () {
                              if (formKey.currentState!.validate()) {
                                if (isEdit) {
                                  ShopCubit.get(context).updateAdress(
                                      addressId: addressId,
                                      name: nameController.text,
                                      city: cityController.text,
                                      region: regionController.text,
                                      details: detailsController.text,
                                      notes: notesController.text);
                                } else {
                                  ShopCubit.get(context).addAdderess(
                                    name: nameController.text,
                                    city: cityController.text,
                                    region: regionController.text,
                                    details: detailsController.text,
                                    notes: notesController.text,
                                  );
                                }

                                Get.back();
                              }
                            },
                            buttomWidth: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

Widget buildAdderessFeild({
  required String text,
  required TextEditingController controller,
  required TextInputType inputType,
  IconData? pIcon,
  required String title,
  String? Function(String?)? validate,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        customTextFeild(
          controller: controller,
          inputType: inputType,
          title: title,
          pIcon: pIcon,
          textColor: Colors.black,
          validate: validate,
          backgroundColor: Colors.white,
        )
      ],
    );
