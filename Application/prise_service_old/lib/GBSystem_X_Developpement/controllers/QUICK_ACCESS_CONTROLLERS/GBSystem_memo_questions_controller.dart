import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_memo_question_model.dart';
import 'package:get/get.dart';

class GBSystemMemoQuestionController extends GetxController {
  List<MemoQuestionModel> _allMemo = [];
  Rx<MemoQuestionModel?> _selectedMemo = Rx<MemoQuestionModel?>(null);
  RxBool _isFirstLoad = RxBool(true);

  set setSelectedMemo(MemoQuestionModel? memo) {
    _selectedMemo.value = memo;
    update();
  }

  set setIsFirstLoad(bool isFirstLoad) {
    _isFirstLoad.value = isFirstLoad;
    update();
  }

  set addListMemo(List<MemoQuestionModel> Memo) {
    _allMemo.addAll(Memo);
    update();
  }

  set setMemoToLeft(MemoQuestionModel Memo) {
    _allMemo?.insert(0, Memo);
    update();
  }

  set setMemoToRight(MemoQuestionModel Memo) {
    _allMemo?.insert(_allMemo!.length, Memo);
    update();
  }

  set setAllMemo(List<MemoQuestionModel> allMemo) {
    // _allMemo = [];
    // allMemo?.forEach(
    //   (element) {
    //     if (checkExistsMemo(memo: element)) {
    //       _allMemo?.add(element);
    //     }
    //   },
    // );
    _allMemo = allMemo;
    update();
  }

  bool checkExistsMemo({required MemoQuestionModel memo}) {
    bool check = false;
    print("------------all memo  ----------------");

    _allMemo?.forEach(
      (element) => print(element.LIEINSMMO_LIB),
    );
    print(_allMemo?.length);
    print("------------ end all memo  ----------------");

    for (var i = 0; i < (_allMemo?.length ?? 0); i++) {
      if (_allMemo![i].LIEINSMMO_IDF == memo.LIEINSMMO_IDF &&
          _allMemo![i].LIEINSPQU_IDF == memo.LIEINSPQU_IDF &&
          _allMemo![i].LIEINSQMMO_IDF == memo.LIEINSQMMO_IDF &&
          _allMemo![i].LIEINSQMMO_UIDF == memo.LIEINSQMMO_UIDF &&
          _allMemo![i].USER_IDF == memo.USER_IDF &&
          _allMemo![i].LAST_UPDT == memo.LAST_UPDT &&
          _allMemo![i].LIEINSMMO_CODE == memo.LIEINSMMO_CODE &&
          _allMemo![i].LIEINSMMO_LIB == memo.LIEINSMMO_LIB &&
          _allMemo![i].LIEINSMMO_MEMO == memo.LIEINSMMO_MEMO &&
          _allMemo![i].LIEINSPQU_CODE == memo.LIEINSPQU_CODE &&
          _allMemo![i].LIEINSPQU_LIB == memo.LIEINSPQU_LIB &&
          _allMemo![i].USR_LIB == memo.USR_LIB) {
        print(
            "comparre ${_allMemo![i].LIEINSMMO_LIB}  , my : ${memo.LIEINSMMO_LIB}");

        check = true;
      }
    }

    return check;
  }

  bool checkExistsMemoIDF({required MemoQuestionModel memo}) {
    bool check = false;

    for (var i = 0; i < (_allMemo?.length ?? 0); i++) {
      if (_allMemo![i].LIEINSMMO_IDF == memo.LIEINSMMO_IDF) {
        check = true;
      }
    }

    return check;
  }

  MemoQuestionModel? get getSelectedSite => _selectedMemo.value;
  bool get getIsFirstLoad => _isFirstLoad.value;
  List<MemoQuestionModel>? get getAllMemo => _allMemo?.toSet().toList();

  List<MemoQuestionModel>? getAllMemoFiltred() {
    print(_allMemo?.length);
    print(_allMemo?.toSet().toList().length);
    return _allMemo?.toSet().toList();
  }

  List<MemoQuestionModel>? getAllMemoFiltredWith_LIEINSPQU_IDF(
      String LIEINSPQU_IDF) {
    // List<MemoQuestionModel> firstFiltreMemo = _allMemo?.toSet().toList() ?? [];

    return (_allMemo ?? [])
        .where(
          (element) => element.LIEINSPQU_IDF == LIEINSPQU_IDF,
        )
        .toList();
  }

  // List<MemoQuestionModel>? getAllMemoFiltred2() {
  //   List<MemoQuestionModel>? allMemoFiltred = [];
  //   for (var i = 0; i < (_allMemo?.length ?? 0); i++) {
  //     if (!checkExistsMemo(memo: _allMemo![i])) {
  //       allMemoFiltred.add(_allMemo![i]);
  //     }
  //   }
  //   print("all filtre length ${allMemoFiltred.length}");

  //   return allMemoFiltred;
  // }
}
