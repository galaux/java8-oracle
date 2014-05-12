# Maintainer: Guillaume ALAUX <guillaume at alaux dot net>
pkgname=('jre8-oracle' 'jdk8-oracle')
#pkgname=('jre8-oracle-headless' 'jre8-oracle' 'jdk8-oracle')
pkgbase=java8-oracle
_java_ver=8
_minor=5
_build=b13
# FIXME pkgver to match Arch Linux JDK versioning scheme. Watch out for source
pkgver=${_java_ver}u${_minor}
pkgrel=1

arch=('i686' 'x86_64')
# FIXME '_JARCH'
if [ "${CARCH}" = 'x86_64' ]; then
  _JARCH=x64
  _JARCH_ALT=amd64
else
  _JARCH=i586
  _JARCH_ALT=i386
fi

url='http://www.oracle.com/technetwork/java/index.html'
license=('custom')
# TODO add support for i686
source=("http://download.oracle.com/otn-pub/java/jdk/${pkgver}-${_build}/jdk-${pkgver}-linux-${_JARCH}.tar.gz"
        'derby.conf'
        'derby.service'
        'java-mission-control.desktop'
        'java-monitoring-and-management-console.desktop'
        'java-policy-settings.desktop'
        'java-visualvm.desktop'
        'javaws-launcher'
        'jdk.csh'
        'jdk.sh')

sha256sums=('44901389e9fb118971534ad0f58558ba8c43f315b369117135bd6617ae631edc'
            'd6d69b7276e18459d1ee3a4a4ed8e5416a6ca0f7751b674776cc08a6bd0f0665'
            'de08c2eb2de1e00dbba2e8d86319a87af6897d67987a822df8eeba7993b53ec5'
            '00378bacf08dae0b66bd2162e8848a3b785b6e2b50b64f106063168b8675efec'
            '822863cab818dc0d5106975f2ad3209e8cbb6f93bd45920ea0488a0fc1c271c6'
            '13a0eab88c2ecdbfc705e972df865c318d1684bdd80c96b460f881dfc52d6316'
            'f97a54155ceed7f774dd27e25c2300a22e2a77ad46f202da4b108f3c329b4d2e'
            '5a43bf54553ea39c147a67935d68646806a5053fefd527bd69c546f4c884402e'
            '97b967904d6a1009a8e993df5cb9d9e663f14d700583ad1cb832205594db4018'
            'ebfbd8d12dfc5ce88a1e2970810319577e6a61ee926a8174ef782cf3a0c9aea4')

DLAGENTS=('http::/usr/bin/curl -LC - -b "oraclelicense=a" -O')

_jdkname=oracle8
_jvmdir=/usr/lib/jvm/java-8-oracle

