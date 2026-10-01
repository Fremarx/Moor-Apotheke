# Backlog: Welt und Moorgebiete

**Ziel:** Eine gut lesbare Welt mit dem Dorf als Mittelpunkt, fünf eigenständigen Sammelgebieten, passenden Gegnern und sinnvollen Verbesserungen.

**Grundlage:** [Weltentwurf und Karten-Mockup](world_design_plan.md)

**Gegnerdetails:** [Aussehen, Fähigkeiten und Gegenmaßnahmen](enemy_roster.md)

**Langfristiger Ausbau:** [Stufenplan für Gebiete, Rezepte und Verbesserungen](progression_roadmap.md)

**Ressourcen und Verkauf:** [Ressourcen-, Rezept- und Wirtschaftsentwurf](resource_economy.md)

Prioritäten: **P0** = erster spielbarer Ausbau, **P1** = nächste Erweiterung, **P2** = späterer Ausbau. Die Reihenfolge hält die vorhandenen Aufträge, Ressourcen und Rezepte als Einstieg bei.

## Maßstab als feste Vorgabe

### SCALE-01: Große, inhaltsreiche Gebiete planen — P0

- Die Weltkarte ist eine Übersicht; jedes Gebiet wird als eigenes, großes Areal gebaut.
- Bei der geplanten Ansicht von 480×270 Pixeln mit 16×16-Kacheln entspricht ein Bildschirm etwa 30×17 Kacheln.
- Mindestmaß je Moorgebiet: ungefähr 4×3 Bildschirmansichten begehbarer Raum (etwa 120×51 Kacheln); Zielgröße 5×4 Ansichten. Wasser und leere Dekorationsfläche zählen nicht.
- Jedes Gebiet erhält mindestens drei Teilbereiche, zwei Nebenwege, eine Rundroute oder Abkürzung, drei Landmarken, mehrere Fundstellen und einen optionalen Geheimort.
- Ziel: 25–40 Minuten beim ersten Erkunden je Gebiet und insgesamt etwa 4–6 Stunden für die erste Reise durch alle Gebiete, Aufträge und Verbesserungen.
- Spielzeit durch interessante Orte, Sammeln, Aufträge, Gegner, Geheimnisse und spätere Abkürzungen erzeugen; leere Laufstrecken zählen nicht als Inhalt.

**Fertig, wenn:** Jedes der fünf Areale die Mindestfläche und Inhaltsziele erfüllt und ein einfacher Spieltest zeigt, dass die Gebiete weder in wenigen Minuten durchlaufen noch durch leere Fläche künstlich gestreckt werden.

## Epic A — Dorfzentrum und Weltkarte

### MAP-01: Dorfplatz als zentralen Orientierungspunkt bauen — P0

**Status: DONE (01.10.2026)**

- Dorfplatz in die Kartenmitte setzen, Apotheke und Auftragsbrett gut sichtbar machen.
- Startpunkt so platzieren, dass die Figur direkt einen Blick auf mindestens zwei Ausgänge hat.
- Gebäude und Figuren dürfen die Wege zu den Ausgängen nicht verdecken.
- Umgesetzt: Apotheke mit lesbarem Schild und freiem Eingang, gepflasterte Platzmitte mit Brunnen, Auftragsbrett sowie fünf markierte Wegverläufe. MAP-02 setzt Schilfufer an den offenen Nordwestweg; die übrigen vier Richtungen bleiben bis zu ihren Fortschrittsschritten gesperrt.
- Das bestehende Szenenobjekt `TestMap` behält seinen stabilen Knotennamen und meldet sich in der Welt als `Dorfplatz`.
- SCALE-01 bleibt offen: MAP-01 gestaltet den kompakten Hub und behauptet noch nicht, dass die fünf Gebiete den geplanten Großmaßstab erfüllen.

**Fertig, wenn:** Dorfplatz, Apotheke, Brett und Startpunkt auf der Karte sofort erkennbar und erreichbar sind.

