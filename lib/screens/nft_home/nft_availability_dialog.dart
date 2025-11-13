import 'package:flutter/material.dart';

class AvailabilityDialog extends StatefulWidget {
  const AvailabilityDialog({super.key});

  @override
  AvailabilityDialogState createState() => AvailabilityDialogState();
}

class AvailabilityDialogState extends State<AvailabilityDialog> {
  DateTime? start;
  DateTime? end;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Availability'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              start != null
                  ? 'Start: ${start!.toIso8601String()}'
                  : 'Select Start Date',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) setState(() => start = date);
            },
          ),
          ListTile(
            title: Text(
              end != null
                  ? 'End: ${end!.toIso8601String()}'
                  : 'Select End Date',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: start ?? DateTime.now(),
                firstDate: start ?? DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) setState(() => end = date);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: start != null && end != null
              ? () => Navigator.of(context).pop({'start': start!, 'end': end!})
              : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
