import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'model/completion.dart';

part 'api_service.g.dart';

//`ApiService` 클래스가 OpenAI API와 통신하기 위한 기본 URL을 설정
@RestApi(baseUrl: 'https://api.openai.com/v1')
abstract class ApiService { //ApiService`는 추상 클래스로 선언되어 있으며, 이는 직접 인스턴스를 생성할 수 없음을 의미한다.대신, `Dio`를 사용하여 구현된 인스턴스를 생성해야 한다.
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService; //Dio` 인스턴스와 선택적으로 `baseUrl`을 인자로 받아 `_ApiService`의 인스턴스를 생성한다. 이는 `Dio`를 사용하여 HTTP 요청을 보내는 구현체를 생성하는 방법이다.

  @POST('/chat/completions') //getCompletion` 메서드는 `CompletionRequest` 객체를 받아, 비동기적으로 `CompletionResponse` 객체를 반환
  Future<CompletionResponse> getCompletion(@Body() CompletionRequest request);
}