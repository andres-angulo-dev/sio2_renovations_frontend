import 'package:flutter/material.dart';
import '../widgets/cookies_consent_banner_widget.dart';
import '../widgets/my_button_widget.dart';
import '../utils/global_others.dart';

class CookiesOverlayManager extends StatefulWidget {
  final Widget child;

  const CookiesOverlayManager({super.key, required this.child});

  @override
  CookiesOverlayManagerState createState() => CookiesOverlayManagerState();
}

class CookiesOverlayManagerState extends State<CookiesOverlayManager> {
  bool _showCookiesButton = false;
  bool? _consentGiven; // State to track cookies consent
  bool _isBannerVisible = false;

  @override
  void initState() {
    super.initState();

    _isBannerVisible = _consentGiven == null; // if true we consider that consent was never given = show cookies banner
  }

  // Handles user consent for cookies and manages the visibility of the cookie consent banner
  void _onConsentAccepted(bool? consent) {
    setState(() {
      _consentGiven = consent;
      _isBannerVisible = false; // Hide banner after animation
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showCookiesButton = true; // Allows the animation to start with each clickin the banner
        });
      }
    });
  }

  // Loads previously saved cookie consent state and updates the banner visibility accordingly
  void _onConsentLoaded(bool? consent) {
    if (_consentGiven == null) {
      setState(() {
        _consentGiven = consent;
        _isBannerVisible = consent == null;
      });

      if (consent == true) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _showCookiesButton = true; // Allows the cookie button to be displayed upon arrival on the page if there are recorded consents
            });
          }
        });
      }
    }
  }

  // Toggles the visibility of the cookie consent banner
  void _onBannerToggle() {
    setState(() {
      if (_isBannerVisible) {
        _isBannerVisible = false; // Hide banner after animation
      } else {
        _isBannerVisible = true;
        _showCookiesButton = false; // Reset the animation to false after each click in the banner
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        // Cookie banner appears when no consent is given
        if (_isBannerVisible)
          CookiesConsentBannerWidget(
            onConsentGiven: _onConsentAccepted,
            onConsentLoaded: _onConsentLoaded,
            toggleVisibility: _onBannerToggle,
          ),

        // Button appears after consent is accepted
        if (!_isBannerVisible && _consentGiven == true)
          Positioned(
            bottom: 15,
            left: 15,
            child: AnimatedOpacity(
              opacity: _showCookiesButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: MyButtonWidget(
                onPressed: _onBannerToggle,
                buttonPath: GlobalButtonsAndIcons.cookiesButton,
                foregroundPath: GlobalButtonsAndIcons.iconCookieButton,
              ),
            ),
          ),
      ],
    );
  }
}
