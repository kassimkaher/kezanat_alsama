import 'package:ramadan/utils/utils.dart';

const host = "https://api.feed.app/v1";
const hostP = "https://api.feed.app/python";
const guestUrl = "$host/guest/signIn";
const sentOTPURL = "$host/customer/sendOtp";
const verifyOtpUrl = "$host/customer/verifyOtp";
const signupUrl = "$host/signUp";
const signInUrl = "$host/signIn";
const logoutUrl = "$host/customer/logout";
const getProfileUrl = "$host/customer/profile";
const addressUrl = "$host/address";
const defaultAddressUrl = "$host/defaultAddress";
const cartUrl = "$host/cart";
const orderUrl = "$host/order";
const reorderUrl = "$host/reOrder";
const ordersUrl = "$host/orders?limit=10&skip=0&status=0";
const ordersDetailsUrl = "$host/orders/details?";
const getCategoryListUrl = "$hostP/category/list?requestFrom=1";
const zoneUrl = "$hostP/zones";
const searchUrl = "$hostP/search/filter/new?";
const suggestionUrl = "$hostP/suggestions?";
const refreshTokenUrl = "$host/generateToken";
const getItemDetailsUrl = "$hostP/product/details?productId=";
const favouritUrl = "$hostP/favourite/product/";
const homeUrl = "$hostP/v4/home/page?";
const notificationUrl = "$hostP/user/notification?";
const favoruteUrl = "$hostP/wishList/";
const storeUrl = "$hostP/get/fcstore?";
const walletUrl = "$host/wallet?userType=customer&userId=";

//chat route

const createUserZendeskUrl = "$host/zendesk/user";
const createTicketkUrl = "$host/zendesk/ticket";
const addCommentUrl = "$host/zendesk/ticket/comments";
const getTicketsUrl = "$host/zendesk/user/ticket?emailId=";

const getTicktComments = "$host/zendesk/ticket/history?id=";
//sphinx

const updateUserUrl = "$host/user/edit";
const getUserUrl = "$host/users/me";
const getDashboardUrl = "$host/home/page";
const getSectionListUrl = "$host/section/list?locale=ar&offset=0";
const getSectionItemsUrl = "$host/section/items/list?section_id=";
const productDetailsUrl = "$host/product/detail/";
const getBannerUrl = "$host/banner/list?type=TABLET";
Route to(Widget page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}


// const getAddressListUrl = "$host/address/list?offset=";
// const postAddress = "$host/address";
// const updateAddressUrl = "$host/address/edit";
// const deleteAddressUrl = "$host/address/";

// const getCartListUrl = "$host/cart/list?offset=";

// const removeCart = "$host/remove/cart/";

// const getProductListUrl = "$host/product/list?offset=";
// const catImageUrl = "https://feedapi.winayak.com/categories";
