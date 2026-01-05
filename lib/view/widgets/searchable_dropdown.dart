import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:flutter/material.dart';

class SearchableDropdown extends StatefulWidget {
  final String value;
  final List<String> items;
  final Function(String?) onChanged;
  final String hintText;
  final Widget? icon;

  const SearchableDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select',
    this.icon,
  }) : super(key: key);

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _SearchDialog(
          items: widget.items,
          onChanged: widget.onChanged,
          hintText: widget.hintText,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSearchDialog,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: paddingSize20,
          vertical: paddingSize20,
        ),
        decoration: BoxDecoration(
          color: lavenderMist,
          borderRadius: BorderRadius.circular(radius10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 0,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.value,
                style: fontMedium.copyWith(
                  color: midnightBlue,
                  fontSize: fontSize14,
                ),
              ),
            ),
            widget.icon ?? Icon(Icons.arrow_drop_down, color: midnightBlue),
          ],
        ),
      ),
    );
  }
}

class _SearchDialog extends StatefulWidget {
  final List<String> items;
  final Function(String?) onChanged;
  final String hintText;

  const _SearchDialog({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  State<_SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<_SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ${widget.hintText}',
                hintStyle: fontRegular.copyWith(
                  fontSize: fontSize14,
                  color: midnightBlue.withOpacity(0.6),
                ),
                prefixIcon: Icon(Icons.search, color: midnightBlue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: BorderSide(color: midnightBlue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: BorderSide(color: midnightBlue.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius10),
                  borderSide: BorderSide(color: midnightBlue),
                ),
              ),
              onChanged: _filterItems,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Text(
                        'No results found',
                        style: fontMedium.copyWith(
                          color: midnightBlue,
                          fontSize: fontSize14,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            _filteredItems[index],
                            style: fontMedium.copyWith(
                              color: midnightBlue,
                              fontSize: fontSize14,
                            ),
                          ),
                          onTap: () {
                            widget.onChanged(_filteredItems[index]);
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

