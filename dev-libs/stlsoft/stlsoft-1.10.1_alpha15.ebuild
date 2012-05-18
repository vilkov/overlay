# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Robust, Lightweight, Cross-platform, Template Software."
HOMEPAGE="http://www.stlsoft.org/"
SRC_URI="mirror://sourceforge/stlsoft/stlsoft-1.10-alpha-15-delta.zip"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="1.10"
KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""

src_install() {
	default
	insinto /usr
	doins -r include/
}