### MAP-02: Fünf Pfade und Übergänge anlegen — P0

**Status: DONE (01.10.2026)**

- Fünf sichtbare Pfade führen vom Dorfplatz in die vorgesehenen Richtungen: Schilfufer (NW), Quellsenke (NE), Alter Torfstich (O), Nebelhain (SW) und Versunkener Wurzelhain (SE).
- Ein begehbarer Holzsteg führt über den Teich zum NE-Ausgang.
- Nur der offene Startweg zum bestehenden Schilfufer hat einen funktionierenden Übergang. Die übrigen vier Wege zeigen physische Holzbarrieren und untersuchbare Hinweise auf ihre geplanten Freischaltungen.
- Der Schilfufer-Rückweg setzt den Spieler am NW-Startpunkt des Dorfplatzes ab. Sichere Rückwege und Rastpunkte für weitere Gebiete werden von REG-01 bis REG-05 ergänzt, wenn ihre Karten gebaut werden.
- Die auftragsbasierten Freischaltungen sind aktuell Erklärtexte; ihre dynamische Zustandslogik gehört zu PROG-01.

**Fertig, wenn:** Alle fünf Wege visuell bis zu ihrem Ausgang verfolgbar sind, der aktive Startübergang hin und zurück funktioniert und jeder künftige Weg sichtbar, physisch sowie mit seiner geplanten Voraussetzung gesperrt ist.

### MAP-03: Wiederverwendbares Moor-Kachelset festlegen — P0

- Gras, Torf, Schlamm, flaches/tiefes Wasser, Ufer, Holzsteg und Weg als Grundkacheln festlegen.
- Kachelübergänge für Ufer, Wegkurven und Brücken so anlegen, dass keine Lücken entstehen.
- Sammelpflanzen und Interaktionsorte mit klaren Silhouetten und zurückhaltendem Leuchteffekt markieren.

**Fertig, wenn:** Die Wege ohne sichtbare Kachelbrüche gebaut werden können und sammelbare Objekte auch bei Spielgröße leicht zu erkennen sind.

## Epic B — Gebiete einzeln gestalten

### REG-01: Schilfufer als Startgebiet — P0

- **Lage und Eingang:** nordwestlicher Abzweig direkt vom Dorf.
- **Aufbau:** drei Teilbereiche: Uferwiesen am Eingang, ein verzweigtes Schilflabyrinth und die Lichtung an der versunkenen Fähre. Hauptpfad plus zwei Seitenwege; Steg und Schilfschleife bilden eine Abkürzung zurück.
- **Fundstellen:** mehrere Sumpfminz- und Schilfwurzelgruppen verteilt über alle Teilbereiche; ein sichtbarer Sammelpunkt erklärt die Ernte, seltene Pflanzen liegen abseits des Hauptpfads.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten beim ersten Besuch, einschließlich mindestens einer optionalen Schleife.
- **Gegner:** zuerst Schilfschnapper als einzelner, gut angekündigter Gegner; Mückenschwarm später als seltene Variante ergänzen.
- **Look:** helles Schilf, olivgrüne Inseln, schlammige Wege und wenige offene Wasserflächen.

**Fertig, wenn:** Beide bestehenden Pflanzen hier gesammelt werden können, der Weg zum Dorf klar bleibt und der Gegner ohne Verlust von Gegenständen umgangen oder vertrieben werden kann.

### REG-02: Alter Torfstich und Torfsteg — P0

- **Lage und Eingang:** östlicher Pfad vom Dorf.
- **Aufbau:** drei Teilbereiche: Torfhof mit Werkzeugresten, verzweigte Grubenstege und der alte Torfweg als Moosgebiet. Mehrere Stegschleifen verbinden sichere und optionale Routen.
- **Fundstellen:** Nachtmoos in mehreren schattigen Nischen am alten Steg; Torfherz an sicheren Grubenrändern und in einer optionalen Seitenroute.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit mindestens einer Abkürzung, die erst beim Erkunden geöffnet wird.
- **Gegner:** Moorwühler kündigt sein Auftauchen am Boden an; Irrlicht ist die seltene Variante und darf nicht in Sackgassen locken.
- **Look:** Torfbraun, dunkles Wasser, verwittertes Holz und kleine blaugrüne Mooslichter.

