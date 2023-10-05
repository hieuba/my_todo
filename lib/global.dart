import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_todo/services/storage_service.dart';
import 'package:path_provider/path_provider.dart';

class Global {
  static late StorageService storageService;

  static Future initGlobal() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        //
        );

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    );
    await EasyLocalization.ensureInitialized();

    storageService = await StorageService().initStorage();
  }
}
