#!/bin/bash

set -e  # Stop on error

NEW_HOSTNAME="arch"

echo "[+] Setting hostname to ..."
sudo hostnamectl set-hostname "$NEW_HOSTNAME"

echo "[+] Updating /etc/hostname..."
echo "$NEW_HOSTNAME" | sudo tee /etc/hostname > /dev/null

echo "[+] Patching /etc/hosts..."
sudo sed -i "s/127.0.1.1\s\+\S\+\s\+\S\+/127.0.1.1\t${NEW_HOSTNAME}.localdomain\t$NEW_HOSTNAME/" /etc/hosts || \
  echo -e "127.0.1.1\t${NEW_HOSTNAME}.localdomain\t$NEW_HOSTNAME" | sudo tee -a /etc/hosts > /dev/null

echo "[+] Dropping a surprise MOTD..."
echo "Never gonna give you up 🎶 — welcome to $NEW_HOSTNAME" | sudo tee /etc/motd > /dev/null

echo "[✔] All done! Reboot or re-login to see it take effect!"

