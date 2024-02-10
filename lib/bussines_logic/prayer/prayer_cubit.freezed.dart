// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PrayerState {
  DataStatus get datastatus => throw _privateConstructorUsedError;
  PrayersTimeModel? get preyerTimes => throw _privateConstructorUsedError;
  PrayerTimesEntity? get currentDay => throw _privateConstructorUsedError;
  PrayerTimesEntity? get nextDay => throw _privateConstructorUsedError;
  NextTime? get nextTime => throw _privateConstructorUsedError;
  PrayerTimesEntity? get agoDay => throw _privateConstructorUsedError;
  bool get timer => throw _privateConstructorUsedError;
  int get dayNumber => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)?
        initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PrayerStateCopyWith<PrayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerStateCopyWith<$Res> {
  factory $PrayerStateCopyWith(
          PrayerState value, $Res Function(PrayerState) then) =
      _$PrayerStateCopyWithImpl<$Res, PrayerState>;
  @useResult
  $Res call(
      {DataStatus datastatus,
      PrayersTimeModel? preyerTimes,
      PrayerTimesEntity? currentDay,
      PrayerTimesEntity? nextDay,
      NextTime? nextTime,
      PrayerTimesEntity? agoDay,
      bool timer,
      int dayNumber});
}

/// @nodoc
class _$PrayerStateCopyWithImpl<$Res, $Val extends PrayerState>
    implements $PrayerStateCopyWith<$Res> {
  _$PrayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? preyerTimes = freezed,
    Object? currentDay = freezed,
    Object? nextDay = freezed,
    Object? nextTime = freezed,
    Object? agoDay = freezed,
    Object? timer = null,
    Object? dayNumber = null,
  }) {
    return _then(_value.copyWith(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      preyerTimes: freezed == preyerTimes
          ? _value.preyerTimes
          : preyerTimes // ignore: cast_nullable_to_non_nullable
              as PrayersTimeModel?,
      currentDay: freezed == currentDay
          ? _value.currentDay
          : currentDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      nextDay: freezed == nextDay
          ? _value.nextDay
          : nextDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      nextTime: freezed == nextTime
          ? _value.nextTime
          : nextTime // ignore: cast_nullable_to_non_nullable
              as NextTime?,
      agoDay: freezed == agoDay
          ? _value.agoDay
          : agoDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as bool,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $PrayerStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DataStatus datastatus,
      PrayersTimeModel? preyerTimes,
      PrayerTimesEntity? currentDay,
      PrayerTimesEntity? nextDay,
      NextTime? nextTime,
      PrayerTimesEntity? agoDay,
      bool timer,
      int dayNumber});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$PrayerStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? datastatus = null,
    Object? preyerTimes = freezed,
    Object? currentDay = freezed,
    Object? nextDay = freezed,
    Object? nextTime = freezed,
    Object? agoDay = freezed,
    Object? timer = null,
    Object? dayNumber = null,
  }) {
    return _then(_$InitialImpl(
      datastatus: null == datastatus
          ? _value.datastatus
          : datastatus // ignore: cast_nullable_to_non_nullable
              as DataStatus,
      preyerTimes: freezed == preyerTimes
          ? _value.preyerTimes
          : preyerTimes // ignore: cast_nullable_to_non_nullable
              as PrayersTimeModel?,
      currentDay: freezed == currentDay
          ? _value.currentDay
          : currentDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      nextDay: freezed == nextDay
          ? _value.nextDay
          : nextDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      nextTime: freezed == nextTime
          ? _value.nextTime
          : nextTime // ignore: cast_nullable_to_non_nullable
              as NextTime?,
      agoDay: freezed == agoDay
          ? _value.agoDay
          : agoDay // ignore: cast_nullable_to_non_nullable
              as PrayerTimesEntity?,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as bool,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.datastatus = DataStatus.ideal,
      this.preyerTimes,
      this.currentDay,
      this.nextDay,
      this.nextTime,
      this.agoDay,
      this.timer = false,
      this.dayNumber = 0});

  @override
  @JsonKey()
  final DataStatus datastatus;
  @override
  final PrayersTimeModel? preyerTimes;
  @override
  final PrayerTimesEntity? currentDay;
  @override
  final PrayerTimesEntity? nextDay;
  @override
  final NextTime? nextTime;
  @override
  final PrayerTimesEntity? agoDay;
  @override
  @JsonKey()
  final bool timer;
  @override
  @JsonKey()
  final int dayNumber;

  @override
  String toString() {
    return 'PrayerState.initial(datastatus: $datastatus, preyerTimes: $preyerTimes, currentDay: $currentDay, nextDay: $nextDay, nextTime: $nextTime, agoDay: $agoDay, timer: $timer, dayNumber: $dayNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.datastatus, datastatus) ||
                other.datastatus == datastatus) &&
            (identical(other.preyerTimes, preyerTimes) ||
                other.preyerTimes == preyerTimes) &&
            (identical(other.currentDay, currentDay) ||
                other.currentDay == currentDay) &&
            (identical(other.nextDay, nextDay) || other.nextDay == nextDay) &&
            (identical(other.nextTime, nextTime) ||
                other.nextTime == nextTime) &&
            (identical(other.agoDay, agoDay) || other.agoDay == agoDay) &&
            (identical(other.timer, timer) || other.timer == timer) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, datastatus, preyerTimes,
      currentDay, nextDay, nextTime, agoDay, timer, dayNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)
        initial,
  }) {
    return initial(datastatus, preyerTimes, currentDay, nextDay, nextTime,
        agoDay, timer, dayNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)?
        initial,
  }) {
    return initial?.call(datastatus, preyerTimes, currentDay, nextDay, nextTime,
        agoDay, timer, dayNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DataStatus datastatus,
            PrayersTimeModel? preyerTimes,
            PrayerTimesEntity? currentDay,
            PrayerTimesEntity? nextDay,
            NextTime? nextTime,
            PrayerTimesEntity? agoDay,
            bool timer,
            int dayNumber)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(datastatus, preyerTimes, currentDay, nextDay, nextTime,
          agoDay, timer, dayNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements PrayerState {
  const factory _Initial(
      {final DataStatus datastatus,
      final PrayersTimeModel? preyerTimes,
      final PrayerTimesEntity? currentDay,
      final PrayerTimesEntity? nextDay,
      final NextTime? nextTime,
      final PrayerTimesEntity? agoDay,
      final bool timer,
      final int dayNumber}) = _$InitialImpl;

  @override
  DataStatus get datastatus;
  @override
  PrayersTimeModel? get preyerTimes;
  @override
  PrayerTimesEntity? get currentDay;
  @override
  PrayerTimesEntity? get nextDay;
  @override
  NextTime? get nextTime;
  @override
  PrayerTimesEntity? get agoDay;
  @override
  bool get timer;
  @override
  int get dayNumber;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
