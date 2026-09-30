# Architektur – Die Moor-Apotheke

Stand: 30.09.2026 · Godot 4.7.2 Standard · GDScript

## Ziele
- Kleine 2D-Einzelspielerproduktion mit kurzer Rückkopplung im Godot-Editor.
- Eigenständige Szenen und lockere Beziehungen über Signale oder kleine Schnittstellen.
- Erst die Kräuter-zu-Auftrag-Schleife zuverlässig machen; nur bei Bedarf erweitern.
- Pixelgrafik und Spielregeln so trennen, dass Platzhalter leicht ersetzt werden.

## Einstiegspunkt und Szenenstruktur
Die Startszene stellt Graybox-Karte und Platzhalterfigur zusammen:

~~~text
Main (Node2D, main.gd)
├── World (Node2D)
│   ├── TestMap (Node2D, Interaktionsprobe und Sumpfminze)
│   └── Player (CharacterBody2D)
│       ├── InteractionArea (Area2D)
│       └── Camera2D
├── Inventory (Node)
└── HUD (CanvasLayer)
    ├── InventoryCount
    ├── InteractionPrompt
    ├── InteractionFeedback
    └── FeedbackTimer
~~~

`TestMap` zeichnet die provisorische Moorfläche und stellt Begrenzungen sowie einige blockierte Stellen bereit. `Player` liest die benannten Richtungsaktionen aus der Input Map, bewegt sich als `CharacterBody2D` und führt die Kamera mit Kartengrenzen. Die Figuren- und Kartengrafik besteht bis zur Grafikphase aus einfachen gezeichneten Farbblöcken.

CORE-002 ergänzt eine wiederverwendbare Area2D-Interaktionsfläche am Player. Interaktive Ziele tragen die Gruppe `interactables` und stellen Hinweistext sowie `interact()` bereit. Der Player wählt das räumlich nächste Ziel und meldet Hinweis bzw. Ergebnis über Signale. Main verbindet diese Signale mit dem HUD; das Objekt führt seine eigene Aktion aus. Ein Autoload ist dafür nicht erforderlich.

ITEM-001 ergänzt eine Sumpfminze-Area2D, die von `interactable.gd` erbt. Beim Einsammeln sendet sie `item_collected(item_id, amount)` und deaktiviert sich. Main verbindet die Sammelsignale mit dem lokalen `Inventory`-Node. Dieser verwaltet Mengen und sendet `item_count_changed`; Main aktualisiert damit `InventoryCount` im HUD. Das Inventar ist in diesem Slice flüchtiger Spielzustand und wird noch nicht gespeichert.

Spätere eigenständige Szenen:
- player/player.tscn: Bewegung, Kollision, Sprite/Animation und Kamera.
- world/test_map.tscn: Kachelboden, Hindernisse und Spielobjekte.
- items/herb_pickup.tscn: Pflanze und Sammelinteraktion.
- stations/drying_rack.tscn und stations/brewing_cauldron.tscn: Verarbeitung.
- npcs/fenja.tscn: erste Auftraggeberin.
- HUD-Komponenten bleiben von der Karte getrennt.

Szenen sollen möglichst wenig über feste Pfade auf Geschwister zugreifen. Eltern verbinden Abhängigkeiten; Ereignisse wie item_collected melden Ergebnisse über Signale. Ein Autoload kommt erst hinzu, wenn ein konkret global benötigter Zustand mehrere Szenen überlebt und die lokale Elternstruktur nicht ausreicht.

## Zuständigkeiten
- Main/World: Spielabschnitt zusammenstellen und Zustand vermitteln.
- Player: Eingaben lesen, Bewegung ausführen, Interaktionsnähe darstellen.
- Interaktives Objekt: eigene Aktion ausführen und Erfolg melden.
- Inventory: Mengenbestände verwalten und Änderungen signalisieren.
- Station: Verarbeitung ausführen; UI bleibt separat.
- Quest: Annahme, benötigtes Produkt und Abschlussstatus verwalten.
- HUD: Spielzustand darstellen, nicht eigenständig verändern.

## Erster Datenfluss

~~~mermaid
flowchart LR
  Input[Eingabe] --> Player[Player]
  Player --> Interact[Interaktion in Reichweite]
  Interact --> Herb[Sumpfminze]
  Herb --> Inventory[Inventar]
  Inventory --> HUD[Inventaranzeige]
  Inventory --> Rack[Trockengestell]
  Rack --> Cauldron[Braukessel]
  Cauldron --> Quest[Fenjas Auftrag]
  Quest --> HUD[Auftrags- und Belohnungsanzeige]
~~~

Im ersten Slice wird der Auftrag direkt bei Fenja angenommen und abgegeben. Das Brett kommt erst mit CONTENT-001.

## Daten und Persistenz
- Im ersten Slice bleibt die Datenmenge klein und explizit.
- Sobald mehrere Gegenstände und Rezepte existieren, prüfen wir Godot-Resource-Dateien für Item-, Rezept- und Auftragsdefinitionen. Laufzeitbestand und Queststatus bleiben veränderlicher Spielzustand.
- Das erste Saveformat wird in SAVE-001 festgelegt. Es speichert nur benötigte IDs, Zahlen und Zustände in user:// und validiert geladene Werte.
- Keine Datenbank und keine Netzwerk-API.

## Grafik und Eingaben
- Pixelmaßstab: 16-Pixel-Kacheln, Viewport 480 × 270 und scharfe Darstellung als Startwerte.
- Erster Build verwendet Platzhaltergrafik.
- Bildgenerator-Ausgaben werden auf Transparenz, Raster, Anschlüsse und Lesbarkeit geprüft.
- Fremde Assets benötigen Herkunft und Lizenzangabe; Prompts finaler eigener Bilder werden gespeichert.
- Benannte Aktionen: move_left/right/up/down, interact, inventory. Die Belegung wird nicht in Gameplay-Skripte eingebrannt.

## Qualität, Sicherheit und Performance
- GDScript typisieren, wo dies Lesbarkeit und Fehlererkennung verbessert.
- Fehlende Eingaben, nicht verfügbare Zutaten und ungültige Abgaben erhalten sichtbare ruhige Rückmeldungen.
- Bei der kleinen Karte zuerst Korrektheit und Lesbarkeit; vor Optimierung messen.
- Keine Konten oder Secrets; fremde Add-ons und Assets prüfen.

## Bekannte Einschränkungen
- Noch keine Stations- oder Auftragslogik, Save-/Load-Logik, finale Pixelgrafik oder Exportprofile.
- Das Spiel liegt eigenständig in `Fremarx/Moor-Apotheke`. Eine spätere Zusammenführung mit dem früher verwendeten 2DGame-Repo wäre eine eigene Migrationsentscheidung.

## Engine-Dokumentation
Versionierte Quellen stehen in docs/KNOWLEDGE_BASE.md. Für CORE-001 wurden [2D-Bewegung](https://docs.godotengine.org/en/4.7/tutorials/2d/2d_movement.html), [CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html) und [Input-Beispiele](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html) verwendet. Weitere Quellen betreffen Szenenorganisation, TileSets und Resources.

Für CORE-002 wurden zusätzlich die versionierte [Area2D-Dokumentation](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html) und die [Node-Klassenreferenz](https://docs.godotengine.org/en/4.7/classes/class_node.html) zur Overlap-Erkennung und Eingabeweitergabe herangezogen. ITEM-001 verwendet zudem die dokumentierte [Signal-API](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [GDScript-Vererbung](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html).
