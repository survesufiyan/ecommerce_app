import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'edit_profile.screen.dart';
import 'addresses_screen.dart';
import 'payment_methods_screen.dart';
import 'orders_screen.dart';
import 'help_support_screen.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
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
              // Profile Section — uses Consumer so it updates after EditProfile saves
              Consumer<UserProvider>(
                builder: (context, user, _) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFF6B35), shape: BoxShape.circle),
                        child: const Icon(Icons.person,
                            size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      if (user.phone.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          user.phone,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Available Discount Codes
              const Text('Available Discount Codes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildDiscountCodeCard(
                  'SAVE10', '10% Off', 'Save 10% on any purchase'),
              const SizedBox(height: 12),
              _buildDiscountCodeCard(
                  'SAVE20', '20% Off', 'Save 20% on purchases over \$50'),
              const SizedBox(height: 12),
              _buildDiscountCodeCard(
                  'WELCOME', '15% Off', 'Welcome offer for new customers'),
              const SizedBox(height: 12),
              _buildDiscountCodeCard(
                  'SUMMER', '25% Off', 'Summer special offer'),
              const SizedBox(height: 24),

              // Account Settings
              const Text('Account Settings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _buildAccountOption(
                context,
                Icons.person_outline,
                'Edit Profile',
                'Update your name, email & phone',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EditProfileScreen())),
              ),
              const SizedBox(height: 8),
              _buildAccountOption(
                context,
                Icons.location_on_outlined,
                'Addresses',
                'Manage your delivery addresses',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AddressesScreen())),
              ),
              const SizedBox(height: 8),
              _buildAccountOption(
                context,
                Icons.credit_card_outlined,
                'Payment Methods',
                'Manage your saved cards',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PaymentMethodsScreen())),
              ),
              const SizedBox(height: 8),
              _buildAccountOption(
                context,
                Icons.receipt_long_outlined,
                'Orders',
                'View your order history',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const OrdersScreen())),
              ),
              const SizedBox(height: 8),
              _buildAccountOption(
                context,
                Icons.help_outline,
                'Help & Support',
                'FAQs and contact support',
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HelpSupportScreen())),
              ),
              const SizedBox(height: 24),

              // Logout
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                                (route) => false,
                              );
                            },
                            child: const Text('Logout',
                                style: TextStyle(color: Color(0xFFFF6B35))),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Logout',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountCodeCard(
      String code, String discount, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFF6B35), width: 2),
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
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B35).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFF6B35), width: 2),
            ),
            child: Center(
              child: Text(code,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B35))),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(discount,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
