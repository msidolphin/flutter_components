abstract class ICheckListItem<T> {

  String getLabel();
  T getId();
  bool isDisabled();

}