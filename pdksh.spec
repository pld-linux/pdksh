Summary:	Public Domain Korn Shell
Summary(de):	Korn-Shell aus dem Public Domain
Summary(es):	Shell Korn de dominio público
Summary(fr):	Korn Shell du domaine public
Summary(pl):	Shell Korna z Public Domain
Summary(pt_BR):	Shell Korn de domínio público
Summary(tr):	Serbest Korn kabuðu
Name:		pdksh
Version:	5.2.14
Release:	24
License:	mostly Public Domain with Free & GPL additions
Group:		Applications/Shells
Group(de):	Applikationen/Shells
Group(pl):	Aplikacje/Pow³oki
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}.tar.gz
Source1:	ksh.1.pl
Patch0:		%{name}-static.patch
Patch1:		%{name}-quote.patch
Patch2:		%{name}-history.patch
Patch3:		ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}-patches.1
Patch4:		ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}-patches.2
Patch5:		%{name}-debian.patch
Patch6:		%{name}-EDITMODE.patch
Patch7:		%{name}-rlimit_locks.patch
Patch8:		%{name}-eval-segv.patch
Patch9:		%{name}-awful-free-bug.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%define		_exec_prefix		/

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
Pdksh jest implementacj± shella ksh. Komendy pdksh s± zgodne z
komendami shella sh(1).

%description -l pt_BR
Pdksh, uma reimplementação de ksh, é um interpretador de comandos
destinado tanto para uso interativo como em shell scripts. Sua
linguagem de comandos é um superconjunto da linguagem sh(1) shell.

%description -l tr
pdksh, hem etkileþimli hem de kabuk programcýklarýnýn kullanýmý için
tasarlanmýþ bir komut yorumlayýcýsýdýr. pdksh'ýn komut dili sh(1)
kabuk dilinin bir kümesidir.

%package static
Summary:	Statically linked Public Domain Korn Shell
Summary(pl):	Statycznie zlinkowany shell Korna
Group:		Applications/Shells
Group(de):	Applikationen/Shells
Group(pl):	Aplikacje/Pow³oki
Requires:	%{name}

%description static
pdksh, a remimplementation of ksh, is a command interpreter that is
intended for both interactive and shell script use. Its command
language is a superset of the sh(1) shell language.

This packege contains statically linked version of pdksh.

%description static -l pl
Pdksh jest implementacj± shella ksh. Komendy pdksh s± zgodne z
komendami shella sh(1).

W tym pakiecie jest statycznie zlinkowany pdksh.

%prep
%setup  -q
%{?_without_static:#}%patch0 -p0
%patch1 -p1
%patch2 -p1
%patch3 -p2
%patch4 -p0
%patch5 -p1
%patch6 -p1
%patch7 -p1
%patch8 -p1
%patch9 -p1

%build
#autoconf
%configure2_13 \
	--enable-emacs \
	--enable-vi
%{__make}

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT{%{_mandir}/pl/man1,%{_sysconfdir}}

%{__make} install \
	exec_prefix=$RPM_BUILD_ROOT/ \
	mandir=$RPM_BUILD_ROOT%{_mandir}/man1

echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/man1/sh.1

install	%{SOURCE1} $RPM_BUILD_ROOT%{_mandir}/pl/man1/ksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/pdksh.1
echo ".so ksh.1" > $RPM_BUILD_ROOT%{_mandir}/pl/man1/sh.1

ln -sf ksh $RPM_BUILD_ROOT/bin/sh

gzip -9nf README NEWS BUG-REPORTS

%clean
rm -rf $RPM_BUILD_ROOT

%post
if [ ! -f /etc/shells ]; then
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

%post static
if [ ! -f /etc/shells ]; then
	echo "/bin/ksh.static" > /etc/shells
else
	while read SHNAME; do
        	if [ "$SHNAME" = "/bin/ksh.static" ]; then
                	HAS_KSH_STATIC=1
	        fi
	done < /etc/shells
	[ -n "$HAS_KSH_STATIC" ] || echo "/bin/ksh.static" >> /etc/shells
fi

%preun
if [ "$1" = "0" ]; then
	while read SHNAME; do
		[ "$SHNAME" = "/bin/ksh" ] ||\
		[ "$SHNAME" = "/bin/sh" ] ||\
		echo "$SHNAME"
	done < /etc/shells > /etc/shells.new
	mv -f /etc/shells.new /etc/shells
fi

%preun static
if [ "$1" = "0" ]; then
	while read SHNAME; do
		[ "$SHNAME" = "/bin/ksh.static" ] ||\
		echo "$SHNAME"
	done
	mv -f /etc/shells.new /etc/shells
fi

%files
%defattr(644,root,root,755)
%doc *.gz

%attr(755,root,root) /bin/ksh
/bin/sh

%{_mandir}/man1/*
%lang(pl) %{_mandir}/pl/man1/*

%{?_without_static:#}%files static
%{?_without_static:#}%defattr(644,root,root,755)
%{?_without_static:#}%attr(755,root,root) /bin/ksh.static
