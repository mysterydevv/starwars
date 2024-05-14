import 'package:flutter/material.dart';

class CinemaOverview extends StatefulWidget {
  const CinemaOverview({super.key});
  @override
  State<StatefulWidget> createState() {
    return CinemaOverviewState();
  }
}

class CinemaOverviewState extends State<CinemaOverview> {
  bool _isExpanded = false;
  static const String title = 'INCEPTION';
  static const String fullText =
      'Cobb is a talented thief, the best of the best in the dangerous art of extraction: he steals valuable secrets from the depths of the subconscious during sleep, when the human mind is most vulnerable. Cobb\'s rare abilities made him a valuable player in the treacherous world of industrial espionage, but they also turned him into an eternal fugitive and deprived him of everything he had ever loved.';
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            title,
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto'),
          ),
          const SizedBox(height: 8.0),
          Text(
            fullText,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
            maxLines: _isExpanded ? null : 3,
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                height: 1.5,
                letterSpacing: 0.5,
                wordSpacing: 1.0,
                decoration: TextDecoration.none,
                decorationColor: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
                decorationThickness: 1.0,
                debugLabel: 'black display4'
                ),
          ),
          const SizedBox(height: 8.0),
          TextButton(
            onPressed: _toggleExpanded,
            child: Text(
              _isExpanded ? 'Hide' : 'Read more',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
