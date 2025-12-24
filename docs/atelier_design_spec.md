# Fildişi Çikolata & Makaron Atölyesi — Luxury Atelier Website Spec (v1)

This document is the single source of truth for the redesign.

Scope rule: **Design + structure only. No production Flutter UI implementation yet.**

## 0) Brand & Experience North Star

**Positioning**: Limited-production artisan chocolate atelier (bonbons as jewel-like objects). Not a bakery.

**Target emotion**: quiet confidence · precision · craftsmanship · desire.

**Reference feel** (directional): AndSons, Pierre Marcolini, Patrick Roger, Scandinavian minimal luxury.

**Interaction principle**: reveal, don’t shout.

---

## 1) Mandatory Site Structure (IA)

Required pages (6):
1. Landing / Home
2. Bonbon Collection
3. Macaron Collection
4. Gift Boxes
5. Atelier Philosophy
6. Contact / Order

### Route & naming recommendation
Keep routes short and brand-appropriate. Two viable options:

**Option A (TR-first, current project pattern):**
- `/` → Home
- `/bonbonlar`
- `/makaronlar`
- `/hediye-kutulari`
- `/atolye-felsefesi`
- `/siparis-iletisim`

**Option B (EN-neutral, luxury minimal):**
- `/` → Home
- `/bonbons`
- `/macarons`
- `/gift-boxes`
- `/philosophy`
- `/order`

Choose one set and keep it consistent. (Implementation can still localize nav labels later.)

### Mapping from current prototype
- Current “Gallery” becomes: **Bonbon Collection / Macaron Collection / Gift Boxes** (product-led)
- Current “About” becomes: **Atelier Philosophy** (editorial)
- Current “Contact” becomes: **Contact / Order** (conversion clarity)

---

## 2) Design Token System (Implementation-ready)

### 2.1 Color tokens
No loud gradients. **Background is ivory, not pure white.**

**Foundation**
- `bg.ivory` (main background): warm off-white
- `bg.paper` (section background): slightly deeper ivory
- `ink.cocoa` (primary text): deep cocoa
- `ink.muted` (secondary text): cocoa softened
- `stroke.stone` (borders/hairlines): stone/sand

**Accents**
- `accent.gold` (metallic hint): *extremely subtle*, used for 1px rules, tiny bullets, focus ring
- `accent.seasonal` (rotating): used sparingly for one element per screen at most (e.g., a single badge or a micro underline)

**States**
- `state.focus` (keyboard): thin outline, not a glow
- `state.hover` (cards): overlay with subtle opacity shift

Rules:
- Avoid pure black and pure white.
- Avoid large saturated fills.
- Shadows are soft and rare; prefer borders and whitespace.

### 2.2 Typography tokens
**Headings (serif)**: editorial/fashion-like.
**Body (sans)**: modern, neutral.

Token names:
- `type.serif` (headings)
- `type.sans` (body)

Hierarchy:
- `H1` hero statement: serif, large, tight line count (1–2 lines max)
- `H2` section header: serif, smaller than H1, confident
- `H3` product name: serif or high-contrast sans (choose one and commit)
- `Body` descriptions: sans
- `Label` microcopy: sans, increased letter spacing

Letter spacing rules:
- Labels (ALL CAPS or small caps): + tracking
- Body: normal tracking
- Headings: slightly reduced tracking if needed to feel editorial

### 2.3 Spacing scale
Use a strict scale for rhythm:
- `space.2 = 8`
- `space.3 = 12`
- `space.4 = 16`
- `space.6 = 24`
- `space.8 = 32`
- `space.10 = 40`
- `space.12 = 48`
- `space.16 = 64`
- `space.20 = 80`
- `space.24 = 96`

Rule: default to bigger whitespace than feels “normal”.

### 2.4 Radius, borders, elevation
- Radii: small and intentional (avoid bubbly corners)
  - `radius.s = 6`
  - `radius.m = 10`
- Borders: 1px stone hairline where needed
- Elevation: minimal; use only for overlays/dialogs and rare hero images

### 2.5 Texture / grain
A subtle paper grain is allowed.
- Implement as a **tiny repeating** texture asset (compressed), at low opacity.
- Grain must never reduce text legibility.

---

## 3) Layout & Grid Rules

### Breakpoints (recommendation)
- Mobile: 0–599
- Tablet: 600–899
- Desktop: 900–1199
- Wide: 1200+

### Max width and gutters
- Max content width: 1100–1200 (editorial)
- Side gutters:
  - Mobile: 20–24
  - Desktop: 32–48

### Home hero structure
- Full-width hero band (ivory background)
- Content inside max width
- One hero image (bonbon), large, crisp
- One hero statement (≤8 words)
- One primary CTA

### Product grid: “asymmetric rhythm” rules
Goal: jewelry-like presentation without chaotic misalignment.

Rules:
- Use a grid that supports **mixed card spans** (e.g., 2-wide feature card + smaller cards).
- Cards align to an underlying rhythm, but not all baselines match.
- Maintain consistent internal padding and typography.

Card sizing guidance:
- Primary card: large image, 1.2–1.4× height of standard
- Standard card: tall enough for name + flavor line

Image aspect ratios:
- Bonbons: 4:5 or 1:1 depending on photography style
- Gift boxes: 3:2 or 4:3 (packaging oriented)

---

