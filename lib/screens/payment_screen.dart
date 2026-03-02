import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class PaymentScreen extends StatefulWidget {
  final double totalAmount;
  final String? discountCode;
  final double discount;

  const PaymentScreen({
    super.key,
    required this.totalAmount,
    this.discountCode,
    required this.discount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'card';
  bool _isProcessing = false;

  void _processPayment() {
    setState(() {
      _isProcessing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      // FIX: Clear the cart after successful payment so ordered items don't
      // persist when the user returns to the dashboard via "Continue Shopping".
      context.read<CartProvider>().clearCart();

      // Navigate to order confirmation and remove all screens up to /main
      // so back-navigation from the confirmation screen is not possible.
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/order-confirmation',
        (route) => route.settings.name == '/main',
        arguments: {
          'totalAmount': widget.totalAmount,
          'discountCode': widget.discountCode,
          'discountAmount': widget.discount,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '\$${widget.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (widget.discountCode != null) ...[
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount (${widget.discountCode})',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '-\$${widget.discount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFF6B35),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${(widget.totalAmount - widget.discount).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B35),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Credit Card Option
              GestureDetector(
                onTap: () => setState(() => _selectedPaymentMethod = 'card'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _selectedPaymentMethod == 'card'
                        ? const Color(0xFFFF6B35).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedPaymentMethod == 'card'
                          ? const Color(0xFFFF6B35)
                          : Colors.grey[300]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: _selectedPaymentMethod == 'card'
                            ? const Color(0xFFFF6B35)
                            : Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credit/Debit Card',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Visa, Mastercard, Amex',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedPaymentMethod == 'card')
                        const Icon(Icons.check_circle,
                            color: Color(0xFFFF6B35)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Wallet Option
              GestureDetector(
                onTap: () => setState(() => _selectedPaymentMethod = 'wallet'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _selectedPaymentMethod == 'wallet'
                        ? const Color(0xFFFF6B35).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedPaymentMethod == 'wallet'
                          ? const Color(0xFFFF6B35)
                          : Colors.grey[300]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.wallet,
                        color: _selectedPaymentMethod == 'wallet'
                            ? const Color(0xFFFF6B35)
                            : Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Digital Wallet',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Google Pay, Apple Pay',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedPaymentMethod == 'wallet')
                        const Icon(Icons.check_circle,
                            color: Color(0xFFFF6B35)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // UPI Option
              GestureDetector(
                onTap: () => setState(() => _selectedPaymentMethod = 'upi'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _selectedPaymentMethod == 'upi'
                        ? const Color(0xFFFF6B35).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedPaymentMethod == 'upi'
                          ? const Color(0xFFFF6B35)
                          : Colors.grey[300]!,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.qr_code_2,
                        color: _selectedPaymentMethod == 'upi'
                            ? const Color(0xFFFF6B35)
                            : Colors.grey,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UPI',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'GooglePay, PhonePe, PayTM',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_selectedPaymentMethod == 'upi')
                        const Icon(Icons.check_circle,
                            color: Color(0xFFFF6B35)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _processPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                disabledBackgroundColor: Colors.grey[400],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Complete Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