**Fertig, wenn:** Nachtmoos wie im bestehenden Spielplan am alten Steg liegt, alle Gruben sicher umgehbar sind und mindestens eine klare Sammelroute zurückführt.

### REG-03: Quellsenke — P1

- **Lage und Eingang:** nordöstlicher Pfad; Brücke wird durch einen Dorfauftrag repariert.
- **Aufbau:** drei Teilbereiche: oberer Wasserfall, ausgedehnter Seerosenteich und Quellgrotte. Uferwege, mehrere Inseln und kurze Stege formen eine Rundroute mit zwei Nebenwegen.
- **Fundstellen:** Seerosenwurzel am Ufer, seltene Quellperle auf einer Insel. Quellwasser bleibt zunächst Dekoration und ersetzt nicht das kostenlose Kesselwasser.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit Erkundung der Wasserfälle und mindestens einem optionalen Grottenfund.
- **Gegner:** Blasenkröte verlangsamt oder stößt kurz zurück; Quellwächter schützt die seltene Insel-Fundstelle.
- **Look:** klares Türkis, Seerosen, helles Moos und Wasserfälle als Orientierungspunkte.

**Fertig, wenn:** Beide Ressourcen ohne Schwimmen oder unklare Sprünge erreichbar sind und die Inselroute eine sichere Rückkehr erlaubt.

### REG-04: Nebelhain — P1

- **Lage und Eingang:** südwestlicher Weg; wird mit wachsendem Dorfvertrauen geöffnet.
- **Aufbau:** drei Teilbereiche: äußerer Nebelpfad, Flüsterlichtung und alter Steinkreis. Mehrere Lichtungen und leuchtende Wegzeichen bilden einen verzweigten Rundweg.
- **Fundstellen:** Flüsterpilze auf Lichtungen, Irrlichtstaub nahe bläulichen Lichtern.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten. Landmarken bleiben trotz Nebel sichtbar; optionale Abzweigungen führen zu Geheimorten.
- **Gegner:** Nebelkrähe greift in sichtbaren Vorbeiflügen an; Wurzelhocker hält kurz fest, ohne den Hauptweg zu blockieren.
- **Look:** dunkles Grün und Nebelblau; Nebel darf Details abdämpfen, aber weder Wegmarkierungen noch Gegnerwarnungen verdecken.

**Fertig, wenn:** Der Ausgang auch bei Nebel erkennbar bleibt, beide Ressourcen unterschiedliche Fundorte haben und der Rundweg nicht in eine Sackgasse führt.

### REG-05: Versunkener Wurzelhain — P2

- **Lage und Eingang:** südöstlicher Weg; spätere Freischaltung über Kräuterbuch-Auftrag.
- **Aufbau:** drei Teilbereiche: Wurzelrand, verzweigte Harzkanäle und innere Lichtung. Wurzelbögen rahmen längere Wege statt kleiner Kammern; ein später geöffneter Steg bildet eine Abkürzung.
- **Fundstellen:** Wurzelrinde an freiliegenden Wurzeln, Harzbeere nahe warmer Harzstellen.
- **Größe und Erkundung:** SCALE-01 erfüllen; Ziel sind 25–40 Minuten, mit einem Geheimort und einer optionalen Route an der inneren Lichtung.
- **Gegner:** Rankenläufer greift in einem klar sichtbaren Bereich an; Bernsteinwächter bewacht die innere Lichtung.
- **Look:** dunkles Torfgrün und Holzbraun, warme Bernsteinpunkte als Blickführung.

