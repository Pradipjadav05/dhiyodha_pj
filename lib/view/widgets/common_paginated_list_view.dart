import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonPaginatedListView extends StatefulWidget {
  final ScrollController scrollController;
  final Function(int? offset) onPaginate;
  final int? totalSize;
  final int? offset;
  final Widget productView;
  final bool enabledPagination;
  const CommonPaginatedListView({
    Key? key,
    required this.scrollController,
    required this.onPaginate,
    required this.totalSize,
    required this.offset,
    required this.productView,
    this.enabledPagination = true,
  }) : super(key: key);

  @override
  State<CommonPaginatedListView> createState() =>
      _CommonPaginatedListViewState();
}

class _CommonPaginatedListViewState extends State<CommonPaginatedListView> {
  int? _offset;
  late List<int?> _offsetList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _offset = 1;
    _offsetList = [1];

    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent &&
          widget.totalSize != null &&
          !_isLoading &&
          widget.enabledPagination) {
        if (mounted && !CommonResponsiveHelper.isDesktop(context)) {
          _paginate();
        }
      }
    });
  }

  void _paginate() async {
    int pageSize = (widget.totalSize! / 10).ceil();
    if (_offset! < pageSize && !_offsetList.contains(_offset! + 1)) {
      setState(() {
        _offset = _offset! + 1;
        _offsetList.add(_offset);
        _isLoading = true;
      });
      await widget.onPaginate(_offset);
      setState(() {
        _isLoading = false;
      });
    } else {
      if (_isLoading) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offset != null) {
      _offset = widget.offset;
      _offsetList = [];
      for (int index = 1; index <= widget.offset!; index++) {
        _offsetList.add(index);
      }
    }

    return Column(children: [
      widget.productView,
      (CommonResponsiveHelper.isDesktop(context) &&
              (widget.totalSize == null ||
                  _offset! >= (widget.totalSize! / 10).ceil() ||
                  _offsetList.contains(_offset! + 1)))
          ? const SizedBox()
          : Center(
              child: Padding(
              padding: (_isLoading || CommonResponsiveHelper.isDesktop(context))
                  ? const EdgeInsets.all(paddingSize10)
                  : EdgeInsets.zero,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : (CommonResponsiveHelper.isDesktop(context) &&
                          widget.totalSize != null)
                      ? InkWell(
                          onTap: _paginate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: paddingSize10,
                                horizontal: paddingSize25),
                            margin: CommonResponsiveHelper.isDesktop(context)
                                ? const EdgeInsets.only(top: paddingSize10)
                                : null,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius5),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text('view_more'.tr,
                                style: fontMedium.copyWith(
                                    fontSize: fontSize18, color: Colors.white)),
                          ),
                        )
                      : const SizedBox(),
            )),
    ]);
  }
}
