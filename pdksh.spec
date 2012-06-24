Summary:	Public Domain Korn Shell
Summary(de):	Korn-Shell aus dem Public Domain
Summary(fr):	Korn Shell du domaine public.
Summary(pl):	Sell Korna z Public Domain
Summary(tr):	Serbest Korn kabu�u
Name:		pdksh
Version:	5.2.13.9
Release:	3
Copyright:	Public Domain
Group:		Shells
Group(pl):	Pow�oki
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-unstable-%{version}.tar.gz
Source1:	ksh.1.pl
Patch0:		pdksh-8bit.patch
Patch1:		pdksh-alloc.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
Buildroot:	/tmp/%{name}-%{version}-root

%description
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use.  Its command
language is a superset of the sh(1) shell language.

%description -l de
pdksh, eine Neuimplementierung von ksh, ist ein Befehlsinterpreter f�r
interaktiven und Shell-Script-Betrieb. Die Befehlssprache ist eine
�bermenge der Shell-Sprache sh(1).

%description -l fr
pdksh, un remplacement de ksh, est un interpr�teur de commande qui est
� destin� � la fois � l'utilisation interactive et a l'utilisation de
scripts. Son langage de commande est un ensemble de commande du langage
shell de sh(1).

%description -l pl
Pdksh jest implementacj� shella ksh. Komendy pdksh s� zgodne z komendami
shella sh(1).

%description -l tr
pdksh, hem etkile�imli hem de kabuk programc�klar�n�n kullan�m� i�in
tasarlanm�� bir komut yorumlay�c�s�d�r. pdksh'�n komut dili sh(1) kabuk
dilinin bir k�mesidir.

%prep
%setup -q -n %{name}-unstable-%{version}
%patch0 -p1
%patch1 -p1

%build
autoconf
CFLAGS="$RPM_OPT_FLAGS" LDFLAGS="-s" \
    ./configure \
	--prefix=/ \
	--mandir=%{_mandir}/man1 \
	--enable-emacs \
	--enable-vi %{_target_platform}
make

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT%{_mandir}/pl/man1
install -d $RPM_BUILD_ROOT/etc

make install \
	prefix=$RPM_BUILD_ROOT/ \
	mandir=$RPM_BUILD_ROOT%{_mandir}/man1

echo .so ksh.1 > $RPM_BUILD_ROOT%{_mandir}/man1/pdksh.1
echo .so ksh.1 > $RPM_BUILD_ROOT%{_mandir}/man1/sh.1

install	%{SOURCE1}		$RPM_BUILD_ROOT%{_mandir}/pl/man1/ksh.1
echo	.so ksh.1	>	$RPM_BUILD_ROOT%{_mandir}/pl/man1/pdksh.1
echo	.so ksh.1	>	$RPM_BUILD_ROOT%{_mandir}/pl/man1/sh.1
install etc/ksh.*		$RPM_BUILD_ROOT/etc

ln -s ksh $RPM_BUILD_ROOT/bin/sh

gzip -9nf $RPM_BUILD_ROOT%{_mandir}/{man1/*,pl/man1/*} \
	README NEWS BUG-REPORTS

%post
if [ ! -f /etc/shells ]; then
	echo "/bin/ksh" > /etc/shells
	echo "/bin/sh" >> /etc/shells
else
	if ! grep '^/bin/ksh$' /etc/shells > /dev/null; then
		echo "/bin/sh" >> /etc/shells
	fi
	if ! grep '^/bin/sh$' /etc/shells > /dev/null; then
		echo "/bin/sh" >> /etc/shells
	fi
fi

%postun
if [ $1 = 0 ]; then
	grep -v /bin/ksh /etc/shells | grep -v /bin/sh > /etc/shells.new
	mv /etc/shells.new /etc/shells
fi

%files
%defattr(644,root,root,755)
%doc {README,NEWS,BUG-REPORTS}.gz

%attr(755,root,root) /bin/*
/etc/*

%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*

%clean
rm -rf $RPM_BUILD_ROOT

%changelog
* Sat May 29 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.9-2]
- more rpm macros,
- added pl man page for ksh(1).

* Sun May  9 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.9-1]
- now package is FHS 2.0 compliant.

* Sun May  2 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.8-1]
- fixed memory allocation bug by Marcin Danecki (pdksh-alloc.patch).

* Fri Mar  5 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.7-2]
- added symlink ksh -> /bin/sh.

* Wed Feb 24 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.7-1]
- removed man group from man pages,
- added --enable-emacs, --enable-vi to configure parameters,
- added LDFLAGS="-s" to configure enviroment,
- removed %{_bindir}/* symlinks,
- added gzipping man pages,
- added bzipping2 %doc,
- added URL,
- added Group(pl),
- simplified %post, %postun.

* Wed Oct 07 1998 Wojtek �lusarczyk <wojtek@shadow.eu.org>
  [5.2.12-3d]
- translation modified for pl,
- build from non root's account,
- major changes of the spec file
  (PLD spec file standard).

* Thu Jul 23 1998 Wojtek �lusarczyk <wojtek@shadow.eu.org>
  [5.2.12-3]
- build agains glibc-2.1,
- start at RH spec file.
