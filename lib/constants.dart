import 'package:flutter/material.dart';

// colors
//const Color mainColor = Color(0xff0c646b);
const Color mainColor =Color.fromARGB(255, 7, 55, 59);
const Color secondColor = Colors.white;

// routes
const String startPath = "/";
const String splashPath = "/splash";
const String loginPath = "/login";
const String registerPath = "/register";
const String forgetPasswordPath = "/forget password";
const String selectUserPath = "/select user";
const String homePath = "/home";
const String privacyPolicyPath = "/privacy policy";
const String profilePath = "/profile";
const String performerReqPath = "/performer requests";
const String newOrderPath = "/new order";
const String reviewOrderPath = "/review order";
const String orderConfirmedPath = "/order confirmed";
const String trackPath = "/track";
const String orderNotStartedPath = "/order not started";
const String videoPath = "/video";
const String showOrderPath = "/show order";
const String resetPasswordPath = "/reset password";
const String videosSubmissionPath = "/videos submission";
const String introPath = "/intro";
const String ourGoalPath = "/our goal";


// end points
const String baseUrl= "https://taffweed.com/api/";
const String uploadVideoEndPoint = "api/upload";
const String loginEndPoint = "login";
const String registerEndPoint = "register";
const String logoutEndPoint = "logout";
const String countriesEndPoint = "countries";
const String servicesEndPoint = "services";
const String deviceTokenEndPoint = "devicetoken";
const String personCasesEndPoint = "person-cases";
const String updateProfileEndPoint = "password-reset";
const String checkCouponEndPoint = "check-coupon-code-working";
const String newRequestEndPoint = "service_requests";
const String requestPaymentEndPoint = "service_request_payment";
const String myRequestEndPoint = "user-requests";
const String requestDetailsEndPoint = "user-request-detail";
const String videosEndPoint = "user-request-videos";
const String resetPasswordEndPoint = "password-forget";
const String deleteAccountEndPoint = "api/deleteaccount";
const String promoCodeEndPoint = "api/checkcopoun";

// packages prices in Saudi Real
const double ragabPackageOriginalPrice = 600;
const double shabaanPackageOriginalPrice = 650;
const double ramadanPackageOriginalPrice = 700;
const double fastPackageOriginalPrice = 900;
const double restPackageOriginalPrice = 500;