**Fertig, wenn:** Hauptroute und Abkürzung unterscheidbar sind, Harzstellen nicht mit Gegnern überlagern und ein sicherer Rückweg offen bleibt.

## Epic C — Sammeln, Gegner und Gebietsfortschritt

### SYS-01: Gebietseigene Fundstellen und Nachwachsen — P0

- Jeder Fundstelle eine feste Gebiet- und Ressourcen-ID zuordnen.
- Pro Gebiet mindestens zwei normale Fundstellen und eine seltene Fundstelle anlegen.
- Gesammelte Pflanzen nach einem Gebietswechsel oder festgelegtem Spielabschnitt wieder verfügbar machen.
- Ressourcen und Fundstellen im Kräuterbuch nach Entdeckung sichtbar machen.

**Fertig, wenn:** Jede Ressource eindeutig nur einem Gebiet zugeordnet ist, gesammelt werden kann und nicht dauerhaft verschwindet.

### RES-01: Ressourcen sinnvoll in Rezepten und Ausbauten verwenden — P0/P1/P2

- Ressourcenorte, Verarbeitungszustand und Verwendungen nach [Ressourcenplan](resource_economy.md) abbilden.
- Frische Pflanzen am Trockengestell verarbeiten; Gebietsmaterial und Gegnerdrops direkt am Kessel nutzen.
- Für jede Gebietspflanze und jeden Gegnertropfen mindestens ein passendes Rezept anlegen.
- Quellperle und Irrlichtstaub zusätzlich für Gebietsfortschritt verwenden; Torfherz und ausgewählte Ressourcen zusätzlich für Upgrades nutzen.
- Alle verbrauchten Hauptzutaten wachsen nach oder werden durch Gegner erneut geliefert.

**Fertig, wenn:** Keine Ressource ohne bekannte Verwendung im Inventar liegt und ein Spieler durch Brauen oder Verkaufen keinen Hauptfortschritt blockiert.

### SYS-02: Sichere Begegnungen mit Gegnern — P0

- Gegner kündigen Angriffe klar über Animation, Geräusch oder Bodeneffekt an.
- Ausweichen, Abstand halten oder Laterne/Schutzmittel als einfache Antwort ermöglichen.
- Treffer dürfen keine Zutaten aus dem Inventar löschen.
- Bei Niederlage Rückkehr zu Dorf oder letztem sicheren Wegpunkt.
- Gegner belohnen optional mit Münzen, Vertrauen oder passenden Gebietszutaten.

**Fertig, wenn:** Eine Begegnung ohne Kampfkenntnisse verständlich ist, kein Pflichtgegner einen Auftrag blockiert und ein Fehlschlag keinen Sammelfortschritt löscht.

### ENE-01: Startgegner platzieren — P0

- Schilfschnapper im Schilfufer und Moorwühler im Torfstich umsetzen.
- Beide zuerst einzeln platzieren und Warnung, Reichweite und Erholung festlegen.
- Gegner nicht direkt an Startpunkten, Auftragszielen oder schmalen Brücken platzieren.

**Fertig, wenn:** Beide Gegner lesbar und umgehbar sind und ihre Fundstellen nach einer Begegnung erreichbar bleiben.

### ENE-02: Gebietsvarianten ergänzen — P1/P2

- P1: Mückenschwarm, Irrlicht, Blasenkröte und Quellwächter.
- P1: Nebelkrähe und Wurzelhocker.
- P2: Rankenläufer und Bernsteinwächter.
- Seltene Varianten nur an markanten Orten und mit optionaler Belohnung einsetzen.

**Fertig, wenn:** Jeder Gegner eine eigene erkennbare Bewegung und eine verständliche Gegenmaßnahme hat.

### ENE-03: Gegnerdrops in Trankrezepte einbinden — P0/P1/P2

