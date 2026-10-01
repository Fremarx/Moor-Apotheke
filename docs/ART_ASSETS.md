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

## MAP-03 – Wiederverwendbarer Moor-Kachelatlas

- Datei: `assets/tilesets/moor_terrain_atlas_ai_20261001.png`
- Format: PNG, 128 × 128 Pixel, 8 × 8 Zellen à 16 × 16 Pixel; eingesetzt über `assets/tilesets/moor_terrain_tileset.tres`.
- Aufbau: Reihe 0 enthält den ruhigen, einfarbigen Basistile (`#707A50`) und dezente Grasvarianten; Reihe 1 Gras- und Moosvarianten; Reihe 2 Torf und Schlamm; Reihe 3 gerade Wege, Kurven und Endstücke; Reihe 4 Wasser; Reihe 5 Ufer; Reihe 6 Holzstege und Brückenteile; Reihe 7 Schilf und nasse Uferkanten.
- Verwendung: Ein gemeinsames TileSet wird von den `TerrainBase`-TileMapLayers im Dorfplatz und Schilfufer genutzt. Der Basistile füllt das Kartenraster; die bestehenden Wege, Uferkonturen und Bodendetails werden weiterhin von den Kartenskripten gezeichnet. Weitere Kacheln sind im Editor zur manuellen Verwendung verfügbar. Automatische Terrainmasken sind nicht eingerichtet.
- Herkunft: Mit dem integrierten OpenAI Imagegen in Codex am 01.10.2026 erstellt und gezielt vereinfacht. Das 1254 × 1254-Ausgangsbild wurde zellenweise auf 128 × 128 Pixel mit Nearest-Neighbor-Skalierung verkleinert. Es wurden keine Fremdassets verwendet; eine externe Lizenz ist nicht betroffen.

### Prompt zur Erstgenerierung

<pre>
Create a top-down 8-by-8 atlas of seamless 16-by-16 pixel-art terrain tiles for a cozy warm evening moor game. Keep every square tile aligned to the same grid, with hard pixel edges, restrained handcrafted clusters, and no outlines between cells. Arrange the rows by material: quiet olive grass and moss; peat and mud; readable dirt paths with straight, curved, and ending pieces; shallow and deep dark teal water; marsh shore transitions; weathered wooden boardwalk and bridge sections; reeds and wet bank accents. Use warm moss green, sage, peat brown, muted teal, and weathered honey wood. No text, characters, props, lighting effects, perspective, blur, anti-aliasing, or tile gaps. The tiles must remain legible at native 16-pixel gameplay size.
</pre>

### Bereinigungsschritte

