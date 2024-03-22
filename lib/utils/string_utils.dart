// Function to capitalize the first letter of each word and make the rest lowercase
String capitalize(String? text) {
  if (text == null || text.isEmpty) {
    return 'No name';
  }
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}
