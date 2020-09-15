import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_approval/bloc/hod_bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/hod_services.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/style.dart';

class UpdateProfileScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;

  UpdateProfileScreen({
    this.snapshot,
  });

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          iconTheme: new IconThemeData(
            color: Colors.black87,
          ),
          backgroundColor: Colors.cyanAccent,
          title: Text(
            'Update Profile',
            style: appBarTitleStyle.copyWith(fontFamily: "RedRose Bold"),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: UpdateProfileScreenBody(snapshot: widget.snapshot),
      ),
    );
  }
}

class UpdateProfileScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;

  UpdateProfileScreenBody({this.snapshot});

  @override
  Widget build(BuildContext context) {
    String userType = snapshot.data["USER_TYPE"];

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomLoginScreenBottomClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 56,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        color: Colors.cyanAccent.withOpacity(.4),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            userType == hodType
                                ? UpdateHodProfileData(
                                    snapshot: snapshot,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateHodProfileData extends StatefulWidget {
  final DocumentSnapshot snapshot;

  UpdateHodProfileData({this.snapshot});

  @override
  _UpdateHodProfileDataState createState() => _UpdateHodProfileDataState();
}

class _UpdateHodProfileDataState extends State<UpdateHodProfileData> {
  bool isLoading = false;
  String error = "";
  Color errorColor = Colors.redAccent;
  int selectedBranchIndex = 0;
  bool isBranchSelected = true;
  String designationText = "";
  String nameText = "";
  String phoneText = "";
  String profileImageUrl = defaultProfileImageUrl;
  final hodBloc = new HodBloc();

  @override
  void initState() {
    hodBloc.name.listen((event) {
      nameText = event;
    });

    hodBloc.phone.listen((event) {
      phoneText = event;
    });

    hodBloc.designation.listen((event) {
      designationText = event;
    });

    hodBloc.branch.listen((event) {
      selectedBranchIndex = event;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Card(
          elevation: 3,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent.withOpacity(.15),
                    border: Border.all(color: Colors.black38, width: 2.0),
                    shape: BoxShape.circle,
                  ),
                  child: profileImageUrl == defaultProfileImageUrl
                      ? SvgPicture.asset(
                          'assets/logo/user.svg',
                          width: 50,
                          color: Colors.black38,
                        )
                      : NetworkImage(
                          "$profileImageUrl",
                        ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  child:
                      StreamBuilder<String>(stream: hodBloc.name.map((event) {
                    return nameText;
                  }), builder: (context, snapshot) {
                    return TextField(
                      onChanged: hodBloc.nameChanged,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: appBarTitleStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                          fontFamily: "Open Sans Bold"),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: -5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        hintText: "Enter Name",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: "Raleway Bold"),
                        errorText: snapshot.error,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child:
                      StreamBuilder<String>(stream: hodBloc.phone.map((event) {
                    return phoneText;
                  }), builder: (context, snapshot) {
                    return TextField(
                      onChanged: hodBloc.phoneChanged,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      maxLines: 1,
                      style: appBarTitleStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                          fontFamily: "Open Sans Bold"),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: -5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        hintText: "Enter phone number ex: 7015720216",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: "Raleway Bold"),
                        errorText: snapshot.error,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: StreamBuilder<String>(
                      stream: hodBloc.designation.map((event) {
                    return designationText;
                  }), builder: (context, snapshot) {
                    return TextField(
                      onChanged: hodBloc.designationChanged,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      style: appBarTitleStyle.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                          fontFamily: "Open Sans Bold"),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: -5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        hintText: "Enter Designation",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: "Raleway Bold"),
                        errorText: snapshot.error,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<int>(stream: hodBloc.branch.map((event) {
                  if (event != 0)
                    isBranchSelected = true;
                  else
                    isBranchSelected = false;
                  return selectedBranchIndex;
                }), builder: (context, snapshot) {
                  return Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color:
                            isBranchSelected ? Colors.grey : Colors.redAccent,
                      ),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: PopupMenuButton(
                      onSelected: hodBloc.branchChanged,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${branches[selectedBranchIndex]}',
                            style: appBarTitleStyle.copyWith(
                                fontSize: 12,
                                decoration: TextDecoration.none,
                                fontFamily: "Raleway Bold",
                                color: Colors.black87),
                          ),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                      itemBuilder: (BuildContext context) {
                        return branchPopupMenuItems;
                      },
                    ),
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                isLoading
                    ? Container(
                        constraints: BoxConstraints(
                          minHeight: 80,
                        ),
                        child: Center(child: TransparentLoadingScreen()))
                    : Column(
                  children: [
                    StreamBuilder<bool>(
                        stream: hodBloc.updateHodSubmitCheck,
                        builder: (context, submitSnapshot) {
                          return Container(
                            height: 40,
                            decoration: (submitSnapshot.hasData &&
                                nameText.isNotEmpty &&
                                designationText.isNotEmpty &&
                                selectedBranchIndex != 0)
                                ? BoxDecoration(
                              gradient: gradientAddFacultyButton,
                              borderRadius: BorderRadius.circular(3.0),
                            )
                                : BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: FlatButton(
                              onPressed: (submitSnapshot.hasData &&
                                  nameText.isNotEmpty &&
                                  designationText.isNotEmpty &&
                                  selectedBranchIndex != 0)
                                  ? () {
                                updateHodProfile();
                              }
                                  : null,
                              child: Text(
                                'UPDATE',
                                style: defaultTextStyle.copyWith(
                                  color: submitSnapshot.hasData
                                      ? Colors.black87
                                      : Colors.grey[500],
                                ),
                              ),
                            ),
                          );
                        }),
                    error != null
                        ? SizedBox(
                      height: 15,
                    )
                        : Container(),
                    error != null
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            error,
                            style: appBarTitleStyle.copyWith(
                              color: errorColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void updateHodProfile() async {
    setState(() {
      isLoading = true;
    });
    HodService hodService = new HodService();
    ///update hod profile
    Hod hod = new Hod(
      id: widget.snapshot.data["Id"],
      name: nameText,
      phone: phoneText,
      designation: designationText,
      branch: branches[selectedBranchIndex],
      profileImageUrl: profileImageUrl,
    );
    dynamic result = await hodService.updateHodProfileData(hod);
    if (result == null) {
      setState(() {
        error = "Profile Updated!";
        errorColor = Colors.green;
        isLoading = false;
      });
    } else {
      setState(() {
        error = "Error : " + result.toString();
        errorColor = Colors.redAccent;
        isLoading = false;
      });
    }
  }
}
