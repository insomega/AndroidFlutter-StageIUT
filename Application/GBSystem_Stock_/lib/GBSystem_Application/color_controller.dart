import 'package:gbsystem_stock/GBSystem_Application/GBSystem_color_model.dart';
import 'package:get/get.dart';

class ColorController extends GetxController {
  List<GbsystemColorModel>? _allColors;
  Rx<GbsystemColorModel?> _selectedColor = Rx<GbsystemColorModel?>(null);

  set setSelectedColor(GbsystemColorModel? color) {
    _selectedColor.value = color;
    update();
  }

  set setAllColors(List<GbsystemColorModel>? colors) {
    _allColors = colors;
    update();
  }

  GbsystemColorModel? get getSelectedColor => _selectedColor.value;
  Rx<GbsystemColorModel?> get getSelectedColorObx => _selectedColor;

  List<GbsystemColorModel>? get getAllColors => _allColors;
  Rx<List<GbsystemColorModel>?> get getAllColorsRx => Rx(_allColors);
}
