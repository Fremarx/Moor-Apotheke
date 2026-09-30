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
| [Resources](https://docs.godotengine.org/en/4.7/tutorials/scripting/resources.html) | 4.7, 30.09.2026 | Datencontainer und Rezeptdaten | Offizielle Engine-Doku; LOOP-002/CONTENT-001 |
| [Saving Games](https://docs.godotengine.org/en/4.7/tutorials/io/saving_games.html) | 4.7, 30.09.2026 | Persistenz und user:// | Offizielle Engine-Doku; SAVE-001 |

## Grenzen
- Dies ist ein Quellenindex, keine Kopie der Dokumentation.
- API-Details vor der Implementierung gegen die passende 4.7-Seite prüfen.
- Fremde Forenbeiträge oder Assets sind keine verbindliche technische oder Lizenzquelle.
- Vertrauliche Projektinhalte werden nicht an externe Wissensdienste gesendet.
