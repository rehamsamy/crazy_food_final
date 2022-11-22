import 'package:crazy_food/app/shared/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

class BottomAddAdress extends StatefulWidget {
  bool _show;
  Address ? _address;
  BottomAddAdress(this._show,this._address);

  @override
  State<BottomAddAdress> createState() => _BottomAddAdressState();
}

class _BottomAddAdressState extends State<BottomAddAdress> {
  @override
  Widget build(BuildContext context) {
      if(widget._show)
      {
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 150,
            child:    Container(
            height: 120,
            width: double.infinity,
            color: Colors.grey.shade200,
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val){}),
                    AppText((widget._address?.addressLine??null).toString())
                  ],
                ),
                ElevatedButton(
                  child: Text("Close Bottom Sheet"),
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Colors.green,

                  ),
                  onPressed: () {
                    widget._show = false;
                    setState(() {

                    });
                  },
                ),
              ],
            ),
          ),
            // child: BottomSheet(
            //   onClosing: () {
            //   },
            //   builder: (context) {
            //     return Container(
            //       height: 120,
            //       width: double.infinity,
            //       color: Colors.grey.shade200,
            //       alignment: Alignment.center,
            //       child: Column(
            //         children: [
            //           Row(
            //             children: [
            //               Checkbox(value: true, onChanged: (val){}),
            //               AppText((widget._address?.addressLine??null).toString())
            //             ],
            //           ),
            //           ElevatedButton(
            //             child: Text("Close Bottom Sheet"),
            //             style: ElevatedButton.styleFrom(
            //               onPrimary: Colors.white,
            //               primary: Colors.green,
            //
            //             ),
            //             onPressed: () {
            //               widget._show = false;
            //               setState(() {
            //
            //               });
            //             },
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),
          ),
        );
      }
      else{
        return SizedBox();
      }
  }
}
