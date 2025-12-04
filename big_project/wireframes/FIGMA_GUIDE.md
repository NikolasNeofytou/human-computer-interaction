# Figma Quick Start Guide for GestureCards Wireframes

## Get Started in 30 Minutes

### Step 1: Setup (5 minutes)

1. **Create Free Account**
   - Go to: https://www.figma.com
   - Sign up with email (or use Google/GitHub)
   - Choose "Free" plan (unlimited files)

2. **Create New Design File**
   - Click "+ New design file"
   - Rename to "GestureCards Wireframes"
   - You'll see a blank canvas

3. **Set Up Phone Frame**
   - Press `F` (Frame tool) or click frame icon
   - Select "Phone" → "iPhone 14 Pro" (or Android)
   - This gives you proper phone dimensions (393 x 852 px)
   - Duplicate frame 7 times (Cmd/Ctrl + D)

### Step 2: Get UI Kits (5 minutes)

**Free Wireframe Kits (Copy to your file):**

1. **Wireframe Kit** (essential components)
   - Search Figma Community: "Wireframe kit"
   - Popular: "Wireframing Kit" by Figma (official)
   - Click "Duplicate" to your drafts
   - Copy components to your GestureCards file

2. **iOS/Material Design Icons**
   - Search: "Material Icons" or "iOS 17 UI Kit"
   - Duplicate to drafts
   - Use for buttons, icons, navigation

3. **Hand Gesture Icons** (for your project)
   - Search: "Hand gestures" or "Touch gestures"
   - Find packs with shake, swipe, pinch icons

**How to Copy Components:**
- Open UI kit file
- Select components you need
- Cmd/Ctrl + C (copy)
- Switch to GestureCards file
- Cmd/Ctrl + V (paste)

### Step 3: Essential Shortcuts (Learn these 10)

| Shortcut | Action | Use Case |
|----------|--------|----------|
| `F` | Frame tool | Create phone screen |
| `R` | Rectangle | Buttons, cards, boxes |
| `T` | Text tool | Labels, descriptions |
| `O` | Circle | Icons, avatars |
| `Cmd/Ctrl + D` | Duplicate | Copy elements quickly |
| `Cmd/Ctrl + G` | Group | Organize layers |
| `A` | Auto Layout | Responsive spacing |
| `Shift + A` | Add to auto layout | Smart alignment |
| `Cmd/Ctrl + /` | Quick actions | Search any command |
| `Space + Drag` | Pan canvas | Navigate |

### Step 4: Wireframe Workflow (15 minutes per screen)

**For Each Screen:**

1. **Start with Frame**
   - Select iPhone frame
   - Name it (e.g., "Screen 1 - Tutorial")

