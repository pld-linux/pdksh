Summary:	Public Domain Korn Shell
Summary(de):	Korn-Shell aus dem Public Domain
Summary(fr):	Korn Shell du domaine public.
Summary(pl):	Sell Korna z Public Domain
Summary(tr):	Serbest Korn kabuðu
Name:		pdksh
Version:	5.2.14
Release:	1
Copyright:	Public Domain
Group:		Shells
Group(pl):	Pow³oki
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}.tar.gz
Source1:	ksh.1.pl
Patch0:		pdksh-static.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
Buildroot:	/tmp/%{name}-%{version}-root

%define		_exec_prefix		/

%description
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use.  Its command
language is a superset of the sh(1) shell language.

%description -l de
pdksh, eine Neuimplementierung von ksh, ist ein Befehlsinterpreter für
interaktiven und Shell-Script-Betrieb. Die Befehlssprache ist eine
Übermenge der Shell-Sprache sh(1).

%description -l fr
pdksh, un remplacement de ksh, est un interpréteur de commande qui est
à destiné à la fois à l'utilisation interactive et a l'utilisation de
scripts. Son langage de commande est un ensemble de commande du langage
shell de sh(1).

%description -l pl
Pdksh jest implementacj± shella ksh. Komendy pdksh s± zgodne z komendami
shella sh(1).

%description -l tr
pdksh, hem etkileþimli hem de kabuk programcýklarýnýn kullanýmý için
tasarlanmýþ bir komut yorumlayýcýsýdýr. pdksh'ýn komut dili sh(1) kabuk
dilinin bir kümesidir.

%package static
Summary:	Staticly linked Public Domain Korn Shell
Group:		Shells
Group(pl):	Pow³oki
Requires:	%{name}

%description static
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use.  Its command
language is a superset of the sh(1) shell language.

This packege contains staticly linked version of pdksh.

%description static -l pl
Pdksh jest implementacj± shella ksh. Komendy pdksh s± zgodne z komendami
shella sh(1).

W tym pakiecie jest statycznie zlinkowany pdksh.

%prep
%setup  -q
%patch0 -p0

%build
autoconf
LDFLAGS="-s"; export LDFLAGS
%configure \
	--enable-emacs \
	--enable-vi
make

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_mandir}/pl/man1,/etc}

make install \
	exec_prefix=$RPM_BUILD_ROOT/ \
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
		echo "/bin/ksh" >> /etc/shells
	fi
	if ! grep '^/bin/sh$' /etc/shells > /dev/null; then
		echo "/bin/sh" >> /etc/shells
	fi
fi

%post static
if [ ! -f /etc/shells ]; then
	echo "/bin/ksh.static" > /etc/shells
else
	if ! grep '^/bin/ksh.static$' /etc/shells > /dev/null; then
		echo "/bin/ksh.static" >> /etc/shells
	fi
fi

%postun
if [ $1 = 0 ]; then
	grep -v /bin/ksh /etc/shells | grep -v /bin/sh > /etc/shells.new
	mv /etc/shells.new /etc/shells
fi

%postun static
if [ $1 = 0 ]; then
	grep -v /bin/ksh.static /etc/shells > /etc/shells.new
	mv /etc/shells.new /etc/shells
fi

%files
%defattr(644,root,root,755)
%doc {README,NEWS,BUG-REPORTS}.gz

%attr(755,root,root) /bin/ksh
/bin/sh
/etc/*

%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*

%files static
%defattr(644,root,root,755)
%attr(755,root,root) /bin/ksh.static

%clean
rm -rf $RPM_BUILD_ROOT
