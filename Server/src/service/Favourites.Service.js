const favouritesModel = require('../model/Favourites.Model');

class FavouritesService {
  static async addToFavourites(userId, productId) {
    try {
      const favourite = new favouritesModel({
        userId: userId,
        productId: productId,
      });
      await favourite.save();
      return {
        status: 201,
        message: 'Thêm sản phẩm vào danh sách yêu thích thành công',
        data: favourite,
      };
    } catch (error) {
      console.log('🚀 ~ FavouritesService ~ addToFavourites ~ error:', error);
      return {
        status: 500,
        message: error.message,
        data: null,
      };
    }
  }

  static async getFavourites(userId) {
    try {
      const favourites = await favouritesModel
        .find({userId: userId})
        .populate('productId');
      return {
        status: 200,
        message: 'Danh sách sản phẩm yêu thích',
        data: favourites,
      };
    } catch (error) {
      return {
        status: 500,
        message: error.message,
        data: null,
      };
    }
  }

  static async removeFromFavourites(id) {
    try {
      const favourite = await favouritesModel.findByIdAndDelete(id);
      return {
        status: 200,
        message: 'Xóa sản phẩm khỏi danh sách yêu thích thành công',
        data: favourite,
      };
    } catch (error) {
      return {
        status: 500,
        message: error.message,
        data: null,
      };
    }
  }
}

module.exports = FavouritesService;
