# Note:
# - pdksh is maintained in OpenBSD at http://www.openbsd.org/cgi-bin/cvsweb/src/bin/ksh/
# - PLD Th uses mksh instead
#
# Conditional build:
%bcond_without	static	# don't build static version of (pd)ksh

Summary:	Public Domain Korn Shell
Summary(de.UTF-8):	Korn-Shell aus dem Public Domain
Summary(es.UTF-8):	Shell Korn de dominio público
Summary(fr.UTF-8):	Korn Shell du domaine public
Summary(pl.UTF-8):	Powłoka Korna z Public Domain
Summary(pt_BR.UTF-8):	Shell Korn de domínio público
Summary(ru.UTF-8):	Свободная реализация командного процессора Korn shell (ksh)
Summary(tr.UTF-8):	Serbest Korn kabuğu
Summary(uk.UTF-8):	Вілбна реалізація командного процесора Korn shell (ksh)
Name:		pdksh
Version:	5.2.14
Release:	58
License:	Mostly Public Domain with Free & GPL additions
Group:		Applications/Shells
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}.tar.gz
# Source0-md5:	871106b3bd937e1afba9f2ef7c43aef3
Source1:	ksh.1.pl
Source2:	%{name}-kshrc
Patch0:		%{name}-static.patch
Patch1:		%{name}-debian.patch
Patch2:		%{name}-tablesize.patch
Patch3:		%{name}-memcpy.patch
Patch4:		%{name}-history.patch
Patch5:		%{name}-defer-unalias.patch
Patch9:		%{name}-no_stop_alias.patch
Patch10:	%{name}-man_no_plusminus.patch
Patch11:	%{name}-circumflex.patch
Patch12:	%{name}-siglist-sort.patch
Patch13:	%{name}-hex.patch
Patch14:	%{name}-kshrc_support.patch
Patch15:	%{name}-openbsd.patch
Patch16:	%{name}-empty-for-loop.patch
Patch17:	%{name}-format.patch
Patch18:	%{name}-eval-var-expansion.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
%{?with_static:BuildRequires:	glibc-static}
BuildRequires:	rpmbuild(macros) >= 1.462
# is needed for /etc directory existence
Requires(pre):	FHS
Requires:	setup >= 2.4.6-2
Obsoletes:	mksh
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_exec_prefix		/
%define		_bindir			/bin

%description
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use. Its command
language is a superset of the sh(1) shell language.

%description -l de.UTF-8
pdksh, eine Neuimplementierung von ksh, ist ein Befehlsinterpreter für
interaktiven und Shell-Script-Betrieb. Die Befehlssprache ist eine
Übermenge der Shell-Sprache sh(1).

%description -l es.UTF-8
Pdksh, una ampliación más de ksh, es un interpretador de comandos
destinado tanto al uso interactivo como en shell scripts. Su lenguaje
de comandos es un superconjunto del lenguaje sh(1) shell.

%description -l fr.UTF-8
pdksh, un remplacement de ksh, est un interpréteur de commande qui est
à destiné à la fois à l'utilisation interactive et a l'utilisation de
scripts. Son langage de commande est un ensemble de commande du
langage shell de sh(1).

%description -l pl.UTF-8
Pdksh jest implementacją powłoki ksh. Komendy pdksh są zgodne z
komendami powłoki sh(1).

%description -l pt_BR.UTF-8
Pdksh, uma reimplementação de ksh, é um interpretador de comandos
destinado tanto para uso interativo como em shell scripts. Sua
linguagem de comandos é um superconjunto da linguagem sh(1) shell.

%description -l ru.UTF-8
pdksh, повторная реализация ksh, - это командный процессор,
рассчитанный как на интерактивный режим, так и на использование в
командных скриптах. Его командный язык представляет собой расширение
языка sh(1).

%description -l tr.UTF-8
pdksh, hem etkileşimli hem de kabuk programcıklarının kullanımı için
tasarlanmış bir komut yorumlayıcısıdır. pdksh'ın komut dili sh(1)
kabuk dilinin bir kümesidir.

%description -l uk.UTF-8
pdksh, вільна реалізація ksh, - це командний процесор, розрахований як
на інтерактивний режим, так і на використання в командних скриптах.
Його мова команд є розширенням мови sh(1).

%package static
Summary:	Statically linked Public Domain Korn Shell
Summary(pl.UTF-8):	Skonsolidowana statycznie powłoka Korna
Group:		Applications/Shells
# requires base for /etc/kshrc?
Requires:	%{name} = %{version}-%{release}

%description static
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use. Its command
language is a superset of the sh(1) shell language.

This packege contains statically linked version of pdksh.

%description static -l pl.UTF-8
Pdksh jest implementacją powłoki ksh. Komendy pdksh są zgodne z
komendami powłoki sh(1).

W tym pakiecie jest pdksh skonsolidowany statycznie.

%prep
%setup -q
%{?with_static:%patch0 -p0}
%patch -P1 -p1
%patch -P2 -p1
%patch -P3 -p1
%patch -P4 -p1
%patch -P5 -p1
%patch -P9 -p1
%patch -P11 -p1
%patch -P13 -p1
%patch -P14 -p1
%patch -P15 -p1
%patch -P16 -p1
%patch -P17 -p1
%patch -P18 -p3

%build
CFLAGS="%{rpmcflags} -D_FILE_OFFSET_BITS=64 -DDEBIAN=1"
LDFLAGS="%{rpmcflags} %{rpmldflags}"
%configure2_13 \
	--enable-emacs \
	--enable-vi
%{__make} \
	CPP="%{__cc} -E -P"

%install
rm -rf $RPM_BUILD_ROOT

%{__make} install \
	exec_prefix=$RPM_BUILD_ROOT \
	mandir=$RPM_BUILD_ROOT%{_mandir}/man1

install -d $RPM_BUILD_ROOT{%{_mandir}/pl/man1,/etc}

echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/sh.1

cp -p %{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/ksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/sh.1

ln -s ksh $RPM_BUILD_ROOT/bin/sh
cp -p %{SOURCE2} $RPM_BUILD_ROOT/etc/kshrc

%clean
rm -rf $RPM_BUILD_ROOT

%post	-p %add_etc_shells -p /bin/sh /bin/ksh
%preun	-p %remove_etc_shells -p /bin/sh /bin/ksh

%post	static -p %add_etc_shells -p /bin/ksh.static
%preun	static -p %remove_etc_shells -p /bin/ksh.static

%triggerpostun -p <lua> -- mksh
if arg[2] ~= 0 then
%lua_add_etc_shells /bin/sh /bin/ksh
end

%files
%defattr(644,root,root,755)
%doc README NEWS BUG-REPORTS LEGAL
%config(noreplace,missingok) %verify(not md5 mtime size) /etc/kshrc
%attr(755,root,root) %{_bindir}/ksh
%attr(755,root,root) %{_bindir}/sh
%{_mandir}/man1/ksh.1*
%{_mandir}/man1/pdksh.1
%{_mandir}/man1/sh.1
%lang(pl) %{_mandir}/pl/man1/ksh.1*
%lang(pl) %{_mandir}/pl/man1/pdksh.1
%lang(pl) %{_mandir}/pl/man1/sh.1

%if %{with static}
%files static
%defattr(644,root,root,755)
%attr(755,root,root) %{_bindir}/ksh.static
%endif
