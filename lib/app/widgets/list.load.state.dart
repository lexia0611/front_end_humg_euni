import 'package:equatable/equatable.dart';

class ListLoadState<T> extends Equatable {
  final ListLoadStatus _status;
  final IsFullStatus _isFullStatus;
  final List<T> _list;
  const ListLoadState({
    ListLoadStatus? status,
    IsFullStatus? isFullStatus,
    List<T>? list,
  })  : _status = status ?? ListLoadStatus.initial,
        _isFullStatus = isFullStatus ?? IsFullStatus.havemore,
        _list = list ?? const [];

  ListLoadStatus get status => _status;
  IsFullStatus get isFullStatus => _isFullStatus;
  List<T> get list => _list;

  ListLoadState<T> copyWith({
    ListLoadStatus? status,
    IsFullStatus? isFullStatus,
    List<T>? list,
  }) {
    return ListLoadState<T>(
      status: status ?? _status,
      isFullStatus: isFullStatus ?? _isFullStatus,
      list: list ?? _list,
    );
  }

  @override
  List<Object> get props {
    print(_list.length);
    return [_status, _isFullStatus, _list.length, _list];
  }
}

enum ListLoadStatus { initial, loading, success, loadmore }

enum IsFullStatus { isfull, havemore }
