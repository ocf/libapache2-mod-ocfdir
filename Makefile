autotools:
	cd libapache2-mod-ocfdir && autoheader && autoconf && ./configure

builddeb: autotools autoversion
	cd libapache2-mod-ocfdir && dpkg-buildpackage -us -uc

clean:
	for f in `cat .gitignore`; do rm -rvf $$f; done

autoversion:
	date +%Y.%m.%d.%H.%M-git`git rev-list -n1 HEAD | cut -b1-8` > .version
	rm -f libapache2-mod-ocfdir/debian/changelog
	DEBFULLNAME="Open Computing Facility" DEBEMAIL="help@ocf.berkeley.edu" VISUAL=true \
		cd libapache2-mod-ocfdir && dch -v `sed s/-/+/g ../.version` -D stable --no-force-save-on-release \
		--create --package "libapache2-mod-ocfdir" "Package for Debian."
