library stripe_platform_interface;

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'models.dart';
import 'src/method_channel_stripe.dart';
import 'src/models/setup_intent.dart';

export 'models.dart';

abstract class StripePlatform extends PlatformInterface {
  StripePlatform() : super(token: _token);

  static final Object _token = Object();

  static StripePlatform _instance = MethodChannelStripeFactory().create();

  /// The default instance of [StripePlatform] to use.
  ///
  /// Defaults to [MethodChannelStripe].
  static StripePlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [StripePlatform] when they register themselves.
  static set instance(StripePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialise({
    required String publishableKey,
    String? stripeAccountId,
    ThreeDSecureConfigurationParams? threeDSecureParams,
    String? merchantIdentifier,
    String? urlScheme,
  });

  Future<PaymentMethod> createPaymentMethod(
    PaymentMethodParams data, [
    Map<String, String> options = const {},
  ]);

  Future<PaymentIntent> handleCardAction(String paymentIntentClientSecret);
  Future<PaymentIntent> confirmPaymentMethod(
      String paymentIntentClientSecret, PaymentMethodParams params,
      [Map<String, String> options = const {}]);
  Future<void> configure3dSecure(ThreeDSecureConfigurationParams params);
  Future<bool> isApplePaySupported() async {
    return false;
  }

  Future<void> presentApplePay(ApplePayPresentParams params);
  Future<void> confirmApplePayPayment(String clientSecret);
  Future<SetupIntent> confirmSetupIntent(
      String setupIntentClientSecret, PaymentMethodParams data,
      [Map<String, String> options = const {}]);
  Future<PaymentIntent> retrievePaymentIntent(String clientSecret);
  Future<String> createTokenForCVCUpdate(String cvc);

}
