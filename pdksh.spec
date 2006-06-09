#
# Conditional build:
%bcond_without	static	# don't build static version of (pd)ksh
#
Summary:	Public Domain Korn Shell
Summary(de):	Korn-Shell aus dem Public Domain
Summary(es):	Shell Korn de dominio público
Summary(fr):	Korn Shell du domaine public
Summary(pl):	Pow³oka Korna z Public Domain
Summary(pt_BR):	Shell Korn de domínio público
Summary(ru):	ó×ÏÂÏÄÎÁÑ ÒÅÁÌÉÚÁÃÉÑ ËÏÍÁÎÄÎÏÇÏ ÐÒÏÃÅÓÓÏÒÁ Korn shell (ksh)
Summary(tr):	Serbest Korn kabuðu
Summary(uk):	÷¦ÌÂÎÁ ÒÅÁÌ¦ÚÁÃ¦Ñ ËÏÍÁÎÄÎÏÇÏ ÐÒÏÃÅÓÏÒÁ Korn shell (ksh)
Name:		pdksh
Version:	5.2.14
Release:	43.1
License:	Mostly Public Domain with Free & GPL additions
Group:		Applications/Shells
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}.tar.gz
# Source0-md5:	871106b3bd937e1afba9f2ef7c43aef3
Source1:	ksh.1.pl
Source2:	%{name}-kshrc
Patch0:		%{name}-static.patch
Patch1:		%{name}-history.patch
Patch2:		ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}-patches.1
Patch3:		ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}-patches.2
Patch4:		%{name}-debian.patch
Patch5:		%{name}-EDITMODE.patch
Patch6:		%{name}-rlimit_locks.patch
Patch7:		%{name}-eval-segv.patch
Patch8:		%{name}-awful-free-bug.patch
Patch9:		%{name}-no_stop_alias.patch
Patch10:	%{name}-man_no_plusminus.patch
Patch11:	%{name}-circumflex.patch
Patch12:	%{name}-siglist-sort.patch
Patch13:	%{name}-hex.patch
Patch14:	%{name}-kshrc_support.patch
Patch15:	%{name}-ulimit-vmem.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
%{?with_static:BuildRequires:	glibc-static}
Requires(preun):	sed >= 4.1.5-1.2
Requires:	setup >= 2.4.6-2
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_exec_prefix		/
%define		_bindir			/bin

%description
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use. Its command
language is a superset of the sh(1) shell language.

%description -l de
pdksh, eine Neuimplementierung von ksh, ist ein Befehlsinterpreter für
interaktiven und Shell-Script-Betrieb. Die Befehlssprache ist eine
Übermenge der Shell-Sprache sh(1).

%description -l es
Pdksh, una ampliación más de ksh, es un interpretador de comandos
destinado tanto al uso interactivo como en shell scripts. Su lenguaje
de comandos es un superconjunto del lenguaje sh(1) shell.

%description -l fr
pdksh, un remplacement de ksh, est un interpréteur de commande qui est
à destiné à la fois à l'utilisation interactive et a l'utilisation de
scripts. Son langage de commande est un ensemble de commande du
langage shell de sh(1).

%description -l pl
Pdksh jest implementacj± pow³oki ksh. Komendy pdksh s± zgodne z
komendami pow³oki sh(1).

%description -l pt_BR
Pdksh, uma reimplementação de ksh, é um interpretador de comandos
destinado tanto para uso interativo como em shell scripts. Sua
linguagem de comandos é um superconjunto da linguagem sh(1) shell.

%description -l ru
pdksh, ÐÏ×ÔÏÒÎÁÑ ÒÅÁÌÉÚÁÃÉÑ ksh, - ÜÔÏ ËÏÍÁÎÄÎÙÊ ÐÒÏÃÅÓÓÏÒ,
ÒÁÓÓÞÉÔÁÎÎÙÊ ËÁË ÎÁ ÉÎÔÅÒÁËÔÉ×ÎÙÊ ÒÅÖÉÍ, ÔÁË É ÎÁ ÉÓÐÏÌØÚÏ×ÁÎÉÅ ×
ËÏÍÁÎÄÎÙÈ ÓËÒÉÐÔÁÈ. åÇÏ ËÏÍÁÎÄÎÙÊ ÑÚÙË ÐÒÅÄÓÔÁ×ÌÑÅÔ ÓÏÂÏÊ ÒÁÓÛÉÒÅÎÉÅ
ÑÚÙËÁ sh(1).

