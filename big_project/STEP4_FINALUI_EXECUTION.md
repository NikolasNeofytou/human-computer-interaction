# STEP 4: Final UI Screens - Execution Checklist
## ⏱️ Time: 4-5 hours | 📍 Page: "4. Final UI"

---

## 🎯 OBJECTIVE
Create 7 high-fidelity screens using component instances from your published Team Library. Apply Material Design 3 styling for market-ready quality.

---

## 📚 SETUP: Import Team Library (5 minutes)

1. Go to **"4. Final UI"** page
2. Open **Assets panel** (Alt + 2)
3. Find **"GestureCards Design System"** (purple book icon)
4. Components now available to drag & drop

**Optional: Import Material Design 3 Kit** (Bonus quality)
1. Community search (Shift + C)
2. Search: **"Material 3 Design Kit"**
3. Find official Google kit → **Duplicate**
4. Copy icon and component extras to your file

---

## 🎨 DESIGN PRINCIPLES

### Consistency Rules
- **Spacing**: 16px margins from edges, 24px between sections, 12px between elements
- **Alignment**: 8px grid (View → Layout Grids → 8px)
- **Safe Area**: iPhone 14 Pro → Top 59px, Bottom 34px (notch & home indicator)
- **Typography**: Use your text styles exclusively
- **Colors**: Use your color styles exclusively
- **Components**: Drag from Assets panel (not recreate)

### Quality Markers
- ✅ Real content (no "Lorem ipsum")
- ✅ Consistent spacing (mathematically precise)
- ✅ Appropriate hierarchy (visual weight)
- ✅ Realistic data (win rates, times, names)
- ✅ Professional polish (shadows, alignment)

---

## 📱 CREATE 7 SCREENS (4 hours)

### Setup Frames (2 min)
1. Press **`F`** → Select **"iPhone 14 Pro"** (393 × 852)
2. Create 7 frames
3. Name them:
   - `Screen 1: Gesture Tutorial`
   - `Screen 2: Gameplay`
   - `Screen 3: Camera Gestures`
   - `Screen 4: AR Mode`
   - `Screen 5: Victory Photo`
   - `Screen 6: Haptic Settings`
   - `Screen 7: Adaptive Dashboard`
4. Arrange in 3 rows × 3 columns

---

## Screen 1: Gesture Tutorial (30 min)

### Layout Structure
```
┌─────────────────────────┐
│   [Safe Area: 59px]    │ <- Status bar
├─────────────────────────┤
│    Learn Gestures      │ <- Title (Display/Large)
│        Step 1 of 5     │ <- Subtitle (Label/Small)
├─────────────────────────┤
│                         │
│     [Hand Image]        │ <- 240 × 240px illustration
│                         │
│   Shake to Shuffle      │ <- Gesture name (Title/Large)
│                         │
│  Shake your phone to    │ <- Description (Body/Large)
│  shuffle your hand      │
│                         │
├─────────────────────────┤
│     ● ○ ○ ○ ○          │ <- Progress dots
├─────────────────────────┤
│   [Next Step Button]    │ <- Button/Primary
│   [Skip Tutorial]       │ <- Button/Text
│   [Safe Area: 34px]     │
└─────────────────────────┘
```

### Build Instructions

