# Grafikquellen

## Spieler-Richtungsatlas

- Datei: assets/sprites/player_directions_ai_20261001.png
- Format: PNG mit transparentem Hintergrund, 1262 × 1246 Pixel, 2 × 2 Ansichten.
- Zellenreihenfolge: oben links vorne, oben rechts Profil nach links, unten links Rücken, unten rechts Profil nach rechts.
- Herkunft: mit dem integrierten OpenAI Imagegen in Codex aus dem abgestimmten Spielerentwurf weiterentwickelt. Der Entwurf aus dem lokalen Mockup-Ordner diente als Identitäts- und Stilreferenz; es wurde kein Fremdasset eingebunden.
- Verwendung: Sprite2D liest die Zellen über zwei horizontale und zwei vertikale Frames. Die Spielrichtung wählt den passenden Frame; der Sprite selbst wird nicht gespiegelt.
- Transparenz wurde am oberen linken Bildpunkt geprüft.

### Finaler Prompt

<pre>
Use case: stylized-concept
Asset type: four-direction 2D player-character sprite atlas for a top-down Godot game
Input image: Image 1 is the approved character-design reference; preserve the same character identity, outfit, colors, proportions, satchel design, and pixel-art style.
Primary request: Create a clean transparent 2-by-2 sprite atlas of the same small red-haired moor apothecary adventurer, ready to use as four directional idle sprites in a game.
Composition: exactly four equal square cells with no dividers or cell backgrounds. Top-left: front view, facing down toward the player. Top-right: left profile, facing screen-left. Bottom-left: back view, facing up away from the player. Bottom-right: right profile, facing screen-right. Keep all four sprites at the same scale, centered, and standing on the same bottom baseline with generous transparent padding; each sprite stays fully inside its own cell.
Character: short auburn hair, dark moss-green hood and cape, cream scarf, orange coat with straw-gold cuffs, dark tunic and trousers, brown boots, one brown cross-body satchel.
Satchel logic: the satchel remains attached to the character's anatomical left hip in all four views, connected by one continuous cross-body strap from the opposite shoulder. In the front view this left hip appears on the viewer's right; in the back view it appears on the viewer's left. In profile views, show the same physical satchel attached behind the torso only where that side is visible; if the body hides it, let it be partly occluded rather than moving it to the other hip or mirroring the whole character.
Mint logic: one small mint sprig grows naturally from the opening of the satchel, integrated with the pocket seam. Show it peeking from the front view; hide it in the back view because the body blocks the opening. In the left profile, allow only a small glimpse if the opening faces the camera. In the right profile, do not mirror the sprig onto the opposite side.
Style: crisp hand-crafted 16-bit pixel art with visible deliberate pixel clusters and hard edges, limited warm moor palette, consistent dark outlines, readable at about 32 game pixels tall.
Lighting: soft warm late-evening highlight matching the reference without dramatic cast shadows.
Constraints: actual transparent background, exactly one character per cell, no text, no labels, no glow, no floor, no scenery, no props outside the satchel, no extra accessories.
Avoid: 3D rendering, painterly shading, blurred/anti-aliased edges, detached bag or sprig, inconsistent strap, duplicated straps, changed clothing, mirrored character poses, clipped limbs, cell overflow.
</pre>
## Moor-Umgebungsatlas

- Datei: assets/tilesets/moor_vegetation_atlas_ai_20261001.png
- Format: PNG mit transparentem Hintergrund, 1261 × 1247 Pixel, 4 × 4 Motive.
- Herkunft: eigens mit dem integrierten OpenAI Imagegen in Codex erstellt und verfeinert. Es wurde kein Fremdasset eingebunden.
- Stilreferenz: das zuvor abgestimmte warme Abendmoor-Konzept aus dem lokalen Mockup-Ordner; nur Stimmung und Farbpalette wurden als Hinweis verwendet.
- Verwendung: Die 16 Zellen werden im Kartenskript proportional aus der Atlasgröße berechnet und mit Godots draw_texture_rect_region auf 16-Pixel-Spielmaßstab gezeichnet. Die Projektfilterung nutzt den nächsten Pixel.
- Transparenz wurde am oberen linken Bildpunkt geprüft. Bilddatei und alle finalen Promptdurchläufe gehören zum Projekt.

### Prompt zur Erstgenerierung