## 4) Interaction & Motion (Calm Luxury)

### Motion constraints
- No bouncy curves
- No aggressive scaling
- No carousel/slider

### Recommended timings
- Hover reveal: 180–240ms
- Page fade transition: 200–320ms
- Section fade-in on scroll: 280–420ms (stagger up to 80ms between items)

### Easing
- Use gentle ease-out / cubic for reveals

### Hover/tap behavior (product cards)
- Default state: image + name + flavor line
- Hover/focus: ingredient/notes layer fades in (opacity + subtle blur)
- Mobile tap: first tap reveals overlay; second tap opens detail (optional)

### Reduced motion
If reduced motion is enabled:
- Remove stagger
- Use immediate or very short fades

---

## 5) Page Blueprints (sections + components)

### 5.1 Landing / Home
**Goal**: desire + clarity.

Sections (top → bottom):
1. `TopNavBar` (minimal)
2. `HeroSection`
   - H1 statement (≤8 words)
   - One hero bonbon image
   - CTA primary: “Explore Bonbons”
   - CTA secondary: “Gift Boxes”
3. `EditorialSection` — Bonbon preview (2–4 items)
4. `EditorialSection` — Macaron preview (2–4 items)
5. `EditorialSection` — Philosophy teaser (short paragraph)
6. `InstagramLinkStrip` (one row, not a wall)
7. `MinimalFooter`

Hero copy options:
- “Sculpted chocolate. Designed to linger.”
- “Quiet precision. Vivid flavor.”
- “Small batches. Lasting impressions.”

### 5.2 Bonbon Collection
**Goal**: present bonbons like jewelry.

Sections:
1. `CollectionHeader`
   - Title
   - 1–2 sentences intro
2. `AsymmetricProductGrid` (signature + seasonal)
3. `CraftNoteBand` (short: limited production / seasonal rotation)
4. `MinimalFooter`

Card content:
- Name
- Flavor line (poetic, short)
- Reveal: ingredients + notes

Flavor line examples:
- “Cocoa depth, orange lift, warm spice.”
- “Hazelnut praliné, browned butter, sea salt.”

### 5.3 Macaron Collection
Same structure as bonbons, with slightly lighter tone.

Intro line example:
- “Thin shells. Clean fillings. Controlled sweetness.”

### 5.4 Gift Boxes
**Goal**: gifting reassurance and clarity.

Sections:
1. `CollectionHeader` (Gift Boxes)
2. `GiftBoxGrid`
   - Each card: box name, piece count, flavor mix, lead time
3. `WhatArrives` (packaging + care card + storage)
4. `OrderingSteps` (3 steps max)
5. `MinimalFooter`

Copy examples:
- “Curated for gifting—finished with understated detail.”

### 5.5 Atelier Philosophy
**Goal**: credibility.

Sections:
1. `EditorialHero` (single image + title)
2. `PhilosophyChapter` x 4–5
   - Craft
   - Ingredients
   - Process
   - Limited Production
   - Seasonal Drops
3. `MinimalFooter`

### 5.6 Contact / Order
**Goal**: conversion with calm clarity.

Layout (desktop): two-column
- Left: address, hours, phone, Instagram
- Right: ordering guidance + lead times

Sections:
1. `ContactHeader`
2. `ContactGrid`
3. `OrderGuidelines`
4. `MinimalFooter`

Microcopy example:
- “Orders are limited. Reserve in advance.”

---

## 6) Component Inventory (Naming + responsibilities)

Core shell
- `AtelierShell`: global background, max-width container, nav, footer
- `TopNavBar`: brand mark, minimal links, menu button on mobile

Editorial primitives
- `EditorialScaffold`: background + texture + gutters
- `EditorialSection`: section spacing + optional intro
- `EditorialDivider`: hairline rule

Hero
- `HeroSection`
- `HeroStatement`
- `HeroMedia`
- `PrimaryCtaRow`

Products
- `AsymmetricProductGrid`
- `ProductCard`
- `ProductRevealOverlay`
- `FlavorLine`
- `IngredientNotes`

Gifting
- `GiftBoxCard`
- `BoxSpecsRow`
- `WhatArrives`

Philosophy
- `PhilosophyChapter`
- `ChapterMedia`
- `ChapterText`

Footer
- `MinimalFooter`
- `FooterContactLine`
- `FooterInstagramLink`

---

## 7) SEO-friendly structure (Flutter Web realities)

Flutter Web has limits vs fully semantic HTML, but we can still improve:
- One clear page title and description per route
- Structured headings via `Semantics` and consistent visual hierarchy
- Avoid heavy client-side-only critical content (keep key copy visible)
- Keep images optimized, use explicit dimensions to reduce layout shift

Implementation notes (later): update `web/index.html` meta tags + dynamic titles per route.

---

## 8) Accessibility checklist

- Contrast: cocoa-on-ivory must meet WCAG AA
- Keyboard: nav + product cards focusable; focus reveals overlay
- Reduced motion: respect user setting
- Tap targets: minimum 44px
- Images: meaningful alt text for hero and products

---

## 9) Acceptance criteria (design)

The redesign is successful when:
- The home page reads like a luxury atelier landing within 3 seconds
- Product pages feel like a gallery of objects, not a grid of snacks
- Hover/tap reveals feel calm and intentional
- Mobile experience feels premium and spacious
- Footer is minimal and uncluttered

