import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class SearchingWorkshopPage extends StatefulWidget {
  const SearchingWorkshopPage({super.key});

  @override
  State<SearchingWorkshopPage> createState() => _SearchingWorkshopPageState();
}

class _SearchingWorkshopPageState extends State<SearchingWorkshopPage> {
  String _status = "Analizando situación con Inteligencia Artificial...";
  int _step = 0;

  @override
  void initState() {
    super.initState();
    _startSimulation();
  }

  void _startSimulation() async {
    // Simulando el análisis de AI
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _status = "Diagnóstico: Problema de batería detectado.\nPrioridad asignada: Alta";
        _step = 1;
      });
    }

    // Simulando la búsqueda de talleres
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _status = "Contactando al especialista más rápido...";
        _step = 2;
      });
    }

    // Simulando que el taller acepta
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/tracking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animation / Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryBlue,
                        strokeWidth: 3,
                      ),
                    ),
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: AppTheme.primaryBlue,
                      size: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              
              Text(
                "Tranquilo, estamos contigo.",
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _status,
                  key: ValueKey<String>(_status),
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: _step == 1 ? AppTheme.secondaryGreen : AppTheme.textGray,
                    fontWeight: _step == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
