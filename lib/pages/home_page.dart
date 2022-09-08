import 'package:flutter/material.dart';
import 'package:odc_flutter_features/controllers/app_controller.dart';
import 'package:odc_flutter_features/controllers/chat_controller.dart';
import 'package:odc_flutter_features/pages/bottomsheet_page.dart';
import 'package:odc_flutter_features/pages/calendar_page.dart';
import 'package:odc_flutter_features/pages/camera_image_page.dart';
import 'package:odc_flutter_features/pages/chat_page.dart';
import 'package:odc_flutter_features/pages/checkbox_page.dart';
import 'package:odc_flutter_features/pages/datepicker_page.dart';
import 'package:odc_flutter_features/pages/dismissible_page.dart';
import 'package:odc_flutter_features/pages/loading_page.dart';
import 'package:odc_flutter_features/pages/location_page.dart';
import 'package:odc_flutter_features/pages/menu_lateral_sous_menus_page.dart';
import 'package:odc_flutter_features/pages/menu_popup.dart';
import 'package:odc_flutter_features/pages/notification_page.dart';
import 'package:odc_flutter_features/pages/pageview_page.dart';
import 'package:odc_flutter_features/pages/play_sound_page.dart';
import 'package:odc_flutter_features/pages/radiobuttons_page.dart';
import 'package:odc_flutter_features/pages/refresh_indicator_page.dart';
import 'package:odc_flutter_features/pages/switchbuttons_page.dart';
import 'package:odc_flutter_features/pages/validation_page.dart';
import 'package:provider/provider.dart';

import 'alert_dialog_page.dart';
import 'bottom_navigation_bar.dart';
import 'gallery_page.dart';
import 'qr_generator_page.dart';
import 'qr_scanner_page.dart';
import 'snackbar_page.dart';
import 'tabs_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatController>().initKoltin();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map> options = [
      {
        "title": "SnackBar",
        "navigation": (String data) => SnackBarPage(
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
        "navigation": (String data) => MenuLateralSousMenusPage(
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
      },
      {
        "title": "Swiper horizontalement",
        "navigation": (String data) => DismissiblePage(
              title: data,
            )
      },
      {
        "title": "Bottom Sheet",
        "navigation": (String data) => BottomSheetPage(
              title: data,
            )
      },
      {
        "title": "QR Generateur",
        "navigation": (String data) => QRCodeGeneratorPage(
              title: data,
            )
      },
      {
        "title": "QR Scanner",
        "navigation": (String data) => QRCodeScannerPage(
              title: data,
            )
      },
      {
        "title": "Jouer du son",
        "navigation": (String data) => PlaySoundPage(
              title: data,
            )
      },
      {
        "title": "Localisation",
        "navigation": (String data) => LocationPage(
              title: data,
            )
      },
      {
        "title": "Notifications",
        "navigation": (String data) => NotificationPage(
              title: data,
            )
      },
      {
        "title": "Chat Page",
        "navigation": (String data) => ChatPage(
              title: data,
            )
      },
      {
        "title": "Calendar Page",
        "navigation": (String data) => CalendarPage(
              title: data,
            )
      }
    ];

    int? selectedPAgeIndex = context.watch<AppController>().selectedPageIndex;
    print('selected $selectedPAgeIndex');
    bool status = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.home),
        title: status
            ? ListView()
            : Text(
                'ODC : Flutter',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status)
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
            height: 20,
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
                  tileColor: selectedPAgeIndex == index
                      ? Colors.orange.withOpacity(.3)
                      : Colors.transparent,
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
                  onTap: () => naviguerVersToastPage(context, option, index),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  naviguerVersToastPage(BuildContext context, Map option, int index) {
    context.read<AppController>().changeSelectedPageIndex(index);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      var titre = "#${index + 1}: ${option['title']}";
      var fonctionNavigation = option['navigation'];
      return fonctionNavigation(titre); //
    }));
  }
}
