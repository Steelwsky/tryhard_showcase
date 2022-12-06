// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'home_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeWrapperState {
  int get page => throw _privateConstructorUsedError;

  List<Widget> get pages => throw _privateConstructorUsedError;

  List<BottomNavBarItemModel> get tabs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeWrapperStateCopyWith<HomeWrapperState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeWrapperStateCopyWith<$Res> {
  factory $HomeWrapperStateCopyWith(
          HomeWrapperState value, $Res Function(HomeWrapperState) then) =
      _$HomeWrapperStateCopyWithImpl<$Res, HomeWrapperState>;

  @useResult
  $Res call({int page, List<Widget> pages, List<BottomNavBarItemModel> tabs});
}

/// @nodoc
class _$HomeWrapperStateCopyWithImpl<$Res, $Val extends HomeWrapperState>
    implements $HomeWrapperStateCopyWith<$Res> {
  _$HomeWrapperStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? pages = null,
    Object? tabs = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      tabs: null == tabs
          ? _value.tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BottomNavBarItemModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeWrapperStateCopyWith<$Res>
    implements $HomeWrapperStateCopyWith<$Res> {
  factory _$$_HomeWrapperStateCopyWith(
          _$_HomeWrapperState value, $Res Function(_$_HomeWrapperState) then) =
      __$$_HomeWrapperStateCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({int page, List<Widget> pages, List<BottomNavBarItemModel> tabs});
}

/// @nodoc
class __$$_HomeWrapperStateCopyWithImpl<$Res>
    extends _$HomeWrapperStateCopyWithImpl<$Res, _$_HomeWrapperState>
    implements _$$_HomeWrapperStateCopyWith<$Res> {
  __$$_HomeWrapperStateCopyWithImpl(
      _$_HomeWrapperState _value, $Res Function(_$_HomeWrapperState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? pages = null,
    Object? tabs = null,
  }) {
    return _then(_$_HomeWrapperState(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<Widget>,
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BottomNavBarItemModel>,
    ));
  }
}

/// @nodoc

class _$_HomeWrapperState implements _HomeWrapperState {
  const _$_HomeWrapperState(
      {required this.page,
      required final List<Widget> pages,
      required final List<BottomNavBarItemModel> tabs})
      : _pages = pages,
        _tabs = tabs;

  @override
  final int page;
  final List<Widget> _pages;

  @override
  List<Widget> get pages {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  final List<BottomNavBarItemModel> _tabs;

  @override
  List<BottomNavBarItemModel> get tabs {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  String toString() {
    return 'HomeWrapperState(page: $page, pages: $pages, tabs: $tabs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeWrapperState &&
            (identical(other.page, page) || other.page == page) &&
            const DeepCollectionEquality().equals(other._pages, _pages) &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      const DeepCollectionEquality().hash(_pages),
      const DeepCollectionEquality().hash(_tabs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeWrapperStateCopyWith<_$_HomeWrapperState> get copyWith =>
      __$$_HomeWrapperStateCopyWithImpl<_$_HomeWrapperState>(this, _$identity);
}

abstract class _HomeWrapperState implements HomeWrapperState {
  const factory _HomeWrapperState(
      {required final int page,
      required final List<Widget> pages,
      required final List<BottomNavBarItemModel> tabs}) = _$_HomeWrapperState;

  @override
  int get page;

  @override
  List<Widget> get pages;

  @override
  List<BottomNavBarItemModel> get tabs;

  @override
  @JsonKey(ignore: true)
  _$$_HomeWrapperStateCopyWith<_$_HomeWrapperState> get copyWith =>
      throw _privateConstructorUsedError;
}