<pre>
Simplify the repeated ground texture so the upper-left cell is a uniform muted olive base tile (#707A50) without speckles or visible pattern. Preserve all other 63 atlas cells and their positions, keeping the existing grass and moss variants, peat, mud, paths, water, shore, boardwalk, reeds, and wet-bank tiles. Maintain a precise 8-by-8 grid with hard pixel edges and no seams.
</pre>

Das Atlasbild wurde anschließend zellenweise auf exakt 16 × 16 Pixel pro Motiv zugeschnitten und mit Nearest-Neighbor auf 128 × 128 gebracht. Die Prüfung im Spielmaßstab zeigte ruhige Grundflächen, lesbare Sammelpflanzen und durchgehende gezeichnete Wege.

## VIS-005 – Abgestimmte Boden- und Wegtexturen

- Aktive Datei: `assets/tilesets/moor_terrain_atlas_ai_20261001_v3.png` (128 × 128 Pixel, 8 × 8 Zellen zu 16 × 16 Pixeln).
- Hochauflösende Imagegen-Quelle: `assets/tilesets/moor_terrain_atlas_ai_20261001_v3_source.png` (1254 × 1254 Pixel). Die 64 Zellen wurden mit einem 2-Pixel-Inset je Kante sauber aus dem Quellraster ausgeschnitten und mit Nearest Neighbor auf je 16 × 16 Pixel verkleinert. Die erste und zweite Atlasreihe liefern 16 natürliche Basisvarianten; die übrigen Reihen behalten Torf, Wege, Wasser, Ufer, Stege und nasse Moorflächen.
- `assets/tilesets/moor_terrain_tileset.tres` verwendet den aktiven Atlas. `TerrainBase` verteilt die 16 Moos- und Grasflächen reproduzierbar per Rasterkoordinaten auf Dorfplatz und Schilfufer. Die bisherigen flachen Bodenübermalungen wurden entfernt; gezeichnete Torfwege erhielten sparsame Abriebpixel.
- Herkunft: mit dem integrierten OpenAI Imagegen in Codex am 01.10.2026 nach den vorhandenen Figuren-, Kräuter- und Umgebungsatlanten gestaltet. Es wurden keine Fremdassets verwendet; eine externe Lizenz ist nicht betroffen.

### Finaler Prompt zur Generierung

<pre>
Use case: stylized-concept
Asset type: subtle, hand-crafted pixel-art tile atlas for a top-down cozy marsh game.

Use the supplied player, herb and reed sprites as style references only. Match their warm evening palette, clean dark mossy outlines, intentional pixel clusters, soft warm edge-lighting and deep green/teal shadows. The tile art must sit quietly under the detailed sprites and never compete with the character or collectible herbs.

Make one exact square atlas of 8 columns by 8 rows, equal square cells, no gutters and no drawn grid. Every cell is a seamless top-down ground tile. It will be reduced to 128x128 and then displayed as 16x16 pixels in the actual game: create only a few bold, legible clusters per tile. At that final 16x16 scale, each tile should show a calm main surface with just 2–5 small material clusters; broad calm areas must remain visible. Keep the contrast moderate. No dense foliage carpet, no tiny noise, no large decorative clumps, no miniature bouquets, no leafy canopy filling cells. Small accents should occupy no more than about 20 percent of a tile. Some cells may have no grass or leaves at all and should simply show softly shaded damp moss or peat.

Rows 0–1: 16 distinctly varied walkable base tiles. Mix shaded olive moss, sage grass, dark moist earth, little peat patches, occasional tiny flattened leaf pieces or 2–3 grass blades. These are environmental floor textures, not plant sprites.
Row 2: eight dark peat and soft mud surface variations with a few pebbles.
Row 3: eight simple worn-path sections and moss-edge blends, connected, softly textured, no large stones.
Row 4: quiet dark teal water surface tiles with only a few thin warm glints and faint reflections.
Row 5: restrained organic water-edge transitions, short moss tufts and dark wet soil.
Row 6: readable honey-brown wooden boardwalk tiles with sparse plank grain and fine dark seams.
Row 7: muted root, damp bank and reed-shadow ground patterns, still walkable and low contrast.

Palette: deep moss green, subdued olive, sage, warm peat umber and dark teal. Bright yellow, white flowers, large leaves and tall reeds should be very rare in this ground atlas.
Strong constraints: exactly 8 by 8 equal tiles, muted ground texture with restrained contrast, no cell dividers, no labels, text, icons, characters, buildings, UI, oversized plants, external shadows, blur, antialiasing, perspective, photorealism or watermark.
</pre>

## VIS-004 – Hausarchitektur und Moorvegetation

- Datei: `assets/sprites/moor_environment_atlas_ai_20261001.png`
- Format: PNG mit transparentem Hintergrund, 1774 × 887 Pixel. Das Blatt enthält eine Apotheke, ein kleineres Torfhaus, ein üppiges Schilfbüschel und einen bemoosten Steinhaufen.
- Verwendung: Dorfplatz zeichnet das Apothekenmotiv aus dem Quellrechteck `(230, 20, 640, 500)` in 180 × 141 Spielpixel. Schilf- und Moosgruppen werden in beiden Karten als transparente Sprites verwendet. Das kleinere Torfhaus bleibt als passende Architektur für spätere Dorfbereiche verfügbar. Kollisionsrechtecke und Wege bleiben bestehen.
- Stil: dunkle Torfkonturen, warme obere Lichtkante, abgestufte Materialfarben und dichte Pixelcluster wie bei Spieler und Kräutern. Die Naturmotive sind bei 480 × 270 größer und klarer platziert, ohne die Wege zuzudecken.
- Herkunft: am 01.10.2026 mit OpenAI Imagegen in Codex erzeugt und mit einer gezielten Layoutkorrektur weitergeführt. Es wurden keine Fremdassets eingebunden; eine externe Lizenz ist nicht betroffen.

### Prompt zur Erstgenerierung

<pre>
Create a production-ready transparent pixel-art environment sprite atlas for the cozy 2D top-down game Moor-Apotheke. Arrange exactly four equal square cells in a clean 2-by-2 grid with generous transparent padding and no dividers. Cell 1: the village apothecary cottage, compact and welcoming, cream plaster over dark peat-brown timber framing, steep mossy terracotta shingle roof, two softly amber-lit windows, small chimney, attached tiny herb planter, blank wooden signboard with no writing; frontal facade from the same slightly elevated game viewpoint as the characters. Cell 2: a smaller peat-cutter cottage in the same architecture and scale, dark weathered boards, green moss roof, warm shuttered window. Cell 3: a lush irregular tuft of marsh reeds with cattails, broad layered leaves, small roots and a few amber seed heads. Cell 4: a rich moss bank with two rounded stones, fern fronds, a few tiny cream flowers and fallen ochre leaves. Each object is isolated, fully contained in its cell, with no ground plane or backdrop. Match the approved game characters and medicinal herb sprites: crisp hand-crafted 16-bit pixel art, intentional chunky pixel clusters, visible discrete highlight and shadow bands, strong deep peat-brown outlines, warm upper-left highlights, dimensional wood, roof shingles, leaves and moss; a few bright details but a restrained moss, sage, peat, honey and cream palette. Designed to remain readable when each cell is displayed around 64 by 64 game pixels, with the main cottage about 56 pixels tall and nature props 28 to 42 pixels tall. Transparent alpha, hard pixel edges, no blur, anti-aliasing, smooth gradients, glow, 3D, text, labels, watermark, border, UI, overlapping cells, or shadows reaching another cell.
</pre>

### Prompt zur Layoutkorrektur

<pre>
Make a precise layout correction to the provided transparent 2-by-2 pixel-art environment atlas. Preserve the four exact objects and their current rich, polished hand-crafted 16-bit pixel art style, palette, shading, material detail, outlines, and warm lighting. Keep the canvas and four equal quadrants. The quadrant boundaries are exactly the vertical centerline and horizontal centerline. Scale each object down just enough and center it so every opaque pixel, including the apothecary's hanging blank sign, roof, chimney, planter, all reed tips, shadows, and moss leaves, stays completely inside its own quadrant with at least 6 percent transparent padding from every quadrant edge. Top-left: apothecary only, entirely within the top-left quadrant. Top-right: peat cottage only, entirely within the top-right quadrant. Bottom-left: reed tuft only, entirely within bottom-left quadrant. Bottom-right: moss and stone cluster only, entirely within bottom-right quadrant. Leave a visibly transparent gutter along both centerlines. Preserve true transparent alpha outside the art. Do not add, remove, or redesign objects. No background, no tile cell colors, no lines, no text, no labels, no glow, no blur.
</pre>

Godot nutzt explizite Quellrechtecke, damit die Motive aus dem transparenten Atlas ohne Zelltrennlinien ausgeschnitten werden. Der kleine Schriftzug `APO` im Holzschild hält das Ladenmotiv bei nativer Pixelgröße erkennbar.

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
