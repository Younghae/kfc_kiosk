class Formatters {
  static String formatPrice(int price) {
    return '₩${price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  static String formatOrderNumber(String orderId) {
    return '#${orderId.substring(orderId.length - 3)}';
  }

  static String formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
