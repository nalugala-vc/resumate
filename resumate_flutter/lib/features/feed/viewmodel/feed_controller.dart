import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/feed/repository/feed_repository.dart';

class FeedController extends BaseController {
  static FeedController get instance => Get.find();
  final FeedRepository _feedRepository = FeedRepository();
}
