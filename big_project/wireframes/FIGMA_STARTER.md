Figma Starter - Quick import assets & build steps

Purpose
This short guide walks you through importing the SVG assets in `wireframes/assets/` and creating the first Figma frames/components for GestureCards.

Files to import (already in repo)
- `wireframes/assets/hand_wave.svg`
- `wireframes/assets/thumbs_up.svg`
- `wireframes/assets/trophy.svg`
- `wireframes/assets/confetti.svg`
- `wireframes/assets/card_template.svg`

Step 0 - open your Figma account
- Sign in at https://www.figma.com
- Create a new file named: "GestureCards - Wireframes"

Step 1 - Create phone frames
- Press `F` and choose iPhone 14 Pro (or Android) frame
- Duplicate frame 7 times (Cmd/Ctrl + D) and rename:
  - Screen 1 - Tutorial
  - Screen 2 - Gameplay
  - Screen 3 - Camera Gestures
  - Screen 4 - AR Mode
  - Screen 5 - Victory Photo
  - Screen 6 - Haptic Settings
  - Screen 7 - Adaptive Dashboard

Step 2 - Import assets
- Menu -> File -> Place image or drag-and-drop each SVG from `wireframes/assets/`
- Place icons in an "Assets" panel on left of canvas

Step 3 - Create card component
- Drag `card_template.svg` onto frame
- Select it and click "Create component" (Cmd/Ctrl + Alt + K)
- Name component: `Card / Default`
- Create variants later for selected/played states

Step 4 - Create icon components
- For each SVG (hand_wave, thumbs_up, trophy, confetti):
  - Drag to canvas, make a component
  - Organize in a `Icons` frame (left side)

Step 5 - Build Screen 1 (Tutorial)
- Use the `hand_wave` icon large in center
- Add text blocks (T) below for instructions
- Add progress dots (use circles)
- Prototype: add interaction to next frame

Step 6 - Build Screen 3 (Camera Gestures)
- Place a large rectangle to represent camera viewfinder
- Drag `hand_wave` svg into viewfinder
- Add green stroke rectangle overlay (use color styles)
- Add player status grid (4 components) with checkmark icons

Step 7 - Reuse components across screens
- Use `Card / Default` in Screen 2 and Screen 4
- Use icons from `Icons` frame for consistent look

Step 8 - Export
- Select all 7 frames (click first, Shift+click last)
- Right sidebar -> Export -> PNG -> 2x
- Save into `wireframes/` and name as: `wireframe_1_tutorial.png`, etc.

Optional: Share interactive link
- Click Share -> Anyone with link can view
- Paste link into deliverable

Notes
- If you want, I can generate more SVGs (arrows, camera frame, checkmarks) or tweak these assets.
- Tell me when you've created the Figma file and imported the assets; I can walk you through building Screen 1 step-by-step or create the remaining SVG components you want.
