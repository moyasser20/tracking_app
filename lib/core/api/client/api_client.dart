import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_request.dart';
import 'package:tarcking_app/features/auth/data/models/login/login_response.dart';
import '../../../features/auth/data/models/forget_password_models/forget_password_request.dart';
import '../../../features/auth/data/models/forget_password_models/reset_password_request_model.dart';
import '../../../features/auth/data/models/forget_password_models/verify_code_request_model.dart';
import '../../../features/homescreen/data/models/orders_list_response.dart';
import '../../../features/myorders/data/models/my_order_list_response.dart';
import '../../../features/order_details/data/models/update_order_state_request_model.dart';
import '../../../features/order_details/data/models/update_order_state_response_model.dart';
import '../../../features/profile/data/models/change_password_request_model.dart';
import '../../../features/profile/data/models/change_password_response_model.dart';
import '../../../features/profile/data/models/edit_profile_request_model.dart';
import '../../../features/profile/data/models/edit_profile_response_model.dart';
import '../../../features/profile/data/models/profile_response.dart';
import '../../../features/profile/data/models/upload_photo_response.dart';
import '../api_constants/api_end_points.dart';

part 'api_client.g.dart';

@injectable
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _ApiClient;

  @POST(ApiEndPoints.forgetPassword)
  Future<String> forgetPassword(
    @Body() ForgetPasswordRequestModel forgetPasswordRequestModel,
  );

  @POST(ApiEndPoints.verifyReset)
  Future<String> verifyResetCode(
    @Body() VerifyCodeRequestModel verifyResetCode,
  );

  @PUT(ApiEndPoints.resetPassword)
  Future<String> resetPassword(
    @Body() ResetPasswordRequestModel resetPasswordRequestModel,
  );

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);

  @GET(ApiEndPoints.logout)
  @Extra({'auth': true})
  Future<String> logout();

  @GET(ApiEndPoints.profileData)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();

  @PATCH(ApiEndPoints.changePassword)
  @Extra({'auth': true})
  Future<ChangePasswordResponseModel> changePassword(
    @Body() ChangePasswordRequestModel changePasswordRequestModel,
  );

  @PUT(ApiEndPoints.editProfile)
  @Extra({'auth': true})
  Future<EditProfileResponseModel> editProfile(
    @Body() EditProfileRequestModel model,
  );

  @PUT(ApiEndPoints.uploadPhoto)
  @MultiPart()
  @Extra({'auth': true})
  Future<UploadPhotoResponse> uploadPhoto(@Part(name: "photo") File photo);

  @GET(ApiEndPoints.pendingOrders)
  Future<OrdersListResponse> getOrders(
    @Header("Authorization") String bearerToken,
    @Query("limit") int limit,
    @Query("page") int page,
  );

  @GET(ApiEndPoints.orders)
  Future<MyOrdersListResponse> getAllOrders(
    @Header("Authorization") String bearerToken,
  );

  @PUT('${ApiEndPoints.updateOrderState}/{orderId}')
  @Extra({'auth': true})
  Future<UpdateOrderStateResponse> updateOrderState(
    @Path('orderId') String orderId,
    @Body() UpdateOrderStateRequest request,
  );
}
