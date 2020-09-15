import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

///authentication type for navigating from login to hod or student dashboard (for temporary use only)
//final bool isStudentAuth = true; //for navigating to student dashboard

///ROLE (EITHER USER IS HOD OR STUDENT OR SUPERVISOR
final String hodType = "HOD";
final String studentType = "STUDENT";
final String supervisorType = "SUPERVISOR";
final String principalType = "PRINCIPAL";

///user data
final String defaultProfileImageUrl = "default.svg";

///errors constants (to show error)
final String weakPasswordMessage = "Password should be at least 8 characters.";
final String emailAlreadyInUseMessage = "Email is already in use.";
final String badFormattedEmailMessage = "Invalid email, email is bad formatted";
final String userNotFoundMessage = "Account does not exists!";
final String wrongPasswordMessage = "Wrong credentials!";

///strings for exceptions
final String badFormattedEmail = "ERROR_INVALID_EMAIL";
final String emailAlreadyInUse = "ERROR_EMAIL_ALREADY_IN_USE";
final String weakPassword = "ERROR_WEAK_PASSWORD";
final String userNotFound = "ERROR_USER_NOT_FOUND";
final String wrongPassword = "ERROR_WRONG_PASSWORD";

///BRANCHES (CSE, MEC, CIV, EEE, ECE)
final String selectBranch = "SELECT BRANCH";
final String cseBranch = "CSE";
final String civBranch = "CIV";
final String mecBranch = "MEC";
final String eeeBranch = "EEE";
final String eceBranch = "ECE";

///BRANCHES (CSE, MEC, CIV, EEE, ECE) - order is mandatory as per popup menu item UI
final int branch = 0;
final int cse = 1;
final int mec = 2;
final int civ = 3;
final int eee = 4;
final int ece = 5;

///bottom nav bar index
final int homeIndex = 0;
final int teamIndex = 1;
final int projectIndex = 2;
final int statusIndex = 3;

///order is mandatory
final branches = [
  selectBranch,
  cseBranch,
  mecBranch,
  civBranch,
  eeeBranch,
  eceBranch,
];

///database related constants
final CollectionReference userReference =
    Firestore.instance.collection("USERS");
final CollectionReference teamReference =
    Firestore.instance.collection("TEAMS");

///team status
final teamStatusFull = "Full";
final teamStatusAvailable = "Available";

///gender values - male - 1, female-2
final int male = 1;
final int female = 2;

///team roles (teamLeader or teamMember)
final String maleGender = "Male";
final String femaleGender = "Female";

///team role values - teamLeader - 1, teamMember-2
final int teamLeader = 1;
final int teamMember = 2;

///team roles (teamLeader or teamMember)
final String teamLeaderRole = "TEAM LEADER";
final String teamMemberRole = "TEAM MEMBER";

///team status warning messages
final String teamFullWarningMessage = "Warning! This team is full";
final String teamAvailableWarningMessage = "Warning! This is not full yet";
final String teamHasAlreadyAnLeader =
    "Warning! This team has already a Team Leader.";
final String youAreATeamLeader = "Warning! You are a Team Leader.";
final String teamHasNotAnLeader = "Warning! This team has not a Team Leader.";

///re-register your account
final String reRegistrationMessage =
    "Oops! something went wrong with your account while registering.\n Please delete your account and then register again.";

///team has no members message
final String teamIsEmptyMessage =
    "Team has no members yet. \n Note: Team may have only one Team Leader but member can be more.";

///team and supervisor not found
final String teamAndSupervisorNotExists =
    "Oops! something went wrong.\nTeam or Supervisor does not exists!";

///remove from team member
final String removeMemberFromTeamWarningMessage =
    "Your are about to lose connection between this 'Team and this member'\n The shared data also will be lost.";
