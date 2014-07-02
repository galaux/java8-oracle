update_desktop() {
  echo 'Updating desktop MIME database'
  update-desktop-database -q

  echo 'Updating MIME database'
  update-mime-database /usr/share/mime >/dev/null

  echo 'Updating icon cache'
  xdg-icon-resource forceupdate &>/dev/null
  xdg-icon-resource forceupdate --theme HighContrast &>/dev/null || true
  xdg-icon-resource forceupdate --theme HighContrastInverse &>/dev/null || true
  xdg-icon-resource forceupdate --theme LowContrast &>/dev/null || true
}

post_install() {
  /usr/bin/archlinux-java --try-unset java-8-oracle/jre
  /usr/bin/archlinux-java --try-set   java-8-oracle

  update_desktop
}

post_upgrade() {
  post_install "$@"
}

post_remove() {
  /usr/bin/archlinux-java --try-unset java-8-oracle
  /usr/bin/archlinux-java --try-set   java-8-oracle/jre

  update_desktop
}