<pre>
Use case: stylized-concept
Asset type: 2D pixel-art decoration atlas for a top-down Godot game
Input image: Image 1 is a mood and color reference only; do not copy its composition or painterly rendering.
Primary request: Create one clean, production-ready sprite atlas for a cozy herb-gathering game set in a warm evening moor. The atlas has exactly 4 columns and 4 rows of equal square cells, with sixteen distinct, individually centered environmental decoration sprites. Each sprite stays entirely inside its own cell, with generous transparent padding so no sprite touches or crosses a cell boundary. No grid lines or cell backgrounds.
Subject: top-down marshland details: varied reed tufts with cattails, golden grass clumps, a fern, a small mint-like leafy tuft, dark purple and cream wildflowers, a mossy stone cluster, a weathered driftwood branch, a low tree stump, two different lily pads, a lily pad with one small pink flower, a tiny mushroom pair, scattered amber leaves, and a small marsh blossom clump. Each cell should contain exactly one distinct sprite, not a scene.
Style/medium: authentic crisp 16-bit pixel art with deliberate visible pixel clusters and hard edges, limited palette, no painterly brushwork, no blur, no gradients, no anti-aliasing, designed to read when reduced to about 32x32 game pixels.
Lighting/mood: soft amber late-evening light, gentle warm highlights, cozy and magical but readable.
Color palette: moss greens, muted sage, deep teal, warm straw gold, earthy brown, small accents of muted plum, cream, and rose.
Composition/framing: orthographic directly top-down game sprites, 4x4 evenly aligned atlas, consistent scale and light direction, square cells, transparent empty space around each object.
Constraints: actual transparent background, no tile or cell backgrounds, no text, no labels, no border, no watermarks, no characters, no buildings, no UI, no scene perspective, no shadows extending into neighboring cells.
Avoid: photorealism, isometric angle, pixelated filters over smooth painting, repeated identical icons, random objects outside cells, any objects touching each other.
</pre>

### Bereinigungsschritte

<pre>
Edit the provided 4-by-4 environmental sprite atlas. Preserve the exact 4-column by 4-row layout, keep one centered sprite in each cell, and preserve the same sprite subjects and their order. Keep a genuinely transparent background and clear transparent padding between cells.
Make one targeted improvement: remove every red, magenta, pink, or bright outline fringe around the sprites. Replace it with clean dark-green or brown pixel outlines that naturally match each sprite. Simplify the art into flatter, readable 16-bit game pixel art with compact deliberate pixel clusters; remove the chunky 3D/voxel look, excessive tiny texture noise, bevel-like highlights, and painted shading. Keep the warm moss, sage, teal, straw-gold, brown, plum, cream, and muted rose palette. Each sprite must remain distinct and legible when displayed at 32 by 32 game pixels.
No added objects, no cell dividers, no labels, no text, no shadows between cells, no background color, no external glow, no red fringe.
</pre>

<pre>
Make a precise cleanup pass on this 4-by-4 pixel-art sprite atlas. Preserve exactly the same sixteen subjects in the same cells and the same left-to-right, top-to-bottom order. Keep the atlas background transparent.
Changes required: (1) shrink each sprite so it occupies no more than the centered 65 percent of its own cell, leaving a wide empty transparent safety margin on all four sides; no blade, leaf, shadow, or pixel may touch or cross a cell edge. (2) remove any bright red, pink, orange, white, or yellow fringe around silhouettes. Use only natural dark green/brown outline pixels that belong to the sprite; no external glow or colored rim. Keep the art as clean, flat, readable 16-bit pixel art with a small deliberate palette, not 3D or voxel art.
Do not add or remove subjects. No cell dividers, no text, no labels, no background fill, no neighboring shadows.
</pre>

## VIS-003 – Stationen, Bewohner und Sammelpflanzen

Alle drei PNG-Dateien sind transparente Atlanten mit 2172 × 724 Pixeln und drei Zellen à 724 × 724 Pixel. Sie wurden mit dem integrierten OpenAI Imagegen in Codex erstellt; es wurden keine Fremdassets eingebunden. Die Mockups dienten nur als Stil- und Farbhinweis.

| Datei | Zellen von links nach rechts | Spielverwendung |
| --- | --- | --- |
| assets/sprites/workstations_ai_20261001.png | Trockengestell, Braukessel, Auftragsbrett | Drei Sprite2D-Frames; bestehende Interaktionen bleiben. |
| assets/sprites/villagers_ai_20261001.png | Fenja, Marten, Lene | Drei Sprite2D-Frames an den bestehenden Bewohnern. |
| assets/sprites/herb_pickups_ai_20261001.png | Sumpfminze, Schilfwurzel, Nachtmoos | Drei Sprite2D-Frames; Pickup-Logik steuert Sichtbarkeit. |

