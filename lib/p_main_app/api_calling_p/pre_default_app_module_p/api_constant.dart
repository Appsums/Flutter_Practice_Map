const imageNotFoundC =
    'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';

const baseUrl = 'https://java.powerkickcorp.com/';
const baseUrlDevC = 'https://java.powerkickcorp.com/';
const baseUrlProC = 'https://java.powerkickcorp.com/';

const baseImageUrl = 'https://power-kick.s3.ap-northeast-2.amazonaws.com/';
const baseImageUrlDevC = 'https://power-kick.s3.ap-northeast-2.amazonaws.com/';
const baseImageUrlProC = 'https://power-kick.s3.ap-northeast-2.amazonaws.com/'; // Production API's

const languageCodeC = 'language';
const countryCodeC = 'country';
const selectedLanguageC = 'selected_language';
const isNotFirstTime = 'is_not_first_time';
const selectedLanguageEnglishC = 'lang_eng';
const selectedLanguageKoreanC = 'lang_kor';
const userIdC = 'user_id';
const mobileC = 'mobile';
const nameC = 'name';
const accessTokenC = 'access_token';
const deviceTypeC = 'device_type';
const nationMobileC = 'nation_mobile';
const emailC = 'email';
const nationCodeC = 'nation_code';
const userProfileImageC = 'profile_image';
const sessionIdC = 'session_id';
const getOtpC = 'customer/mobile/code/';
const getUserInfoC = 'customer/user-info';
const verifyOtpC = 'customer/loginByCode/';
const getOrderListC = 'customer/order/list?';
const getStoreIndexC = 'customer/store/index/';
const getStationListC = 'customer/store/list?';
const getStationDetailC = 'customer/store/detail?';
const searchStationC = 'customer/store/queryStores';
const orderPowerBankC = 'customer/order/powerbank';
const validateOrderC = 'customer/order/validate';
const orderDetailsC = 'customer/order/detail?';
const updateProfilePictureC = 'customer/upload-avatar';
const updateProfileDetailsC = 'customer/upUserInfo';
const addPaymentCardC = 'nicepay/saveCreditKey';
const getAddedCardInfoC = 'customer/card-info';
const getNotificationC = 'manager/push/list/';

class ConstantC {
  static bool isProduction = false;
  static String baseUrl = isProduction
      ? baseUrlProC
      : baseUrlDevC;

  static String baseImageUrl = isProduction
      ? baseImageUrlProC
      : baseImageUrlDevC; // Production API's  //Here 2 = production and one = develop
  static String fcmAuthKey = '';

}
