#m Star
pkgname=gtk
_pkgver=4.7
pkgver=$_pkgver.0

fetch() {
	curl -L "https://download.gnome.org/sources/$pkgname/$_pkgver/$pkgname-$pkgver.tar.xz" -o $pkgname-$pkgver.tar.xz
	tar -xf $pkgname-$pkgver.tar.xz
	mkdir -p $pkgname-$pkgver/_build
	cd $pkgname-$pkgver
	patch -p1 < ../../fix-llvm-build.patch

}

build() {
	cd $pkgname-$pkgver
	meson _build \
		--buildtype=release \
		--prefix=/usr \
		--libexecdir=lib \
		--localstatedir=/var \
		-Dbroadway-backend=false \
		-Dx11-backend=false \
		-Dwayland-backend=true \
		-Dwin32-backend=false \
		-Dcolord=disabled \
		-Ddemos=false \
		-Dgtk_doc=false \
		-Dintrospection=disabled \
		-Dbuild-tests=false \
		-Dbuild-examples=false \
		-Dmedia-gstreamer=disabled \
		-Dvulkan=enabled \
		-Dmedia-ffmpeg=enabled \
		-Dgi-docgen:development_tests=false
		
	samu -C _build
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
