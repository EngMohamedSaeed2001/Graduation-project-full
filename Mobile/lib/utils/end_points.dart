const String baseURL = "http://10.0.2.2:8080";
//const String baseURL = "http://localhost:8080";
const String GET_USER = "$baseURL/user/getUser";

const String UPDATE_USER = "$baseURL/insecure/userDetails/updateUser";
const String VERFIY_EMAIL = "$baseURL/insecure/userDetails/checkEmail";
const String LOGIN = "$baseURL/insecure/authenticate";
const String SEND_OTP = "$baseURL/email/sendOtp";
const String VERIFY_OTP = "$baseURL/email/verifyEmail";
const String VERIFY_NID = "$baseURL/user/faceRecognition";
const String CREATE_USER = "$baseURL/insecure/userDetails";
const String GET_ALL_ADS = "$baseURL/common/getAllAds";
const String FILTER = "$baseURL/user/filter";
const String CREATE_AD = "$baseURL/user/createAd";
const String EDIT_AD = "$baseURL/user/updateAd";
const String GET_AD_BY_ID = "$baseURL/user/building";
const String GET_MY_ADS = "$baseURL/user/getMyAds";
const String GET_MY_FAVS = "$baseURL/user/getMyFavourite";
const String SIGN_OUT = "$baseURL/signOut";
const String GET_CHAT_USER = "$baseURL/chat/getChats";
const String GET_CHAT_ROOM = "$baseURL/room-semsark";
const String SEND_MESSAGE= "$baseURL/chat-semsark";
const String FORGET_PASSWORD= "$baseURL/forgetPassword/";
const String UPDATE_PASSWORD= "$baseURL/forgetPassword/updatePassword";
const String FORGETPASSWORD_CHECK_OTP= "$baseURL/forgetPassword/checkOtp";
const String ADD_TO_FAV= "$baseURL/user/addFavourite";
const String DELETE_FROM_FAV= "$baseURL/user/deleteFavourite/";
const String DELETE_ADVERTISEMENT= "$baseURL/user/deleteAd/";
const String CHECK_IS_FAV= "$baseURL/user/getMyFavouriteById/";
const String GET_RECOMMENDED_ADS= "$baseURL/user/recommendation/";
