// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nutrisolutions_mobile/data/models/recipe_model.dart';

class RecipesScreenState {
  final String searchText;
  final int page;
  final int limit;
  final String? objectif;
  final String? category;
  final bool areFiltersOpen;

  RecipesScreenState({
    this.searchText = '',
    this.page = 1,
    this.limit = 6,
    this.objectif = 'Tous',
    this.category = 'Tous',
    this.areFiltersOpen = false,
  });

  RecipesScreenState copyWith(
      {String? searchText,
      int? page,
      int? limit,
      String? objectif,
      String? category,
      bool? areFiltesrOpen}) {
    return RecipesScreenState(
        searchText: searchText ?? this.searchText,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        objectif: objectif ?? this.objectif,
        category: category ?? this.category,
        areFiltersOpen: areFiltesrOpen ?? areFiltersOpen);
  }

  @override
  bool operator ==(covariant RecipesScreenState other) {
    if (identical(this, other)) return true;

    return other.searchText == searchText &&
        other.page == page &&
        other.limit == limit &&
        other.objectif == objectif &&
        other.category == category &&
        other.areFiltersOpen == areFiltersOpen;
  }

  @override
  int get hashCode {
    return searchText.hashCode ^
        page.hashCode ^
        limit.hashCode ^
        objectif.hashCode ^
        areFiltersOpen.hashCode ^
        category.hashCode;
  }

  @override
  String toString() {
    return 'RecipesScreenState(searchText: $searchText, page: $page, limit: $limit, objectif: $objectif, category: $category, areFiltersOpen: $areFiltersOpen)';
  }
}
