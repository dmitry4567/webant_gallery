import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webant_gallery/core/theme/font.dart';
import 'package:webant_gallery/core/theme/my_icons_icons.dart';
import 'package:webant_gallery/core/theme/palete.dart';
import 'package:webant_gallery/core/utils/dialogs.dart';
import 'package:webant_gallery/core/utils/toast.dart';
import 'package:webant_gallery/features/add_photo/presentation/cubit/add_photo_cubit.dart';

@RoutePage()
class NewPhotoPage extends StatefulWidget {
  final XFile file;

  const NewPhotoPage({super.key, required this.file});

  @override
  State<NewPhotoPage> createState() => _NewPhotoPageState();
}

class _NewPhotoPageState extends State<NewPhotoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<AddPhotoCubit>().setPhoto(file: widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          "New photo",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        leadingWidth: 84,
        leading: ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.white10,
              onTap: () {
                if (Platform.isIOS) {
                  iosDialog(context);
                } else if (Platform.isAndroid) {
                  androidDialog(context);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 9),
                child: Row(
                  children: [
                    Icon(MyIcons.back, color: AppColors.blue, size: 19),
                    SizedBox(width: 5),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w400,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: [
          BlocBuilder<AddPhotoCubit, AddPhotoState>(
            builder: (context, state) {
              return !state.isLoading
                  ? ClipRRect(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(10),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          highlightColor: Colors.white10,
                          onTap: () {
                            context.read<AddPhotoCubit>().uploadPhoto();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 9),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColors.main,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.symmetric(horizontal: 9),
                      child: CircularProgressIndicator(color: AppColors.main),
                    );
            },
          ),
        ],
      ),
      body: BlocListener<AddPhotoCubit, AddPhotoState>(
        listener: (context, state) {
          if (state.isUploaded) {
            ToastService().showInfoToast("Photo uploaded successfully");
            
            context.router.back();
            context.tabsRouter.setActiveIndex(0);
          } else if (state.error.isNotEmpty) {
            ToastService().showErrorToast(state.error);
            
            context.read<AddPhotoCubit>().clearError();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.file(
                File(widget.file.path),
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        onChanged: (value) {
                          context.read<AddPhotoCubit>().setName(value.trim());
                        },
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        cursorWidth: 1,
                        cursorHeight: 17,
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: AppTextStyle.p.copyWith(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.main,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.greyLight,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 6,
                            right: 0,
                            top: 0,
                            bottom: 0,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 128,
                      child: TextFormField(
                        onChanged: (value) {
                          context.read<AddPhotoCubit>().setDescription(
                            value.trim(),
                          );
                        },
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        cursorWidth: 1,
                        cursorHeight: 17,
                        decoration: InputDecoration(
                          hintText: "Description",
                          hintStyle: AppTextStyle.p.copyWith(
                            color: AppColors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.main,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: AppColors.greyLight,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 6,
                            right: 0,
                            top: 14,
                            bottom: 0,
                          ),
                        ),
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        BlocBuilder<AddPhotoCubit, AddPhotoState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Checkbox(
                                    value: state.isNew,
                                    onChanged: (value) => context
                                        .read<AddPhotoCubit>()
                                        .setIsNew(value!),
                                    activeColor: AppColors.main,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "New",
                                  style: state.isNew
                                      ? AppTextStyle.h4
                                      : AppTextStyle.p,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(width: 20),
                        BlocBuilder<AddPhotoCubit, AddPhotoState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: Checkbox(
                                    value: state.isPopular,
                                    onChanged: (value) => context
                                        .read<AddPhotoCubit>()
                                        .setIsPopular(value!),
                                    activeColor: AppColors.main,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Popular",
                                  style: state.isPopular
                                      ? AppTextStyle.h4
                                      : AppTextStyle.p,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
