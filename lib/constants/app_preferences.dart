import 'package:nb_utils/nb_utils.dart';

class AppPreferences {
  // Setters

  /*  Set user id  */
  static Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', userId);
  }

  // set member id
  static Future<void> setMemberId(String memberId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('member_id', memberId);
  }

  // set email
  static Future<void> setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  // set name
  static Future<void> setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  // set gsrn id number
  static Future<void> setGsrnIdNumber(String gsrnIdNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gsrn_id_number', gsrnIdNumber);
  }

  // set mobile number
  static Future<void> setMobileNumber(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile_number', mobileNumber);
  }

  // set residence id number
  static Future<void> setResidenceIdNumber(String residenceIdNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('residence_id_number', residenceIdNumber);
  }

  // set national address qrcode
  static Future<void> setNationalAddressQrcode(
      String nationalAddressQrcode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('national_address_qrcode', nationalAddressQrcode);
  }

  // set role
  static Future<void> setRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('role', role);
  }

  // Getters...
  /*  Get user id  */
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  // get member id
  static Future<String?> getMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('member_id');
  }

  // get email
  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  // get name
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  // get gsrn id number
  static Future<String?> getGsrnIdNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('gsrn_id_number');
  }

  // get mobile number
  static Future<String?> getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile_number');
  }

  // get residence id number
  static Future<String?> getResidenceIdNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('residence_id_number');
  }

  // get national address qrcode
  static Future<String?> getNationalAddressQrcode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('national_address_qrcode');
  }

  // get role
  static Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Clear all data
  static Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
