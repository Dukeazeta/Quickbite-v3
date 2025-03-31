import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/payment_method.dart';
import '../screens/payment/payment_methods_screen.dart';

class PaymentMethodSelection extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  final PaymentMethod? selectedPaymentMethod;
  final Function(PaymentMethod) onPaymentMethodSelected;

  const PaymentMethodSelection({
    super.key,
    required this.paymentMethods,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (paymentMethods.isEmpty)
          _buildEmptyState(context)
        else
          Column(
            children: [
              ...paymentMethods.map((method) => _buildPaymentMethodCard(context, method)),
              const SizedBox(height: 12),
            ],
          ),
        _buildAddPaymentMethodButton(context),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Text(
            'No payment methods available',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add a payment method to continue',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(BuildContext context, PaymentMethod method) {
    final isSelected = selectedPaymentMethod?.id == method.id;

    return GestureDetector(
      onTap: () => onPaymentMethodSelected(method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red[700]! : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Payment method icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  _getPaymentIcon(method.type),
                  color: Colors.grey[800],
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Payment method details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    method.details!,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selected indicator
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.red[700],
                size: 24,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: Colors.grey[400],
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPaymentMethodButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PaymentMethodsScreen(isSelecting: true),
          ),
        );
        
        if (result != null && result is PaymentMethod) {
          onPaymentMethodSelected(result);
        }
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.red[700],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, size: 18, color: Colors.red[700]),
          const SizedBox(width: 8),
          Text(
            'Add Payment Method',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getPaymentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'card':
        return Icons.credit_card;
      case 'paypal':
        return Icons.payment;
      case 'cash':
        return Icons.money;
      case 'bank':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }
}