import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  void _showAddressSheet(BuildContext context, {int? editIndex}) {
    final user = context.read<UserProvider>();
    final labelCtrl = TextEditingController(
        text: editIndex != null ? user.addresses[editIndex].label : '');
    final addressCtrl = TextEditingController(
        text: editIndex != null ? user.addresses[editIndex].address : '');
    final phoneCtrl = TextEditingController(
        text: editIndex != null ? user.addresses[editIndex].phone : '');
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
              // Handle bar
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
              Text(editIndex != null ? 'Edit Address' : 'Add New Address',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: labelCtrl,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Label is required' : null,
                decoration: _inputDec('Label (e.g. Home, Work)'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: addressCtrl,
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Address is required' : null,
                decoration: _inputDec('Full Address'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Phone is required' : null,
                decoration: _inputDec('Phone Number'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newAddress = AddressModel(
                        label: labelCtrl.text.trim(),
                        address: addressCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                      );
                      if (editIndex != null) {
                        context
                            .read<UserProvider>()
                            .updateAddress(editIndex, newAddress);
                      } else {
                        context.read<UserProvider>().addAddress(newAddress);
                      }
                      Navigator.pop(ctx);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text(
                      editIndex != null ? 'Update Address' : 'Save Address',
                      style: const TextStyle(
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
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('My Addresses',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddressSheet(context),
        backgroundColor: const Color(0xFFFF6B35),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Address',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Consumer<UserProvider>(
        builder: (context, user, _) {
          if (user.addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off_outlined,
                      size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text('No addresses saved',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  const Text('Tap + to add a new address',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: user.addresses.length,
            itemBuilder: (context, index) {
              final addr = user.addresses[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.location_on,
                            color: Color(0xFFFF6B35), size: 22),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(addr.label,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(addr.address,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(addr.phone,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined,
                                color: Color(0xFFFF6B35), size: 20),
                            onPressed: () =>
                                _showAddressSheet(context, editIndex: index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline,
                                color: Colors.red[400], size: 20),
                            onPressed: () => context
                                .read<UserProvider>()
                                .removeAddress(index),
                          ),
                        ],
                      ),
                    ],
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
