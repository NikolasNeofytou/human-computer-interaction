# GestureCards Wireframe Guide

## Purpose
This guide provides detailed specifications for all 7 wireframes needed for Phase 1 deliverable. You can use these as references to create hand-drawn or digital wireframes.

---

## Screen 1: Gesture Tutorial (Onboarding)

### Purpose
Introduce new players to the gesture system through interactive tutorial.

### Layout
```
┌─────────────────────────────────┐
│  ← Back        Tutorial    Skip →│
├─────────────────────────────────┤
│                                 │
│        [Animated Hand Icon]     │
│       ╭───────╮                 │
│       │ 👋    │                 │
│       ╰───────╯                 │
│     Shake your phone            │
│     to shuffle the deck         │
│                                 │
│    [Phone shaking animation]    │
│         ↙️  ↘️                   │
│                                 │
│         Try it now!             │
│                                 │
│    ○ ○ ○ ○ ● ○ ○ ○             │
│  (Progress: 5/8 gestures)       │
│                                 │
│  [ Next Gesture → ]             │
└─────────────────────────────────┘
```

### Key Elements
1. **Header**: Back button, "Tutorial" title, Skip option
2. **Animated Hand/Phone Icon**: Shows gesture being demonstrated
3. **Instruction Text**: Clear, concise description
4. **Visual Demonstration**: Animation showing phone movement
5. **Progress Dots**: 8 dots (one per gesture)
6. **Try It Prompt**: Encourages user interaction
7. **Next Button**: Proceeds after successful gesture

### Gestures to Cover (8 screens)
- Shake (shuffle)
- Tilt forward (play card)
- Tilt back (draw card)
- Swipe left/right (browse hand)
- Pinch (zoom card)
- Wave hand to camera (dealer ready-check)
- Thumbs up (vote yes)
- AR mode (point at table)

### Interaction Flow
1. User sees animated demonstration
2. User attempts gesture
3. Success: ✓ checkmark appears, vibration feedback
4. Failure: Hint appears ("Shake faster!")
5. Auto-advance to next gesture after success

---

## Screen 2: Gesture-Enhanced Gameplay (Main Game Screen)

### Purpose
Main game interface with gesture hint overlays and active gameplay.

### Layout
```
┌─────────────────────────────────┐
│ ⚙️  GestureCards    🔔 📊 ⏸️    │
├─────────────────────────────────┤
│  [Opponent 1: Sarah]   [42 pts] │
│      😊 👤 [3 cards]            │
│                                 │
│  ┌─────────────────────────┐   │
│  │   Current Trick         │   │
│  │   ┌────┐  ┌────┐        │   │
│  │   │ 7♥ │  │ K♠ │        │   │
│  │   └────┘  └────┘        │   │
│  └─────────────────────────┘   │
│                                 │
│  💡 Gesture Hints (toggle)      │
│   ↗️ Tilt to peek at cards      │
│   ↑ Swipe up to play           │
│   🔄 Shake to shuffle          │
│                                 │
│ ┌──────────────────────────┐   │
│ │  YOUR HAND               │   │
│ │ ┌───┐┌───┐┌───┐┌───┐┌───┐│  │
│ │ │A♠ ││9♥ ││5♦ ││J♣ ││2♦ ││ │
│ │ └───┘└───┘└───┘└───┘└───┘│  │
│ └──────────────────────────┘   │
│                                 │
│  📷 AR Mode    [Your Turn]  🎵  │
└─────────────────────────────────┘
```