package_jre8-oracle() {
  pkgdesc='Oracle Java 8 runtime environment'
  # FIXME jre dependencies
  depends=('java-runtime-headless-meta' 'java-runtime-meta' 'desktop-file-utils'
           'hicolor-icon-theme' 'libxrender' 'libxtst' 'shared-mime-info' 'xdg-utils')
  optdepends=('alsa-lib: sound'
              'ttf-dejavu: fonts')
  provides=('java-runtime-headless=8' 'java-runtime=8')
  _backup_etc=(etc/java-8-oracle/${_JARCH_ALT}/jvm.cfg
               etc/java-8-oracle/${_JARCH_ALT}/server/Xusage.txt
               etc/java-8-oracle/calendars.properties
               etc/java-8-oracle/content-types.properties
               etc/java-8-oracle/flavormap.properties
               etc/java-8-oracle/fontconfig.properties.src
               etc/java-8-oracle/hijrah-config-umalqura.properties
               etc/java-8-oracle/images/cursors/cursors.properties
               etc/java-8-oracle/javafx.properties
               etc/java-8-oracle/jvm.hprof.txt
               etc/java-8-oracle/logging.properties
               etc/java-8-oracle/management/jmxremote.access
               etc/java-8-oracle/management/jmxremote.password.template
               etc/java-8-oracle/management/management.properties
               etc/java-8-oracle/management/snmp.acl.template
               etc/java-8-oracle/net.properties
               etc/java-8-oracle/psfontj2d.properties
               etc/java-8-oracle/psfont.properties.ja
               etc/java-8-oracle/security/java.policy
               etc/java-8-oracle/security/java.security
               etc/java-8-oracle/security/javaws.policy
               etc/java-8-oracle/sound.properties)
  backup=(${_backup_etc[@]})
  install=install_jre8-oracle.sh

  # FIXME try to use vars for this versin number
  cd "${srcdir}/jdk1.8.0_05/jre"

  install -d -m 755 "${pkgdir}${_jvmdir}/jre/"
  cp -ra * "${pkgdir}${_jvmdir}/jre"

  install -d -m 755 ${pkgdir}/usr/share
  # FIXME sed desktop files so that they directly call /usr/lib/jvm/java-8-oracle/jre/bin/*
  mv ${pkgdir}${_jvmdir}/jre/lib/desktop/* ${pkgdir}/usr/share
  rmdir ${pkgdir}${_jvmdir}/jre/lib/desktop
  # TODO add extra icons and desktop entries

  # Set config files
  rm "${pkgdir}${_jvmdir}"/jre/lib/fontconfig.*.properties.src

  # TODO Remove 'non-headless' lib files
  #for f in ${_nonheadless[@]}; do
  #  rm "${pkgdir}${_jvmdir}/jre/${f}"
  #done

  # Man pages
  pushd bin
  install -d -m 755 "${pkgdir}"/usr/share/man/{,ja/}man1/
  for m in *; do
    # '|| true' because some man page do not exist for several binaries/links
    install -m 644 ../../man/man1/${m}.1    "${pkgdir}/usr/share/man/man1/${m}-${_jdkname}.1"    || true
    install -m 644 ../../man/ja/man1/${m}.1 "${pkgdir}/usr/share/man/ja/man1/${m}-${_jdkname}.1" || true
  done
  popd

  # FIXME Should we use Arch's certs?
  # Link JKS keystore from ca-certificates-java
  #rm -f "${pkgdir}${_jvmdir}/jre/lib/security/cacerts"
  #ln -sf /etc/ssl/certs/java/cacerts "${pkgdir}${_jvmdir}/jre/lib/security/cacerts"

  # Install license
  install -d -m 755 "${pkgdir}/usr/share/licenses/${pkgbase}/"
  install -m 644 COPYRIGHT LICENSE README THIRDPARTYLICENSEREADME{,-JAVAFX}.txt \
                 "${pkgdir}/usr/share/licenses/${pkgbase}"
  ln -sf /usr/share/licenses/${pkgbase} "${pkgdir}/usr/share/licenses/${pkgname}"

  # Link 'Oracle only' binaries into /usr/bin
  install -d -m755 "${pkgdir}/usr/bin/"
  for b in ControlPanel javawx jcontrol jjs; do
    ln -sf ${_jvmdir}/jre/bin/${b} "${pkgdir}/usr/bin"
  done

  # Move config files that were set in _backup_etc from ./lib to /etc
  for file in ${_backup_etc[@]}; do
    _filepkgpath=${_jvmdir}/jre/lib/${file#etc/java-8-oracle/}
    install -D -m 644 "${pkgdir}${_filepkgpath}" "${pkgdir}/${file}"
    ln -sf /${file} "${pkgdir}${_filepkgpath}"
  done
}

package_jdk8-oracle() {
  pkgdesc='Oracle Java 8 development kit'
  # FIXME jdk dependencies
  depends=('jre8-oracle')
  provides=('java-environment=8')
  # TODO backup=()
  # TODO install=

  cd "${srcdir}/jdk1.8.0_05"
  make DESTDIR="${pkgdir}/" install-pkg2
}