Der korrigierte Stationenatlas wurde auf Zellrandabstand geprüft: Das Trockengestell endet 76 Pixel vor der Trennkante; die nächste Grafik beginnt 92 Pixel innerhalb der zweiten Zelle. Godot verwendet Nearest-Filterung.

### Finaler Prompt – Stationen

<pre>
Use case: stylized-concept
Asset type: transparent 3-cell horizontal pixel-art sprite atlas for a cozy Godot top-down game, Moor-Apotheke
Input images: Image 1 is the approved player sprite, use only for pixel-art rendering style and warm outline treatment. Image 2 is the approved moor vegetation atlas, use only for its moss, peat, reed, and dusk palette. Do not copy any subject from either image.
Primary request: Create exactly three distinct, readable game props in a single horizontal 3-cell atlas, one centered object per equal-width cell, with transparent background and no visible cell dividers.
Scene/backdrop: no backdrop or ground plane; isolated props on transparency.
Subject: Cell 1, a small sturdy wooden drying rack with crossbar, two hanging bunches of mint and reed herbs, and little cloth ties. Cell 2, a compact dark iron herbal cauldron on a simple peat-brick stand, with a copper rim and two tiny warm reflected highlights. Cell 3, a weathered timber village request board on two short posts, holding several pale parchment notes with simple tiny herb marks, absolutely no readable writing.
Style/medium: handcrafted crisp 16-bit pixel art, deliberate blocky pixel clusters, hard pixel edges, limited palette, dark moss-brown outlines, richly textured wood, iron, peat and paper, matching the references' polished but compact sprite art.
Composition/framing: front-facing props from a slightly elevated top-down game viewpoint, like the references; same visual scale and ground baseline, isolated per cell, generous transparent padding, no overlap across cell boundaries. Keep silhouettes distinctive and readable when each cell is displayed about 32–42 game pixels tall.
Lighting/mood: soft warm late-evening highlights, calm and cozy.
Color palette: peat brown, weathered honey wood, charcoal iron, muted copper, sage green, mint, parchment cream; harmonize with both references.
Materials/textures: individual pixel clusters for wood grain, tied herbs, iron bands, paper corners; avoid smooth gradients.
Constraints: actual transparent alpha background, exactly 3 equal cells in one row, no text, no labels, no scenery, no characters, no shadow extending into another cell, all props fully inside their cell.
Avoid: photorealism, 3D rendering, blur, anti-aliased edges, glows, shiny modern metal, overly ornate fantasy machinery, UI frame, watermark, cast shadows outside each prop.
</pre>

### Finaler Prompt – Bewohner

<pre>
Use case: stylized-concept
Asset type: transparent 3-cell horizontal atlas of front-facing stationary villager sprites for a cozy Godot top-down game, Moor-Apotheke
Input images: Image 1 is the approved player character; use only as the scale, pixel-art craft, outline, and warm dusk style reference. Image 2 is the approved moor vegetation atlas; use only for the moss, peat, sage and muted flower palette. Do not copy its subjects.
Primary request: Draw exactly three distinct friendly village residents as small full-body game sprites, one centered in each equal-width cell of one 3-cell horizontal atlas.
Scene/backdrop: none, genuinely transparent background.
Subject: Cell 1 Fenja, a practical village herbalist with chestnut-brown hair, a moss-green bonnet, sage-green work dress and warm cream scarf/apron detail. Cell 2 Marten, a sturdy peat gatherer with a weathered brown cap, earth-brown work coat, dark green accents, and one small simple hand shovel held at his side. Cell 3 Lene, an elderly healer with softly silver-gray hair, a pale sage shawl, layered deep teal dress, and one tiny leafy brooch. Keep each character recognizable through silhouette and two or three large color shapes, with kind understated expressions.
Style/medium: polished hand-crafted 16-bit pixel art, visible deliberate pixel clusters, hard crisp pixel edges, the same thick dark outline, warm shaded highlights and restrained detail as the references; match their small readable sprite scale.
Composition/framing: straight-on front-facing idle standing poses, same body proportions and height, feet on one shared baseline, full bodies visible, centered in separate equal square-like cells, generous transparent padding, no touching adjacent cells. Readable at about 28–32 game pixels tall.
Lighting/mood: warm late-evening highlights, calm welcoming village.
Color palette: moss green, peat brown, amber, sage, cream, muted teal and chestnut; clearly distinguish the three residents while harmonizing with the references.
Materials/textures: discrete pixel clusters in cloth, hair and leather; simple folded fabric, no soft gradients.
Constraints: actual transparent alpha, exactly 3 cells in one row, no names, no labels, no scenery, no extra items except Marten's small shovel, no cell dividers, no cropping, subtle compact foot shadows only.
Avoid: 3D, photorealism, painterly blur, anti-aliased edges, complex anatomy, oversized heads, shiny armor, hats obscuring faces, large handheld objects, glows, text, watermark, ground tiles.
</pre>

