import 'package:get/get.dart';

class RoleScreenController extends GetxController{

  int _selectedRoleIndex = 0;

  int get selectedRoleIndex => _selectedRoleIndex;

  void selectRole(int index){
    _selectedRoleIndex = index;
  }
}