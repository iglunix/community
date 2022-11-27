pkgname=shared-mime-info
pkgver=2.2

fetch() {
	curl -L "https://gitlab.freedesktop.org/xdg/$pkgname/-/archive/$pkgver/$pkgname-$pkgver.tar.bz2" -o $pkgname-$pkgver.tar.bz2
	tar -xf $pkgname-$pkgver.tar.bz2
	mkdir $pkgname-$pkgver/_build
}

build() {
	cd $pkgname-$pkgver
	cd _build
	meson .. \
		--buildtype=release \
		--prefix=/usr \
		--libexecdir=lib
	samu
}

package() {
	cd $pkgname-$pkgver
	cd _build
	DESTDIR=$pkgdir samu install
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat COPYING
}