- Jeder Gegnertyp erhält eine eigene Alchemiezutat, passend zu seinem Gebiet und Aussehen.
- Jede gelöste Begegnung liefert eine Einheit dieses Materials; der Gegner kann nach einem späteren Dorfbesuch wieder erscheinen.
- Für jeden Drop mindestens ein benanntes Rezept mit einer Gebietspflanze als weiterer Zutat und einem klaren, zeitlich begrenzten Nutzen anlegen.
- P0: Schnapperschleim, Torfpanzerflocke und ihre Rezepte mit den Startgegnern umsetzen.
- P1: Drops und Rezepte für Quellsenke, Nebelhain sowie die seltenen Gegner der frühen Gebiete ergänzen.
- P2: Drops und Rezepte für den versunkenen Wurzelhain und Bernsteinwächter ergänzen.
- Rezepte und benötigte Zutaten im Rezeptbuch anzeigen; kein Hauptauftrag darf einen seltenen Gegnerdrop verlangen.

**Fertig, wenn:** Alle zehn Gegnertypen ein verwendbares Material fallen lassen, für jeden Drop mindestens ein Trankrezept existiert und die Materialien ohne Pflichtkampf oder Gegenstandsverlust gesammelt werden können.

## Epic D — Spielerkampf

### COM-01: Kräuterstab, Ausweichen und Herzen — P0

- Kräuterstab-Angriff in Blickrichtung auf F/Linksklick; die Grundwaffe verbraucht keine Zutaten.
- Ausweichschritt auf Leertaste; er lässt angekündigte Angriffe passieren und nutzt keine Ausdauerleiste.
- Drei Herzen für den Spieler; ein Treffer kostet ein Herz, kurzzeitiger Schutz verhindert direkte Trefferketten.
- Gewöhnliche Gegner werden nach zwei Treffern vertrieben, seltene nach drei; sichtbare Widerstandspunkte zeigen den Fortschritt.
- Bei null Herzen Rückkehr zum letzten sicheren Wegpunkt; Inventar, Münzen und Zutaten bleiben erhalten.
- Gegner können während ihrer Erholung zusätzlich beruhigt oder abgelenkt werden.

**Fertig, wenn:** Ein Spieler ohne Tränke jeden frühen Gegner ausweichen und vertreiben kann und Angriffe stets klar angekündigt werden.

### COM-02: Trankgürtel und Kampfmixturen — P1

- Schnellplätze 1 und 2 wählen; Q verwendet den gewählten Trank.
- Heil-, Schutz- und Gebietsmixturen direkt anwenden; geworfene Tränke fliegen in Blickrichtung.
- Nebelbombe unterbricht Gegner in kleinem Umkreis; Harzfang verlangsamt Gegner in einer kurzlebigen Fläche.
- Beruhigungstee stellt ein Herz wieder her.

**Fertig, wenn:** Schnellplätze während des Erkundens ohne Öffnen des Inventars nutzbar sind und keine Kampfmixtur zwingend für den Hauptfortschritt gebraucht wird.

## Epic E — Aufträge und Upgrades

### PROG-01: Wege über Dorfaufträge freischalten — P0

- **Start:** Dorfplatz und Schilfufer sind offen.
- **Nach Fenjas Beruhigungstee:** Alter Torfstich wird geöffnet. Dort liegt das Nachtmoos für Lenes Nachttrank.
- **Nach Martens stärkendem Aufguss:** Quellsenke wird über den reparierten Nordsteg geöffnet.
- **Nach Lenes Nachttrank:** Nebelhain wird über den südwestlichen Pfad geöffnet.
- **Später:** Nach je einem erfüllten Auftrag in Quellsenke und Nebelhain sowie der Abgabe von Quellperle und Irrlichtstaub an Lene wird der Versunkene Wurzelhain geöffnet.
- Gesperrte Pfade bleiben sichtbar; beim Untersuchen wird die konkrete Bedingung angezeigt.
- Jeder einmal geöffnete Weg bleibt dauerhaft offen.
- Aufträge und Gebietsfreischaltungen verlangen keinen Pflichtkampf.

