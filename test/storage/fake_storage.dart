import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeStorage extends Mock implements Storage {}

late Storage hydratedStorage;

void initHydratedStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  hydratedStorage = FakeStorage();
  when(() => hydratedStorage.write(any(), any<dynamic>()))
      .thenAnswer((_) async {});
  when<dynamic>(() => hydratedStorage.read(any()))
      .thenReturn(<String, dynamic>{});
  when(() => hydratedStorage.delete(any())).thenAnswer((_) async {});
  when(() => hydratedStorage.clear()).thenAnswer((_) async {});
  HydratedBloc.storage = hydratedStorage;
}
