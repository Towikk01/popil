import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<List<Map<String, dynamic>>> fetchBrands(String url) async {
    final response = await dio.get(url);
    final document = parse(response.data);
    final items = document.querySelectorAll('.child_category');

    return items.map((item) {
      return {
        'title': item.querySelector('span')?.text ?? 'Unknown',
        'image':
            item.querySelector('img')?.attributes['src'] ?? 'default_image_url',
        'link': item.attributes['href'] ?? '#',
      };
    }).toList();
  }

  Future<Map<String, dynamic>> fetchProducts(String url, int page) async {
    final fullUrl = '$url/?page=$page';

    final response = await dio.get(fullUrl);
    final document = parse(response.data);
    final itemElements = document.querySelectorAll('.product-item');
    final categoryElements = document.querySelectorAll('.child_category');
    final isLastPage = itemElements.length < 12;

    final items = itemElements.where((item) {
      var isOutOfStockElement = item.querySelector('.isnotstock');
      return isOutOfStockElement == null;
    }).map((item) {
      return {
        'price': item.querySelector('.price')?.text ?? 'No price',
        'title': item.querySelector('img')?.attributes['title'] ?? 'No title',
        'image':
            item.querySelector('img')?.attributes['src'] ?? 'default_image_url',
      };
    }).toList();

    final categories = categoryElements.map((category) {
      return {
        'title': category.querySelector('span')?.text ?? 'Unknown',
        'image': category.querySelector('img')?.attributes['src'] ??
            'default_image_url',
        'link': category.attributes['href'] ?? '#', // Use link as provided
      };
    }).toList();

    return {
      'items': items,
      'categories': categories,
      'isLastPage': isLastPage,
    };
  }
}
