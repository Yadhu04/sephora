import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import 'product_list_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: () async {
       
        context
            .read<ProductListProvider>()
            .restoreLatestIfNeeded();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
      
              Hero(
                tag: 'search-bar',
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search products',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onSubmitted: (query) {
                        if (query.trim().isEmpty) return;
      
                        context
                            .read<ProductListProvider>()
                            .searchProducts(query, minRating: 1);
      
       
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>  ProductListPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
      
              const Expanded(
                child: Center(
                  child: Text(
                    'Type and press search',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
