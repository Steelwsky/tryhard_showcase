// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stopwatch_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StopwatchState _$$_StopwatchStateFromJson(Map<String, dynamic> json) =>
    _$_StopwatchState(
      currentView: $enumDecode(_$StopwatchViewEnumMap, json['currentView']),
      isMuted: json['isMuted'] as bool,
      durationInSecs: json['durationInSecs'] as int,
    );

Map<String, dynamic> _$$_StopwatchStateToJson(_$_StopwatchState instance) =>
    <String, dynamic>{
      'currentView': _$StopwatchViewEnumMap[instance.currentView]!,
      'isMuted': instance.isMuted,
      'durationInSecs': instance.durationInSecs,
    };

const _$StopwatchViewEnumMap = {
  StopwatchView.stopwatch: 'stopwatch',
  StopwatchView.settings: 'settings',
};
