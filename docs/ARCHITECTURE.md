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
│   ├── TestMap (Node2D, Interaktionsprobe, Sumpfminze, Trockengestell, Braukessel und Fenja)
│   └── Player (CharacterBody2D)
│       ├── InteractionArea (Area2D)
│       └── Camera2D
├── Inventory (Node)
├── Quest (Node)
│   └── FenjaQuest (Node)
└── HUD (CanvasLayer)
    ├── InventoryCount
    ├── DriedMintCount
    ├── TeaCount
    ├── QuestStatus
    ├── InteractionPrompt
    ├── InteractionFeedback
    └── FeedbackTimer
~~~

`TestMap` zeichnet die provisorische Moorfläche und stellt Begrenzungen sowie einige blockierte Stellen bereit. `Player` liest die benannten Richtungsaktionen aus der Input Map, bewegt sich als `CharacterBody2D` und führt die Kamera mit Kartengrenzen. Die Figuren- und Kartengrafik besteht bis zur Grafikphase aus einfachen gezeichneten Farbblöcken.

CORE-002 ergänzt eine wiederverwendbare Area2D-Interaktionsfläche am Player. Interaktive Ziele tragen die Gruppe `interactables` und stellen Hinweistext sowie `interact()` bereit. Der Player wählt das räumlich nächste Ziel und meldet Hinweis bzw. Ergebnis über Signale. Main verbindet diese Signale mit dem HUD; das Objekt führt seine eigene Aktion aus. Ein Autoload ist dafür nicht erforderlich.

ITEM-001 ergänzt eine Sumpfminze-Area2D, die von `interactable.gd` erbt. Beim Einsammeln sendet sie `item_collected(item_id, amount)` und deaktiviert sich. Main verbindet die Sammelsignale mit dem lokalen `Inventory`-Node. Dieser verwaltet Mengen und sendet `item_count_changed`; Main aktualisiert damit `InventoryCount` im HUD.

LOOP-001 ergänzt das `Trockengestell` als spezialisierte Interaktions-Area2D. Main übergibt der Station beim Szenenaufbau das lokale Inventar. Bei E ruft die Station `Inventory.transfer_item("sump_mint", "dried_sump_mint", 1)` auf. Die Inventarkomponente prüft den Bestand vor der Änderung, aktualisiert beide Mengen und sendet anschließend beide Zählersignale. Die Station gibt bei Erfolg oder fehlender Zutat Text an den vorhandenen Interaktionsfluss zurück. Main zeigt `sump_mint` und `dried_sump_mint` über getrennte Labels `InventoryCount` und `DriedMintCount` an. Die Verarbeitung ist in diesem Slice sofort; Inventar und Stationszustand werden nicht gespeichert.

LOOP-002 ergänzt den `Braukessel` als weitere Interaktions-Area2D der Gruppe `processing_stations`. Main übergibt ihm dieselbe lokale Inventarkomponente. E ruft `Inventory.transfer_item("dried_sump_mint", "calming_tea", 1)` auf. So werden Zutat und Ergebnis vor der HUD-Aktualisierung gemeinsam verbucht. Wasser ist unbegrenzt am Kessel verfügbar und wird entsprechend `GAME_PLAN.md` nicht als Inventargegenstand geführt. Das feste Startrezept bleibt explizit im Stationsskript; Rezeptressourcen werden erst geprüft, wenn mehrere Rezepte hinzukommen. `TeaCount` zeigt die fertige Menge.

QUEST-001 ergänzt eine kleine `FenjaQuest`-Komponente neben Inventar und Welt. Main übergibt ihr das lokale Inventar und verbindet `state_changed` mit `QuestStatus`. Fenja erhält die Quest über Dependency Injection und delegiert ihre Interaktion an sie. Die Quest schaltet zwischen `not_accepted`, `active` und `completed`; für die Abgabe ruft sie `Inventory.remove_item("calming_tea", 1)` auf und wechselt nur bei Erfolg in den Abschlusszustand. Main fordert den Player anschließend auf, den aktuellen Fenja-Prompt neu zu senden. Wiederholtes Ansprechen nach Abschluss ändert den Bestand nicht. Der Status lebt nur in der laufenden Partie und wird nicht gespeichert.

UX-001 lässt Main die dauerhafte `QuestStatus`-Zeile nach Annahme und bei jedem `item_count_changed` aus dem lokalen Inventar ableiten. Die Reihenfolge der Ziele lautet: Sumpfminze sammeln, frische Minze trocknen, getrocknete Minze brauen, Tee Fenja bringen. Ist bereits ein späteres Produkt vorhanden, zeigt die HUD den dazu passenden nächsten Schritt. Bei `completed` bleibt die Abschlusszeile stehen; vor Annahme bleibt sie verborgen. Bestehende zeitlich begrenzte Interaktionsrückmeldungen und Inventarzähler laufen unverändert weiter.

Spätere eigenständige Szenen:
- player/player.tscn: Bewegung, Kollision, Sprite/Animation und Kamera.
- world/test_map.tscn: Kachelboden, Hindernisse und Spielobjekte.
- items/herb_pickup.tscn: Pflanze und Sammelinteraktion.
- stations/drying_rack.tscn und stations/brewing_cauldron.tscn: Verarbeitung.
- npcs/fenja.tscn: mögliche spätere Extraktion; QUEST-001 verwendet Fenja noch als Platzhalter direkt in der Testkarte.
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
  Cauldron --> Inventory
  Player --> Fenja[Fenja ansprechen]
  Fenja --> Quest[Fenjas Auftrag]
  Quest -->|einen Tee abgeben| Inventory
  Inventory --> HUD[Inventaranzeige]
  Quest -->|state_changed| HUDQuest[Auftragsstatus]
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
- Trockengestell, Braukessel und Fenja sind vorläufig direkt in der Testkarte gezeichnet; eigenständige Szenen, Produktionszeiten und Animationen, zusätzliche Aufträge, Save-/Load-Logik, finale Pixelgrafik und Exportprofile fehlen noch.
- Das Spiel liegt eigenständig in `Fremarx/Moor-Apotheke`. Eine spätere Zusammenführung mit dem früher verwendeten 2DGame-Repo wäre eine eigene Migrationsentscheidung.

## Engine-Dokumentation
Versionierte Quellen stehen in docs/KNOWLEDGE_BASE.md. Für CORE-001 wurden [2D-Bewegung](https://docs.godotengine.org/en/4.7/tutorials/2d/2d_movement.html), [CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html) und [Input-Beispiele](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html) verwendet. Weitere Quellen betreffen Szenenorganisation, TileSets und Resources.

Für CORE-002 wurden zusätzlich die versionierte [Area2D-Dokumentation](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html) und die [Node-Klassenreferenz](https://docs.godotengine.org/en/4.7/classes/class_node.html) zur Overlap-Erkennung und Eingabeweitergabe herangezogen. ITEM-001 verwendet zudem die dokumentierte [Signal-API](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [GDScript-Vererbung](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html). QUEST-001 verwendet außerdem die offizielle [Godot-4.7-Szenenorganisation](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html) für die Übergabe von Abhängigkeiten über Main sowie die bestehende Signal-API für Statusänderungen. UX-001 aktualisiert ein bestehendes [Label](https://docs.godotengine.org/en/4.7/classes/class_label.html) über die Inventaränderungssignale; neue UI- oder Engine-Abhängigkeiten kommen nicht hinzu.
