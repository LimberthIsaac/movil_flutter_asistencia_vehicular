import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../theme.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(-17.7833, -63.1821); // Posición por defecto (Santa Cruz)
  bool _loadingLocation = true;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _loadingLocation = false;
        });
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition, 15),
        );
      }
    } catch (e) {
      debugPrint("Error obteniendo ubicación: $e");
      if (mounted) {
        setState(() => _loadingLocation = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: Stack(
        children: [
          // Mapa a Pantalla Completa
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition,
                zoom: 15.0,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                _mapController = controller;
                if (!_loadingLocation) {
                  controller.animateCamera(
                    CameraUpdate.newLatLngZoom(_currentPosition, 15),
                  );
                }
              },
            ),
          ),
          
          if (_loadingLocation)
            const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryBlue),
            ),

          // Header Flotante / Back Button
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.textDark, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Título Central Superior
          Positioned(
            top: 60,
            left: 80,
            right: 80,
            child: Center(
              child: Text(
                "Seguimiento",
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 20, color: AppTheme.textDark),
              ),
            ),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppTheme.bgLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5)),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "En Atención",
                                style: GoogleFonts.inter(
                                  color: AppTheme.accentYellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          
                          Stack(
                            children: [
                              Container(
                                height: 6,
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(3)),
                              ),
                              Container(
                                height: 6,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(3)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          
                          _buildStep(Icons.check_rounded, "Buscando taller", true, true, false),
                          _buildStep(Icons.check_rounded, "Taller asignado", true, true, false),
                          _buildStep(Icons.check_rounded, "En camino", true, true, false),
                          _buildStep(Icons.build_circle_rounded, "En atención", true, true, true),
                          _buildStep(Icons.star_rounded, "Finalizada", false, false, false),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Taller asignado", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textGray)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.handyman_rounded, color: AppTheme.primaryBlue),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Taller Mecánico El Rápido", style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                                    Text("A 1.5 km de tu posición", style: GoogleFonts.inter(color: AppTheme.textGray, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: AppTheme.accentYellow, size: 18),
                                  Text(" 4.8", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/checkout');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue.withOpacity(0.1),
                              foregroundColor: AppTheme.primaryBlue,
                              elevation: 0,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text("Ver perfil del taller"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep(IconData icon, String title, bool isCompleted, bool showLine, bool isCurrent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.grey.shade400,
                size: 20,
              ),
            ),
            if (showLine)
              Container(
                width: 2,
                height: 35,
                color: isCompleted ? AppTheme.primaryBlue : Colors.grey.shade200,
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isCurrent ? AppTheme.primaryBlue : (isCompleted ? AppTheme.textDark : AppTheme.textGray),
                ),
              ),
              if (isCurrent)
                Text("En progreso...", style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textGray)),
            ],
          ),
        ),
        if (isCompleted && !isCurrent)
          const Icon(Icons.check_circle_outline_rounded, color: AppTheme.secondaryGreen, size: 24),
      ],
    );
  }
}

