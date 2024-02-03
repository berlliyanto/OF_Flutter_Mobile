String queryBuilder({required String activeQuery, String query = ""}) {
  if (query.isEmpty) {
    return activeQuery;
  }

  List<String> activeQueryParts = activeQuery.split('&');
  List<String> queryParts = query.split('=');

  String queryKey = queryParts[0];
  String queryValue = queryParts.length > 1 ? queryParts[1] : "";

  bool keyExists =
      activeQueryParts.any((part) => part.startsWith('$queryKey='));

  if (keyExists) {
    List<String> updatedQueryParts = activeQueryParts.map((part) {
      if (part.startsWith('$queryKey=')) {
        return '$queryKey=$queryValue';
      }
      return part;
    }).toList();

    return updatedQueryParts.join('&');
  } else {
    return '$activeQuery&$query';
  }
}

String removeQuery(String queryString, String filter) {
  List<String> parts = queryString.split('&');
  List<String> filteredParts = [];

  for (String part in parts) {
    if (!part.contains(filter)) {
      filteredParts.add(part);
    }
  }

  return filteredParts.join('&');
}
