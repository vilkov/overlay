# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: This ebuild is from dav overlay $

EAPI="4"

inherit eutils rpm

DESCRIPTION="SafeNet (Aladdin) eToken Middleware for eTokenPRO, eTokenNG OTP, eTokenNG Flash, eToken Pro (Java)"

MY_PN="SafenetAuthenticationClient"
MY_PV="${PV}.0-4"
MY_P_86="${MY_PN}-${MY_PV}.i386.rpm"
MY_P_64="${MY_PN}-${MY_PV}.x86_64.rpm"
MY_COMPAT_P="SAC-32-CompatibilityPack-${MY_PV}.x86_64.rpm"

SRC_URI="x86? ( ${MY_P_86} )
	amd64? ( ${MY_P_64} ${MY_COMPAT_P} )"

HOMEPAGE="http://www.etokenonlinux.org"
LICENSE="EULA"
RESTRICT="fetch"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
FEATURES="-collision-protect"

IUSE="multilib"
REQUIRED_USE="amd64? ( multilib )"

RDEPEND=">=sys-apps/pcsc-lite-1.4.99
	net-dialup/ppp[eap-tls]
	virtual/libusb
	sys-apps/dbus
	dev-libs/engine_pkcs11
	>=sys-apps/hal-0.5.14"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"
QA_SONAME_NO_SYMLINK="usr/lib32/.* usr/lib64/.*"

S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please send mail to Aladdin eToken TS <support.etoken@aladdin-rd.ru> and"
	einfo "ask them to provide a ${PV} version of eToken driver. Then put RPMs from"
	einfo "archive, they emailed to you, into ${DISTDIR} ( cp ${A} ${DISTDIR} )"
}

src_unpack() {
	rpm_src_unpack ${A}

	#use x86 && ( cat "${FILESDIR}/dist/libhal_x86.txz" | tar xJf - )
	#use amd64 && ( cat "${FILESDIR}/dist/libhal_amd64_lib32.txz" | tar xJf - )
	#use amd64 && ( cat "${FILESDIR}/dist/libhal_amd64_lib64.txz" | tar xJf - )
	use amd64 && ( cat "${FILESDIR}/dist/pcsc_amd64.txz" | tar xJf - )
}

src_install()
{
	if use amd64; then
		dodir lib
		dodir lib32
		dodir lib64
		dodir usr/lib
		dodir usr/lib32
		dodir usr/lib64
								
    	cp "${S}"/lib/libeToken.so.8.1 "${D}"/lib32/libeToken.so.8.1
    	dosym /lib32/libeToken.so.8.1 /lib32/libeToken.so.8
	   	
    	cp "${S}"/lib64/libeToken.so.8.1 "${D}"/lib64/libeToken.so.8.1
    	dosym /lib64/libeToken.so.8.1 /lib64/libeToken.so.8
	   	
	   	dosym /lib32/libeToken.so.8.1 /usr/lib32/libeTPkcs11.so
	   	dosym /lib64/libeToken.so.8.1 /usr/lib64/libeTPkcs11.so
    	    	    	    	
    	#cp "${S}"/usr/lib32/libhal.so.1.0.0 "${D}"/usr/lib32/libhal.so.1.0.0
    	#dosym /usr/lib32/libhal.so.1.0.0 /usr/lib32/libhal.so.1

    	#cp "${S}"/usr/lib64/libhal.so.1.0.0 "${D}"/usr/lib64/libhal.so.1.0.0
    	#dosym /usr/lib64/libhal.so.1.0.0 /usr/lib64/libhal.so.1

    	#cp "${S}"/usr/lib32/libpcsclite.so.1.0.0 "${D}"/usr/lib/libpcsclite.so.1.0.0
    	#dosym /usr/lib/libpcsclite.so.1.0.0 /usr/lib/libpcsclite.so.1

		dodir usr/lib/readers/usb
    	cp -R "${S}"/usr/share/eToken/drivers/* "${D}"/usr/lib/readers/usb/
    	cp "${S}"/usr/share/eToken/drivers/aks-ifdh.bundle/Contents/Linux/libAksIfdh.so.8.1 "${D}"/usr/lib/readers/usb/aks-ifdh.bundle/Contents/Linux/libAksIfdh.so
	else
		into /
	  	dolib.so lib/libeToken.so.8.1
	   	dosym /lib/libeToken.so.8.1 /lib/libeToken.so.8
	   	dosym /lib/libeToken.so.8.1 /usr/lib/libeTPkcs11.so

		#into /usr
	  	#dolib.so usr/lib/libhal.so.1.0.0
	   	#dosym /usr/lib/libhal.so.1.0.0 /usr/lib/libhal.so.1

		dodir usr/lib/readers/usb
    	cp -R "${S}"/usr/share/eToken/drivers/* "${D}"/usr/lib/readers/usb/
    	cp "${S}"/usr/share/eToken/drivers/aks-ifdh.bundle/Contents/Linux/libAksIfdh.so.8.1 "${D}"/usr/lib/readers/usb/aks-ifdh.bundle/Contents/Linux/libAksIfdh.so
	fi

    dodir usr/share/doc/eToken
    cp "${S}"/usr/share/doc/eToken/LICENSE.txt "${D}"/usr/share/doc/eToken/LICENSE.txt
    cp "${S}"/usr/share/doc/eToken/version "${D}"/usr/share/doc/eToken/version

    dodir var/cache/eToken
}
