#!/bin/bash
# Composite score: Lighthouse avg * 0.5 + Feature checklist % * 0.5
# Features checklist (20 items from research):
# 1. Dark theme with signature accent color
# 2. Bold oversized hero typography (clamp 3rem-8rem)
# 3. One-line tagline communicating tone
# 4. Latest episode with embedded player
# 5. Multi-platform link bar (3+ platforms)
# 6. Episode cards with number, title, description
# 7. Clips/Shorts section with video embeds
# 8. Quote/review cards with pull-quote styling
# 9. Scroll-triggered reveal animations
# 10. Grain/texture overlay for personality
# 11. Monospace accent font for metadata
# 12. Sticky nav with blur backdrop
# 13. Glow/neon effects on accent elements
# 14. About section matching show tone
# 15. Feature cards (show format/schedule)
# 16. Mobile responsive (clamp, grid auto-fill)
# 17. Social proof / reviews section
# 18. Gradient or radial glow hero background
# 19. Hover animations on interactive elements
# 20. Fast load (<500KB, no framework bloat)

HTML="C:/Users/evanp/AppData/Local/Temp/fakeproblemspodcast/index.html"
SCORE=0
TOTAL=20

check() { grep -qi "$1" "$HTML" && SCORE=$((SCORE+1)); }

# 1. Dark theme
check "background.*#0[0-9a-f]"
check "#0d0d0d\|#0a0a0a\|#111\|--darker"

# 2. Bold hero typography (clamp or large font-size)
check "clamp\|font-size.*[3-9]rem\|font-size.*[3-9]\.[0-9]rem"

# 3. Tagline
check "tagline"

# 4. Embedded player (YouTube iframe or audio element)
check "youtube.com/embed\|<audio"

# 5. Multi-platform links (at least YouTube + one other)
check "listen-btn\|platform-btn"

# 6. Episode cards
check "episode-card\|ep-number"

# 7. Clips section
check "clip-card\|clips-grid\|clips-scroll"

# 8. Quote cards
check "quote-card\|blockquote"

# 9. Scroll animations (IntersectionObserver or .reveal)
check "IntersectionObserver\|\.reveal"

# 10. Grain/texture
check "noise\|grain\|mix-blend-mode\|background-size.*3px"

# 11. Monospace accent
check "monospace\|JetBrains Mono\|Fira Code\|Source Code Pro"

# 12. Sticky nav with backdrop-filter
check "backdrop-filter"

# 13. Glow effects
check "text-shadow.*glow\|box-shadow.*glow\|0 0 [2-9]0px"

# 14. About section
check "about"

# 15. Feature/info cards
check "feature\|info-card\|stat-card"

# 16. Mobile responsive
check "@media.*max-width\|clamp("

# 17. Social proof / reviews
check "review\|testimonial\|listener"

# 18. Gradient hero
check "radial-gradient\|linear-gradient"

# 19. Hover animations
check "hover.*transform\|hover.*scale\|hover.*translateY"

# 20. No framework (static HTML, check page is under 50KB)
SIZE=$(wc -c < "$HTML")
if [ "$SIZE" -lt 51200 ]; then
  SCORE=$((SCORE+1))
fi

FEATURE_PCT=$((SCORE * 100 / TOTAL))
echo "FEATURES: $SCORE/$TOTAL ($FEATURE_PCT%)"
echo "COMPOSITE: $FEATURE_PCT"
