# Architektur – Die Moor-Apotheke

Stand: 01.10.2026 · Godot 4.7.2 Standard · GDScript

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
│   ├── TestMap (Node2D, Interaktionsprobe, Pflanzen, Stationen, Bewohner, QuestBoard und Ausgang)
│   ├── Schilfufer (Node2D, drei zusätzliche Kräuterstellen und Rückweg)
│   └── Player (CharacterBody2D)
│       ├── InteractionArea (Area2D)
│       └── Camera2D
├── Inventory (Node)
├── Quest (Node)
│   ├── FenjaQuest (Node)
│   ├── MartenQuest (Node)
│   └── LeneQuest (Node)
└── HUD (CanvasLayer)
    ├── InventoryCount
    ├── ReedRootCount
    ├── DriedMintCount
    ├── DriedReedRootCount
    ├── TeaCount
    ├── InfusionCount
    ├── NightMossCount
    ├── DriedNightMossCount
    ├── NightPotionCount
    ├── CoinCount
    ├── QuestStatus
    ├── InteractionPrompt
    ├── InteractionFeedback
    ├── FeedbackTimer
    └── QuestBoardPanel
        └── Content (VBoxContainer: Bewohneraufträge, Status und Aktionen)
~~~

`TestMap` behält seinen Szenenknotennamen für bestehende Szenenpfade, meldet sich aber mit `area_id = Dorfplatz` als zentraler Hub an. Der Hub ist derzeit ein kompakter 640 × 360-Prototyp: `scripts/test_map.gd` zeichnet Apotheke, Platz, Brunnen und Wegweiser mit CanvasItem-Zeichenfunktionen; Kollisionen für Gebäude, Brunnen und Hindernisse werden als statische Rechtecke gesetzt. MAP-01 ist damit erfüllt, nicht jedoch SCALE-01.

TestMap und Schilfufer sind eigenständige 640 × 360-Karten und liegen in `World` nebeneinander; Schilfufer beginnt bei Weltkoordinate x = 640. Jede Karte meldet sich mit `area_id` in `world_areas` an. Übergangs-Area2Ds gehören zu `map_transitions` und senden `transition_requested`; Main sucht die Zielkarte anhand ihrer ID und setzt den Player auf deren lokalen Spawnpunkt. Beide Szenen bleiben geladen, sodass Pickup-Gruppen und eindeutige Save-IDs gebietsübergreifend gemeinsam ausgewertet werden. Kamera und Speicher-Validator erlauben Positionen bis x = 1280. Player liest die benannten Richtungsaktionen aus der Input Map und bewegt sich als CharacterBody2D entlang der Kartenbegrenzungen. Karte, Spieler, Stationen, Bewohner und Sammelpflanzen verwenden ihre Pixelart-Grafiken als getrennte Atlaszellen; VIS-003 ergänzt die neun Weltobjekte über Sprite2D-Kinder, während Interaktions- und Save-Skripte weiterhin die Spiellogik verwalten.

CORE-002 ergänzt eine wiederverwendbare Area2D-Interaktionsfläche am Player. Interaktive Ziele tragen die Gruppe `interactables` und stellen Hinweistext sowie `interact()` bereit. Der Player wählt das räumlich nächste Ziel und meldet Hinweis bzw. Ergebnis über Signale. Main verbindet diese Signale mit dem HUD; das Objekt führt seine eigene Aktion aus. Ein Autoload ist dafür nicht erforderlich.

ITEM-001 ergänzt eine Sumpfminze-Area2D, die von `interactable.gd` erbt. Beim Einsammeln sendet sie `item_collected(item_id, amount)` und deaktiviert sich. Main verbindet die Sammelsignale mit dem lokalen `Inventory`-Node. Dieser verwaltet Mengen und sendet `item_count_changed`; Main aktualisiert damit den passenden HUD-Zähler. CONTENT-001a verwendet dieselbe Pickup-Logik mit der eindeutigen ID `reed_root`, einer eigenen Pixelzeichnung und `ReedRootCount`. CONTENT-001b ergänzt Nachtmoos am schattigen Torfsteg über dieselbe Logik und ID `night_moss`; Main aktualisiert den getrennten `NightMossCount`. Die dunkle Moos-Silhouette und der alte Holzsteg bleiben Graybox-Zeichnungen. LOOP-003 ergänzt die Schilfwurzelverarbeitung zu `dried_reed_root`.