1. **Background**:
   - Fill: Gradient (Primary-Container #EADDFF → Surface #FFFBFE, vertical)
   - Creates subtle depth

2. **Title Section** (y: 80px):
   - Drag **Text component** from Assets
   - Text: "Learn Gestures"
   - Style: "Display/Large" (57px, Bold)
   - Color: "On-Surface"
   - Center align

3. **Step Indicator** (y: 150px):
   - Text: "Step 1 of 5"
   - Style: "Label/Small" (11px)
   - Color: "On-Surface-Variant"
   - Center align

4. **Hand Illustration** (y: 220px):
   - Option A: Import hand_wave.svg from wireframes/assets/
   - Option B: Use lottie animation (search "hand shake animation")
   - Size: 240 × 240px
   - Center horizontally
   - Add subtle drop shadow (Elevation/Level-1)

5. **Gesture Name** (y: 490px):
   - Text: "Shake to Shuffle"
   - Style: "Title/Large" (22px, Medium)
   - Color: "On-Surface"
   - Center align

6. **Description** (y: 530px):
   - Text: "Shake your phone to shuffle your hand and draw new cards"
   - Style: "Body/Large" (16px)
   - Color: "On-Surface-Variant"
   - Width: 280px, center align
   - Multi-line enabled

7. **Progress Dots** (y: 640px):
   - 5 circles: 8 × 8px each, 12px gap
   - Dot 1: Filled with "Primary" color
   - Dots 2-5: Outlined with "On-Surface-Variant"
   - Center horizontally

8. **Next Button** (y: 720px):
   - Drag **Button component** → Variant: Primary
   - Text: "Next Step"
   - Size: 328 × 48px
   - Center horizontally

9. **Skip Button** (y: 780px):
   - Drag **Button component** → Variant: Text
   - Text: "Skip Tutorial"
   - Center horizontally

**Pro Tips**:
- Add subtle animation notes ("Hand bounces left-right")
- Use haptic feedback indicator (small icon)
- Consider adding gesture count: "1 / 5 gestures learned"

---

## Screen 2: Gameplay (45 min)

### Layout Structure
```
┌─────────────────────────┐
│   [Safe Area: 59px]    │
├─────────────────────────┤
│  [Opponent Hand]        │ <- 3 face-down cards
│   Opponent: 12          │ <- Score
├─────────────────────────┤
│                         │
│   [Play Area]           │ <- Drop zone (dotted)
│   Swipe up to play      │
│                         │
├─────────────────────────┤
│   You: 15               │ <- Your score
│                         │
│  [Your Hand: 5 cards]   │ <- Player Hand component
│                         │
├─────────────────────────┤
│  [Navigation Bar]       │ <- Nav component (Home active)
│   [Safe Area: 34px]     │
└─────────────────────────┘
```

### Build Instructions

1. **Background**:
   - Fill: Surface color (#FFFBFE)
   - Optional: Subtle texture overlay

2. **Opponent Section** (y: 80px):
   - Title text: "Opponent" (Label/Large)
   - Score: "12 points" (Body/Large, "On-Surface-Variant")
   - Position: Top-left, x: 16px

3. **Opponent Cards** (y: 120px):
   - Drag **Playing Card component** × 3
   - Variant: State = Face-Down
   - Size: 80 × 112px each
   - Spacing: 12px gap
   - Center horizontally
   - Add subtle shadow (Elevation/Level-1)

4. **Play Area** (y: 280px):
   - Rectangle: 320 × 220px
   - Border: 3px, "Primary" color, Dashed (12px dash, 8px gap)
   - Corner radius: 16px
   - Background: "Primary-Container" at 30% opacity
   - Center horizontally

5. **Play Area Label** (inside play area, centered):
   - Text: "Swipe up to play"
   - Style: "Label/Large" (14px)
   - Color: "Primary"
   - Icon: ↑ arrow above text

6. **Player Score** (y: 520px):
   - Text: "You" (Label/Large)
   - Score: "15 points" (Body/Large, "Success" color)
   - Position: Top-left, x: 16px

7. **Player Hand** (y: 560px):
   - Drag **Player Hand component** from Assets
   - Variant: Card Count = Normal (5 cards)
   - Center horizontally
   - Cards should overlap (reveal layout)

   **Customize cards**:
   - Card 1: Ace of Hearts (selected state - raised)
   - Card 2: King of Spades
   - Card 3: Queen of Diamonds
   - Card 4: Jack of Clubs
   - Card 5: 10 of Hearts

8. **Gesture Hint** (y: 740px):
   - Small icon: Swipe gesture (↑)
   - Text: "Swipe up to play card"
   - Style: "Label/Small" (11px)
   - Color: "On-Surface-Variant"
   - Center horizontally
   - Subtle animation indicator (dashed outline)

9. **Navigation Bar** (y: 772px):
   - Drag **Navigation Bar component** from Assets
   - Variant: Active Tab = Home
   - Full width (393px)

**Pro Tips**:
- Add "2 cards remaining in deck" text (top-right)
- Show turn indicator: "Your turn" (subtle glow)
- Add timer: "15s" countdown (optional)
- Include menu button (top-right, 3 dots)

---

## Screen 3: Camera Gestures (40 min)

### Layout Structure
```
┌─────────────────────────┐
│   Dealer Ready Check  ✕ │ <- Title + close button
├─────────────────────────┤
│                         │
│                         │
│    [Target Circle]      │ <- Dotted ring
│    [Hand Skeleton]      │ <- Green overlay
│                         │
│                         │
├─────────────────────────┤
│    [Confidence 85%]     │ <- Circular progress
├─────────────────────────┤
│  Wave your hand...      │ <- Status text
│                         │
│   [Cancel Button]       │
│   [Safe Area: 34px]     │
└─────────────────────────┘
```

### Build Instructions

1. **Background**:
   - Full screen rectangle (393 × 852)
   - Fill: Black (#000000) at 80% opacity
   - Simulates camera passthrough with dark overlay

2. **Top Bar** (y: 59px):
   - Rectangle: 393 × 60px
   - Background: Black at 40% opacity (semi-transparent bar)
   - Title: "Dealer Ready Check"
   - Style: "Headline/Large" (32px, but reduce to 20px for space)
   - Color: White (#FFFFFF)
   - Center horizontally

3. **Close Button** (y: 70px, x: 345px):
   - Drag **Button component** → Variant: Icon
   - Icon: X (close)
   - Size: 40 × 40px
   - Color: White with dark background

4. **Hand Target Zone** (y: 260px, center):
   - Circle: 280 × 280px
   - Stroke: 4px, White, Dashed (16px dash, 12px gap)
   - No fill (transparent)
   - Center horizontally
   - Subtle pulsing animation note

5. **Hand Skeleton Overlay** (y: 300px, center):
   - Import hand_wave.svg (or use hand skeleton illustration)
   - Size: 200 × 200px
   - Color: "Success" green (#4CAF50) at 80% opacity
   - Layer blend mode: Screen (glowing effect)
   - Center within target circle

   **Alternative**: Use MediaPipe hand landmark dots:
   - 21 small circles (6 × 6px)
   - Connected by lines (2px)
   - Green color when recognized

6. **Confidence Meter** (y: 560px, center):
   - Drag **Stats Card component** (or create custom):
   - Circular progress ring: 140 × 140px
   - Stroke: 8px, "Success" color
   - Progress: 85% (arc from top, clockwise)
   - Background ring: "Surface-Variant" at 30%
   - Center text: "85%"
   - Style: "Display/Large" (reduce to 48px)
   - Color: White

7. **Status Text** (y: 720px):
   - Text: "Wave your hand..."
   - Style: "Body/Large" (16px)
   - Color: White
   - Center align
   - Add subtle loading animation (3 dots: . . .)

8. **Cancel Button** (y: 760px):
   - Drag **Button component** → Variant: Secondary
   - Text: "Cancel"
   - Size: 328 × 48px
   - Border: White, transparent background
   - Center horizontally

**State Variations** (Optional - show 3 versions):
- Version A: "Waiting" (0%, gray hand, "Wave your hand...")
- Version B: "Recognizing" (45%, yellow hand, "Keep going...")
- Version C: "Recognized" (100%, green hand, "Recognized! ✓")

**Pro Tips**:
- Add haptic feedback indicator when threshold reached
- Show gesture name icon (small hand wave symbol)
- Include accessibility note: "Voice command: 'I'm ready'"

---

## Screen 4: AR Mode (40 min)

### Layout Structure
```
┌─────────────────────────┐
│  Point camera at table  │ <- Instructions banner
├─────────────────────────┤
│                         │
│   [Surface Grid]        │ <- Blue detection grid
│                         │
│     [Floating Card]     │ <- Card with shadow
│                         │
│   [Hand Cursor]         │ <- Drag indicator
│                         │
├─────────────────────────┤
│  Drag to position       │ <- Gesture hints
│  Pinch to resize        │
│                         │
│   [Place Card]          │ <- Primary button
│   [Cancel AR]           │ <- Text button
│   [Safe Area: 34px]     │
└─────────────────────────┘
```

### Build Instructions

1. **Camera Background**:
   - Full screen rectangle (393 × 852)
   - Fill: Placeholder image (table/desk photo) OR gray (#9E9E9E)
   - Simulate real camera feed
   - Slight blur effect (optional)

2. **Instructions Banner** (y: 100px):
   - Rectangle: 393 × 70px
   - Background: Black at 70% opacity
   - Text: "Point camera at flat surface"
   - Style: "Body/Large" (16px)
   - Color: White
   - Center align
   - Icon: Camera targeting symbol (crosshair)

3. **Surface Detection Grid** (y: 200px):
   - 12 horizontal lines (40px apart)
   - 12 vertical lines (33px apart)
   - Color: "Info" blue (#2196F3) at 60% opacity
   - Line width: 2px
   - Creates AR surface mesh effect

   **Quick method**:
   - Create 1 line → Duplicate 11 times (Cmd + D)
   - Group horizontals, group verticals
   - Rotate verticals 90°

4. **Floating Card** (y: 360px, center):
   - Drag **Playing Card component**
   - Variant: Ace of Hearts, Normal state
   - Size: 160 × 224px (80% scale)
   - Shadow: "Elevation/Level-3" (strong shadow, 0px 12px 24px rgba(0,0,0,0.4))
   - Slight rotation: -5° (dynamic feel)
   - Center horizontally

5. **Hand Cursor** (y: 600px):
   - Circle: 48 × 48px
   - Fill: "Primary" color at 40% opacity
   - Border: 3px, White
   - Shadow: "Elevation/Level-2"
   - Icon inside: Hand pointing down (↓) or drag symbol

6. **Gesture Hints** (y: 680px):
   - Text line 1: "Drag to position card"
   - Style: "Body/Large" (16px), White
   - Icon: Two-finger drag symbol

   - Text line 2: "Pinch to resize" (y: 710px)
   - Style: "Label/Large" (14px), White at 70% opacity
   - Icon: Pinch gesture symbol

   - Center both lines

7. **Place Button** (y: 750px):
   - Drag **Button component** → Variant: Primary
   - Text: "Place Card"
   - Size: 328 × 48px
   - Center horizontally

8. **Cancel Button** (y: 810px):
   - Drag **Button component** → Variant: Text
   - Text: "Cancel AR"
   - Color: White
   - Center horizontally

**Pro Tips**:
- Add surface confidence indicator: "Surface detected: 95%"
- Show real-world scale reference: "Card size: Actual (3.5 × 2.5 in)"
- Include lighting adjustment slider (optional)
- Add AR debug info (distance: 2.3m, angle: 45°)

---

## Screen 5: Victory Photo (50 min)

### Layout Structure
```
┌─────────────────────────┐
│   [Camera Preview]      │ <- Live camera feed
│     [Trophy Overlay]    │ <- Golden trophy
│    [Confetti × 12]      │ <- Scattered particles
│                         │
│       [3]               │ <- Countdown (large)
├─────────────────────────┤
│   [Winning Hand]        │ <- 5 cards fanned
│                         │
│      Victory!           │ <- Celebration text
│  You won with a Flush!  │
│                         │
│  [Capture Photo]        │ <- Primary button
│  [Retake]               │ <- Secondary button
│   [Safe Area: 34px]     │
└─────────────────────────┘
```

### Build Instructions

1. **Camera Preview Background**:
   - Rectangle: 393 × 650px (top portion)
   - Fill: Placeholder selfie image OR gray
   - Position: Top of frame
   - Slight vignette effect (darker edges)

2. **Trophy Overlay** (y: 160px, center):
   - Import trophy.svg from wireframes/assets/
   - Size: 140 × 140px
   - Color: Golden gradient (#FFD700 → #FFA500)
   - Shadow: "Elevation/Level-3"
   - Slight rotation: 12° (dynamic)
   - Add shine effect (white highlight oval, 30% opacity)

3. **Confetti Particles** (scattered across top 500px):
   - Import confetti.svg × 12
   - Sizes: Vary 16-32px
   - Colors: Mix of Primary, Success, Warning, Info
   - Random rotations: -45° to 45°
   - Random positions (avoid trophy)
   - Motion blur on 4 pieces (falling effect)

   **Positions** (example):
   ```
   Piece 1: (60, 120, 24px, 15°, blue)
   Piece 2: (300, 180, 20px, -30°, purple)
   Piece 3: (120, 240, 28px, 45°, green)
   Piece 4: (340, 200, 18px, 0°, orange)
   Piece 5: (40, 350, 22px, -15°, pink)
   Piece 6: (280, 420, 26px, 30°, yellow)
   ... (6 more scattered)
   ```

4. **Countdown Timer** (y: 340px, center):
   - Text: "3"
   - Style: Custom - 120px, Bold
   - Color: White with black outline (3px stroke)
   - Shadow: 0px 8px 16px rgba(0,0,0,0.6) (strong shadow)
   - Center align

   **Note**: Show "3 → 2 → 1 → Click!" sequence (optional animation frames)

5. **Winning Hand** (y: 460px):
   - Drag **Player Hand component**
   - Variant: Card Count = Normal (5 cards)
   - Customize to winning hand:
     - 10♥, J♥, Q♥, K♥, A♥ (Royal Flush)
   - Size: 100 × 140px per card
   - Fan layout: Slight arc curve
   - Center horizontally

6. **Victory Text** (y: 620px):
   - Text: "Victory!"
   - Style: "Display/Large" (reduce to 40px)
   - Color: "Success" green
   - Center align

7. **Win Description** (y: 670px):
   - Text: "You won with a Royal Flush!"
   - Style: "Body/Large" (16px)
   - Color: "On-Surface"
   - Center align

8. **Capture Button** (y: 730px):
   - Drag **Button component** → Variant: Primary
   - Text: "Capture Photo"
   - Icon: Camera icon (left side)
   - Size: 328 × 48px
   - Center horizontally

9. **Retake Button** (y: 790px):
   - Drag **Button component** → Variant: Secondary
   - Text: "Retake"
   - Size: 328 × 48px
   - Center horizontally

**Post-Capture State** (Optional second version):
- Replace countdown with captured photo (framed)
- Change button to "Share" (with social icons)
- Add social platform icons: Instagram, WhatsApp, Messages, Twitter
- Caption preview: "I won with a Royal Flush! 🏆 #GestureCards"

**Pro Tips**:
- Add AR filter options (sparkles, crown, etc.)
- Show share count: "12 friends shared victory photos today"
- Include privacy toggle: "Include face" ON/OFF

---

## Screen 6: Haptic Settings (35 min)

### Layout Structure
```
┌─────────────────────────┐
│  ← Haptic Settings      │ <- Header with back
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Haptic Intensity  │  │ <- Card 1
│  │ [Slider]          │  │
│  │ [Try It]          │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Feedback Types    │  │ <- Card 2
│  │ Card Play    [ON] │  │
│  │ Card Draw    [ON] │  │
│  │ Shuffle      [ON] │  │
│  │ Win/Lose     [ON] │  │
│  │ Gesture      [ON] │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Vibration Pattern │  │ <- Card 3
│  │ ◉ Standard        │  │
│  │ ○ Subtle          │  │
│  │ ○ Intense         │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  Reset to Default       │
│  [Navigation Bar]       │
└─────────────────────────┘
```

### Build Instructions

1. **Background**:
   - Fill: "Surface" color (#FFFBFE)

2. **Header** (y: 59px):
   - Rectangle: 393 × 60px
   - Background: "Surface" (matches background, creates clean header)
   - Border bottom: 1px, "Surface-Variant"

   - Back arrow: ← icon (x: 16px)
   - Title: "Haptic Settings"
   - Style: "Headline/Large" (reduce to 20px)
   - Color: "On-Surface"
   - Position: Center

3. **Card 1: Intensity** (y: 140px):
   - Rectangle: 361 × 160px
   - Corner radius: 16px
   - Background: "Surface"
   - Shadow: "Elevation/Level-1"
   - Center horizontally
   - Padding: 24px all sides

   **Card content**:
   - Label: "Haptic Intensity"
   - Style: "Title/Large" (22px, Medium)
   - Color: "On-Surface"

   - Drag **Slider component** (y: 60px relative to card)
   - Variant: Value = Medium
   - Width: 280px
   - Labels: "Subtle" (left), "Strong" (right)
   - Current value: "Medium" (center, below slider)

   - Test button (y: 120px relative to card):
   - Drag **Button component** → Variant: Secondary, small
   - Text: "Try It"
   - Size: 100 × 36px
   - Position: Right-aligned
   - Icon: Vibration symbol

4. **Card 2: Feedback Types** (y: 320px):
   - Rectangle: 361 × 240px
   - Same styling as Card 1

   **Card content**:
   - Label: "Feedback Types"
   - Style: "Title/Large"

   **5 Toggle rows** (starting y: 60px relative to card, 36px apart):
   - Row 1: "Card Play" + Toggle (ON)
   - Row 2: "Card Draw" + Toggle (ON)
   - Row 3: "Shuffle" + Toggle (ON)
   - Row 4: "Win/Lose" + Toggle (ON)
   - Row 5: "Gesture Confirm" + Toggle (ON)

   **Each row**:
   - Text: Style "Body/Large", Color "On-Surface", Left-aligned (x: 0px)
   - Drag **Toggle component**, Right-aligned (x: 280px)
   - Variant: State = ON (or OFF for variety)

5. **Card 3: Vibration Pattern** (y: 580px):
   - Rectangle: 361 × 180px
   - Same styling as Card 1 & 2

   **Card content**:
   - Label: "Vibration Pattern"
   - Style: "Title/Large"

   **4 Radio button rows** (starting y: 60px relative to card, 32px apart):
   - Row 1: ◉ "Standard" (selected)
   - Row 2: ○ "Subtle"
   - Row 3: ○ "Intense"
   - Row 4: ○ "Custom"

   **Each row**:
   - Radio button: Circle 20 × 20px
     - Selected: Filled with "Primary" color, white dot center (8 × 8px)
     - Unselected: Border 2px "On-Surface-Variant"
   - Text: Style "Body/Large", 12px left of radio

6. **Reset Button** (y: 780px):
   - Drag **Button component** → Variant: Text
   - Text: "Reset to Default"
   - Color: "On-Surface-Variant"
   - Center horizontally

7. **Navigation Bar** (y: 772px):
   - Drag **Navigation Bar component**
   - Variant: Active Tab = Settings
   - Full width

**Pro Tips**:
- Add preview description for each pattern: "Standard: Short pulse"
- Show battery impact: "Current settings: Moderate battery use"
- Include accessibility note: "Enhanced haptics for hearing impaired"

---

## Screen 7: Adaptive Dashboard (50 min)

### Layout Structure
```
┌─────────────────────────┐
│  Your Stats  [Last 7d▼]│ <- Header + filter
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Win Rate     🏆   │  │ <- Card 1
│  │ [Line Graph]      │  │
│  │ 68%    +12%       │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Gesture Accuracy  │  │ <- Card 2
│  │ [Pie Chart] List  │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  ┌───────────────────┐  │
│  │ Play Time     ⏱️  │  │ <- Card 3
│  │ 12.5 hrs          │  │
│  │ 24 games played   │  │
│  └───────────────────┘  │
├─────────────────────────┤
│  Current: Intermediate  │
│  [Progress Bar] 145 XP  │
│  [Navigation Bar]       │
└─────────────────────────┘
```

### Build Instructions

1. **Background**:
   - Fill: "Surface" color

2. **Header** (y: 59px):
   - Title: "Your Stats"
   - Style: "Headline/Large" (28px, Bold)
   - Color: "On-Surface"
   - Position: Left (x: 16px)

   - Date filter button: "Last 7 Days ▼"
   - Style: "Label/Large" (14px)
   - Color: "Primary"
   - Position: Right (x: 280px)
   - Background: "Primary-Container" with 8px padding
   - Corner radius: 8px

3. **Card 1: Win Rate** (y: 130px):
   - Drag **Stats Card component** OR build custom:
   - Rectangle: 361 × 200px
   - Corner radius: 16px
   - Background: "Surface"
   - Shadow: "Elevation/Level-1"
   - Padding: 20px
   - Center horizontally

   **Card header**:
   - Title: "Win Rate"
   - Style: "Title/Large" (22px, Medium)
   - Icon: Trophy 🏆 (24 × 24px, right side)

   **Line graph** (y: 60px relative to card):
   - Size: 320 × 100px
   - 7 data points (Mon-Sun):
     - Mon: 55%, Tue: 60%, Wed: 58%, Thu: 65%, Fri: 68%, Sat: 72%, Sun: 68%
   - Line: 3px stroke, "Success" color (#4CAF50)
   - Data points: Circles 6 × 6px at each point
   - Fill below line: "Success" at 10% opacity (optional)

   **X-axis labels** (below graph):
   - Text: "M  T  W  T  F  S  S"
   - Style: "Label/Small" (11px)
   - Color: "On-Surface-Variant"
   - Evenly spaced

   **Y-axis grid** (optional):
   - 5 horizontal lines: 0%, 25%, 50%, 75%, 100%
   - Color: "Surface-Variant", 1px
   - Very subtle

   **Current value** (bottom-left, y: 165px relative to card):
   - Text: "68%"
   - Style: "Display/Large" (reduce to 32px, Bold)
   - Color: "On-Surface"

   **Change indicator** (bottom-right, y: 175px):
   - Text: "+12%"
   - Style: "Label/Large" (14px, Medium)
   - Color: "Success" green
   - Icon: ↑ arrow (before text)
   - Text: "vs last week" (Label/Small, gray, below)

4. **Card 2: Gesture Accuracy** (y: 350px):
   - Rectangle: 361 × 200px
   - Same styling as Card 1

   **Card header**:
   - Title: "Gesture Accuracy"
   - Icon: Hand wave 👋 (24 × 24px)

   **Content layout**: Split in two columns

   **Left column: Pie chart** (120 × 120px):
   - 3 segments:
     - Excellent (45%): "Success" green, 0-162° arc
     - Good (35%): "Info" blue, 162-288° arc
     - Practice (20%): "Warning" orange, 288-360° arc
   - Position: Left side (x: 20px, y: 60px relative to card)

   **Right column: Legend** (x: 160px, y: 70px relative to card):
   - 3 rows:
     - Row 1: Green square (12 × 12px) + "Excellent" + "45%"
     - Row 2: Blue square + "Good" + "35%"
     - Row 3: Orange square + "Practice" + "20%"
   - Style: "Body/Large" for labels, "Label/Large" for %
   - 24px spacing between rows

5. **Card 3: Play Time** (y: 570px):
   - Rectangle: 361 × 140px
   - Same styling as Card 1 & 2

   **Card header**:
   - Title: "Total Play Time"
   - Icon: Clock ⏱️ (24 × 24px)

   **Large number** (y: 60px relative to card):
   - Text: "12.5 hrs"
   - Style: "Display/Large" (reduce to 36px, Bold)
   - Color: "On-Surface"

   **Breakdown** (y: 105px relative to card):
   - Text: "24 games played"
   - Style: "Label/Large" (14px)
   - Color: "On-Surface-Variant"

6. **Skill Level Section** (y: 730px):
   - Background: Transparent (no card)
   - Width: 361px, center horizontally

   **Level text**:
   - Text: "Current Level: Intermediate"
   - Style: "Title/Large" (18px, Medium)
   - Color: "On-Surface"

   **Progress bar** (y: 20px relative to section):
   - Track: 361 × 8px rectangle, "Surface-Variant" fill, rounded ends
   - Fill: 60% width (217px), "Primary" color, rounded ends
   - Align to track

   **XP remaining** (y: 36px relative to section):
   - Text: "145 XP to Expert"
   - Style: "Label/Small" (11px)
   - Color: "On-Surface-Variant"
   - Right-aligned

7. **Navigation Bar** (y: 772px):
   - Drag **Navigation Bar component**
   - Variant: Active Tab = Profile
   - Full width

**Pro Tips**:
- Add "View Details" link on each card (top-right, small)
- Include time period comparison: "Best day: Saturday (72%)"
- Show achievement badge: "7-day streak! 🔥"
- Add gesture breakdown button: "Tap for individual gesture stats"

---

## ✅ FINAL CHECKLIST (15 minutes)

### Component Usage
- [ ] All buttons use Button component from library
- [ ] All cards use consistent styling (16px radius, Elevation/Level-1)
- [ ] Navigation bars use Nav Bar component (3 screens)
- [ ] Player Hand component used (Screen 2, 5)
- [ ] Playing Card component used (Screen 2, 4, 5)
- [ ] Toggle component used (Screen 6)
- [ ] Slider component used (Screen 6)

### Visual Consistency
- [ ] All screens use iPhone 14 Pro frame (393 × 852)
- [ ] Safe areas respected (top 59px, bottom 34px)
- [ ] 16px margins from edges (consistent)
- [ ] 8px grid alignment (all elements)
- [ ] Color styles used (no hex codes directly)
- [ ] Text styles used (no custom sizes)

### Content Quality
- [ ] Real data (no Lorem ipsum)
- [ ] Consistent terminology ("Shuffle" not "Mix")
- [ ] Proper capitalization (Title Case for buttons)
- [ ] Realistic numbers (win rates, times, scores)
- [ ] Error-free text (spell check)

### Professional Polish
- [ ] All icons aligned and sized consistently (24 × 24px standard)
- [ ] Shadows applied appropriately (buttons, cards, modals)
- [ ] Spacing mathematically consistent (16px, 24px, 32px)
- [ ] Visual hierarchy clear (titles > body > labels)
- [ ] No overlapping elements (clean layout)

### Screen-Specific
- [ ] Screen 1: Tutorial has progress dots (1/5 active)
- [ ] Screen 2: Gameplay has 5 different cards in hand
- [ ] Screen 3: Camera has confidence meter (85% shown)
- [ ] Screen 4: AR has surface grid and floating card
- [ ] Screen 5: Victory has 12 confetti pieces scattered
- [ ] Screen 6: Settings has 5 toggles + 1 slider + 4 radios
- [ ] Screen 7: Dashboard has 3 data viz (line, pie, number)

---

## 🎓 MATERIAL DESIGN 3 PRINCIPLES APPLIED

Your screens follow **Material Design 3 (Material You)** guidelines:

1. **Dynamic Color**: Primary palette from user's wallpaper (simulated)
2. **Elevation**: Tonal surfaces with subtle shadows (Level 0-3)
3. **Typography**: San Francisco Pro (iOS native) scale system
4. **Layout**: 8dp grid with consistent spacing
5. **Components**: State layers (hover, pressed, disabled)
6. **Motion**: Implied animations (Smart Animate in prototype)

**Grading advantage**: MD3 is current industry standard (2024-2025)

---

## ⏭️ NEXT STEP
When complete, message: **"Step 4 complete - Final UI ready"**

Then move to: **STEP5_PROTOTYPE_EXECUTION.md** (Add interactions and flows)
