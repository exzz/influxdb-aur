# Maintainer: Nicolas Leclercq <nicolas.private@gmail.com>
pkgname=influxdb
pkgver=0.5.0_rc.5
pkgrel=1
epoch=
pkgdesc='Scalable datastore for metrics, events, and real-time analytics'
arch=('i686' 'x86_64')
url='http://influxdb.org/'
license=('MIT')
groups=()
depends=('snappy' 'leveldb')
makedepends=('wget' 'protobuf' 'bison' 'flex' 'go')
checkdepends=()
optdepends=()
provides=('influxdb')
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=("http://s3.amazonaws.com/influxdb/$pkgname-${pkgver//_/-}.src.tar.gz"
        'influxdb.service'
        'influxdb.install')
noextract=()
md5sums=('dec088e9cbb5abecce23524129778d21'
         'b9f2ad83e58119bd022b8136379dc62d'
         '6b2d8446592d11345b6c262c2ff4d480')

build() {
  cd "$srcdir/$pkgname"
  export GOPATH="$srcdir/$pkgname"
  ./configure --prefix=/usr
  make protobuf parser
  go build daemon
}

check() {
  cd "$srcdir/$pkgname"
  ./daemon -v
}

package() {
  # create user/group, home directory, log file
  install=influxdb.install

  # systemctl service file
  install -D -m644  'influxdb.service' "$pkgdir/usr/lib/systemd/system/influxdb.service"

  cd "$srcdir/$pkgname"

  # influxdb binary
  install -D -m755 'daemon' "$pkgdir/usr/bin/$pkgname"

  # admin console assets
  install -d "$pkgdir/usr/share/$pkgname"
  cp -r admin "$pkgdir/usr/share/$pkgname"

  # configuration file
  sed -i 's/\/tmp\/influxdb\/development\/db/\/var\/lib\/influxdb\/data/g' config.toml.sample
  sed -i 's/\/tmp\/influxdb\/development\/raft/\/var\/lib\/influxdb\/raft/g' config.toml.sample
  sed -i 's/\/tmp\/influxdb\/development\/wal/\/var\/lib\/influxdb\/wal/g' config.toml.sample
  sed -i 's/influxdb.log/\/var\/log\/influxdb\/influxdb.log/g' config.toml.sample
  sed -i 's/.\/admin/\/usr\/share\/influxdb\/admin/g' config.toml.sample
  install -D -m644 'config.toml.sample' "$pkgdir/etc/$pkgname.conf"

  # license
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
