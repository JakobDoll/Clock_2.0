#!/bin/bash

# Setup-Script für Clock 2.0 ESPHome-Projekt

echo "=== Clock 2.0 ESPHome Setup ==="
echo

# Prüfe ob Python verfügbar ist
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 ist nicht installiert!"
    exit 1
fi

# Prüfe virtuelle Umgebung
if [ ! -d ".venv" ]; then
    echo "🔧 Erstelle virtuelle Python-Umgebung..."
    python3 -m venv .venv
fi

# Aktiviere virtuelle Umgebung
echo "🔧 Aktiviere virtuelle Umgebung..."
source .venv/bin/activate

# Installiere Abhängigkeiten
echo "📦 Installiere Python-Pakete..."
pip install --upgrade pip
pip install -r requirements.txt

echo
echo "✅ Setup abgeschlossen!"
echo
echo "Nächste Schritte:"
echo "1. WiFi-Zugangsdaten in clock.yaml oder secrets.yaml anpassen"
echo "2. ESP8266 per USB anschließen"
echo "3. In VSCode: Ctrl+Shift+P -> 'Tasks: Run Build Task' für Kompilierung"
echo "4. In VSCode: Ctrl+Shift+P -> 'Tasks: Run Task' -> 'ESPHome: Upload' für Upload"
echo
echo "Verfügbare Kommandos:"
echo "  .venv/bin/esphome config clock.yaml      # Konfiguration prüfen"
echo "  .venv/bin/esphome compile clock.yaml     # Kompilieren"
echo "  .venv/bin/esphome upload clock.yaml      # Per USB hochladen"
echo "  .venv/bin/esphome logs clock.yaml        # Live-Logs anzeigen"
echo