%description -l tr
pdksh, hem etkileþimli hem de kabuk programcýklarýnýn kullanýmý için
tasarlanmýþ bir komut yorumlayýcýsýdýr. pdksh'ýn komut dili sh(1)
kabuk dilinin bir kümesidir.

%description -l uk
pdksh, ×¦ÌØÎÁ ÒÅÁÌ¦ÚÁÃ¦Ñ ksh, - ÃÅ ËÏÍÁÎÄÎÉÊ ÐÒÏÃÅÓÏÒ, ÒÏÚÒÁÈÏ×ÁÎÉÊ ÑË
ÎÁ ¦ÎÔÅÒÁËÔÉ×ÎÉÊ ÒÅÖÉÍ, ÔÁË ¦ ÎÁ ×ÉËÏÒÉÓÔÁÎÎÑ × ËÏÍÁÎÄÎÉÈ ÓËÒÉÐÔÁÈ.
êÏÇÏ ÍÏ×Á ËÏÍÁÎÄ ¤ ÒÏÚÛÉÒÅÎÎÑÍ ÍÏ×É sh(1).

%package static
Summary:	Statically linked Public Domain Korn Shell
Summary(pl):	Skonsolidowana statycznie pow³oka Korna
Group:		Applications/Shells
Requires(preun):	sed >= 4.1.5-1.2
# requires base for /etc/kshrc?
Requires:	%{name} = %{version}-%{release}

%description static
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use. Its command
language is a superset of the sh(1) shell language.

This packege contains statically linked version of pdksh.

%description static -l pl
Pdksh jest implementacj± pow³oki ksh. Komendy pdksh s± zgodne z
komendami pow³oki sh(1).

W tym pakiecie jest pdksh skonsolidowany statycznie.

%prep
%setup  -q
%{?with_static:%patch0 -p0}
%patch1 -p1
%patch2 -p2
%patch3 -p0
%patch4 -p1
%patch5 -p1
%patch6 -p1
%patch7 -p1
%patch8 -p1
%patch9 -p1
%patch10 -p1
%patch11 -p1
%patch12 -p0
%patch13 -p1
%patch14 -p1
%patch15 -p1

%build
CFLAGS="%{rpmcflags} -D_FILE_OFFSET_BITS=64"
%configure2_13 \
	--enable-emacs \
	--enable-vi
%{__make}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install \
	exec_prefix=$RPM_BUILD_ROOT \
	mandir=$RPM_BUILD_ROOT%{_mandir}/man1

install -d $RPM_BUILD_ROOT{%{_mandir}/pl/man1,/etc}

echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/sh.1

install	%{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/ksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/sh.1

ln -sf ksh $RPM_BUILD_ROOT/bin/sh

install	%{SOURCE2} $RPM_BUILD_ROOT/etc/kshrc

%clean
rm -rf $RPM_BUILD_ROOT

%post
if [ ! -f /etc/shells ]; then
	umask 022
	echo "/bin/ksh" > /etc/shells
	echo "/bin/sh" >> /etc/shells
else
	while read SHNAME; do
		if [ "$SHNAME" = "/bin/ksh" ]; then
			HAS_KSH=1
		elif [ "$SHNAME" = "/bin/sh" ]; then
			HAS_SH=1
		fi
	done < /etc/shells
	[ -n "$HAS_KSH" ] || echo "/bin/ksh" >> /etc/shells
	[ -n "$HAS_SH" ] || echo "/bin/sh" >> /etc/shells
fi

%preun
if [ "$1" = "0" ]; then
	%{__sed} -i -e '
		/^\/bin\/ksh$/d
		/^\/bin\/sh$/d
	' /etc/shells
fi

%post static
if [ ! -f /etc/shells ]; then
	umask 022
	echo "/bin/ksh.static" > /etc/shells
else
	while read SHNAME; do
	if [ "$SHNAME" = "/bin/ksh.static" ]; then
		HAS_KSH_STATIC=1
	fi
	done < /etc/shells
	[ -n "$HAS_KSH_STATIC" ] || echo "/bin/ksh.static" >> /etc/shells
fi

%preun static
if [ "$1" = "0" ]; then
	%{__sed} -i -e '
		/^\/bin\/ksh\.static$/d
	' /etc/shells
fi

%files
%defattr(644,root,root,755)
%doc README NEWS BUG-REPORTS LEGAL
%config(noreplace,missingok) %verify(not md5 mtime size) /etc/kshrc
%attr(755,root,root) %{_bindir}/ksh
%attr(755,root,root) %{_bindir}/sh
%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*

%if %{with static}
%files static
%defattr(644,root,root,755)
%attr(755,root,root) %{_bindir}/ksh.static
%endif
