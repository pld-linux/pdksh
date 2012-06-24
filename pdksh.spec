Summary:	Public Domain Korn Shell
Summary(de):	Korn-Shell aus dem Public Domain
Summary(fr):	Korn Shell du domaine public.
Summary(pl):	Sell Korna z Public Domain
Summary(tr):	Serbest Korn kabu�u
Name:		pdksh
Version:	5.2.13.7
Release:	1
Copyright:	Public Domain
Group:		Shells
Group(pl):	Pow�oki
Source:		ftp://ftp.cs.mun.ca:/pub/%{name}/%{name}-unstable-%{version}.tar.gz
Patch:		pdksh-8bit.patch
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
%patch -p1

%build
CFLAGS="$RPM_OPT_FLAGS" LDFLAGS="-s" \
./configure \
	--prefix=/ \
	--mandir=/usr/man/man1 \
	--enable-emacs \
	--enable-vi

make

%install
rm -rf $RPM_BUILD_ROOT

make install \
	prefix=$RPM_BUILD_ROOT/ \
	mandir=$RPM_BUILD_ROOT/usr/man/man1

echo .so ksh.1 > $RPM_BUILD_ROOT/usr/man/man1/pdksh.1

gzip -9nf $RPM_BUILD_ROOT/usr/man/man1/*
bzip2 -9 {README,NEWS,BUG-REPORTS}

%post
(cat /etc/shells; echo "/bin/ksh" ) | sort -u > /etc/shells

%postun
cat /etc/shells | grep -v "/bin/ksh"  > /etc/shells.new

%verifyscript
echo -n "Looking for ksh in /etc/shells... "
if ! grep '^/bin/ksh$' /etc/shells > /dev/null; then
    echo "missing"
    echo "ksh missing from /etc/shells" >&2
else
    echo "found"
fi

%files
%defattr(644,root,root,755)
%doc {README,NEWS,BUG-REPORTS}.bz2

%attr(755,root,root) /bin/*

/usr/man/man1/*

%clean
rm -rf $RPM_BUILD_ROOT

%changelog
* Wed Feb 24 1999 Tomasz K�oczko <kloczek@rudy.mif.pg.gda.pl>
  [5.2.13.7-1]
- added gzipping man pages,
- removed man group from man pages,
- added --enable-emacs, --enable-vi to configure parameters,
- added LDFLAGS="-s" to configure enviroment,
- removed /usr/bin/* symlinks,
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
- build agains glibc-2.1.

* Mon Apr 27 1998 Prospector System <bugs@redhat.com>
- translations modified for de, fr, tr

* Wed Oct 21 1997 Cristian Gafton <gafton@redhat.com>
- fixed the spec file

* Fri Jul 18 1997 Erik Troan <ewt@redhat.com>
- built against glibc
