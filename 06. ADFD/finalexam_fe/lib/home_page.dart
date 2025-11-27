import 'package:flutter/material.dart';

import 'models/place.dart';
import 'services/place_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Place>> _futurePlaces;
  final PlaceService _placeService = PlaceService();

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _futurePlaces = _placeService.getAllPlace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildCategoryRow(),
              const SizedBox(height: 24),
              _buildPopularSectionTitle(),
              const SizedBox(height: 12),
              _buildPopularDestinationList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- HEADER + SEARCH ----------

  Widget _buildHeader() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF7B5CFA), Color(0xFF9C6CFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi Guy!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Where are you going next?',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  _buildSearchBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search your destination',
                hintStyle: TextStyle(color: Color(0xFFB0B3C0), fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- CATEGORY CARDS ----------

  Widget _buildCategoryRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryCard(
            index: 0,
            icon: Icons.bar_chart_rounded,
            label: 'Hotels',
            backgroundColor: const Color(0xFFFFF1E6),
          ),
          _buildCategoryCard(
            index: 1,
            icon: Icons.flight_takeoff_rounded,
            label: 'Flights',
            backgroundColor: const Color(0xFFFFE6F1),
          ),
          _buildCategoryCard(
            index: 2,
            icon: Icons.grid_view_rounded,
            label: 'All',
            backgroundColor: const Color(0xFFE6FFF5),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required int index,
    required IconData icon,
    required String label,
    required Color backgroundColor,
  }) {
    final bool isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B5CFA) : backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF7B5CFA).withOpacity(0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- POPULAR DESTINATIONS ----------

  Widget _buildPopularSectionTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Popular Destinations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildPopularDestinationList() {
    return SizedBox(
      height: 230,
      child: FutureBuilder<List<Place>>(
        future: _futurePlaces,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Oops, failed to load destinations.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No destinations found'));
          }

          final places = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.only(left: 20, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final place = places[index];
              return _buildPlaceCard(place);
            },
          );
        },
      ),
    );
  }

  Widget _buildPlaceCard(Place place) {
    debugPrint('Image URL for ${place.name}: ${place.imageUrl}');
    return SizedBox(
      width: 190,
      child: Stack(
        children: [
          // Background image card
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: place.imageUrl.isNotEmpty
                  ? Image.network(
                      place.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Image error for ${place.name}: $error');
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(Icons.broken_image, size: 32),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey.shade300,
                      child: const Center(child: Icon(Icons.image)),
                    ),
            ),
          ),

          // Heart icon
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.90),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 18,
                color: Color(0xFFE53935),
              ),
            ),
          ),

          // Name + rating
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        place.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- BOTTOM NAV ----------

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (_) {},
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7B5CFA),
      unselectedItemColor: const Color(0xFFB0B3C0),
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_border),
          label: 'Trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
