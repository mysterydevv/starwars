class Response{
  final int status;
  final String? message;
  final dynamic data;

  Response({required this.status, required this.message, required this.data});

  static Response fromJson(responseBody) {
    return Response(
      status: responseBody['status'],
      message: responseBody['message'],
      data: responseBody['data'],
    );
  }
}