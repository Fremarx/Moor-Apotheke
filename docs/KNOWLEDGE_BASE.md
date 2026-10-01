# Wissensbasis und RAG-Strategie

Stand: 30.09.2026

## Retrieval-Verfahren
Für diesen kleinen Projektumfang reicht eine nachvollziehbare Quellenliste mit gezieltem Retrieval. In der aktuellen Toolausstattung ist kein Context7- oder Vektor-RAG-MCP verfügbar. Projektdokumente werden lokal durchsucht; technische Fragen werden in der passenden offiziellen Godot-4.7-Dokumentation nachgeschlagen. Es wird kein komplettes Engine-Handbuch kopiert und vorerst kein Vektorspeicher aufgebaut.

Reihenfolge pro Frage:
1. AGENTS.md, PROJECT_PLAN.md, GAME_PLAN.md, docs/ARCHITECTURE.md und passende ADRs durchsuchen.
2. Relevante Quelle wählen und konkrete Seite bzw. Überschrift abrufen.
3. Engine-Details nur aus versioniertem Pfad /en/4.7/ ableiten, nicht aus latest oder unversioniertem stable.
4. Wesentliche Quellen in Task-/Architekturtext festhalten.
5. Abrufdatum und verwendeten Abschnitt aktualisieren, wenn sich die Quelle ändert.

Ein Vektorspeicher wird erst dann sinnvoll, wenn lokale Regeln und Quellen so wachsen, dass gezielte Dateisuche und Links nicht mehr zuverlässig ausreichen.

## Quellregister

