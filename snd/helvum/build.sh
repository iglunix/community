#m Star
pkgname=helvum
pkgver=0.3.4

_clear_vendor_checksums() {
	sed -i 's/\("files":{\)[^}]*/\1/' vendor/$1/.cargo-checksum.json
}

fetch() {
	curl -L "https://gitlab.freedesktop.org/pipewire/$pkgname/-/archive/$pkgver/$pkgname-$pkgver.tar.bz2" -o $pkgname-$pkgver.tar.bz2
	tar -xf $pkgname-$pkgver.tar.bz2
	cd $pkgname-$pkgver
	mkdir -p .cargo
	cargo vendor > .cargo/config
}

build() {
	cd $pkgname-$pkgver
	cargo build --release --locked --all-features
}

package() {
	cd $pkgname-$pkgver
	install -Dm755 target/release/$pkgname $pkgdir/usr/bin/$pkgname
}

backup() {
	return
}

license() {
	cd $pkgname-$pkgver
	cat LICENSE
}
