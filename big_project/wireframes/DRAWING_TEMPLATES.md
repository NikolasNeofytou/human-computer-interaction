# Wireframe Drawing Templates

## Quick Reference Cards for Hand Drawing

Print these templates and use them as guides for your wireframes.

---

## SCREEN 1: GESTURE TUTORIAL

```
┌──────────────────────────────────────┐
│ ← Back      Tutorial          Skip → │
├──────────────────────────────────────┤
│                                      │
│                                      │
│         [ANIMATED HAND ICON]         │
│                                      │
│        "Shake your phone"            │
│       "to shuffle the deck"          │
│                                      │
│                                      │
│      [PHONE SHAKING ANIMATION]       │
│                                      │
│                                      │
│            Try it now!               │
│                                      │
│                                      │
│         ○ ○ ○ ○ ● ○ ○ ○              │
│       Progress: 5/8 gestures         │
│                                      │
│                                      │
│         [ Next Gesture → ]           │
│                                      │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Top bar: Navigation elements
→ Center: Large animated demonstration
→ Bottom: Progress and navigation
→ Interaction: User performs gesture, system detects, advances
```

---

## SCREEN 2: GAMEPLAY (MAIN)

```
┌──────────────────────────────────────┐
│ ⚙️  GestureCards      🔔 📊 ⏸️       │
├──────────────────────────────────────┤
│  [Opponent: Sarah]          [42 pts] │
│     😊 👤  [3 cards shown]           │
│                                      │
│  ┌────────────────────────────────┐  │
│  │   CURRENT TRICK (TABLE)        │  │
│  │   ┌─────┐    ┌─────┐           │  │
│  │   │ 7♥  │    │ K♠  │           │  │
│  │   └─────┘    └─────┘           │  │
│  └────────────────────────────────┘  │
│                                      │
│  💡 GESTURE HINTS:                   │
│     ↗️ Tilt to peek                  │
│     ↑ Swipe up to play              │
│     🔄 Shake to shuffle             │
│                                      │
│  ┌────────────────────────────────┐  │
│  │    YOUR HAND                   │  │
│  │  ┌──┐ ┌──┐ ┌──┐ ┌──┐ ┌──┐     │  │
│  │  │A♠│ │9♥│ │5♦│ │J♣│ │2♦│     │  │
│  │  └──┘ └──┘ └──┘ └──┘ └──┘     │  │
│  └────────────────────────────────┘  │
│                                      │
│  📷 AR Mode    [YOUR TURN]       🎵  │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Top: Status bar with settings
→ Upper area: Opponent info and cards
→ Middle: Play area (active trick)
→ Gesture hints: Toggleable overlay
→ Bottom: Your cards
→ Footer: Mode toggles and indicators
```

---

## SCREEN 3: CAMERA GESTURES

```
┌──────────────────────────────────────┐
│  ✕ Close          Ready Check         │
├──────────────────────────────────────┤
│  ╔════════════════════════════════╗  │
│  ║  [FRONT CAMERA VIEWFINDER]     ║  │
│  ║                                ║  │
│  ║      ╭─────────────╮           ║  │
│  ║      │   👋 Hand   │ ✓         ║  │
│  ║      │  [detected] │           ║  │
│  ║      ╰─────────────╯           ║  │
│  ║                                ║  │
│  ║    "Wave detected!"            ║  │
│  ╚════════════════════════════════╝  │
│                                      │
│   Player Ready Status:               │
│   ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐   │
│   │Sarah│ │ YOU │ │Mike │ │Lisa │   │
│   │  ✓  │ │  ✓  │ │  ✓  │ │ ⏳  │   │
│   └─────┘ └─────┘ └─────┘ └─────┘   │
│                                      │
│        Ready: 3/4 players            │
│                                      │
│   💡 Tip: Show thumbs up to ready    │
│                                      │
│   [Auto-deal when all ready]         │
│                                      │
│   [  Cancel  ]    [ Force Start ]    │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Top 40%: Live camera feed
→ Hand detection: Green outline on recognition
→ Player grid: Visual status for all players
→ Ready states: ✓ (ready), ⏳ (waiting), ✕ (not ready)
→ Bottom: Action buttons
```

---

## SCREEN 4: AR MODE