### Finaler Prompt – Sammelpflanzen

<pre>
Use case: stylized-concept
Asset type: transparent 3-cell horizontal atlas of collectible herb sprites for a cozy Godot top-down game, Moor-Apotheke
Input images: Image 1 is the approved moor vegetation atlas, use its pixel-art craft, foliage shapes, dark outlines, and warm wetland palette. Image 2 is the approved player, use only as a scale and rendering-style reference. Do not copy their subjects.
Primary request: Create exactly three distinctive collectible medicinal plants as isolated game sprites, one centered in each equal-width cell of a single horizontal 3-cell atlas.
Scene/backdrop: none; real transparent background, no ground tile.
Subject: Cell 1 Sumpfminze, a low but lush cluster of broad mint leaves with a few small mint blossoms, unmistakably leafy rather than a generic flower. Cell 2 Schilfwurzel, three narrow upright reed blades and two warm ochre exposed root segments crossing the base, so both reed and root are visible. Cell 3 Nachtmoos, a compact low cushion of deep blue-green bog moss with tiny pale sage dew flecks and one or two small muted purple buds; quiet and rare, no magical glow.
Style/medium: crisp hand-crafted 16-bit pixel art, intentional blocky clusters, hard clean pixel edges, thick dark moss-brown outlines, rich but restrained natural shading, matching the approved moor atlas.
Composition/framing: top-down game sprite viewed at the same slightly elevated angle as the reference plants; centered, compact silhouettes on a shared baseline; all leaves/roots fully inside their cell with generous transparent padding. Distinct forms must read when displayed around 20–24 game pixels tall.
Lighting/mood: late-evening warm rim light with soft local highlights, damp and cozy.
Color palette: moss, sage, fern green, muted mint, peat brown and ochre root; night moss adds restrained cool teal and a few plum pixels.
Materials/textures: pixel clusters, no smooth gradients, clear leaf veins using only a few readable pixel groups.
Constraints: genuine transparent alpha background, exactly 3 equal cells in one row, one plant species per cell, no labels, no text, no frame, no overlapping or crossing cell boundaries, no scenery, no extra flowers except specified blossoms/buds.
Avoid: photorealism, 3D, painterly softness, anti-aliasing, glow, sparkles, water, pots, picked bouquets, repeated identical plants, watermark.
</pre>

### Gezielter Korrekturprompt – Zellabstand Stationen

<pre>
Use case: precise-object-edit
Asset type: transparent horizontal 3-cell pixel-art atlas for Godot, preserving the existing Moor-Apotheke station sprites
Input image: Image 1 is the exact atlas to edit. Preserve its three-column single-row layout, pixel-art style, palette, subjects, and overall canvas dimensions.
Primary request: Fix only the first cell's drying-rack fit. Reduce the drying rack and both hanging herb bundles together by about 10 percent and center them in the first 724-by-724-pixel cell, leaving a clearly transparent margin of at least 48 pixels from every cell edge. Ensure no rack wood, foliage, tie, highlight, shadow, or fringe crosses x=723 into the second cell.
Constraints: Keep the cauldron unchanged and centered in the second cell. Keep the request board unchanged and centered in the third cell. Preserve actual transparency, 3 equal square cells, current cell order, and the established crisp 16-bit pixel style. Do not alter colors, add or remove subjects, add dividers, or change any detail except the size and placement of the first-cell rack needed to create safe padding.
Avoid: changing the canvas layout or dimensions, moving the cauldron or board, style drift, blur, anti-aliasing, black cell backgrounds, text, labels, watermark.
</pre>