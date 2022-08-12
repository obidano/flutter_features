import 'package:flutter/material.dart';
import 'package:odc_flutter_features/pages/camera_image_page.dart';
import 'package:odc_flutter_features/pages/checkbox_page.dart';
import 'package:odc_flutter_features/pages/datepicker_page.dart';
import 'package:odc_flutter_features/pages/loading_page.dart';
import 'package:odc_flutter_features/pages/menu_lateral_sous_menus.dart';
import 'package:odc_flutter_features/pages/menu_popup.dart';
import 'package:odc_flutter_features/pages/pageview_page.dart';
import 'package:odc_flutter_features/pages/radiobuttons_page.dart';
import 'package:odc_flutter_features/pages/refresh_indicator_page.dart';
import 'package:odc_flutter_features/pages/switchbuttons_page.dart';
import 'package:odc_flutter_features/pages/validation_page.dart';

import 'alert_dialog_page.dart';
import 'bottom_navigation_bar.dart';
import 'gallery_page.dart';
import 'tabs_page.dart';
import 'toast_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map> options = [
      {
        "title": "SnackBar",
        "navigation": (String data) => ToastPage(
              title: data,
            )
      },
      {
        "title": "Boite de dialogue",
        "navigation": (String data) => AlertDialogPage(
              title: data,
            )
      },
      {
        "title": "Tirer pour actualiser",
        "navigation": (String data) => RefreshIndicatorPage(
              title: data,
            )
      },
      {
        "title": "Menu Lateral: Sous-menu",
        "navigation": (String data) => MenuLateralSousMenus(
              title: data,
            )
      },
      {
        "title": "Menu Popup",
        "navigation": (String data) => MenuPopup(
              title: data,
            )
      },
      {
        "title": "Le Bottom Navigation Bar",
        "navigation": (String data) => BottomNavigationBarPage(
              title: data,
            )
      },
      {
        "title": "CheckBox",
        "navigation": (String data) => CheckBoxpage(
              title: data,
            )
      },
      {
        "title": "Radio Button",
        "navigation": (String data) => RadioButtonspage(
              title: data,
            )
      },
      {
        "title": "Switch Button",
        "navigation": (String data) => SwitchButtonsPage(
              title: data,
            )
      },
      {
        "title": "Tabs",
        "navigation": (String data) => TabsPage(
              title: data,
            )
      },
      {
        "title": "Pageview",
        "navigation": (String data) => PageViewPage(
              title: data,
            )
      },
      {
        "title": "Loading Page",
        "navigation": (String data) => LoadingPage(
              title: data,
            )
      },
      {
        "title": "Validation Page",
        "navigation": (String data) => ValidationPage(
              title: data,
            )
      },
      {
        "title": "DatePicker Page",
        "navigation": (String data) => DatepickerPage(
              title: data,
            )
      },
      {
        "title": "Gallerie",
        "navigation": (String data) => GalleryPage(
              title: data,
            )
      },
      {
        "title": "Camera Image",
        "navigation": (String data) => CameraImagePage(
              title: data,
            )
      },
      {
        "title": "Camera Video",
        "navigation": (String data) => CameraImagePage(
              title: data,
              isVideo: true,
            )
      }
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.home),
          title: Text(
            'ODC : Flutter',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${options.length} Fonctionnalités supplementaires',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  thickness: 5,
                ),
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  var option = options[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 15,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(option['title']),
                    trailing: Icon(Icons.arrow_circle_right_sharp),
                    onTap: () => naviguerVersToastPage(context, option),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  naviguerVersToastPage(BuildContext context, Map option) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      var titre = option['title'];
      return option['navigation'](titre); //
    }));
  }
}
