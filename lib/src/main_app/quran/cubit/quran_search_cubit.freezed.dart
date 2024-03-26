// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_search_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuranSearchState {
  DataStatus<dynamic>? get dataStatus => throw _privateConstructorUsedError;
  QuranModel? get quranModel =>
      throw _privateConstructorUsedError; // @Default(false) bool isSearch,
  SearchType get searchType => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataStatus<dynamic>? dataStatus,
            QuranModel? quranModel, SearchType searchType)
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus<dynamic>? dataStatus, QuranModel? quranModel,
            SearchType searchType)?
        initial,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus<dynamic>? dataStatus, QuranModel? quranModel,
            SearchType searchType)?
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
  $QuranSearchStateCopyWith<QuranSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuranSearchStateCopyWith<$Res> {
  factory $QuranSearchStateCopyWith(
          QuranSearchState value, $Res Function(QuranSearchState) then) =
      _$QuranSearchStateCopyWithImpl<$Res, QuranSearchState>;
  @useResult
  $Res call(
      {DataStatus<dynamic>? dataStatus,
      QuranModel? quranModel,
      SearchType searchType});
}

/// @nodoc
class _$QuranSearchStateCopyWithImpl<$Res, $Val extends QuranSearchState>
    implements $QuranSearchStateCopyWith<$Res> {
  _$QuranSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = freezed,
    Object? quranModel = freezed,
    Object? searchType = null,
  }) {
    return _then(_value.copyWith(
      dataStatus: freezed == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>?,
      quranModel: freezed == quranModel
          ? _value.quranModel
          : quranModel // ignore: cast_nullable_to_non_nullable
              as QuranModel?,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $QuranSearchStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DataStatus<dynamic>? dataStatus,
      QuranModel? quranModel,
      SearchType searchType});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$QuranSearchStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dataStatus = freezed,
    Object? quranModel = freezed,
    Object? searchType = null,
  }) {
    return _then(_$InitialImpl(
      dataStatus: freezed == dataStatus
          ? _value.dataStatus
          : dataStatus // ignore: cast_nullable_to_non_nullable
              as DataStatus<dynamic>?,
      quranModel: freezed == quranModel
          ? _value.quranModel
          : quranModel // ignore: cast_nullable_to_non_nullable
              as QuranModel?,
      searchType: null == searchType
          ? _value.searchType
          : searchType // ignore: cast_nullable_to_non_nullable
              as SearchType,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl(
      {this.dataStatus, this.quranModel, this.searchType = SearchType.sura});

  @override
  final DataStatus<dynamic>? dataStatus;
  @override
  final QuranModel? quranModel;
// @Default(false) bool isSearch,
  @override
  @JsonKey()
  final SearchType searchType;

  @override
  String toString() {
    return 'QuranSearchState.initial(dataStatus: $dataStatus, quranModel: $quranModel, searchType: $searchType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.dataStatus, dataStatus) ||
                other.dataStatus == dataStatus) &&
            (identical(other.quranModel, quranModel) ||
                other.quranModel == quranModel) &&
            (identical(other.searchType, searchType) ||
                other.searchType == searchType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dataStatus, quranModel, searchType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DataStatus<dynamic>? dataStatus,
            QuranModel? quranModel, SearchType searchType)
        initial,
  }) {
    return initial(dataStatus, quranModel, searchType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DataStatus<dynamic>? dataStatus, QuranModel? quranModel,
            SearchType searchType)?
        initial,
  }) {
    return initial?.call(dataStatus, quranModel, searchType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DataStatus<dynamic>? dataStatus, QuranModel? quranModel,
            SearchType searchType)?
        initial,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(dataStatus, quranModel, searchType);
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

abstract class _Initial implements QuranSearchState {
  const factory _Initial(
      {final DataStatus<dynamic>? dataStatus,
      final QuranModel? quranModel,
      final SearchType searchType}) = _$InitialImpl;

  @override
  DataStatus<dynamic>? get dataStatus;
  @override
  QuranModel? get quranModel;
  @override // @Default(false) bool isSearch,
  SearchType get searchType;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
