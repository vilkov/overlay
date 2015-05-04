# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/quickaccess/quickaccess-0.8.2.ebuild,v 1.1 2012/01/22 22:16:51 johu Exp $

EAPI=5

KDE_LINGUAS="de es fr gl nl pt_BR sv tr zh_CN"
inherit kde4-base git-2

MY_PN="plasma-widget-${PN}"
MY_P="${MY_PN}-${PV}-2"

DESCRIPTION="KDE4 plasmoid. Designed for the panel, provides quick access to the most used folders"
HOMEPAGE="http://kde-look.org/content/show.php?content=134442"
#SRC_URI="http://kde-look.org/CONTENT/content-files/134442-${MY_P}.zip"
EGIT_REPO_URI="git://github.com/vilkov/plasma-widget-quickaccess.git https://vilkov@github.com/vilkov/plasma-widget-quickaccess.git"
EGIT_NOUNPACK="1"

LICENSE="GPL-3"
KEYWORDS="x86"
SLOT="4"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep plasma-workspace)
"

S="${WORKDIR}/${MY_P}"
EGIT_SOURCEDIR="${S}"

src_unpack() {
	git-2_src_unpack
}
