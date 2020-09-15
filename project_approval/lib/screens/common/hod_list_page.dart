import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_approval/bloc/hod_bloc.dart';
import 'package:project_approval/clipper/CustomLoginScreenClipper.dart';
import 'package:project_approval/models/hod.dart';
import 'package:project_approval/screens/common/widgets.dart';
import 'package:project_approval/screens/common/widgets/hod_list_table.dart';
import 'package:project_approval/screens/loading.dart';
import 'package:project_approval/screens/shared_widgets.dart';
import 'package:project_approval/services/principal_services.dart';
import 'package:project_approval/utils/constants.dart';
import 'package:project_approval/utils/helper.dart';
import 'package:project_approval/utils/style.dart';

class HodListPage extends StatefulWidget {
  final DocumentSnapshot snapshot;

  HodListPage({this.snapshot});

  @override
  _HodListPageState createState() => _HodListPageState();
}

class _HodListPageState extends State<HodListPage> {
  bool isLoading = true;
  List<Hod> hodList = [];
  @override
  void initState() {
    ///get hod details
    getHodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String userType = widget.snapshot.data["USER_TYPE"];
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
            'Hod List',
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
        body: isLoading
            ? LoadingScreen() : HodListScreenBody(
            snapshot: widget.snapshot, hodList: hodList, userType: userType),
      ),
    );
  }

  void getHodList() async {
    await userReference
        .where("USER_TYPE", isEqualTo: hodType)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot == null) {
        setState(() {
          isLoading = false;
        });
      } else {
        for (var doc in querySnapshot.documents) {
//          hodList.add(new HodService().hodFromDynamicMap(doc));//this can be also used
          hodList.add(Helper().generateHodData(doc));
        }

        if (hodList.length == 0)
          setState(() {
            isLoading = false;
          });
      }
    });
    setState(() {
      isLoading = false;
    });
  }
}

class HodListScreenBody extends StatelessWidget {
  final DocumentSnapshot snapshot;
  final List<Hod> hodList;
  final String userType;
  HodListScreenBody({this.snapshot, this.hodList, this.userType});

  @override
  Widget build(BuildContext context) {
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
                              height: 50,
                            ),
                            userType == principalType
                                ? AddFacultyPart(snapshot: snapshot)
                                : Container(),
                            SizedBox(
                              height: 50,
                            ),
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: HodListTable(hodList: hodList),
                            ),
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

class AddFacultyPart extends StatefulWidget {
  final DocumentSnapshot snapshot;

  AddFacultyPart({this.snapshot});

  @override
  _AddFacultyPartState createState() => _AddFacultyPartState();
}

class _AddFacultyPartState extends State<AddFacultyPart> {
  bool addHodButtonToggler = true;
  final PrincipalService _principalService = new PrincipalService();
  bool isLoading = false;
  String error = "";
  Color errorColor = Colors.redAccent;
  int selectedBranchIndex = 0;
  bool isBranchSelected = true;
  String emailText = "";
  String nameText = "";
  final hodBloc = new HodBloc();

  ///isBranchSelected - just to show red border if not selected but initially it will be true because we don't want to show red border initially
  @override
  void initState() {
    super.initState();
    hodBloc.email.listen((event) {
      emailText = event;
    });

    hodBloc.name.listen((event) {
      nameText = event;
    });
    hodBloc.branch.listen((event) {
      selectedBranchIndex = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addHodButtonToggler
            ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                resetForm();
                setState(() {
                  error = "";
                  errorColor = Colors.redAccent;
                  addHodButtonToggler = !addHodButtonToggler;
                });
              },
              child: Container(
                decoration: BoxDecoration(gradient: gradientAddButton),
                child: Text(
                  'Add Hod',
                  style: appBarTitleStyle.copyWith(
                      fontFamily: "Roboto Bold",
                      fontSize: 15,
                      color: Colors.blue),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
            )
          ],
        )
            : Container(),
        !addHodButtonToggler
            ? Column(
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
                      child: StreamBuilder<String>(
                          stream: hodBloc.name.map((event) {
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: -5),
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
                      child: StreamBuilder<String>(
                          stream: hodBloc.email.map((event) {
                            return emailText;
                          }), builder: (context, snapshot) {
                        return TextField(
                          onChanged: hodBloc.emailChanged,
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          style: appBarTitleStyle.copyWith(
                              fontSize: 18,
                              color: Colors.black87,
                              fontFamily: "Open Sans Bold"),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: -5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            hintText: "Enter Email ID",
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
                    StreamBuilder<int>(
                        stream: hodBloc.branch.map((event) {
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
                            color: isBranchSelected
                                ? Colors.grey
                                : Colors.redAccent,
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
                    error != null
                        ? SizedBox(
                      height: 20,
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
                    SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? Container(
                        constraints: BoxConstraints(
                          minHeight: 80,
                        ),
                        child:
                        Center(child: TransparentLoadingScreen()))
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: gradientCancelFacultyButton,
                            borderRadius:
                            BorderRadius.circular(3.0),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                addHodButtonToggler =
                                !addHodButtonToggler;
                              });
                            },
                            child: Text(
                              'Cancel',
                              style: defaultTextStyle.copyWith(
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        StreamBuilder<bool>(
                            stream: hodBloc.addHodSubmitCheck,
                            builder: (context, submitSnapshot) {
                              return Container(
                                height: 40,
                                decoration: (submitSnapshot
                                    .hasData &&
                                    nameText.isNotEmpty &&
                                    emailText.isNotEmpty &&
                                    selectedBranchIndex != 0)
                                    ? BoxDecoration(
                                  gradient:
                                  gradientAddFacultyButton,
                                  borderRadius:
                                  BorderRadius.circular(
                                      3.0),
                                )
                                    : BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                  BorderRadius.circular(
                                      3.0),
                                ),
                                child: FlatButton(
                                  onPressed: (submitSnapshot
                                      .hasData &&
                                      nameText.isNotEmpty &&
                                      emailText.isNotEmpty &&
                                      selectedBranchIndex != 0)
                                      ? () {
                                    addHod();
                                  }
                                      : null,
                                  child: Text(
                                    'ADD',
                                    style:
                                    defaultTextStyle.copyWith(
                                      color: submitSnapshot.hasData
                                          ? Colors.black87
                                          : Colors.grey[500],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : Container(),
      ],
    );
  }

  void addHod() async {
    setState(() => isLoading = true);
    Hod hod = new Hod(
      name: nameText,
      email: emailText,
      branch: branches[selectedBranchIndex],
      password: Helper().getRandomString(10),
      profileImageUrl: defaultProfileImageUrl,
      phone: null,
      designation: hodType,
      userType: hodType,
    );
    dynamic result = await _principalService.addHod(hod, widget.snapshot);
    if (result == null) {
        setState(() {
          isLoading = false;
          errorColor = Colors.green;
          error = "Account Registered! \n Please reset your password for login.";
        });
      } else {
        setState(() {
          isLoading = false;
          errorColor = Colors.redAccent;
          error = result.toString();
        });
      }
  }

  void resetForm() {
    setState(() {
      selectedBranchIndex = 0;
      nameText = "";
      emailText = "";
    });
  }
}
