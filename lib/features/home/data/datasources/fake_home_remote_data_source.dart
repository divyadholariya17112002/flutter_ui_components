import 'package:flutter_ui_components/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_ui_components/features/home/data/models/home_item_model.dart';

/// Simulated home feed for development — avoids ReqRes API key requirements.
class FakeHomeRemoteDataSource implements HomeRemoteDataSource {
  static const Duration networkDelay = Duration(milliseconds: 800);

  static const List<HomeItemModel> demoUsers = [
    HomeItemModel(
      id: 1,
      email: 'george.bluth@reqres.in',
      firstName: 'George',
      lastName: 'Bluth',
      avatar: 'https://reqres.in/img/faces/1-image.jpg',
    ),
    HomeItemModel(
      id: 2,
      email: 'janet.weaver@reqres.in',
      firstName: 'Janet',
      lastName: 'Weaver',
      avatar: 'https://reqres.in/img/faces/2-image.jpg',
    ),
    HomeItemModel(
      id: 3,
      email: 'emma.wong@reqres.in',
      firstName: 'Emma',
      lastName: 'Wong',
      avatar: 'https://reqres.in/img/faces/3-image.jpg',
    ),
    HomeItemModel(
      id: 4,
      email: 'eve.holt@reqres.in',
      firstName: 'Eve',
      lastName: 'Holt',
      avatar: 'https://reqres.in/img/faces/4-image.jpg',
    ),
    HomeItemModel(
      id: 5,
      email: 'charles.morris@reqres.in',
      firstName: 'Charles',
      lastName: 'Morris',
      avatar: 'https://reqres.in/img/faces/5-image.jpg',
    ),
    HomeItemModel(
      id: 6,
      email: 'tracey.ramos@reqres.in',
      firstName: 'Tracey',
      lastName: 'Ramos',
      avatar: 'https://reqres.in/img/faces/6-image.jpg',
    ),
  ];

  @override
  Future<List<HomeItemModel>> getHomeItems() async {
    await Future<void>.delayed(networkDelay);
    return demoUsers;
  }
}