2. **Add Structure** (3 min)
   - Draw rectangles for major sections
   - Use gray (#F5F5F5) for backgrounds
   - Use lines (L key) to separate areas

3. **Add Components** (5 min)
   - Drag buttons from UI kit
   - Add text labels (T key)
   - Insert icons from icon pack
   - Place placeholder images

4. **Add Details** (4 min)
   - Gesture indicators (arrows, motion lines)
   - Annotations (small text explaining interactions)
   - State variations (before/after)

5. **Polish** (3 min)
   - Align elements (select all, use alignment tools)
   - Consistent spacing (use auto-layout)
   - Group related elements (Cmd/Ctrl + G)

---

## Screen-by-Screen Tips

### Screen 1: Gesture Tutorial

**Quick Method:**
1. Add phone frame
2. Draw top navigation bar (rectangle)
3. Insert hand gesture icon from UI kit (center, large)
4. Add instruction text below icon
5. Add progress dots (circles at bottom)
6. Add "Next" button

**Figma-Specific Tips:**
- Use "Effects" → "Drop Shadow" for elevated elements
- Use "Opacity" for semi-transparent overlays
- Duplicate dots, change fill color for active state

### Screen 2: Gameplay

**Quick Method:**
1. Top bar: Text + icons
2. Opponent area: Avatar (circle) + name + cards (rectangles)
3. Play area: Larger rectangles for card table
4. Gesture hints: Text with small icons
5. Your hand: Row of card rectangles
6. Bottom bar: Icons and turn indicator

**Figma-Specific Tips:**
- Use "Component" feature for cards (create once, reuse)
- Use "Constraints" to keep elements aligned when resizing
- Group sections (top bar, play area, hand) for easy editing

### Screen 3: Camera Gestures

**Quick Method:**
1. Large rectangle (gray fill) = camera viewfinder
2. Add border with dashed stroke (AR detection grid)
3. Hand icon in center with green outline
4. Player grid: 4 small rectangles with avatars
5. Add checkmark icons (✓) for ready players
6. Buttons at bottom

**Figma-Specific Tips:**
- Use "Stroke" → "Dashed" for detection grid
- Green color (#4CAF50) for active states
- Use "Instance" feature for repeated player cards

### Screen 4: AR Mode

**Quick Method:**
1. Full-screen rectangle (camera background)
2. Dotted grid overlay (low opacity)
3. Card component (with shadow effect)
4. Distance text labels
5. Exit button (top corner)

**Figma-Specific Tips:**
- "Effects" → "Layer Blur" for background (realistic camera)
- "Effects" → "Drop Shadow" for floating cards
- Use perspective transform (rotate slightly) for 3D feel

### Screen 5: Victory Photo

**Quick Method:**
1. Camera viewfinder rectangle
2. Trophy icon (center, large)
3. Confetti shapes (small circles, triangles)
4. Countdown text
5. Stats sidebar (rectangle with text)
6. Action buttons (bottom)

**Figma-Specific Tips:**
- Use "Plugins" → "Confetti" for automatic particles
- Bright colors for celebration feel
- "Effects" → "Inner Shadow" for depth

### Screen 6: Haptic Settings

**Quick Method:**
1. Slider component (line + circle handle)
2. List items (rectangles with text)
3. Test buttons (rounded rectangles)
4. Radio buttons for presets (circles)

**Figma-Specific Tips:**
- Use "Auto Layout" for list items (perfect spacing)
- Create slider as component (reusable)
- "Prototype" mode to show slider interaction

### Screen 7: Adaptive Dashboard

**Quick Method:**
1. Pie chart: Use "Arc" tool or plugin
2. Stat cards: Rectangles with text + icons
3. Checkmarks for optimizations list
4. Buttons at bottom

**Figma-Specific Tips:**
- **Pie Chart Plugin**: "Chart" by Moritz Schwarz (free)
- Use "Data" feature to populate stats
- Color code metrics (green = good, red = bad)

---

## Speed Tips

### 1. Use Auto Layout Everywhere
- Select elements → Shift + A
- Automatically spaces and aligns
- Responsive when content changes

### 2. Create Components for Repeated Elements
- Card component (use 7 times)
- Button component (use everywhere)
- Select element → Create Component (Cmd/Ctrl + Alt + K)

### 3. Use Plugins (Save Hours!)

**Essential Plugins:**
- **Iconify** - 150,000+ free icons
  - Install: Plugins → Browse → Search "Iconify"
  - Usage: Plugins → Iconify → Search "hand wave"
  
- **Unsplash** - Free stock photos
  - For realistic backgrounds
  
- **Chart** - Automatic charts/graphs
  - Perfect for adaptive dashboard pie chart
  
- **Lorem Ipsum** - Placeholder text
  - Plugins → Lorem Ipsum → Generate

### 4. Keyboard Workflow
- `Cmd/Ctrl + /` → Type action (e.g., "align center")
- No need to find buttons in menus

### 5. Use Styles
- Create text styles (Header, Body, Caption)
- Create color styles (Primary, Background, Text)
- Reuse across all screens (one-click consistency)

---

## Export for Deliverable

### Method 1: Export as PNG (Recommended)

1. **Select Frame** (click frame name in layers)
2. **Add Export Settings** (right sidebar)
   - Click "+" under Export
   - Format: PNG
   - Scale: 2x (for retina/high-res)
3. **Export**
   - Select all 7 frames
   - Click "Export" button
   - Save to `wireframes/` folder
4. **Name Files**:
   - `wireframe_1_tutorial.png`
   - `wireframe_2_gameplay.png`
   - etc.

### Method 2: Export as PDF (Alternative)

1. Select all frames
2. File → Export frames to PDF
3. One PDF with all 7 screens
4. Insert into deliverable

### Method 3: Share Link (Bonus)

1. Click "Share" (top right)
2. Set to "Anyone with link can view"
3. Copy link
4. Add link to deliverable: "View interactive wireframes: [link]"
5. Professor can see in browser (impressive!)

---

## Time Breakdown

**Total Time: 4-5 hours**

| Task | Time |
|------|------|
| Setup account & learn basics | 30 min |
| Download UI kits | 15 min |
| Screen 1: Tutorial | 30 min |
| Screen 2: Gameplay | 45 min (most complex) |
| Screen 3: Camera | 30 min |
| Screen 4: AR Mode | 30 min |
| Screen 5: Victory Photo | 25 min |
| Screen 6: Haptic Settings | 25 min |
| Screen 7: Dashboard | 35 min |
| Polish & consistency | 30 min |
| Export & naming | 15 min |

**First screen takes longest (learning), rest go faster!**

---

## Professional Tips

### 1. Consistency is Key
- Use same font throughout (SF Pro for iOS, Roboto for Android)
- Consistent spacing (8px, 16px, 24px grid)
- Same button style everywhere
- Consistent icon style (all outline or all filled)

### 2. Annotations Matter
- Add small notes explaining interactions
- Use arrows to show gesture directions
- Label interactive elements
- Show state changes (before/after)

### 3. Realistic Content
- Use actual text (not Lorem Ipsum)
- Real player names (Sarah, Mike, Lisa)
- Believable scores (42, 78, etc.)
- Actual card symbols (♠ ♥ ♦ ♣)

### 4. Show Gesture Indicators
- Arrows for swipe directions (→ ↑ ↓)
- Curved arrows for rotation
- Wavy lines for shake
- Dotted paths for motion

---

## Learning Resources

### Figma Official Tutorials (Free)
- **"Figma for Beginners"** (4 videos, 30 min total)
  - https://www.youtube.com/figma
  
- **"Design a Mobile App"** (hands-on tutorial)
  - Figma's YouTube channel

### Quick Reference
- **Figma Keyboard Shortcuts Poster**
  - Help → Keyboard Shortcuts
  - Print and keep nearby

### Community
- **Figma Community** - Free templates
  - Browse mobile app wireframes
  - Duplicate and modify for inspiration

---

## Troubleshooting

**Q: Figma is laggy**
A: Use desktop app instead of browser (File → "Get desktop app")

**Q: Can't find gesture icons**
A: Use Iconify plugin (Plugins → Browse → Install Iconify)

**Q: Elements won't align**
A: Select all → Right-click → "Tidy up" or use Auto Layout

**Q: Text is blurry**
A: Export at 2x scale (Export settings → 2x)

**Q: Too much to learn**
A: Start with Screen 1, use template, duplicate for others

---

## Alternative: Start from Template

**Fastest Method** (2-3 hours):

1. Search Figma Community: "Mobile app wireframe"
2. Find template with similar screens
3. Duplicate to your account
4. Replace content with GestureCards specifics
5. Modify layouts to match your specs
6. Export

**Recommended Templates:**
- "Mobile App Wireframe Kit" by Figma
- "iOS 17 UI Kit" by Joey Banks
- "Material Design System" by Google

---

## Final Checklist

Before exporting:

- [ ] All 7 screens created
- [ ] Consistent phone frame size (all screens)
- [ ] Labels on all interactive elements
- [ ] Gesture indicators visible
- [ ] Annotations added where needed
- [ ] Text is readable (not too small)
- [ ] Colors are consistent
- [ ] Spacing looks professional
- [ ] Named frames correctly
- [ ] Grouped elements logically
- [ ] Exported at 2x resolution
- [ ] Files named correctly

---

## Summary: Your Workflow

1. **Setup** (30 min): Create account, get UI kits
2. **Screen 1** (30 min): Learn basics while building tutorial
3. **Screens 2-7** (25-45 min each): Faster as you learn
4. **Polish** (30 min): Consistency pass, alignment
5. **Export** (15 min): PNG files, proper naming

**Total: 4-5 hours for professional wireframes**

---

## Pro Move: Add to Resume

After completing:
- "Designed mobile app wireframes in Figma"
- "Created 7-screen user flow for gesture-based interface"
- "Applied HCI principles to visual design"

**Figma skills are valuable** - recruiters search for this!

---

**Ready to create industry-standard wireframes! 🎨🚀**

Start here: https://www.figma.com/signup
