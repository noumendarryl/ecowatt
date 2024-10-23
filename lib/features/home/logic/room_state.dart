import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/room_model.dart';

part 'room_state.freezed.dart';

@freezed
class RoomState with _$RoomState {
  const factory RoomState.initial() = RoomInitial;
  const factory RoomState.loading() = RoomLoading;
  const factory RoomState.loaded(List<RoomModel> rooms) = RoomLoaded;
  const factory RoomState.detailsLoaded(RoomModel room) = RoomDetailsLoaded;
  const factory RoomState.error(String message) = RoomError;
}
