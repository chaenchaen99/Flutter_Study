

part of 'name_bloc.dart';

sealed class NameEvent {
  const NameEvent();
}

final class NameChanged extends NameEvent {
  final String name;
  const NameChanged(this.name);
}