LOOP-001 ergänzt das `Trockengestell` als spezialisierte Interaktions-Area2D. Main übergibt der Station beim Szenenaufbau das lokale Inventar. Bei E ruft die Station `Inventory.transfer_item("sump_mint", "dried_sump_mint", 1)` auf. Die Inventarkomponente prüft den Bestand vor der Änderung, aktualisiert beide Mengen und sendet anschließend beide Zählersignale. Die Station gibt bei Erfolg oder fehlender Zutat Text an den vorhandenen Interaktionsfluss zurück. Main zeigt `sump_mint` und `dried_sump_mint` über getrennte Labels `InventoryCount` und `DriedMintCount` an. Die Verarbeitung ist in diesem Slice sofort; Inventar und Stationszustand werden nicht gespeichert.

LOOP-002 ergänzt den `Braukessel` als weitere Interaktions-Area2D der Gruppe `processing_stations`. Main übergibt ihm dieselbe lokale Inventarkomponente. E ruft `Inventory.transfer_item("dried_sump_mint", "calming_tea", 1)` auf. So werden Zutat und Ergebnis vor der HUD-Aktualisierung gemeinsam verbucht. Wasser ist unbegrenzt am Kessel verfügbar und wird entsprechend `GAME_PLAN.md` nicht als Inventargegenstand geführt. Das feste Startrezept bleibt explizit im Stationsskript; Rezeptressourcen werden erst geprüft, wenn mehrere Rezepte hinzukommen. `TeaCount` zeigt die fertige Menge.

LOOP-003 erweitert das Trockengestell um `reed_root` → `dried_reed_root`. Es versucht weiterhin zuerst die bestehende Sumpfminze-Übertragung, damit der Einführungspfad erhalten bleibt; falls keine frische Minze vorhanden ist, wird Schilfwurzel verarbeitet. `Inventory.transfer_item` hält beide Bestände atomar konsistent und sendet die bestehenden Änderungssignale. Main aktualisiert dafür `DriedReedRootCount`; die Station nennt im Feedback die tatsächlich getrocknete Pflanze.

LOOP-004 legt beide Kesselrezepte als externe `RecipeDefinition`-Resources ab. Main übergibt den Queststatus `fenja` an die Verarbeitungsstationen; der Kessel liest für jedes Rezept die erforderliche Quest-ID und den Zielzustand aus. Der stärkende Aufguss steht vor dem Tee in der Rezeptreihenfolge, ist bis zum abgeschlossenen Fenja-Auftrag gesperrt und benötigt getrocknete Sumpfminze plus Schilfwurzel. `Inventory.craft_items` prüft alle Anforderungen vor jeder Änderung, aktualisiert Zutaten und Produkt vollständig und sendet die Zähler danach. `InfusionCount` zeigt den Aufguss separat an.

QUEST-001 ergänzt eine kleine `FenjaQuest`-Komponente neben Inventar und Welt. Main übergibt ihr das lokale Inventar und verbindet `state_changed` mit `QuestStatus`. Fenja erhält die Quest über Dependency Injection und delegiert ihre Interaktion an sie. Die Quest schaltet zwischen `not_accepted`, `active` und `completed`; für die Abgabe ruft sie `Inventory.remove_item("calming_tea", 1)` auf und wechselt nur bei Erfolg in den Abschlusszustand. Main fordert den Player anschließend auf, den aktuellen Fenja-Prompt neu zu senden. Wiederholtes Ansprechen nach Abschluss ändert den Bestand nicht. Der Status lebt nur in der laufenden Partie und wird nicht gespeichert.

QUEST-002 ergänzt `MartenQuest` und Marten als zweiten interaktiven Bewohner. Main übergibt Martens Quest das Inventar und Fenjas Quest; `MartenQuest.is_available()` lässt den Folgeauftrag erst nach Fenjas Abschluss zu. Beide NPCs melden ihre Quest-ID, sodass Main ihnen die passende Questkomponente übergibt. Marten gibt mit `Inventory.remove_item("strengthening_infusion", 1)` genau einen Aufguss ab. Das vorhandene Quest-HUD zeigt nach Annahme Martens den nächsten Zutaten- oder Abgabeschritt und nach Abschluss dauerhaft Martens Erledigung an. Beide Questzustände bleiben laufzeitgebunden.


`QUEST-003` ergänzt `LeneQuest` und Lene. Main injiziert das Inventar und Martens Quest; `LeneQuest.is_available()` schaltet den Folgeauftrag erst nach Martens Abschluss frei. Das HUD führt anhand der vorhandenen Inventarbestände durch Schilfwurzel und Nachtmoos bis zum Brauen und zur Abgabe. `Inventory.remove_item("night_potion", 1)` verbraucht genau einen Trank; die Wiederholungsinteraktion verändert den Bestand nicht.

