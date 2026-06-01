import 'package:financial_tracker/common/errors/errors_classes.dart';
import 'package:financial_tracker/common/patterns/command.dart';
import 'package:financial_tracker/domain/entity/transaction_entity.dart';
import 'package:flutter/material.dart';

import 'transaction_update_form.dart';

class TransactionUpdateSheet extends StatelessWidget {
  final TransactionEntity transaction;
  final Command1<void, Failure, TransactionEntity> submitCommand;

  const TransactionUpdateSheet({
    super.key,
    required this.transaction,
    required this.submitCommand,
  });

  static Future<void> show({
    required BuildContext context,
    required TransactionEntity transaction,
    required Command1<void, Failure, TransactionEntity> submitCommand,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionUpdateSheet(
        transaction: transaction,
        submitCommand: submitCommand,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? colorScheme.primary : colorScheme.secondary;
    final availableHeight = MediaQuery.of(context).size.height * 0.75;

    return Container(
      height: availableHeight,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_note,
                        color: colorScheme.onPrimary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Atualizar ${transaction.type.nameSingular}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: TransactionUpdateForm(
                  transaction: transaction,
                  color: color,
                  submitCommand: submitCommand,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}