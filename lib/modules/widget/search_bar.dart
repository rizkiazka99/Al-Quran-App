import 'package:alquranapp/core/values/fonts.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController textController;
  final onChanged;
  final onTap;

  const SearchBar({
    Key? key, 
    required this.textController, 
    required this.onChanged, 
    required this.onTap
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        child: TextFormField(
            controller: widget.textController,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                hintText: 'Cari Surah',
                hintStyle: h6(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2)),
                suffixIcon: InkWell(
                  onTap: widget.onTap,
                  child: const Icon(Icons.close, size: 25, color: Colors.white),
                ))),
      ),
    );
  }
}

class AppBarSearchBar extends StatefulWidget {
  final TextEditingController textController;
  final enableSearchBar;
  final onChanged;
  final onTap;

  const AppBarSearchBar({
    Key? key,
    required this.enableSearchBar,
    required this.textController, 
    required this.onChanged, 
    required this.onTap, 
  }) : super(key: key);

  @override
  State<AppBarSearchBar> createState() => _AppBarSearchBarState();
}

class _AppBarSearchBarState extends State<AppBarSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: widget.enableSearchBar,
            child: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: TextFormField(
                controller: widget.textController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                    hintText: 'Cari Surah',
                    hintStyle: h6(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2)),
                    suffixIcon: InkWell(
                      onTap: widget.onTap,
                      child: const Icon(Icons.close,
                          size: 25, color: Colors.white),
                    ))),
          )
        ],
      ),
    );
  }
}