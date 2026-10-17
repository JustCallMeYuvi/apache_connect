
import 'dart:typed_data';

import 'package:excel/excel.dart' hide Border;
import 'package:flutter/material.dart';

class ExcelEditorPanel extends StatefulWidget {
  final String documentName;
  final Uint8List? fileBytes;
  final VoidCallback onClose;
  final ValueChanged<Uint8List>? onSave;

  const ExcelEditorPanel({
    super.key,
    required this.documentName,
    required this.fileBytes,
    required this.onClose,
    this.onSave,
  });

  @override
  State<ExcelEditorPanel> createState() => _ExcelEditorPanelState();
}

class _ExcelEditorPanelState extends State<ExcelEditorPanel> {
  Excel? _workbook;
  Sheet? _sheet;
  String? _sheetName;
  List<String> _sheetNames = [];
  bool _isLoading = true;
  String? _error;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _loadWorkbook();
  }

  @override
  void didUpdateWidget(covariant ExcelEditorPanel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.fileBytes != widget.fileBytes) {
      _loadWorkbook();
    }
  }

  void _loadWorkbook() {
    setState(() {
      _isLoading = true;
      _error = null;
      _isDirty = false;
    });

    try {
      final bytes = widget.fileBytes;

      if (bytes == null || bytes.isEmpty) {
        throw Exception(
          'No Excel file bytes found. Upload the actual workbook first.',
        );
      }

      final workbook = Excel.decodeBytes(bytes);
      final names = workbook.tables.keys.toList();

      if (names.isEmpty) {
        throw Exception('The workbook contains no worksheets.');
      }

      setState(() {
        _workbook = workbook;
        _sheetNames = names;
        _sheetName = names.first;
        _sheet = workbook.tables[names.first];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Unable to open Excel workbook: $e';
        _isLoading = false;
      });
    }
  }

  void _selectSheet(String name) {
    setState(() {
      _sheetName = name;
      _sheet = _workbook?.tables[name];
    });
  }

  String _cellText(Data? data) {
    final value = data?.value;
    if (value == null) return '';

    if (value is TextCellValue) return value.value.toString();
    if (value is IntCellValue) return value.value.toString();
    if (value is DoubleCellValue) return value.value.toString();
    if (value is BoolCellValue) return value.value.toString();
    if (value is DateCellValue) return value.asDateTimeLocal().toString();
    if (value is DateTimeCellValue) {
      return value.asDateTimeLocal().toString();
    }
    if (value is TimeCellValue) return value.toString();
    if (value is FormulaCellValue) return value.formula;

    return value.toString();
  }

  Future<void> _editCell(int rowIndex, int columnIndex) async {
    final sheet = _sheet;
    if (sheet == null) return;

    final cell = sheet.cell(
      CellIndex.indexByColumnRow(
        columnIndex: columnIndex,
        rowIndex: rowIndex,
      ),
    );

    final controller = TextEditingController(text: _cellText(cell));

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'Edit cell ${cell.cellIndex.columnIndex + 1}, '
          '${cell.cellIndex.rowIndex + 1}',
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Cell value',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) => Navigator.pop(dialogContext, value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              dialogContext,
              controller.text,
            ),
            child: const Text('Apply'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result == null || !mounted) return;

    setState(() {
      cell.value = TextCellValue(result);
      _isDirty = true;
    });
  }

  void _saveWorkbook() {
    final workbook = _workbook;

    if (workbook == null) return;

    try {
      final encoded = workbook.encode();

      if (encoded == null) {
        throw Exception('Unable to encode workbook.');
      }

      final bytes = Uint8List.fromList(encoded);

      if (widget.onSave != null) {
        widget.onSave!(bytes);
        setState(() => _isDirty = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workbook exported successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Workbook prepared, but no file-saving handler is connected.',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final sheet = _sheet;
    final rows = sheet?.rows ?? [];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE5E7EB),
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.table_chart,
                color: Color(0xFF10A760),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.documentName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_isDirty)
                const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(
                    'Unsaved',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                    ),
                  ),
                ),
              TextButton.icon(
                onPressed: _isLoading || _error != null
                    ? null
                    : _saveWorkbook,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save'),
              ),
              IconButton(
                tooltip: 'Close editor',
                onPressed: widget.onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        ),
        if (_isLoading)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_error != null)
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          )
        else ...[
          if (_sheetNames.length > 1)
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _sheetNames.map((name) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(name),
                      selected: name == _sheetName,
                      onSelected: (_) => _selectSheet(name),
                    ),
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: rows.isEmpty
                ? const Center(child: Text('This worksheet is empty.'))
                : SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(
                          isDark
                              ? const Color(0xFF283548)
                              : const Color(0xFFF1F5F9),
                        ),
                        columns: List.generate(
                          rows
                              .map((row) => row.length)
                              .fold<int>(0, (a, b) => a > b ? a : b),
                          (column) => DataColumn(
                            label: Text(
                              _columnName(column),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        rows: List.generate(rows.length, (rowIndex) {
                          final row = rows[rowIndex];

                          final maxColumns = rows
                              .map((r) => r.length)
                              .fold<int>(
                                0,
                                (a, b) => a > b ? a : b,
                              );

                          return DataRow(
                            cells: List.generate(maxColumns, (columnIndex) {
                              final value = columnIndex < row.length
                                  ? _cellText(row[columnIndex])
                                  : '';

                              return DataCell(
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    maxWidth: 220,
                                  ),
                                  child: Text(
                                    value,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                onTap: () =>
                                    _editCell(rowIndex, columnIndex),
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              '${rows.length} rows · ${_sheetName ?? ''} · '
              'Tap a cell to edit',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ],
    );
  }

  String _columnName(int index) {
    var n = index + 1;
    var name = '';

    while (n > 0) {
      final remainder = (n - 1) % 26;
      name = String.fromCharCode(65 + remainder) + name;
      n = (n - 1) ~/ 26;
    }

    return name;
  }
}
