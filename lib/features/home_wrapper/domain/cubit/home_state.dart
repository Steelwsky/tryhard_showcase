part of 'home_cubit.dart';

@Freezed(
  fromJson: false,
  toJson: false,
)
class HomeWrapperState with _$HomeWrapperState {
  const factory HomeWrapperState({
    required int page,
    required List<Widget> pages,
    required List<BottomNavBarItemModel> tabs,
  }) = _HomeWrapperState;
}
