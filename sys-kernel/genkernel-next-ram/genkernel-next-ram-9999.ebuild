# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel-next/genkernel-next-55.ebuild,v 1.4 2014/07/06 12:59:19 ssuominen Exp $

EAPI=5

EGIT_REPO_URI="https://github.com/vilkov/genkernel-next"
inherit git-2

inherit bash-completion-r1 eutils

KEYWORDS="amd64 ~arm ~ia64 x86"

DESCRIPTION="Gentoo automatic kernel building scripts, reloaded"
HOMEPAGE="https://github.com/vilkov/overlay"

LICENSE="GPL-2"
SLOT="0"
RESTRICT=""
IUSE="cryptsetup dmraid gpg iscsi plymouth selinux"

DEPEND="app-text/asciidoc
	sys-fs/e2fsprogs
	!sys-fs/eudev[-kmod,modutils]
	selinux? ( sys-libs/libselinux )"
RDEPEND="${DEPEND}
	!sys-kernel/genkernel
	!sys-kernel/genkernel-next
	cryptsetup? ( sys-fs/cryptsetup )
	dmraid? ( >=sys-fs/dmraid-1.0.0_rc16 )
	gpg? ( app-crypt/gnupg )
	iscsi? ( sys-block/open-iscsi )
	plymouth? ( sys-boot/plymouth )
	app-portage/portage-utils
	app-arch/cpio
	>=app-misc/pax-utils-0.6
	!<sys-apps/openrc-0.9.9
	sys-apps/util-linux
	sys-block/thin-provisioning-tools
	sys-fs/lvm2"

src_prepare() {
	sed -i "/^GK_V=/ s:GK_V=.*:GK_V=${PV}:g" "${S}/genkernel" || \
		die "Could not setup release"

	epatch_user
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	doman "${S}"/genkernel.8 || die "doman"
	dodoc "${S}"/AUTHORS || die "dodoc"

	newbashcomp "${S}"/genkernel.bash "${PN}"
}
