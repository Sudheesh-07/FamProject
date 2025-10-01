import 'package:cached_network_image/cached_network_image.dart';
import 'package:famproject/core/utils/color_utils.dart';
import 'package:famproject/core/utils/deeplink_handler.dart';
import 'package:famproject/features/contextual_cards/data/models/api_model.dart';
import 'package:famproject/features/contextual_cards/presentation/cubits/card_cubits.dart';
import 'package:famproject/features/contextual_cards/presentation/widgets/formatted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HC3BigDisplay extends StatefulWidget {
  final CardModel card;

  const HC3BigDisplay({super.key, required this.card});

  @override
  State<HC3BigDisplay> createState() => _HC3BigDisplayState();
}

class _HC3BigDisplayState extends State<HC3BigDisplay>
    with SingleTickerProviderStateMixin {
  bool _isSliding = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.3, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSlide() {
    if (_isSliding) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isSliding = !_isSliding;
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onLongPress: _toggleSlide,
      onTap: () {
        if (_isSliding) {
          _toggleSlide();
        } else {
          DeeplinkHandler.handleUrl(widget.card.url);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          children: [
            // Action buttons (behind the card)
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildActionButton(
                    icon: Icons.notifications_none,
                    label: 'remind later',
                    onTap: () {
                      context.read<CardsCubit>().remindLater(widget.card.id);
                      _toggleSlide();
                    },
                  ),
                  const SizedBox(width: 12),
                  _buildActionButton(
                    icon: Icons.close,
                    label: 'dismiss now',
                    onTap: () {
                      context.read<CardsCubit>().dismissCard(widget.card.id);
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
            // Main card
            SlideTransition(
              position: _slideAnimation,
              child: _buildCardContent(),
            ),
          ],
        ),
      ),
    );

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) => GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F6F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.black54),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildCardContent() => Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: widget.card.bgImage?.imageUrl != null
            ? DecorationImage(
                image: CachedNetworkImageProvider(
                  widget.card.bgImage!.imageUrl!,
                ),
                fit: BoxFit.cover,
              )
            : null,
        color: widget.card.bgImage == null
            ? ColorUtils.parseColor(widget.card.bgColor)
            : null,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.card.formattedTitle != null)
              FormattedTextWidget(
                formattedText: widget.card.formattedTitle!,
                defaultTextStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
            else if (widget.card.title != null)
              Text(
                widget.card.title!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            const Spacer(),
            if (widget.card.cta != null && widget.card.cta!.isNotEmpty)
              ...widget.card.cta!.map(
                (cta) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildCTAButton(cta),
                ),
              ),
          ],
        ),
      ),
    );

  Widget _buildCTAButton(CTA cta) => GestureDetector(
      onTap: () => DeeplinkHandler.handleUrl(cta.url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: ColorUtils.parseColor(cta.bgColor) ?? Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          cta.text,
          style: TextStyle(
            color: ColorUtils.parseColor(cta.textColor) ?? Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
}
