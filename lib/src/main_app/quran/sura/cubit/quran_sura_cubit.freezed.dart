// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_sura_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuranSuraState {
  DataStatus<dynamic> get dataStatus => throw _privateConstructorUsedError;
  List<SuraModel>? get quranModel => throw _privateConstructorUsedError;
  List<QuranSuraSearchItem>? get cachQuranModelForSearch =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)?
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
  $QuranSuraStateCopyWith<QuranSuraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranSuraStateCopyWith<$Res> {
  factory $QuranSuraStateCopyWith(
          QuranSuraState value, $Res Function(QuranSuraState) then) =
      _$QuranSuraStateCopyWithImpl<$Res, QuranSuraState>;
  @useResult
  $Res call(
      {DataStatus<dynamic> dataStatus,
      List<SuraModel>? quranModel,
      List<QuranSuraSearchItem>? cachQuranModelForSearch});
}

/// @nodoc
class _$QuranSuraStateCopyWithImpl<$Res, $Val extends QuranSuraState>
    implements $QuranSuraStateCopyWith<$Res> {
  _$QuranSuraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = null,
    Object? quranModel = freezed,
    Object? cachQuranModelForSearch = freezed,
  }) {
    return _then(_value.copyWith(
      dataStatus: null == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>,
      quranModel: freezed == quranModel
          ? _value.quranModel
          : quranModel // ignore: cast_nullable_to_non_nullable
              as List<SuraModel>?,
      cachQuranModelForSearch: freezed == cachQuranModelForSearch
          ? _value.cachQuranModelForSearch
          : cachQuranModelForSearch // ignore: cast_nullable_to_non_nullable
              as List<QuranSuraSearchItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $QuranSuraStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DataStatus<dynamic> dataStatus,
      List<SuraModel>? quranModel,
      List<QuranSuraSearchItem>? cachQuranModelForSearch});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$QuranSuraStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = null,
    Object? quranModel = freezed,
    Object? cachQuranModelForSearch = freezed,
  }) {
    return _then(_$InitialImpl(
      dataStatus: null == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>,
      quranModel: freezed == quranModel
          ? _value._quranModel
          : quranModel // ignore: cast_nullable_to_non_nullable
              as List<SuraModel>?,
      cachQuranModelForSearch: freezed == cachQuranModelForSearch
          ? _value._cachQuranModelForSearch
          : cachQuranModelForSearch // ignore: cast_nullable_to_non_nullable
              as List<QuranSuraSearchItem>?,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {required this.dataStatus,
      final List<SuraModel>? quranModel,
      final List<QuranSuraSearchItem>? cachQuranModelForSearch})
      : _quranModel = quranModel,
        _cachQuranModelForSearch = cachQuranModelForSearch;

  @override
  final DataStatus<dynamic> dataStatus;
  final List<SuraModel>? _quranModel;
  @override
  List<SuraModel>? get quranModel {
    final value = _quranModel;
    if (value == null) return null;
    if (_quranModel is EqualUnmodifiableListView) return _quranModel;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<QuranSuraSearchItem>? _cachQuranModelForSearch;
  @override
  List<QuranSuraSearchItem>? get cachQuranModelForSearch {
    final value = _cachQuranModelForSearch;
    if (value == null) return null;
    if (_cachQuranModelForSearch is EqualUnmodifiableListView)
      return _cachQuranModelForSearch;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'QuranSuraState.initial(dataStatus: $dataStatus, quranModel: $quranModel, cachQuranModelForSearch: $cachQuranModelForSearch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.dataStatus, dataStatus) ||
                other.dataStatus == dataStatus) &&
            const DeepCollectionEquality()
                .equals(other._quranModel, _quranModel) &&
            const DeepCollectionEquality().equals(
                other._cachQuranModelForSearch, _cachQuranModelForSearch));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      dataStatus,
      const DeepCollectionEquality().hash(_quranModel),
      const DeepCollectionEquality().hash(_cachQuranModelForSearch));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)
        initial,
  }) {
    return initial(dataStatus, quranModel, cachQuranModelForSearch);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)?
        initial,
  }) {
    return initial?.call(dataStatus, quranModel, cachQuranModelForSearch);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            DataStatus<dynamic> dataStatus,
            List<SuraModel>? quranModel,
            List<QuranSuraSearchItem>? cachQuranModelForSearch)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(dataStatus, quranModel, cachQuranModelForSearch);
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

abstract class _Initial implements QuranSuraState {
  const factory _Initial(
          {required final DataStatus<dynamic> dataStatus,
          final List<SuraModel>? quranModel,
          final List<QuranSuraSearchItem>? cachQuranModelForSearch}) =
      _$InitialImpl;

  @override
  DataStatus<dynamic> get dataStatus;
  @override
  List<SuraModel>? get quranModel;
  @override
  List<QuranSuraSearchItem>? get cachQuranModelForSearch;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
