import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/ColorUtil.dart';
import '../checklist/ICheckListItem.dart';
import '../utils/ViewportUtil.dart';

typedef ValueChanged(String value, String text);
typedef VoidCallback = Function();

class MutexPicker<T extends ICheckListItem> extends StatefulWidget {
  final String value;
  final List<String> disabledValue;
  final List<T> dataSource;
  final String title;
  final ValueChanged onChanged;

  MutexPicker({
    Key key,
    this.dataSource,
    this.value,
    this.title = '请选择',
    this.disabledValue,
    this.onChanged,
  }) : assert(value != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MutexPicker();
  }
}

class _MutexPicker extends State<MutexPicker> {
  String currentValue;
  List<String> disabledValue;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentValue = widget.value;
      disabledValue = widget.disabledValue != null ? widget.disabledValue : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: ColorUtil.web('#E9EAEC'),
      child: Column(
        children: <Widget>[
          handleTitle(),
          handleContent(),
        ],
      ),
    );
  }
  Widget handleTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
              height:44,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0))
              ),
              child: Center(
                child: Text(widget.title,style: TextStyle(color: ColorUtil.web('#333')),),
              )
          ),
        )
      ],
    );
  }
  Widget handleContent () {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15.w),
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.w,
              children: initContChildren(widget.dataSource)
            ),
          ),
        )
      ],
    );
  }
  List<Widget> initContChildren(List<ICheckListItem> children) {
    List<Widget> _children = [];
    for(int i = 0; i < children.length; ++i) {
      _children.add(getContItemChild(children[i], i));
    }
    return _children;
  }

  Widget getContItemChild (ICheckListItem item, index) {
    int dIndex = disabledValue.indexOf(item.getId());
    if (dIndex != -1 && item.getId() != currentValue) {
      return Container(
        width: 174.w,
        height: 88.w,
        decoration: BoxDecoration(
          color: ColorUtil.web("#fff"),
          borderRadius: BorderRadius.all(Radius.circular(4.w)),
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(item.getLabel(), overflow: TextOverflow.ellipsis, textScaleFactor: 1,

              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                  width: (MediaQuery.of(context).size.width - (30.w + 24.w)) / 4,
                  height: 88.w,
                  decoration: BoxDecoration(
                    color: ColorUtil.web("#313131",0.85),
                    borderRadius: BorderRadius.all(Radius.circular(4.w)),
                  ),
                  child: Center(
                    child: Text('已设定',style: TextStyle(color: Colors.white),),
                  )
              ),
            )
          ],
        ),
      );
    } else {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          onTap: () {
            setState(() {
              currentValue = item.getId();
              widget.onChanged(item.getId(),item.getLabel());
            });
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - (30.w + 24.w)) / 4,
            height: 88.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Center(
                child:Text(item.getLabel(),style: TextStyle(
                    color: item.getId() == currentValue ? Theme.of(context).primaryColor : ColorUtil.web('#333')
                ),)
            ),
          ),
        ),
      );
    }
  }

}