```
┌──────────────────────────────────────┐
│  ✕ Exit AR      AR Mode          ⚙️  │
├──────────────────────────────────────┤
│  ╔════════════════════════════════╗  │
│  ║  [REAR CAMERA - LIVE VIEW]     ║  │
│  ║                                ║  │
│  ║    ⊞  ⊞  ⊞  [Grid overlay]    ║  │
│  ║                                ║  │
│  ║         ┌───────┐              ║  │
│  ║         │  8♣   │  (floating)  ║  │
│  ║         └───────┘              ║  │
│  ║            ↓                   ║  │
│  ║        ▬▬▬▬▬▬▬▬  (shadow)      ║  │
│  ║     [Detected Table]           ║  │
│  ║                                ║  │
│  ║    👤 Sarah (2.3m away)        ║  │
│  ║    👤 Mike (1.8m away)         ║  │
│  ║                                ║  │
│  ╚════════════════════════════════╝  │
│                                      │
│   📍 Surface detected                │
│   ↻  Move device to scan table       │
│                                      │
│   Players in AR view: 2/4            │
│                                      │
│   [  Switch to Normal Mode  ]        │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Full-screen rear camera
→ Grid: Shows AR surface detection
→ Virtual cards: 3D objects on table
→ Shadows: Realistic depth
→ Player indicators: Distance shown
→ Instructions: Guide user interaction
```

---

## SCREEN 5: VICTORY PHOTO

```
┌──────────────────────────────────────┐
│             VICTORY! 🏆               │
├──────────────────────────────────────┤
│  ╔════════════════════════════════╗  │
│  ║  [FRONT CAMERA VIEWFINDER]     ║  │
│  ║                                ║  │
│  ║           🏆                   ║  │
│  ║        ╱▔▔▔▔▔╲                 ║  │
│  ║       │  ★   │  (AR trophy)    ║  │
│  ║        ╲_____╱                 ║  │
│  ║                                ║  │
│  ║         😊 👤                  ║  │
│  ║      [Your face]               ║  │
│  ║                                ║  │
│  ║     ✨  *  🎉  *  ✨          ║  │
│  ║   (Confetti animation)         ║  │
│  ║                                ║  │
│  ║    Smile! 3... 2... 1...       ║  │
│  ╚════════════════════════════════╝  │
│                                      │
│  ┌──────────────────────────────┐   │
│  │ Game Stats:                  │   │
│  │ Winner: YOU                  │   │
│  │ Final Score: 78              │   │
│  │ Cards Played: 24             │   │
│  │ Best Move: K♠ (trick 7)     │   │
│  └──────────────────────────────┘   │
│                                      │
│  [ 📸 Retake] [✓ Save] [📤 Share]   │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Victory banner at top
→ Front camera with AR effects
→ Trophy floats above winner's head
→ Confetti particles animate
→ Countdown timer visible
→ Stats sidebar shows game results
→ Action buttons for photo
```

---

## SCREEN 6: HAPTIC SETTINGS

```
┌──────────────────────────────────────┐
│  ← Back        Haptic Settings        │
├──────────────────────────────────────┤
│                                      │
│   🔊 Master Intensity                │
│   ├─────────●─────┤        75%      │
│   Subtle          Strong             │
│                                      │
│   📋 Haptic Patterns:                │
│   ┌───────────────────────────────┐  │
│   │ Card Select       [Test 🎵]   │  │
│   │ Light tap (50ms, 30%)         │  │
│   │ ├──●────────┤                 │  │
│   └───────────────────────────────┘  │
│                                      │
│   ┌───────────────────────────────┐  │
│   │ Win Trick         [Test 🎵]   │  │
│   │ Success wave (200ms, 80%)     │  │
│   │ ├────────●──┤                 │  │
│   └───────────────────────────────┘  │
│                                      │
│   ┌───────────────────────────────┐  │
│   │ Shuffle           [Test 🎵]   │  │
│   │ Rapid burst (150ms, 60%)      │  │
│   │ ├─────●─────┤                 │  │
│   └───────────────────────────────┘  │
│                                      │
│   🎯 Accessibility Presets:          │
│   ○ Subtle    ● Normal               │
│   ○ Strong    ○ Custom               │
│                                      │
│   📖 [View Full Haptic Legend]       │
│                                      │
│   [Reset to Defaults]    [Save]      │
└──────────────────────────────────────┘

ANNOTATIONS:
→ Master slider controls all patterns
→ Each pattern has description + test button
→ Individual sliders for fine control
→ Presets for quick configuration
→ Legend link for reference
```

