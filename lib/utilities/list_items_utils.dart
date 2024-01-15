import 'package:books/models/selected_item.module.dart';

class ListItemsUtils {
  static List<SelectedItem<T>> convertListToSelectedItems<T>(List<T> lstSelectedItem) {
    List<SelectedItem<T>> ret = [];
    
    for (T wrapperModel in lstSelectedItem) {
      ret.add(SelectedItem(wrapperModel));
    }

    return ret;
  }

  static List<SelectedItem<T>> getSelectedItems<T>(List<SelectedItem<T>> lstSelectedItem) {
    return lstSelectedItem.where((element) => element.sel).toList();
  }

  static List<T> getSelectedListItems<T>(List<SelectedItem<T>> lstSelectedItem) {
    List<T> lstOut = [];
    Iterable<SelectedItem<T>> it = lstSelectedItem.where((element) => element.sel).toList();
    if (it.isNotEmpty) {
      for (SelectedItem<T> selectedItem in it) {
        lstOut.add(selectedItem.item);
      }
    }
    return lstOut;
  }

  static bool isThereOneSelected<T>(List<SelectedItem<T>> lstSelectedItem) {
    if (lstSelectedItem.isEmpty) {
      false;
    }
    SelectedItem<T>? elemSel = lstSelectedItem.cast<SelectedItem<T>?>().firstWhere((element) => element!.sel, orElse: () => null);
    return (elemSel != null);
  }

  static bool isThereNoOneSelected<T>(List<SelectedItem<T>> lstSelectedItem) {
    if (lstSelectedItem.isEmpty) {
      false;
    }
    SelectedItem<T>? elemSel = lstSelectedItem.cast<SelectedItem<T>?>().firstWhere((element) => !element!.sel, orElse: () => null);
    return (elemSel != null);
  }

  static bool areAllSelected<T>(List<SelectedItem<T>> lstSelectedItem) {
    return !isThereNoOneSelected(lstSelectedItem);
  }

  static bool areAllNoSelected<T>(List<SelectedItem<T>> lstSelectedItem) {
    return !isThereOneSelected(lstSelectedItem);
  }

  static int countSelectedItems<T>(List<SelectedItem<T>> lstSelectedItem) {
    int nr = 0;
    for (SelectedItem<T> item in lstSelectedItem) {
      nr += item.sel ? 1 : 0;
    }
    return nr;
  }

  static void selectedAllItems<T>(List<SelectedItem<T>> lstSelectedItem) {
    if (lstSelectedItem.isEmpty) {
      return;
    }
    
    for (SelectedItem<T> item in lstSelectedItem) {
      item.sel = true;
    }
  }

  static void deselectedAllItems<T>(List<SelectedItem<T>> lstSelectedItem) {
    if (lstSelectedItem.isEmpty) {
      return;
    }
    
    for (SelectedItem<T> item in lstSelectedItem) {
      item.sel = false;
    }
  }
}