**Fertig, wenn:** Die Gebiete in dieser Reihenfolge erreichbar sind, Lenes Nachtmoos-Aufgabe erst nach Öffnung des Torfstichs startet und die Karte für jeden gesperrten Weg dessen Bedingung erklärt.

### PROG-02: Pro Gebiet neue Ziele und Belohnungen staffeln — P0/P1/P2

- Jede Freischaltung ergänzt einen Auftrag, neue Sammelmaterialien, mindestens eine Rezeptidee und einen Grund, später zurückzukehren.
- Nach einem Gebiet gibt es eine passende Verbesserung für Erkunden, Herstellung oder Kampf.
- Wahlbelohnungen bleiben später kaufbar; keine einzelne Entscheidung sperrt Rezepte oder Gebiete dauerhaft.
- Abschluss eines Gebiets schaltet mindestens eine weitere Abkürzung, Rezeptgruppe oder optionale Fundstelle frei.
- Den Ablauf der fünf Hauptetappen nach [Ausbaupfad](progression_roadmap.md) umsetzen.

**Fertig, wenn:** Jede neue Region einen klaren nächsten Schritt und eine sofort nutzbare Belohnung bietet, ohne neue Sammelmaterialien in einer Sackgasse enden zu lassen.

### UPG-01: Erste Verbesserung als Belohnung — P0

- Nach Fenjas Auftrag zwischen Wanderbeutel und größerem Trockengestell wählen lassen.
- Verbesserung sofort in Inventar- oder Stationsanzeige sichtbar machen.
- Nicht gewählte Verbesserung später zu einem verständlichen Münz- und Ressourcenpreis anbieten.

**Fertig, wenn:** Beide Optionen einen spürbaren, leicht erklärbaren Vorteil geben und die Wahl keinen anderen Fortschritt dauerhaft sperrt.

### UPG-02: Laterne, Sumpfstiefel und Kräuterbuch — P1

- Laterne zeigt seltene Sammelstellen und vertreibt einfache Gegner kurz.
- Sumpfstiefel verringern die Verlangsamung im Schlamm und öffnen ausgewiesene Flachwasserwege.
- Kräuterbuch notiert entdeckte Ressourcen, bekannte Fundorte und fehlende Rezeptzutaten.

**Fertig, wenn:** Jede Verbesserung mindestens einen vorher sichtbaren oder bekannten Spielort sinnvoll verändert.

### UPG-03: Kessel und weitere Herstellungsstufen — P1/P2

- Größeres Trockengestell verarbeitet mehr Pflanzen je Arbeitsgang.
- Verbesserter Kessel kann später zwei Portionen zugleich brauen.
- Gebietszutaten schalten zusätzliche Rezepte und Verbesserungen frei.

**Fertig, wenn:** Verbesserungen Klicks oder Laufwege reduzieren oder neue Rezepte ermöglichen, ohne Zeitdruck einzuführen.

### SALE-01: Gebraute Mittel verkaufen und Aufträge erfüllen — P1

- Fertige Tränke am Apothekentresen zum festen Grundpreis verkaufen.
- Wiederholbare Aufträge zahlen etwa 50 Prozent mehr als der Tresenpreis und erhöhen zusätzlich das Dorfvertrauen.
- Die drei Einführungsaufträge behalten ihre festen Belohnungen.
- Bewohner fragen bevorzugt nach Mitteln, die in ihrem eigenen Gebiet helfen; Aufträge haben keine Frist.
- Zutaten werden im Inventar behalten; ein Verkauf zieht nur das ausgewählte fertige Produkt ab.

**Fertig, wenn:** Der Tresenverkauf eine verlässliche Einnahmequelle ist, Aufträge lohnender sind und Preis sowie erhaltene Münzen vor dem Verkauf sichtbar sind.