---

## SCREEN 7: ADAPTIVE DASHBOARD

```
┌──────────────────────────────────────┐
│  ← Back        Your Play Style        │
├──────────────────────────────────────┤
│                                      │
│   🧠 AI Learning Insights            │
│   Active for 12 games                │
│                                      │
│   📊 Gesture Usage:                  │
│   ┌───────────────────────────────┐  │
│   │       Pie Chart:              │  │
│   │      ╱─────╲                  │  │
│   │     │ 45%  │  Shake           │  │
│   │     │───────│  30% Swipe      │  │
│   │      ╲15%╱    15% Tilt        │  │
│   │        10% Other              │  │
│   └───────────────────────────────┘  │
│                                      │
│   ⚡ Efficiency Metrics:             │
│   ├────────────────────┤             │
│   │ Turn Speed   4.2s   ↑ +15%   │  │
│   │ Accuracy     92%    ↑ +8%    │  │
│   │ Gestures/min 18     →        │  │
│   └────────────────────┤             │
│                                      │
│   🎯 Applied Optimizations:          │
│   ✓ Play button enlarged (+30%)     │
│   ✓ Haptic intensity ↑ (60→75%)    │
│   ✓ Swipe sensitivity adjusted      │
│   ✓ Auto-sort enabled               │
│                                      │
│   💡 Recommendations:                │
│   • Try tilt gestures more          │
│   • Enable advanced combos          │
│                                      │
│   [View Full Stats] [Reset AI]      │
└──────────────────────────────────────┘

ANNOTATIONS:
→ AI status shows learning duration
→ Pie chart visualizes gesture distribution
→ Metrics show performance trends
→ Optimizations list shows AI changes
→ Recommendations suggest improvements
→ Buttons for detailed view and reset
```

---

## DRAWING TIPS

### Materials Needed:
- ✏️ Pencil (HB or 2B)
- 📄 White paper (A4 or Letter size)
- 📐 Ruler (for straight lines)
- 🖍️ Fine-tip pen (for final lines)
- ✂️ Eraser

### Process:
1. **Draw phone outline** (proportions: ~2:3 ratio)
2. **Sketch layout boxes** lightly in pencil
3. **Add UI elements** (buttons, text, icons)
4. **Draw gesture indicators** (arrows, motion paths)
5. **Label everything** with annotations
6. **Trace final lines** with pen
7. **Erase pencil marks**
8. **Scan at 300 DPI** or photograph with good lighting

### Quick Symbols:
- **Button**: `[ Text ]`
- **Icon**: Use emoji or simple shapes
- **Card**: Rectangle with suit symbol
- **Hand**: Simple outline
- **Camera**: Dotted border rectangle
- **Arrow**: → ↑ ↓ ← for gestures
- **Checkmark**: ✓ for completion
- **Clock**: ⏳ for waiting

---

## EXPORT CHECKLIST

After drawing all 7 wireframes:

- [ ] Screen 1: Gesture Tutorial
- [ ] Screen 2: Gameplay (Main)
- [ ] Screen 3: Camera Gestures
- [ ] Screen 4: AR Mode
- [ ] Screen 5: Victory Photo
- [ ] Screen 6: Haptic Settings
- [ ] Screen 7: Adaptive Dashboard

Then:
- [ ] Scan/photograph all wireframes
- [ ] Save as PNG (300 DPI)
- [ ] Name files: `wireframe_1_tutorial.png`, etc.
- [ ] Insert into deliverable document
- [ ] Export full document to PDF
- [ ] Review for completeness

---

## TIME ESTIMATE

- Drawing per wireframe: **15-20 minutes**
- Total drawing time: **~2 hours**
- Scanning/cleanup: **30 minutes**
- Document insertion: **15 minutes**

**Total: ~3 hours** for all 7 wireframes

---

**You're ready to create amazing wireframes! Start with Screen 1 and work through sequentially. Good luck! 🎨**
