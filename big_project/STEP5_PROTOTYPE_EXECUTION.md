# STEP 5: Prototype Page - Execution Checklist
## ⏱️ Time: 2-3 hours | 📍 Page: "5. Prototype"

---

## 🎯 OBJECTIVE
Turn your Final UI into a fully interactive Figma prototype with 6+ flows, core gesture interactions, smart animate transitions, and circular flow verification. This guide gives you exact hotspots, transitions, and prototype settings to copy/paste in Figma.

---

## 📌 PREPARATION (5 minutes)
1. Open your file `GestureCards Complete` → Go to page **`5. Prototype`**
2. Copy the 7 finished screens from **`4. Final UI`** into this page (select all frames → Cmd/Ctrl+C → Cmd/Ctrl+V)
3. Arrange frames neatly in the page (left to right or grid)
4. Open **Prototype** tab (right panel) and set device: **iPhone 14 Pro**
5. Set start frame: **Screen 1: Gesture Tutorial** (right-click frame → "Set as starting frame")

---

## 🔗 GLOBAL PROTOTYPE SETTINGS
- Interaction type defaults: **On Tap** for buttons
- Animation default: **Smart Animate** where possible, 300ms, Ease Out
- Overflow scrolling: enable for Player Hand carousel frames
- Hotspot hints: enabled (Prototype settings → Enable)
- Tap targets: minimum 44 × 44px for accessibility

---

## 🔁 PRIMARY FLOWS (implementation steps)

Each flow below lists source frame, hotspot, target frame, interaction, animation, and notes (timings, easing, properties). Use the Prototype panel to create connections.

### Flow A: Tutorial → Gameplay
- Source: `Screen 1: Gesture Tutorial`
- Hotspot: Next Step button (Button/Primary)
- Interaction: On Tap
- Action: Navigate → `Screen 2: Gameplay`
- Animation: Smart Animate, 300ms, Ease Out
- Notes: Also connect "Skip Tutorial" → `Screen 2` (On Tap, Instant)

### Flow B: Gameplay → Camera Ready-Check
- Source: `Screen 2: Gameplay`
- Hotspot: Camera icon (bottom nav) or Camera CTA inside play area
- Interaction: On Tap
- Action: Navigate → `Screen 3: Camera Gestures`
- Animation: Move In (From Right), 400ms
- Return: On Cancel in `Screen 3`, navigate back to `Screen 2` (Move Out)
- Notes: Create a variant of `Screen 3` for Recognized state and link an auto transition (85% → Recognized)

### Flow C: Gameplay → AR Mode
- Source: `Screen 2: Gameplay`
- Hotspot: AR button (top-right or CTA)
- Interaction: On Tap
- Action: Navigate → `Screen 4: AR Mode`
- Animation: Dissolve, 400ms
- Return: `Screen 4` Cancel → `Screen 2`, Instant
- Notes: Add a prototype overlay to simulate "placing" the card (use overlay, position: Manual, animation: Move In)

### Flow D: Win Condition → Victory Photo
- Source: `Screen 2: Gameplay` (simulate win)
- Hotspot: (You can create an invisible hotspot over the winning trigger area)
- Interaction: On Tap or After Delay (1000ms)
- Action: Navigate → `Screen 5: Victory Photo`
- Animation: Move In (From Bottom), 600ms, Bounce
- Inside `Screen 5`, link Capture Photo → trigger a transition to a "Captured" variant (use Smart Animate) showing share options
- Notes: Use overlay modal for share sheet (simulate native share)

### Flow E: Gameplay → Haptic Settings
- Source: `Screen 2: Gameplay`
- Hotspot: Bottom Nav → Settings icon
- Interaction: On Tap
- Action: Navigate → `Screen 6: Haptic Settings`
- Animation: Instant
- Return: Bottom Nav Home tab → `Screen 2`

### Flow F: Gameplay → Adaptive Dashboard
- Source: `Screen 2: Gameplay`
- Hotspot: Bottom Nav → Profile icon
- Interaction: On Tap
- Action: Navigate → `Screen 7: Adaptive Dashboard`
- Animation: Instant
- Notes: Ensure each card has a "View Details" hotspot linking to an expanded modal overlay (use overlay, close on tap outside)

---

## ✋ GESTURE INTERACTIONS (Figma-supported + annotated for graders)
Figma can't natively simulate device shakes, pinches, or complex haptics — annotate them with sticky notes and provide alternate clickable hotspots where possible.

### Simulated gestures (use prototype interactions):
- Swipe (cards): set the Player Hand frame to Overflow Horizontal + create left/right hotspots that navigate to next/previous card frames using Smart Animate (200ms, ease out)
- Drag (play card to play area): create a Drag interaction on the card instance (Interaction: On Drag → Navigate to same frame or overlay) — note: Figma supports basic Drag. Use Smart Animate for a visual effect.
- Long Press: create a hotspot with Interaction: On Press and Hold (duration 800ms) → Open overlay modal with card details (animation: Scale Up, 200ms)

### Annotated gestures (place sticky notes on prototype):
- Pinch to resize (AR mode): sticky note describing expected behavior and status
- Shake to shuffle: sticky note describing haptic + shuffle effect; provide a "Shuffle" button to simulate in prototype
- Device specific haptics: annotate where haptic feedback would be triggered (play, recognize, win)

---

## 🎯 ADVANCED TRANSITIONS (for polish)
- Use **Smart Animate** on components that exist across frames (cards, nav bar, hand) to create smooth continuity
- Use **Overlay** for modals (card detail, share sheet) with animation: Move In + dim background
- Use **After Delay** (1000ms) to simulate automatic transitions (e.g., win animation → Victory screen)
- For confidence meter: create multiple frames of `Screen 3` with progress 0%, 45%, 85%, 100% and chain them via After Delay (150ms) with Smart Animate to simulate recognition progress

---

## ✅ PROTOTYPE TEST PLAN (10 minutes)
1. Enter Present mode (Play) and test the main flows listed above
2. Verify circular flows: each flow returns to Gameplay or Tutorial as described
3. Test Smart Animate continuity across screens (cards, nav)
4. Confirm overlays close on tap outside and return to correct state
5. On mobile (Figma Mirror), verify tap targets, scroll behavior, and overflow
6. Make quick fixes: adjust timings (200-400ms), fix anchor points for Smart Animate

---

## 🔖 DEVELOPER HANDOFF NOTES
- Add sticky notes for any behavior Figma can't simulate (e.g., real-time MediaPipe thresholds, on-device ML triggers, haptic strength mapping)
- Export assets used in prototype as PNG/SVG with exact size naming (e.g., `card_back_160x224.png`)
- Provide a short README in `Our Assets` describing recognition thresholds and mock endpoints for devs

---

## ⏭️ NEXT STEP
When prototype flows are in place, message: **"Step 5 complete - Prototype ready"**

Then proceed to Step 6: Test & Submit (next file created).