List<T> search<T extends Searchable>(List<T> items, String query) {
  return items.where((item) => item.matches(query)).toList();
}
abstract class Searchable {
  bool matches(String query);
}
