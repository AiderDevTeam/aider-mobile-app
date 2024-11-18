import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';


class ShareLinkUtil {
  static final ShareLinkUtil _launcherUtil = ShareLinkUtil._internal();
  factory ShareLinkUtil() => _launcherUtil;
  ShareLinkUtil._internal();

  Future<void> shareTextToSocial(BuildContext context, {
    String text = '',
    String subject = 'Refer Family And Friends',
  }) async{
    final box = context.findRenderObject() as RenderBox?;

    try{
      await Share.shareWithResult(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }catch(e){
      log(e.toString());
    }
  }


  Future<void> shareFileToSocial(BuildContext context, {
    List<XFile> files = const [],
    String text = '',
    String subject = 'Refer Family And Friends',
  }) async{

    final box = context.findRenderObject() as RenderBox?;

    try{
      await Share.shareXFiles(
        files,
        text: text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }catch(e){
      log(e.toString());
    }
  }

}