### Key Elements
1. **Top Bar**: Settings, app name, notifications, stats, pause
2. **Opponent Display**: Avatar, name, score, card count
3. **Play Area**: Current trick cards (center table)
4. **Gesture Hints Panel**: Toggleable overlay with gesture tips
   - Icons show phone movements
   - Semi-transparent (doesn't block view)
   - Can be dismissed after learning
5. **Player Hand**: Your cards at bottom
6. **Bottom Bar**: AR mode toggle, turn indicator, sound toggle
7. **Haptic Indicator**: Vibration strength icon (⚡)

### Gesture Overlay States
- **Beginner Mode**: All hints visible
- **Intermediate**: Hints fade after 10 seconds
- **Expert Mode**: No hints (gesture by muscle memory)

### Visual Feedback
- **Selected Card**: Slightly raised, glowing border
- **Valid Play**: Green highlight
- **Invalid Play**: Red shake + haptic alert
- **Turn Indicator**: Pulsing border around your hand

---

## Screen 3: Camera Gesture Interface (Dealer Ready-Check)

### Purpose
Show camera-based hand gesture recognition for multiplayer coordination.

### Layout
```
┌─────────────────────────────────┐
│  ✕ Close      Ready Check        │
├─────────────────────────────────┤
│ ┌───────────────────────────┐   │
│ │ [FRONT CAMERA VIEWFINDER] │   │
│ │                           │   │
│ │     ╭──────────╮          │   │
│ │     │  👋      │ ✓        │   │
│ │     │ [Hand    │          │   │
│ │     │ detected]│          │   │
│ │     ╰──────────╯          │   │
│ │                           │   │
│ │  Wave detected!           │   │
│ └───────────────────────────┘   │
│                                 │
│  Player Ready Status:           │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐│
│  │Sarah│ │ YOU │ │Mike │ │Lisa ││
│  │ ✓   │ │ ✓   │ │ ✓   │ │ ⏳  ││
│  └─────┘ └─────┘ └─────┘ └─────┘│
│                                 │
│      Ready: 3/4 players         │
│                                 │
│  💡 Tip: Show thumbs up to      │
│     confirm you're ready        │
│                                 │
│  [Auto-deal when all ready]     │
│                                 │
│  [ Cancel ]    [ Force Start ]  │
└─────────────────────────────────┘
```

### Key Elements
1. **Close Button**: Exit camera mode
2. **Camera Viewfinder**: Live front camera feed (top 40%)
3. **Hand Detection Overlay**: Green outline when hand detected
4. **Gesture Recognition Feedback**: "Wave detected!" text
5. **Player Grid**: 4 player avatars with ready status
   - ✓ = Ready (green checkmark)
   - ⏳ = Waiting (orange clock)
   - ✕ = Not ready (red X)
6. **Progress Counter**: "3/4 ready"
7. **Alternative Gesture Tip**: Thumbs up also works
8. **Action Buttons**: Cancel or Force Start (if dealer)

### Camera Permissions
- First-time: "GestureCards needs camera access for hand gestures"
- Privacy: "Processing on-device only. No images stored."

---

## Screen 4: AR Card Placement Mode (Hybrid Reality)

### Purpose
Use rear camera and AR to place virtual cards on physical table.

### Layout
```
┌─────────────────────────────────┐
│  ✕ Exit AR    AR Mode     ⚙️    │
├─────────────────────────────────┤
│ ╔═══════════════════════════╗   │
│ ║ [REAR CAMERA LIVE VIEW]   ║   │
│ ║                           ║   │
│ ║  ⊞  ⊞  ⊞  [Grid overlay] ║   │
│ ║                           ║   │
│ ║      ┌────┐               ║   │
│ ║      │ 8♣ │ (floating)    ║   │
│ ║      └────┘               ║   │
│ ║        ↓ shadow           ║   │
│ ║    ▬▬▬▬▬▬▬▬              ║   │
│ ║   [Detected table]        ║   │
│ ║                           ║   │
│ ║   👤 Sarah (2.3m away)    ║   │
│ ║   👤 Mike (1.8m away)     ║   │
│ ║                           ║   │
│ ╚═══════════════════════════╝   │
│                                 │
│  📍 Surface detected            │
│  ↻  Move device to scan table   │
│                                 │
│  Players in AR view: 2/4        │
│                                 │
│  [ Switch to Normal Mode ]      │
└─────────────────────────────────┘
```

### Key Elements
1. **Exit Button**: Return to normal game mode
2. **AR Settings**: Configure AR effects
3. **Camera View**: Full-screen rear camera
4. **Grid Overlay**: Shows surface detection (dotted grid)
5. **Virtual Cards**: 3D rendered cards floating above table
6. **Shadows**: Realistic shadows cast on detected surface
7. **Distance Indicators**: Show how far other players are
8. **Player Markers**: Dots/avatars showing player positions
9. **Status Text**: Surface detection status
10. **Instructions**: Guide user to scan table
11. **Mode Toggle**: Switch back to 2D mode

### AR Interactions
- **Pinch**: Zoom virtual cards
- **Drag**: Reposition cards on table
- **Rotate Device**: See cards from different angles
- **Tap Card**: Play card with 3D animation

---

## Screen 5: Victory Photo Capture (Social Sharing)

### Purpose
Automatically capture winner's reaction with AR effects overlay.

### Layout
```
┌─────────────────────────────────┐
│            VICTORY!             │
├─────────────────────────────────┤
│ ╔═══════════════════════════╗   │
│ ║ [FRONT CAMERA VIEWFINDER] ║   │
│ ║                           ║   │
│ ║         🏆                ║   │
│ ║      ╱▔▔▔▔▔╲              ║   │
│ ║     │  ★   │ (AR trophy) ║   │
│ ║      ╲_____╱              ║   │
│ ║                           ║   │
│ ║       😊 👤               ║   │
│ ║    [Your face]            ║   │
│ ║                           ║   │
│ ║   ✨ * 🎉 * ✨           ║   │
│ ║  (Confetti animation)     ║   │
│ ║                           ║   │
│ ║   Smile! 3... 2... 1...   ║   │
│ ╚═══════════════════════════╝   │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ Game Stats:                 │ │
│ │ Winner: YOU                 │ │
│ │ Final Score: 78             │ │
│ │ Cards Played: 24            │ │
│ │ Best Move: K♠ (trick 7)    │ │
│ └─────────────────────────────┘ │
│                                 │
│  [📸 Retake]  [✓ Save]  [📤 Share]│
└─────────────────────────────────┘
```

### Key Elements
1. **Title**: "VICTORY!" banner
2. **Camera View**: Front camera showing winner
3. **AR Trophy**: 3D rendered trophy floating above head
4. **Confetti Particles**: Animated falling confetti
5. **Crown/Stars**: Additional AR decorations
6. **Countdown Timer**: "3... 2... 1... Smile!" countdown
7. **Face Detection**: Automatic framing on winner's face
8. **Game Stats Sidebar**: Key statistics from game
   - Winner name
   - Final score
   - Cards played
   - Best move/trick
9. **Action Buttons**:
   - Retake: Capture new photo
   - Save: Save to gallery
   - Share: Social media export

### AR Effects Options
- Trophy (gold, silver, bronze)
- Confetti colors (match game theme)
- Crown overlay
- Sparkles/stars
- Victory text overlay

### Privacy Options
- "Skip photo capture" checkbox
- Blur background
- Disable in settings

---

## Screen 6: Haptic Settings & Customization

### Purpose
Configure haptic feedback patterns and intensity preferences.

### Layout
```
┌─────────────────────────────────┐
│  ← Back    Haptic Settings       │
├─────────────────────────────────┤
│                                 │
│  🔊 Master Intensity             │
│  ├─────────●─────┤  75%         │
│  Subtle          Strong          │
│                                 │
│  📋 Haptic Patterns:            │
│  ┌────────────────────────────┐ │
│  │ Card Select      [Test 🎵] │ │
│  │ Light tap (50ms, 30%)      │ │
│  │ ├──●────────┤              │ │
│  └────────────────────────────┘ │
│                                 │
│  ┌────────────────────────────┐ │
│  │ Win Trick        [Test 🎵] │ │
│  │ Success wave (200ms, 80%)  │ │
│  │ ├────────●──┤              │ │
│  └────────────────────────────┘ │
│                                 │
│  ┌────────────────────────────┐ │
│  │ Shuffle          [Test 🎵] │ │
│  │ Rapid burst (150ms, 60%)   │ │
│  │ ├─────●─────┤              │ │
│  └────────────────────────────┘ │
│                                 │
│  🎯 Accessibility Presets:      │
│  ○ Subtle (Low intensity)       │
│  ● Normal (Balanced)            │
│  ○ Strong (High intensity)      │
│  ○ Custom (Your settings)       │
│                                 │
│  📖 [View Full Haptic Legend]   │
│                                 │
│  [ Reset to Defaults ] [ Save ] │
└─────────────────────────────────┘
```

### Key Elements
1. **Back Button**: Return to settings menu
2. **Master Intensity Slider**: Global haptic strength (0-100%)
3. **Pattern Library**: List of all haptic patterns
   - Pattern name
   - Description (duration, intensity)
   - Individual intensity slider
   - Test button (plays pattern)
4. **Test Buttons**: Let users feel each pattern
5. **Accessibility Presets**: Quick configurations
   - Subtle (for quiet environments)
   - Normal (default)
   - Strong (for noisy/accessibility needs)
   - Custom (user modifications)
6. **Haptic Legend Link**: Opens full dictionary
7. **Action Buttons**: Reset or Save changes

### Haptic Patterns Shown (Sample)
- Card Select (light tap)
- Card Play (medium pulse)
- Win Trick (success wave)
- Lose Trick (gentle fade)
- Shuffle (rapid burst)
- Invalid Action (warning pattern)
- Your Turn (double pulse)
- Game Won (celebration burst)

---

## Screen 7: Adaptive UI Dashboard (AI Insights)

### Purpose
Display personalized analytics and show how AI has adapted the interface.

### Layout
```
┌─────────────────────────────────┐
│  ← Back    Your Play Style       │
├─────────────────────────────────┤
│                                 │
│  🧠 AI Learning Insights        │
│  Active for 12 games            │
│                                 │
│  📊 Gesture Usage:              │
│  ┌────────────────────────────┐ │
│  │      Pie Chart:             │ │
│  │   ╱─────╲                  │ │
│  │  │ 45%  │  Shake           │ │
│  │  │───────│  30% Swipe      │ │
│  │   ╲15%╱    15% Tilt        │ │
│  │     10% Other               │ │
│  └────────────────────────────┘ │
│                                 │
│  ⚡ Efficiency Metrics:         │
│  ├──────────────────┤           │
│  │ Turn Speed    4.2s  ↑ +15% ││
│  │ Accuracy      92%   ↑ +8%  ││
│  │ Gestures/min  18    →      ││
│  └──────────────────┤           │
│                                 │
│  🎯 Applied Optimizations:      │
│  ✓ Play button enlarged (+30%)  │
│  ✓ Haptic intensity ↑ (60→75%) │
│  ✓ Swipe sensitivity adjusted   │
│  ✓ Auto-sort enabled            │
│                                 │
│  💡 Recommendations:            │
│  • Try tilt gestures more       │
│  • Enable advanced combos       │
│                                 │
│  [ View Full Stats ]            │
│  [ Reset AI Learning ]          │
└─────────────────────────────────┘
```

### Key Elements
1. **Header**: "Your Play Style" title
2. **AI Status**: How long AI has been learning
3. **Gesture Usage Chart**: Pie chart showing gesture frequency
   - Shake: 45%
   - Swipe: 30%
   - Tilt: 15%
   - Other: 10%
4. **Efficiency Metrics**: Performance over time
   - Average turn speed (with % improvement)
   - Gesture accuracy
   - Actions per minute
   - Trend arrows (↑ improving, → stable, ↓ declining)
5. **Applied Optimizations List**: Shows what AI changed
   - UI element size adjustments
   - Haptic intensity changes
   - Sensitivity tuning
   - Feature enablements
6. **Recommendations**: Suggestions to improve gameplay
7. **Action Buttons**:
   - View Full Stats: Detailed analytics
   - Reset AI Learning: Start fresh

### Data Visualization
- **Charts**: Pie chart, bar graphs, line graphs
- **Color Coding**: Green = improvement, Red = decline
- **Icons**: Visual indicators for each metric
- **Before/After**: Show UI changes side-by-side

---

## Drawing Guidelines

### For Hand-Drawn Wireframes:
1. **Use pencil** (easier to erase/adjust)
2. **Draw phone frame** (iPhone/Android proportions)
3. **Label all elements** with arrows/numbers
4. **Add annotations** explaining interactions
5. **Show gesture indicators** (arrows for motion)
6. **Include state changes** (before/after interaction)
7. **Use dotted lines** for optional elements
8. **Add notes** for animations/transitions

### For Digital Wireframes (Figma/Balsamiq/Pencil):
1. **Use standard UI components** (buttons, cards, icons)
2. **Maintain consistent spacing** (8px grid)
3. **Show interactive states** (hover, pressed, disabled)
4. **Add gesture overlays** (semi-transparent)
5. **Include motion paths** (arrows showing movement)
6. **Export as PNG/PDF** (300 DPI for print)

### Style Consistency:
- **Font**: Sans-serif for labels, monospace for code
- **Icons**: Simple, recognizable (Material Icons or iOS SF Symbols)
- **Colors** (grayscale for wireframes):
  - Background: White/Light gray
  - Elements: Black/Dark gray
  - Highlights: Medium gray
- **Spacing**: Consistent padding (16px, 24px, 32px)

---

## Wireframe Checklist

### Screen 1: Gesture Tutorial ✓
- [ ] Phone frame
- [ ] Animated hand icon
- [ ] Instruction text
- [ ] Progress dots (8 total)
- [ ] Try it prompt
- [ ] Next button
- [ ] Gesture demonstration visual

### Screen 2: Gesture-Enhanced Gameplay ✓
- [ ] Top navigation bar
- [ ] Opponent display
- [ ] Play area (trick cards)
- [ ] Gesture hints overlay
- [ ] Player hand (5 cards)
- [ ] Bottom action bar
- [ ] Haptic indicator

### Screen 3: Camera Gesture Interface ✓
- [ ] Camera viewfinder
- [ ] Hand detection overlay
- [ ] Player ready grid (4 players)
- [ ] Status indicators (✓ ⏳ ✕)
- [ ] Progress counter
- [ ] Alternative gesture tip
- [ ] Cancel/Force Start buttons

### Screen 4: AR Card Placement ✓
- [ ] Rear camera view (full screen)
- [ ] Grid overlay (surface detection)
- [ ] Virtual card (3D floating)
- [ ] Shadow effect
- [ ] Player distance indicators
- [ ] Surface status text
- [ ] Mode toggle button

### Screen 5: Victory Photo Capture ✓
- [ ] Front camera viewfinder
- [ ] AR trophy overlay
- [ ] Confetti animation
- [ ] Countdown timer
- [ ] Game stats sidebar
- [ ] Face detection frame
- [ ] Retake/Save/Share buttons

### Screen 6: Haptic Settings ✓
- [ ] Master intensity slider
- [ ] Pattern library (3+ patterns)
- [ ] Individual pattern controls
- [ ] Test buttons
- [ ] Accessibility presets (radio buttons)
- [ ] Haptic legend link
- [ ] Reset/Save buttons

### Screen 7: Adaptive UI Dashboard ✓
- [ ] AI status header
- [ ] Gesture usage pie chart
- [ ] Efficiency metrics (3+ stats)
- [ ] Applied optimizations list
- [ ] Recommendations section
- [ ] View Stats button
- [ ] Reset AI button

---

## Export Instructions

### Phase 1 Submission:
1. Create all 7 wireframes (hand-drawn or digital)
2. Scan/export at high resolution (300 DPI minimum)
3. Save as:
   - `wireframe_1_gesture_tutorial.png`
   - `wireframe_2_gameplay.png`
   - `wireframe_3_camera_gestures.png`
   - `wireframe_4_ar_mode.png`
   - `wireframe_5_victory_photo.png`
   - `wireframe_6_haptic_settings.png`
   - `wireframe_7_adaptive_dashboard.png`
4. Insert into `GESTURECARDS_PHASE1_DELIVERABLE.md`
5. Export complete document to PDF

### Tips:
- Keep wireframes **low-fidelity** (sketchy is OK for Phase 1)
- Focus on **layout and interaction**, not visual polish
- **Annotate heavily** with labels and notes
- Show **gesture indicators** (arrows, motion paths)
- Include **state changes** where relevant
- Use **real content** (not Lorem Ipsum) where possible

---

## Ready to Draw!

Use this guide as a reference while creating your wireframes. Each section provides:
- ✅ Complete layout specification
- ✅ Key elements list
- ✅ Interaction details
- ✅ Visual guidelines

**Next Step:** Open your drawing tool (paper/Figma/Balsamiq) and start with Screen 1!

Good luck! 🎨📱
