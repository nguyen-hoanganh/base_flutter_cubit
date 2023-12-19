part of 'inapp_debug_console_manager.dart';

class InAppDebugConsoleView extends StatefulWidget {
  final List<InAppDebugConsoleModel> datas;

  const InAppDebugConsoleView({
    super.key,
    required this.datas,
  });

  @override
  State<InAppDebugConsoleView> createState() => _InAppDebugConsoleViewState();
}

class _InAppDebugConsoleViewState extends State<InAppDebugConsoleView> {
  StreamSubscription? _streamSubscription;
  late final List<InAppDebugConsoleModel> _originDatas = [...widget.datas];
  final _scrollController = ScrollController();
  final _filterTextEditingController = TextEditingController();
  InAppDebugConsoleModel? _detailData;

  late final List<InAppDebugConsoleModel> _datas = [];
  String _localKeywordFilter = _keywordFilter;
  bool _isFiltering = false;

  @override
  void initState() {
    super.initState();
    _filterTextEditingController.text = _localKeywordFilter;

    _streamSubscription =
        _inAppDebugConsoleController.stream.listen(_handleListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filter();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _filterTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1e2127),
      child: SafeArea(
        child: Stack(
          children: [
            _buildMainWidget(),
            if (_isFiltering) _buildFilterWidget(),
            if (_detailData != null) _buildDetailDataWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1e2127),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  _filterTextEditingController.text = _localKeywordFilter;
                  _isFiltering = true;
                  setState(() => {});
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  InAppDebugConsoleManager.shared.clear();
                  _originDatas.clear();
                  _datas.clear();
                  setState(() => {});
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: InAppDebugConsoleManager.shared.hide,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              reverse: true,
              itemBuilder: (context, index) {
                final item = _datas[index];
                String message = item.message.toString();
                if (item.error != null) {
                  final stackTrace = item.stackTrace == null
                      ? ""
                      : "\n\n[StackTrace]: ${item.stackTrace.toString()}";
                  message =
                      "[Message]: ${item.message.toString()}\n\n[Error]: ${item.error.toString()}$stackTrace";
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () => setState(
                      () => _detailData = item.copyWith(
                        message: message,
                      ),
                    ),
                    child: _HighlightText(
                      text: message,
                      ignoreCase: true,
                      style: TextStyle(
                        color: item.color,
                        fontSize: 16,
                      ),
                      maxLines: 40,
                      overflow: TextOverflow.ellipsis,
                      highlight: _localKeywordFilter,
                      highlightStyle: const TextStyle(
                        backgroundColor: Colors.yellow,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.white,
                thickness: 2,
              ),
              itemCount: _datas.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilterWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _isFiltering = false),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => {},
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1e2127),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NormalInput(
                    configs: NormalInputConfigs(
                      controller: _filterTextEditingController,
                      hintText: "Từ khoá",
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: _submitFilterInput,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Button(
                    configs: ButtonConfigs(
                      content: "Tìm kiếm",
                      onTap: () => _submitFilterInput(
                        _filterTextEditingController.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailDataWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1e2127),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => setState(() => _detailData = null),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                    ClipboardData(
                      text: _detailData!.message,
                    ),
                  );
                },
                child: _HighlightText(
                  text: _detailData!.message,
                  ignoreCase: true,
                  style: TextStyle(
                    color: _detailData!.color,
                    fontSize: 16,
                  ),
                  highlight: _localKeywordFilter,
                  highlightStyle: const TextStyle(
                    backgroundColor: Colors.yellow,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleListener(InAppDebugConsoleModel data) {
    // handle _originDatas
    try {
      if (_originDatas.length >= _maxData) {
        _originDatas.removeLast();
      }
    } catch (_) {}
    _originDatas.insert(0, data);

    // handle _datas
    if (_localKeywordFilter.isNotEmpty) {
      if ((data.message ?? "")
              .toString()
              .toLowerCase()
              .contains(_localKeywordFilter.toLowerCase()) ||
          (data.error ?? "")
              .toString()
              .toLowerCase()
              .contains(_localKeywordFilter.toLowerCase()) ||
          (data.stackTrace ?? "")
              .toString()
              .toLowerCase()
              .contains(_localKeywordFilter.toLowerCase())) {
        try {
          if (_datas.length >= _maxData) {
            _datas.removeLast();
          }
        } catch (_) {}
        _datas.insert(0, data);
      }
    } else {
      try {
        if (_datas.length >= _maxData) {
          _datas.removeLast();
        }
      } catch (_) {}
      _datas.insert(0, data);
    }

    setState(() => {});
  }

  void _submitFilterInput(String? value) {
    if (value == null || _localKeywordFilter == value) {
      _isFiltering = false;
      setState(() => {});

      return;
    }

    final trimValue = value.trim();
    _localKeywordFilter = trimValue;
    _filterTextEditingController.text = trimValue;
    _keywordFilter = trimValue;
    _filter();
    _isFiltering = false;
    setState(() => {});
  }

  void _filter() {
    if (_localKeywordFilter.isEmpty) {
      _datas.clear();
      _datas.addAll([..._originDatas]);
      setState(() => {});
    } else {
      _datas.clear();
      _datas.addAll(
        _originDatas.where((e) {
          return (e.message ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(_localKeywordFilter.toLowerCase()) ||
              (e.error ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(_localKeywordFilter.toLowerCase()) ||
              (e.stackTrace ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(_localKeywordFilter.toLowerCase());
        }).toList(),
      );
    }
  }
}
