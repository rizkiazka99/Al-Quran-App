extension StringExtension on String {
  capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}