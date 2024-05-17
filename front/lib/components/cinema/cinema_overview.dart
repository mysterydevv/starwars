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
  static const String title = 'Star Wars Episode IX';
  static const String fullText =
      'In a galaxy far, far away, the remnants of the Resistance are regrouping, having suffered heavy losses in previous battles. While Ray learns to use the Force, the new Supreme Leader of the First Order, Kylo Ren, searches for a secret Sith hideout, from where messages from Emperor Palpatine are broadcast. Po, Fin and Chewbacca are engaged in subversive activities behind enemy lines, and Ken does not give up his attempts to lure Paradise to the dark side of the Force, being sure that they are destined to rule together. Ray will not only have to face Kyle again, but also finally find out the truth about her parents, as well as reveal a terrible secret that will determine her future and the fate of the entire galaxy...';
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
