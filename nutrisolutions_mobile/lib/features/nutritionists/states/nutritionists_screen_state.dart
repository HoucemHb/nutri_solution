// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NutritionistsScreenState {
  final String searchText;
  final int page;
  final int limit;
  final String? experienceYears;
  final bool areFiltersOpen;

  NutritionistsScreenState({
    this.searchText = '',
    this.page = 1,
    this.limit = 6,
    this.experienceYears = 'Tous',
    this.areFiltersOpen = false,
  });

  NutritionistsScreenState copyWith({
    String? searchText,
    int? page,
    int? limit,
    String? experienceYears,
    bool? areFiltersOpen,
  }) {
    return NutritionistsScreenState(
      searchText: searchText ?? this.searchText,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      experienceYears: experienceYears ?? this.experienceYears,
      areFiltersOpen: areFiltersOpen ?? this.areFiltersOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'searchText': searchText,
      'page': page,
      'limit': limit,
      'experienceYears': experienceYears,
      'areFiltersOpen': areFiltersOpen,
    };
  }

  factory NutritionistsScreenState.fromMap(Map<String, dynamic> map) {
    return NutritionistsScreenState(
      searchText: map['searchText'] as String,
      page: map['page'] as int,
      limit: map['limit'] as int,
      experienceYears: map['experienceYears'] != null
          ? map['experienceYears'] as String
          : null,
      areFiltersOpen: map['areFiltersOpen'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NutritionistsScreenState.fromJson(String source) =>
      NutritionistsScreenState.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NutritionistsScreenState(searchText: $searchText, page: $page, limit: $limit, experienceYears: $experienceYears, areFiltersOpen: $areFiltersOpen)';
  }

  @override
  bool operator ==(covariant NutritionistsScreenState other) {
    if (identical(this, other)) return true;

    return other.searchText == searchText &&
        other.page == page &&
        other.limit == limit &&
        other.experienceYears == experienceYears &&
        other.areFiltersOpen == areFiltersOpen;
  }

  @override
  int get hashCode {
    return searchText.hashCode ^
        page.hashCode ^
        limit.hashCode ^
        experienceYears.hashCode ^
        areFiltersOpen.hashCode;
  }
}
