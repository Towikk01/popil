part of 'items_bloc.dart';

@immutable
abstract class ItemsEvent extends Equatable {}

class LoadItems extends ItemsEvent {
  final String link;
  final int page;
  final Map<String, String>? filters; // Optional filters map

  LoadItems(this.link, this.page, {this.filters});

  @override
  List<Object?> get props => [link, page, filters];
}

class LoadNextPage extends ItemsEvent {
  final String link;
  final int page;
  final Map<String, String>? filters;

  LoadNextPage(this.link, this.page, {this.filters});

  @override
  List<Object?> get props => [link, page, filters];
}
