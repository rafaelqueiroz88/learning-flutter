import '../models/product.dart';
import './users_products.dart';

mixin ProductsModel on UsersProductsModel {

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites)
      return List.from(products.where((Product product) => product.isFavorite).toList());
    return List.from(products);
  }

  int get selectProductIndex {
    return chosedProductIndex;
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  Product get selectedProduct {
    if (chosedProductIndex == null)
      return null;
    return products[chosedProductIndex];
  }

  void toggleProductFavorite() {
    final bool favoriteStatus = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !favoriteStatus;
    final Product updatedProduct = Product(
      title: selectedProduct.title, 
      description: selectedProduct.description, 
      price: selectedProduct.price, 
      image: selectedProduct.image,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavorite: newFavoriteStatus 
    );
    products[chosedProductIndex] = updatedProduct;
    chosedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(String title, String description, String image, double price) {
    final Product updateProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId
    );
    products[chosedProductIndex] = updateProduct;
    chosedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(chosedProductIndex);
    notifyListeners();
  }

  void selectProduct(int index) {
    chosedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}