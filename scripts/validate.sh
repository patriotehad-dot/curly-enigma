#!/usr/bin/env bash
set -eu

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$ROOT_DIR/config/system.yaml"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Hata: sistem konfigürasyon dosyası bulunamadı: $CONFIG_FILE"
  exit 1
fi

required_keys=(
  "system:"
  "identity:"
  "state:"
  "environment:"
  "modules:"
  "permissions:"
  "security:"
)

for key in "${required_keys[@]}"; do
  if ! grep -q "$key" "$CONFIG_FILE"; then
    echo "Hata: gerekli anahtar eksik: $key"
    exit 1
  fi
done

if ! grep -q "title: Zombi" "$CONFIG_FILE"; then
  echo "Hata: sistem başlığı doğrulanamadı."
  exit 1
fi

if ! grep -q "status: active" "$CONFIG_FILE"; then
  echo "Hata: sistem durumu aktif değil."
  exit 1
fi

echo "Zombi sistemi başarıyla doğrulandı."
