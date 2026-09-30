# ADR-0001: Godot 4.7.2 Standard mit GDScript

**Datum:** 2026-09-30
**Status:** accepted
**Entscheider:** Projektverantwortliche; Codex als technischer Berater

## Kontext
Das Projekt ist ein kleines 2D-Pixelart-Einzelspielerspiel mit Bewegung, Interaktion, Sammeln, Verarbeitung und Aufträgen. Es braucht einen direkten Weg zum spielbaren Prototyp ohne unnötige Laufzeit oder zusätzliche Infrastruktur.

## Entscheidung
Das Projekt verwendet Godot 4.7.2 Standard und GDScript. Zunächst nutzen wir Godots eingebauten Editor, kleine Szenen und versionierte Projektdateien.

## Betrachtete Alternativen
### Unity mit C#
- Vorteile: breites Ökosystem und viele Lernmaterialien.
- Nachteile: zusätzlicher Stack und C#/.NET-Werkzeugbedarf für den derzeitigen 2D-Prototyp.

### GameMaker
- Vorteile: auf 2D-Spiele ausgerichteter Editor und schneller 2D-Einstieg.
- Nachteile: eigener Workflow; Lizenz- und Plattformfragen müssten vor langfristiger Festlegung geprüft werden.

## Begründung
Godot bietet spezialisierte 2D-Funktionen und integriert GDScript direkt. Das passt zum schrittweisen Bau eines kleinen 2D-Ausschnitts. Die offizielle Windows-Version ist portabel; das Projekt benötigt keine .NET-Ausgabe.

## Folgen
### Positiv
- Karten, Animation und Interaktion lassen sich im selben Editor bauen und prüfen.
- GDScript ist ohne zusätzliche Runtime nutzbar.
- Szenen und Projekteinstellungen sind textbasiert und passen zum inkrementellen Git-Workflow.

### Negativ und Risiken
- Godot-spezifische Szenen- und GDScript-Konzepte müssen erlernt werden.
- Versionswechsel können Editor- und API-Unterschiede mitbringen; maßgeblich bleibt die 4.7-Dokumentation.
- Portabilität und Export werden bei konkreten Zielplattformen geprüft.

### Rücknahme oder Migration
Vor größerem Content-Aufbau kann die Entscheidung neu bewertet werden. Eine Migration wäre ein eigenes Architekturprojekt; Gameplaylogik, Assets und Daten sind nicht ohne Anpassungen zwischen Engines übertragbar.