BOARD-001 ergänzt `QuestBoard` als Interaktions-Area2D. Das Brett meldet über `open_requested`, dass Main sein `QuestBoardPanel` anzeigen soll. Main aktualisiert die drei Zeilen aus den Questzuständen und fragt `can_accept()` ab; nur verfügbare, noch nicht angenommene Aufträge werden aktiv. Die Questkomponenten stellen `accept()` bereit und behalten NPC-Interaktion für die spätere Abgabe. Im geöffneten Panel pausieren Bewegung und Weltinteraktion; Tastaturfokus, Escape und Schließen-Schaltfläche werden vom UI/Main-Fluss behandelt. Statussignale aktualisieren Brett, HUD und NPC-Hinweise.

ECON-001 hält die Startbelohnungen als Konstanten in den Questkomponenten: Fenja zahlt 5, Marten 10 und Lene 15 Münzen. Eine Quest schreibt die Belohnung erst gut, nachdem das Inventar das Heilmittel erfolgreich entfernt hat; der Wechsel auf completed verhindert weitere Auszahlungen. Das Inventar verbucht coins und löst das bereits verwendete item_count_changed-Signal aus; Main aktualisiert CoinCount. Eine fehlgeschlagene Abgabe verändert den Münzbestand nicht. SAVE-001 persistiert den Münzbestand zusammen mit dem restlichen Inventar und den Questzuständen.

SAVE-001 ergänzt `SaveManager` als untergeordneten Dienst von Main. Er schreibt einen versionierten JSON-Spielstand in `user://moor_apotheke_save.json`; Main steuert automatische Startladung sowie die benannten Aktionen `save_game` (F5) und `load_game` (F9). Version 1 enthält Spielerposition als x/y-Zahlen, ein Inventar aus erlaubten Item-IDs und Mengen, die drei Questzustände und IDs bereits abgeernteter Sammelstellen. Jede Sammelstelle hat dafür eine stabile, eindeutige `pickup_id`.

Vor dem Laden prüft Main den gesamten Datensatz: Version, Zahlenbereiche, bekannte Inventar- und Pickup-IDs, Questzustände sowie die Freischaltreihenfolge. Erst wenn alle Felder gültig sind, werden Position, Bestand, Aufträge und Pickup-Sichtbarkeit gemeinsam angewendet. Fehlende, beschädigte oder nicht unterstützte Spielstände ändern den aktuellen Laufzeitzustand nicht. Beim automatischen Laden wird ein ungültiger Spielstand still verworfen; bei F9 zeigt das HUD eine Fehlermeldung.

LOOP-005 ergänzt als dritte Stufe `night_moss` → `dried_night_moss`. Das Trockengestell versucht weiterhin Sumpfminze zuerst, danach Schilfwurzel und zuletzt Nachtmoos. Die vorhandene atomare `Inventory.transfer_item`-Übertragung aktualisiert beide Bestände samt Signal; Main zeigt den getrockneten Bestand in `DriedNightMossCount`. Bei leerem Vorrat nennt das Feedback alle drei zulässigen Pflanzen.

LOOP-006 ergänzt night_potion als RecipeDefinition mit je einer getrockneten Schilfwurzel und einem getrockneten Nachtmoos. Der Braukessel schaltet das Rezept erst nach Abschluss von Martens Auftrag frei. Main übergibt beim Start beide Queststatus an die Verarbeitungsstationen und leitet spätere Marten-Änderungen weiter. craft_items verbraucht beide Zutaten atomar; NightPotionCount zeigt das Ergebnis.

UX-001 lässt Main die dauerhafte `QuestStatus`-Zeile nach Annahme und bei jedem `item_count_changed` aus dem lokalen Inventar ableiten. Die Reihenfolge der Ziele lautet: Sumpfminze sammeln, frische Minze trocknen, getrocknete Minze brauen, Tee Fenja bringen. Ist bereits ein späteres Produkt vorhanden, zeigt die HUD den dazu passenden nächsten Schritt. Bei `completed` bleibt die Abschlusszeile stehen; vor Annahme bleibt sie verborgen. Bestehende zeitlich begrenzte Interaktionsrückmeldungen und Inventarzähler laufen unverändert weiter.

Spätere eigenständige Szenen:
- player/player.tscn: Bewegung, Kollision, Sprite/Animation und Kamera.
- world/test_map.tscn: Kachelboden, Hindernisse und Spielobjekte.
- items/herb_pickup.tscn: Pflanze und Sammelinteraktion.
- stations/drying_rack.tscn und stations/brewing_cauldron.tscn: Verarbeitung.
- npcs/fenja.tscn: mögliche spätere Extraktion; QUEST-001 verwendet Fenja noch als Platzhalter direkt in der Testkarte.
- HUD-Komponenten bleiben von der Karte getrennt.

