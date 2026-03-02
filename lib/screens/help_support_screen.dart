import 'package:flutter/material.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'How do I track my order?',
      'answer':
          'You can track your order by going to My Orders in the Account section. Each order shows its current status (Processing, Shipped, Delivered).',
      'expanded': false,
    },
    {
      'question': 'What is the return policy?',
      'answer':
          'We offer a 30-day return policy for all items. Items must be in original condition with tags attached. Contact us to initiate a return.',
      'expanded': false,
    },
    {
      'question': 'How do I apply a discount code?',
      'answer':
          'Go to your Cart screen and enter your discount code in the "Enter Discount Code" field, then tap Apply. Valid codes can be found in the Account screen.',
      'expanded': false,
    },
    {
      'question': 'What payment methods are accepted?',
      'answer':
          'We accept Credit/Debit cards (Visa, Mastercard, Amex), Digital Wallets (Google Pay, Apple Pay), and UPI (GooglePay, PhonePe, PayTM).',
      'expanded': false,
    },
    {
      'question': 'How long does delivery take?',
      'answer':
          'Standard delivery takes 3–5 business days. Express delivery (1–2 business days) is available for select locations at an additional charge.',
      'expanded': false,
    },
  ];

  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Help & Support',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Options
            Row(
              children: [
                _contactCard(Icons.chat_outlined, 'Live Chat', 'Chat with us'),
                const SizedBox(width: 12),
                _contactCard(
                    Icons.email_outlined, 'Email', 'support@shophub.com'),
                const SizedBox(width: 12),
                _contactCard(Icons.phone_outlined, 'Call', '+91 1800-XXX-XXXX'),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Frequently Asked Questions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._faqs.asMap().entries.map((entry) {
              final i = entry.key;
              final faq = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: ExpansionTile(
                  onExpansionChanged: (v) =>
                      setState(() => _faqs[i]['expanded'] = v),
                  initiallyExpanded: faq['expanded'] as bool,
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  iconColor: const Color(0xFFFF6B35),
                  collapsedIconColor: Colors.grey,
                  title: Text(faq['question'] as String,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  children: [
                    Text(faq['answer'] as String,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.grey, height: 1.5)),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            const Text('Send Us a Message',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Describe your issue...',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          _messageController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Message sent! We will respond within 24 hours.'),
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
                      child: const Text('Send Message',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFFFF6B35), size: 22),
            ),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
