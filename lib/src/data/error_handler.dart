import 'dart:async';
import 'dart:io';

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is SocketException) {
      // Handle network-related errors
      return 'No Internet connection. Please check your network.';
    } else if (error is HttpException) {
      // Handle HTTP-specific errors
      return 'Failed to load data. HTTP error occurred.';
    } else if (error is FormatException) {
      // Handle JSON or response format errors
      return 'Invalid response format. Data could not be parsed.';
    } else if (error is TimeoutException) {
      // Handle request timeout
      return 'Request timeout. Please try again later.';
    } else if (error.toString().contains('404')) {
      // Handle specific error codes, e.g., "404 Not Found"
      return 'Data not found. Please try again later.';
    } else if (error.toString().contains('500')) {
      // Handle internal server errors
      return 'Server error. Please try again after some time.';
    } else if (error is Exception) {
      // Generic exception
      return 'An error occurred: ${error.toString()}';
    } else {
      // Unknown error
      return 'An unknown error occurred. Please try again.';
    }
  }
}