### UPG-04: Verbesserungen stufenweise ausbauen — P1/P2

- Jede Stufe erweitert einen bestehenden Nutzen, zum Beispiel mehr Trockenkapazität, eine neue Erkundungshilfe oder eine Abwehraktion mit dem Kräuterstab.
- Neue Stufen werden an passende Gebietsaufträge und Zutaten gebunden, nicht an Gegnergrind.
- Vor dem Kauf werden Kosten und Wirkung angezeigt.

**Fertig, wenn:** Verbesserungen sichtbar aufeinander aufbauen und jede Stufe eine neue Rezeptoption, Abkürzung oder Komfortverbesserung eröffnet.

### POST-01: Freien Ausbau nach der Hauptgeschichte anbieten — P2

- Auftragsbrett um wiederholbare Liefer-, Such- und Vertreibungsaufträge erweitern.
- Keine Fristen, Verderb oder Pflichtkämpfe einführen.
- Zusätzliche Belohnungen: Münzen, wiederverwendbare Alchemiezutaten, kosmetischer Dorfausbau und Rezeptvarianten.
- Optional einzelne Unterbereiche an bestehende Gebiete anbauen; jeder Abschnitt braucht eigene Landmarken, Ressourcen und Ziele.

**Fertig, wenn:** Nach Abschluss der fünf Hauptgebiete weitere sinnvolle Ziele bestehen und alle davon freiwillig bleiben.

## Reihenfolge der Gebietsfreischaltungen

| Schritt | Voraussetzung | Danach zugänglich |
| --- | --- | --- |
| Spielstart | keine | Dorfplatz, Apotheke, Schilfufer |
| 1 | Fenjas Beruhigungstee abgegeben | Alter Torfstich |
| 2 | Martens stärkenden Aufguss abgegeben | Quellsenke |
| 3 | Lenes Nachttrank abgegeben | Nebelhain |
| 4 | Je einen Auftrag in Quellsenke und Nebelhain erfüllt; Quellperle und Irrlichtstaub zu Lene gebracht | Versunkener Wurzelhain |

Die Reihenfolge verhindert, dass ein Auftrag eine noch gesperrte Ressource verlangt: Der Torfstich öffnet vor Lenes Nachtmoos-Aufgabe. Laterne und Sumpfstiefel erleichtern spätere Ausflüge, sind aber keine Zugangsvoraussetzung.

## Empfohlene Reihenfolge für den ersten Ausbau

1. SCALE-01 und MAP-01 bis MAP-03: Maßstab, Dorf, Wege und Grundkacheln.
2. REG-01 und REG-02: Schilfufer und Torfstich mit den bereits geplanten Ressourcen.
3. SYS-01 und SYS-02 sowie ENE-01: Fundstellen und zwei Startgegner.
4. COM-01 und ENE-03: Grundkampf sowie Drops und Trankrezepte der Startgegner.
5. PROG-01 und UPG-01: erster freigeschalteter Pfad und erste Verbesserung.
6. REG-03 und REG-04 samt Gegnern, Zutaten und COM-02.
7. REG-05, Kräuterbuch-Auftrag und die letzte Hauptverbesserung.
8. PROG-02 und POST-01: zusätzliche Rezepte, Gebietsschleifen und freiwillige Aufgaben nach der Hauptgeschichte.

## Gemeinsame Abnahmekriterien

- Jeder Pfad ist lesbar und verbindet sein Gebiet mit dem Dorf.
- Jedes Gebiet hat eigene Farben, Formen, Ressourcen und Gegner.
- Spieler verlieren bei Gegnerkontakt keine gesammelten Gegenstände.
- Jeder Sammelort bleibt nach dem ersten Besuch erneut interessant.
- Aufträge, neue Wege und Verbesserungen zeigen klar, was als Nächstes erreichbar ist.
- Die Welt bleibt ohne Verderb, knappe Fristen oder Pflichtkämpfe spielbar.
