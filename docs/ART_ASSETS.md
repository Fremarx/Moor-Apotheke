# Grafikquellen

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
