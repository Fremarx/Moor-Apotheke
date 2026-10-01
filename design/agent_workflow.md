# Parallele KI-Arbeit am Spielprojekt

## Ziel

Mehrere Codex-Aufgaben können gleichzeitig an getrennten Teilen des Spiels arbeiten. Jede Aufgabe läuft in einem eigenen Git-Worktree. Dieses zentrale Gespräch behält Überblick, Prioritäten und Zusammenführung.

## Zuständigkeiten

| Rolle | Eigene Dateien | Zuständigkeit |
| --- | --- | --- |
| Welt und Gebiete | `design/world_design_plan.md` | Biome, Wege, Flächengröße, Erkundungsziele und Gebietsaufgaben |
| Ressourcen und Wirtschaft | `design/resource_economy.md` | Zutaten, Rezepte, Wirkungen, Verkauf und optionale Upgrade-Kosten |
| Gegner und Kampf | `design/enemy_roster.md` | Gegnerverhalten, Warnungen, Gegenmaßnahmen, Kampfschritte und Drops |
| Zentrale Integration | `GAME_PLAN.md`, `design/world_backlog.md`, `design/progression_roadmap.md` | Gemeinsame Regeln, Reihenfolge, Prioritäten, Abnahmekriterien und Konfliktlösung |

Die Rollen bearbeiten jeweils nur ihre eigenen Dateien. Entdecken sie eine Abhängigkeit in einem anderen Bereich, melden sie sie dem zentralen Koordinator, statt dort parallel zu ändern.

## Ablauf für ein Arbeitspaket

1. Der Koordinator beschreibt ein konkretes Ergebnis, betroffene Zuständigkeit und Abnahmekriterien.
2. Für jede parallel arbeitende Rolle wird eine eigene Codex-Aufgabe mit eigenem Worktree erstellt.
3. Jeder Worktree muss den aktuellen Arbeitsstand enthalten. Das ist wichtig, solange Design-Dateien noch uncommittet oder untracked sind; ein Worktree vom letzten Commit könnte diese Dateien sonst nicht sehen.
4. Die Aufgaben arbeiten unabhängig. Gemeinsame Begriffe, Gebietstore und Balanceannahmen kommen aus `GAME_PLAN.md`, `design/progression_roadmap.md` und `design/world_backlog.md`.
5. Der Koordinator prüft jede Änderung, gleicht Widersprüche ab und führt sie kontrolliert in den zentralen Arbeitsstand zurück. Es gibt keine automatische Zusammenführung.
6. Erst nach der Integration wird entschieden, welche Spieltests oder technische Prüfungen für das Arbeitspaket nötig sind.

## Vorlage für einen Agentenauftrag

> **Ziel:** [ein überprüfbares Ergebnis]
>
> **Dateizuständigkeit:** Bearbeite nur `[Dateipfad]`. Ändere keine zentralen oder fremden Plan-Dateien. Melde dortige Abhängigkeiten im Abschlussbericht.
>
> **Leitplanken:** Lies zuerst `AGENTS.md` und die verlinkten Plan-Grundlagen. Bewahre die bestehenden Spielentscheidungen. Kennzeichne ungetestete Balancewerte als Hypothesen.
>
> **Abnahme:** [konkrete Kriterien]
>
> **Abgabe:** Beschreibe geänderte Dateien, wichtige Entscheidungen, offene Fragen und mögliche Konflikte. Ändere oder committe keine Arbeit aus anderen Worktrees.

## Zusammenführungsregeln

- Gleiche Datei nur einem Agenten pro Arbeitspaket zuweisen.
- Wenn zwei Rollen dieselbe Regel berühren müssen, zuerst die gemeinsame Regel zentral festlegen; danach getrennte Änderungen starten.
- Der Koordinator prüft insbesondere Gebietsnamen, Fortschrittsbedingungen, Ressourcennamen, Rezeptzutaten, Verkaufswerte und Upgrade-Kosten auf Übereinstimmung.
- Ein erledigter Agentenauftrag gilt erst nach zentraler Prüfung und Integration als abgeschlossen.

## Aktueller Einsatz

Vorgesehene parallele Rollen: Welt/Gebiete, Ressourcen/Wirtschaft und Gegner/Kampf. Der zentrale Koordinator behält `GAME_PLAN.md`, `world_backlog.md` und `progression_roadmap.md`.

**Wichtiger Stand:** Die aktuellen Entwurfsdateien liegen im Arbeitsverzeichnis, teils noch uncommittet oder untracked. Beim Anlegen eines Worktree-Auftrags muss daher ausdrücklich ein Startstand gewählt werden, der diese Änderungen einschließt.
