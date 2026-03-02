import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  void _showAddCardSheet(BuildContext context) {
    final user = context.read<UserProvider>();
    final cardNumberCtrl = TextEditingController();
    final cardHolderCtrl = TextEditingController();
    final expiryCtrl = TextEditingController();
    final cvvCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Add New Card',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: cardNumberCtrl,
                keyboardType: TextInputType.number,
                maxLength: 19,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Card number required';
                  if (v.replaceAll(' ', '').length < 16)
                    return 'Enter valid 16-digit card number';
                  return null;
                },
                decoration: _inputDec('Card Number (1234 5678 9012 3456)'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: cardHolderCtrl,
                textCapitalization: TextCapitalization.words,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Card holder name required' : null,
                decoration: _inputDec('Card Holder Name'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: expiryCtrl,
                      keyboardType: TextInputType.datetime,
                      maxLength: 5,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(v))
                          return 'Use MM/YY';
                        return null;
                      },
                      decoration: _inputDec('MM/YY'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: cvvCtrl,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      maxLength: 3,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v.length < 3) return 'Invalid CVV';
                        return null;
                      },
                      decoration: _inputDec('CVV'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final rawNumber = cardNumberCtrl.text.replaceAll(' ', '');
                      final last4 = rawNumber.substring(rawNumber.length - 4);

                      // Detect card type by first digit
                      final cardType = rawNumber.startsWith('4')
                          ? 'Visa'
                          : rawNumber.startsWith('5')
                              ? 'Mastercard'
                              : rawNumber.startsWith('3')
                                  ? 'Amex'
                                  : 'Card';

                      final colors = [
                        const Color(0xFF8338EC),
                        const Color(0xFFFF6B35),
                        const Color(0xFF4ECDC4),
                        const Color(0xFFFFBE0B),
                      ];
                      final color = colors[user.cards.length % colors.length];

                      user.addCard(CardModel(
                        type: cardType,
                        number: '**** **** **** $last4',
                        expiry: expiryCtrl.text,
                        holder: cardHolderCtrl.text,
                        color: color,
                      ));
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Card added successfully!'),
                          backgroundColor: Color(0xFFFF6B35),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Add Card',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDec(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        counterText: '',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Payment Methods',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCardSheet(context),
        backgroundColor: const Color(0xFFFF6B35),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Card',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      // Consumer rebuilds whenever cards list changes
      body: Consumer<UserProvider>(
        builder: (context, user, _) {
          if (user.cards.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card_off_outlined,
                      size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('No cards saved',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  const Text('Tap + Add Card to get started',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: user.cards.length,
            itemBuilder: (context, i) {
              final card = user.cards[i];
              final isSelected = user.selectedCardIndex == i;
              return GestureDetector(
                onTap: () => user.selectCard(i),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: card.color,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(color: Colors.black26, width: 3)
                        : null,
                    boxShadow: [
                      BoxShadow(
                          color: card.color.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(card.type,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                if (isSelected)
                                  const Icon(Icons.check_circle,
                                      color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => user.removeCard(i),
                                  child: const Icon(Icons.delete_outline,
                                      color: Colors.white70, size: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(card.number,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                letterSpacing: 2)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('CARD HOLDER',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 10)),
                                Text(card.holder,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('EXPIRES',
                                    style: TextStyle(
                                        color: Colors.white60, fontSize: 10)),
                                Text(card.expiry,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
