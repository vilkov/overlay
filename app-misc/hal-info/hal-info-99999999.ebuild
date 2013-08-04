# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/hal-info-20091130.ebuild,v 1.3 2011/03/19 12:57:09 ssuominen Exp $

EAPI="2"

inherit autotools git-2


DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
EGIT_REPO_URI="http://cgit.freedesktop.org/hal-info"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

RDEPEND=">=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"


src_prepare() {
	eautoreconf
}

src_configure() {
	econf || die "Configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