Szenen sollen möglichst wenig über feste Pfade auf Geschwister zugreifen. Eltern verbinden Abhängigkeiten; Ereignisse wie item_collected melden Ergebnisse über Signale. Ein Autoload kommt erst hinzu, wenn ein konkret global benötigter Zustand mehrere Szenen überlebt und die lokale Elternstruktur nicht ausreicht.

MAP-02 ergänzt fünf gezeichnete Wege. Der aktive Nordwestweg führt ins Schilfufer und kehrt zum NW-Startpunkt zurück; vier spätere Wege sind mit statischen Kollisionsbarrieren und interaktiven Hinweisen versehen. Diese Hinweise erklären die vorgesehene Freischaltung, aber PROG-01 implementiert die dynamische Zustandslogik erst später. Die vier fehlenden Gebietszenen sowie ihre Rast- und Rückkehrpunkte gehören zu REG-01 bis REG-05. Die fünf Gebiete und ihre Mindestflächen aus `design/world_backlog.md` sind nicht Teil der 640 × 360-Hubkarte.

## Zuständigkeiten
- Main/World: Spielabschnitt zusammenstellen und Zustand vermitteln.
- Player: Eingaben lesen, Bewegung ausführen, Interaktionsnähe darstellen.
- Interaktives Objekt: eigene Aktion ausführen und Erfolg melden.
- Inventory: Mengenbestände verwalten und Änderungen signalisieren.
- Station: Verarbeitung ausführen; UI bleibt separat.
- Quest: Annahme, benötigtes Produkt, Abschlussstatus und einmalige Belohnung verwalten.
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
  Player --> Board[Auftragsbrett öffnen]
  Board --> Quest[Fenjas Auftrag annehmen]
  Board --> MartenQuest[Martens Auftrag annehmen]
  Board --> LeneQuest[Lenes Auftrag annehmen]
  Player --> Fenja[Fenja ansprechen und Tee abgeben]
  Fenja --> Quest
  Player --> Marten[Marten ansprechen und Aufguss abgeben]
  Marten --> MartenQuest
  MartenQuest -->|Aufguss abgeben + 10 Münzen| Inventory
  MartenQuest -->|state_changed| HUDQuest
  MartenQuest -->|Abschluss schaltet frei| LeneQuest
  Quest -->|Tee abgeben + 5 Münzen| Inventory
  Inventory --> HUD[Inventar- und Münzanzeige]
  Quest -->|state_changed| HUDQuest[Auftragsstatus]
  Player --> Lene[Lene ansprechen und Trank abgeben]
  Lene --> LeneQuest
  LeneQuest -->|Nachttrank abgeben + 15 Münzen| Inventory
  LeneQuest -->|state_changed| HUDQuest
~~~

Aufträge werden am Brett angenommen und weiterhin direkt bei Fenja, Marten oder Lene abgegeben. Marten und Lene werden nach Abschluss des jeweiligen Vorgängerauftrags am Brett freigeschaltet.

## Daten und Persistenz
- Im ersten Slice bleibt die Datenmenge klein und explizit.
- Sobald mehrere Gegenstände und Rezepte existieren, prüfen wir Godot-Resource-Dateien für Item-, Rezept- und Auftragsdefinitionen. Laufzeitbestand und Queststatus bleiben veränderlicher Spielzustand.
- SAVE-001 legt ein versioniertes JSON-Format in `user://moor_apotheke_save.json` fest; Einzelheiten stehen in [ADR-0002](adr/0002-versioned-json-save.md). Persistiert werden nur IDs, Zahlen und Zustände. F5 speichert, F9 lädt und beim Start wird ein gültiger Spielstand automatisch geladen.
- Der ganze Spielstand wird vor dem Anwenden auf Typen, Wertebereiche, IDs und Questabhängigkeiten validiert.
- Keine Datenbank und keine Netzwerk-API.

## Grafik und Eingaben
- Pixelmaßstab: 16-Pixel-Kacheln, Viewport 480 × 270 und scharfe Darstellung als Startwerte.
- Der Spielstand verwendet Pixelart-Atlanten für Moor, Spieler, Stationen, Bewohner und Sammelpflanzen; weitere Inhalte können zunächst Platzhaltergrafik nutzen.
- Bildgenerator-Ausgaben werden auf Transparenz, Raster, Anschlüsse und Lesbarkeit geprüft.
- Fremde Assets benötigen Herkunft und Lizenzangabe; Prompts finaler eigener Bilder werden gespeichert.
- Benannte Aktionen: move_left/right/up/down, interact, inventory, save_game, load_game. Die Belegung wird nicht in Gameplay-Skripte eingebrannt.

