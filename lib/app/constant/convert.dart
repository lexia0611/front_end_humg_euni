String listIntToString(List<int?> numbers) {
  return numbers.join();
}

List<int?> stringToListInt(String str) {
  return str.split('').map((char) => int.parse(char)).toList();
}