| Quelle | Version / geprüft | Bereich | Vertrauenswürdigkeit / Aktualisierung |
| --- | --- | --- | --- |
| [Godot Windows Downloads](https://godotengine.org/download/windows/) | 4.7.2 Stable, 30.09.2026 | Editor-Version und portable Distribution | Primärquelle; bei Versionswechsel prüfen |
| [Project Organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/project_organization.html) | 4.7, 30.09.2026 | Dateiorganisation | Offizielle Engine-Doku; bei Strukturänderung prüfen |
| [Scene Organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html) | 4.7, 30.09.2026 | Szenengrenzen, Signale, Kopplung | Offizielle Engine-Doku; bei Architekturfragen abrufen |
| [2D Movement Overview](https://docs.godotengine.org/en/4.7/tutorials/2d/2d_movement.html) | 4.7, 30.09.2026 | CharacterBody2D-Bewegung | Offizielle Engine-Doku; CORE-001 |
| [Using CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html) | 4.7, 30.09.2026 | Kollisionen und Bewegung | Offizielle Engine-Doku; CORE-001 |
| [Using TileSets](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilesets.html) | 4.7, 30.09.2026 | Raster, Tilesheets, Kollision/Metadaten | Offizielle Engine-Doku; Karten-/Assettasks |
| [Using TileMaps](https://docs.godotengine.org/en/4.7/tutorials/2d/using_tilemaps.html) | 4.7, 30.09.2026 | TileMapLayer und Kartenaufbau | Offizielle Engine-Doku; Karten-/Assettasks |
| [Input Examples](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html) | 4.7, 30.09.2026 | Input Map und Aktionen | Offizielle Engine-Doku; CORE-001/CORE-002 |
| [Using Area2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html) | 4.7, 30.09.2026 | Überlappung und Reichweitenerkennung mit Area2D | Offizielle Engine-Doku; CORE-002 |
| [Node class reference](https://docs.godotengine.org/en/4.7/classes/class_node.html) | 4.7, 30.09.2026 | Weitergabe von Gameplay-Eingaben über _unhandled_input() | Offizielle Engine-Doku; CORE-002 |
| [Signal class reference](https://docs.godotengine.org/en/4.7/classes/class_signal.html) | 4.7, 30.09.2026 | Lose gekoppelte Benachrichtigung über Inventar- und Queständerungen | Offizielle Engine-Doku; ITEM-001, QUEST-001, UX-001 |
| [Label class reference](https://docs.godotengine.org/en/4.7/classes/class_label.html) | 4.7, 30.09.2026 | Kurze Textanzeige in einem begrenzten HUD-Bereich | Offizielle Engine-Doku; UX-001 |
| [Control class reference](https://docs.godotengine.org/en/4.7/classes/class_control.html) | 4.7, 30.09.2026 | GUI-Eingaben, Fokus und Basisklasse für Panel-Elemente | Offizielle Engine-Doku; BOARD-001 |
| [Button class reference](https://docs.godotengine.org/en/4.7/classes/class_button.html) | 4.7, 30.09.2026 | Aktivierbare UI-Aktion und pressed-Signal | Offizielle Engine-Doku; BOARD-001 |
| [GUI keyboard/controller navigation](https://docs.godotengine.org/en/4.7/tutorials/ui/gui_navigation.html) | 4.7, 30.09.2026 | Fokusreihenfolge und Navigation zwischen UI-Elementen | Offizielle Engine-Doku; BOARD-001 |
| [CanvasItem class reference](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html) | 4.7, 30.09.2026 | Pixel-Platzhalter mit `draw_rect` und `draw_line` darstellen | Offizielle Engine-Doku; CONTENT-001a |
| [CanvasItem class reference](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html) | 4.7, 01.10.2026 | Ausschnitt eines transparenten Dekorationsatlas mit draw_texture_rect_region zeichnen | Offizielle Engine-Doku; VIS-001 |
| [GDScript reference](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html) | 4.7, 30.09.2026 | Ableitung spezialisierter Spielobjekte aus dem Interaktionsskript | Offizielle Engine-Doku; ITEM-001 |
| [Resources](https://docs.godotengine.org/en/4.7/tutorials/scripting/resources.html) | 4.7, 30.09.2026 | Externe `RecipeDefinition`-Datencontainer für Kesselrezepte | Offizielle Engine-Doku; LOOP-004 |
| [Saving Games](https://docs.godotengine.org/en/4.7/tutorials/io/saving_games.html) | 4.7, 30.09.2026 | Persistenz und user:// | Offizielle Engine-Doku; SAVE-001 |
| [JSON class reference](https://docs.godotengine.org/en/4.7/classes/class_json.html) | 4.7, 01.10.2026 | JSON.parse(), Fehlerbehandlung und validiertes Variant-Ergebnis | Offizielle Engine-Doku; SAVE-001 |
| [InputEventKey class reference](https://docs.godotengine.org/en/4.7/classes/class_inputeventkey.html) | 4.7, 01.10.2026 | Physische Tastaturbelegungen für F5 und F9 in der Input Map | Offizielle Engine-Doku; SAVE-001 |
| [Sprite2D class reference](https://docs.godotengine.org/en/4.7/classes/class_sprite2d.html) | 4.7, 01.10.2026 | 2 × 2-Spieleratlas mit hframes, vframes und frame_coords darstellen | Offizielle Engine-Doku; VIS-002 |


## Abrufnotizen
- **30.09.2026 – CORE-001:** 2D-Bewegung: `CharacterBody2D` mit `Input.get_vector()` für normalisierte Richtungssteuerung; CharacterBody2D: Bewegung in `_physics_process()` mit `move_and_slide()`, für Top-down-Bewegung `MOTION_MODE_FLOATING`; Input-Beispiele: benannte Aktionen in der Project Input Map statt Tastencodes im Bewegungs-Skript.
- **30.09.2026 – CORE-002:** Area2D definiert einen Überlappungsbereich; der Player fragt darin interaktive Ziele ab und wählt das nächste. Die benannte Aktion interact wird in _unhandled_input() verarbeitet, damit GUI-Elemente Eingaben zuerst behandeln können.
- **30.09.2026 – ITEM-001:** Area2D wird als nicht blockierender Sammelbereich verwendet und nach Aufnahme deaktiviert. Das Pickup-Skript leitet sich über `extends` vom Interaktionsskript ab und meldet `item_id` sowie Anzahl per Signal an Inventory.
- **30.09.2026 – LOOP-001:** Die Trocknungsstation nutzt dieselbe Area2D-Interaktionsbasis und liefert das Ergebnis über den bestehenden Interaktionsrückgabewert. Inventory führt eine atomare Mengenübertragung aus und sendet `item_count_changed` für Quell- und Zielgegenstand. Dafür waren die bereits gelisteten Godot-4.7-Quellen zu Area2D, Signalen und GDScript-Vererbung ausreichend; keine neue Engine-API eingeführt.
- **30.09.2026 – LOOP-002:** Der Braukessel verwendet dieselbe Interaktions- und Inventarübertragung für das feste Rezept getrocknete Sumpfminze → Beruhigungstee. Die offizielle Area2D-Doku bestätigt Area2D als Raum-/Überlappungsobjekt; die Signal-Doku beschreibt lose gekoppelte Reaktionen auf Zähleränderungen. Unbegrenztes Wasser am Kessel stammt aus GAME_PLAN.md. Für dieses einzelne Rezept wird noch keine Datenressource benötigt.
- **30.09.2026 – QUEST-001:** Die versionierte Godot-4.7-Szenenorganisation empfiehlt, Beziehungen zwischen Geschwistersystemen durch den übergeordneten Main-Kontext zu vermitteln und Abhängigkeiten zu injizieren; Fenja erhält daher die Quest und die Quest das Inventar. `Signal` ermöglicht dem HUD, auf Queststatusänderungen ohne direkte Zustandsänderung zu reagieren. Quellen: [Scene organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html) und [Signal class reference](https://docs.godotengine.org/en/4.7/classes/class_signal.html).
- **30.09.2026 – BOARD-001:** Das Brett ist ein Area2D-Interaktionsziel; Main öffnet ein PanelContainer mit zeilenweisen Buttons. Control verarbeitet GUI-Eingabe und Fokus, Button aktiviert die Annahme und die GUI-Navigationsanleitung deckt Fokuswechsel ab. Escape wird in Main behandelt, während Player-Bewegung und Weltinteraktion pausieren. Quellen: [Control class reference](https://docs.godotengine.org/en/4.7/classes/class_control.html), [Button class reference](https://docs.godotengine.org/en/4.7/classes/class_button.html) und [GUI navigation](https://docs.godotengine.org/en/4.7/tutorials/ui/gui_navigation.html).
- **30.09.2026 – UX-001:** Die Signal-Referenz dokumentiert lose gekoppelte Empfänger für Änderungen; `item_count_changed` aktualisiert daher den nächsten Questschritt im Main. Die Label-Referenz beschreibt `Label` als Kontrolle für kurzen Text innerhalb eines festgelegten Rechtecks; die bestehende `QuestStatus`-Zeile bleibt dafür ausreichend. Quellen: [Signal class reference](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [Label class reference](https://docs.godotengine.org/en/4.7/classes/class_label.html).
- **30.09.2026 – CONTENT-001a:** Das zweite Pflanzen-Pickup verwendet weiter die nicht blockierende `Area2D`-Interaktion. Die eigene Pixel-Silhouette wird mit `CanvasItem`-Zeichenprimitiven aufgebaut; `Label` zeigt den getrennten Bestand an. Quellen: [Using Area2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html), [CanvasItem class reference](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html) und [Label class reference](https://docs.godotengine.org/en/4.7/classes/class_label.html).
- **30.09.2026 – CONTENT-001b:** Das Nachtmoos nutzt dieselbe `Area2D`-Sammelinteraktion und wird als dunkles Pixelcluster in `_draw()` dargestellt. Area2D deckt die nicht blockierende interaktive Region ab; CanvasItem stellt Zeichenprimitiven innerhalb von `_draw()` bereit. Quellen: [Using Area2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html) und [CanvasItem class reference](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html).
- **30.09.2026 – LOOP-003:** Die Station überträgt Zutaten über `Inventory.transfer_item`, das Quell- und Zielbestand gemeinsam ändert; `item_count_changed` hält beide HUD-Zähler synchron. Die UI bleibt in getrennten `Label`-Zeilen, bestehend mit Signal- und Label-Referenz. Quellen: [Signal class reference](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [Label class reference](https://docs.godotengine.org/en/4.7/classes/class_label.html).
- **30.09.2026 – LOOP-004:** Die offizielle Resource-Dokumentation beschreibt `Resource` als Datencontainer für von Nodes verwendete Daten und den externen `.tres`-Speicher. Zwei `RecipeDefinition`-Resources halten Zutaten, Produkt, Rückmeldung und Questfreischaltung getrennt vom Kesselverhalten. Main übergibt den aktuellen Fenja-Queststatus an Verarbeitungsstationen. Quellen: [Resources](https://docs.godotengine.org/en/4.7/tutorials/scripting/resources.html), [Scene Organization](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html) und [Signal class reference](https://docs.godotengine.org/en/4.7/classes/class_signal.html).
- **30.09.2026 – QUEST-002:** Die Szenenorganisation aus QUEST-001 wird für einen zweiten Bewohner-Questzustand wiederverwendet: Main injiziert Inventar und Vorgängerquest; `state_changed` hält Quest-HUD und Interaktionshinweis aktuell. Die Signal- und Szenenorganisation-Quellen oben decken diese lose Kopplung weiterhin ab; für QUEST-002 kam keine neue Engine-API hinzu.

- **30.09.2026 – LOOP-005:** Die dritte Trockengestell-Zutat nutzt die bereits dokumentierte `Inventory.transfer_item`-Methode und `item_count_changed`-Signale; ein eigener `Label` zeigt den getrockneten Bestand. Es kam keine neue Engine-API hinzu; Signal- und Label-Quellen aus LOOP-003 decken die Änderung ab.

- **30.09.2026 – LOOP-006:** Der Nachttrank nutzt die bestehende RecipeDefinition-Resource für Zutaten, Ergebnis und Questfreischaltung. Main leitet Martens Status über die vorhandene Szenen- und Signalstruktur an den Braukessel weiter; ein Label zeigt das Produkt. Es kam keine neue Engine-API hinzu.
- **30.09.2026 – QUEST-003:** Lene nutzt die bestehende Quest-, NPC-, Signal- und Inventarstruktur; Main injiziert Martens Quest als Freischaltbedingung. Die aktive Quest leitet das HUD aus den Inventarbeständen ab. Es wurde keine neue Godot-API eingeführt.

- 30.09.2026 – ECON-001: Die Münzanzeige verwendet das bestehende item_count_changed-Signal und ein Godot-Label; die Questgutschrift nutzt Inventory.add_item. Keine neue Engine-API oder Abhängigkeit kommt hinzu. Quellen: https://docs.godotengine.org/en/4.7/classes/class_signal.html und https://docs.godotengine.org/en/4.7/classes/class_label.html.
- 01.10.2026 – SAVE-001: Die Saving-Games-Anleitung empfiehlt für kleine Spielstände ein einfaches serialisierbares Format und `user://`; Vector2 wird als x/y gespeichert. `JSON.parse()` liefert einen prüfbaren Fehlercode und Variant-Daten, daher werden Typen und erlaubte Werte vollständig geprüft, bevor Laufzeitobjekte geändert werden. Eingaben bleiben benannte Aktionen; F5/F9 sind in der Input Map physisch gebunden. Quellen: [Saving Games](https://docs.godotengine.org/en/4.7/tutorials/io/saving_games.html), [JSON class reference](https://docs.godotengine.org/en/4.7/classes/class_json.html), [Input Examples](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html) und [InputEventKey class reference](https://docs.godotengine.org/en/4.7/classes/class_inputeventkey.html).

- **01.10.2026 – VIS-001:** Die Godot-4.7-CanvasItem-Referenz bestätigt, dass draw_texture_rect_region ein Quellrechteck einer Textur in ein Zielrechteck im lokalen Raum zeichnet. Das bestehende Node2D-Kartenskript nutzt es für transparente Atlaszellen; Quellrechtecke teilen die tatsächliche Texturgröße durch vier, damit auch der 1261 × 1247 Pixel große Atlas korrekt zugeschnitten wird. Die Pixelgrafik erbt die im Projekt gesetzte Nearest-Filterung. Quelle: [CanvasItem class reference](https://docs.godotengine.org/en/4.7/classes/class_canvasitem.html).

- **01.10.2026 – VIS-002:** Die Godot-4.7-Sprite2D-Referenz beschreibt hframes und vframes als Spalten- und Zeilenanzahl eines Sprite-Sheets; frame_coords wählt eine Zelle, sobald mindestens eine Frame-Achse größer als eins ist. Der Spieler verwendet diese eingebaute Zellauswahl für vier getrennte Ansichten und behält im Skript die letzte Richtung im Leerlauf. Quelle: [Sprite2D class reference](https://docs.godotengine.org/en/4.7/classes/class_sprite2d.html).

## VIS-003 – Sprite-Atlanten für Weltobjekte
Stationen, Bewohner und Sammelpflanzen liegen jeweils in einem horizontalen 3-Zellen-Atlas. Godots Sprite2D nutzt hframes = 3 und frame = 0, 1 oder 2 zur Zellwahl. Die Grafik bleibt ein Sprite2D-Kind ihrer Interaktionsobjekte; Sichtbarkeit und Kollision der Sammelstelle bleiben in der vorhandenen Gameplay-Logik. Quelle: [Sprite2D class reference](https://docs.godotengine.org/en/4.7/classes/class_sprite2d.html).

## Grenzen
- Dies ist ein Quellenindex, keine Kopie der Dokumentation.
- API-Details vor der Implementierung gegen die passende 4.7-Seite prüfen.
- Fremde Forenbeiträge oder Assets sind keine verbindliche technische oder Lizenzquelle.
- Vertrauliche Projektinhalte werden nicht an externe Wissensdienste gesendet.