## Qualität, Sicherheit und Performance
- GDScript typisieren, wo dies Lesbarkeit und Fehlererkennung verbessert.
- Fehlende Eingaben, nicht verfügbare Zutaten und ungültige Abgaben erhalten sichtbare ruhige Rückmeldungen.
- Bei der kleinen Karte zuerst Korrektheit und Lesbarkeit; vor Optimierung messen.
- Keine Konten oder Secrets; fremde Add-ons und Assets prüfen.

## Bekannte Einschränkungen
- Trockengestell, Braukessel, Auftragsbrett, Fenja, Marten, Lene und drei Sammelpflanzen verwenden Sprite2D-Atlaszellen in der Testkarte; eigenständige Szenen, Produktionszeiten und Animationen sowie Exportprofile fehlen noch.
- Das Spiel liegt eigenständig in `Fremarx/Moor-Apotheke`. Eine spätere Zusammenführung mit dem früher verwendeten 2DGame-Repo wäre eine eigene Migrationsentscheidung.

## Engine-Dokumentation
ECON-001 nutzt das bestehende Inventaränderungssignal, um CoinCount zu aktualisieren; die verwendete Signal- und Label-API ist in der versionierten [Signal-Referenz](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [Label-Referenz](https://docs.godotengine.org/en/4.7/classes/class_label.html) dokumentiert. Es kommt keine neue Engine-API hinzu.
Das Auftragsbrett nutzt den VIS-003-Atlasframe und ein textbasiertes HUD. Die Szene wurde bei 480 × 270 gerendert; Bewegung, HUD-Führung und echte Tastatureingabe bleiben manuell zu prüfen.

Versionierte Quellen stehen in docs/KNOWLEDGE_BASE.md. Für CORE-001 wurden [2D-Bewegung](https://docs.godotengine.org/en/4.7/tutorials/2d/2d_movement.html), [CharacterBody2D](https://docs.godotengine.org/en/4.7/tutorials/physics/using_character_body_2d.html) und [Input-Beispiele](https://docs.godotengine.org/en/4.7/tutorials/inputs/input_examples.html) verwendet. Weitere Quellen betreffen Szenenorganisation, TileSets und Resources.

Für BOARD-001 wurden außerdem [Control](https://docs.godotengine.org/en/4.7/classes/class_control.html), [Button](https://docs.godotengine.org/en/4.7/classes/class_button.html) und die [GUI-Tastatur-/Controller-Navigation](https://docs.godotengine.org/en/4.7/tutorials/ui/gui_navigation.html) verwendet. Control verwaltet GUI-Eingabe und Fokus, Button stellt die Aktivierungsaktion bereit und die Navigation-Doku beschreibt Fokuswechsel zwischen Bedienelementen.

SAVE-001 verwendet die versionierte [Saving-Games-Anleitung](https://docs.godotengine.org/en/4.7/tutorials/io/saving_games.html) für den Speicherort und serialisierbare Zustände, die [JSON-Referenz](https://docs.godotengine.org/en/4.7/classes/class_json.html) für Parsefehler und typgeprüfte Daten sowie die [InputEventKey-Referenz](https://docs.godotengine.org/en/4.7/classes/class_inputeventkey.html) für benannte Tastaturbelegungen.

Für CORE-002 wurden zusätzlich die versionierte [Area2D-Dokumentation](https://docs.godotengine.org/en/4.7/tutorials/physics/using_area_2d.html) und die [Node-Klassenreferenz](https://docs.godotengine.org/en/4.7/classes/class_node.html) zur Overlap-Erkennung und Eingabeweitergabe herangezogen. ITEM-001 verwendet zudem die dokumentierte [Signal-API](https://docs.godotengine.org/en/4.7/classes/class_signal.html) und [GDScript-Vererbung](https://docs.godotengine.org/en/4.7/tutorials/scripting/gdscript/gdscript_basics.html). QUEST-001 verwendet außerdem die offizielle [Godot-4.7-Szenenorganisation](https://docs.godotengine.org/en/4.7/tutorials/best_practices/scene_organization.html) für die Übergabe von Abhängigkeiten über Main sowie die bestehende Signal-API für Statusänderungen. UX-001 aktualisiert ein bestehendes [Label](https://docs.godotengine.org/en/4.7/classes/class_label.html) über die Inventaränderungssignale; neue UI- oder Engine-Abhängigkeiten kommen nicht hinzu.
