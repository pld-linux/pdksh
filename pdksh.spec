#
# Conditional build:
%bcond_without	static	# don't build static version of (pd)ksh
#
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
Release:	48
License:	Mostly Public Domain with Free & GPL additions
Group:		Applications/Shells
Source0:	ftp://ftp.cs.mun.ca/pub/pdksh/%{name}-%{version}.tar.gz
# Source0-md5:	871106b3bd937e1afba9f2ef7c43aef3
Source1:	ksh.1.pl
Source2:	%{name}-kshrc
Patch0:		%{name}-static.patch
Patch1:		%{name}-debian.patch
Patch4:		%{name}-history.patch
Patch5:		%{name}-EDITMODE.patch
Patch9:		%{name}-no_stop_alias.patch
Patch10:	%{name}-man_no_plusminus.patch
Patch11:	%{name}-circumflex.patch
Patch12:	%{name}-siglist-sort.patch
Patch13:	%{name}-hex.patch
Patch14:	%{name}-kshrc_support.patch
Patch15:	%{name}-ulimit-vmem.patch
Patch16:	%{name}-unset.patch
URL:		http://www.cs.mun.ca/~michael/pdksh/
%{?with_static:BuildRequires:	glibc-static}
# is needed for /etc directory existence
Requires(pre):	FHS
Requires:	setup >= 2.4.6-2
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
%setup  -q
%{?with_static:%patch0 -p0}
%patch1 -p1
%patch4 -p1
%patch5 -p1
%patch9 -p1
%patch11 -p1
%patch13 -p1
%patch14 -p1
%patch15 -p1
%patch16 -p0

%build
CFLAGS="%{rpmcflags} -D_FILE_OFFSET_BITS=64 -DDEBIAN=1"
LDFLAGS="%{rpmcflags} %{rpmldflags}"
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

%post -p <lua>
t = {}
f = io.open("/etc/shells", "r")
if f then
	for l in f:lines() do t[l]=l; end
	f:close()
end
for _, s in ipairs({"/bin/ksh", "/bin/sh"}) do
	if not t[s] then
		f = io.open("/etc/shells", "a"); f:write(s.."\n"); f:close()
	end
end

%preun -p <lua>
if arg[2] == "0" then
	f = io.open("/etc/shells", "r")
	if f then
		s=""
		for l in f:lines() do
			if not string.match(l,"^/bin/k?sh$") then
				s=s..l.."\n"
			end
		end
		f:close()
		io.open("/etc/shells", "w"):write(s)
	end
end

%post static -p <lua>
t = {}
f = io.open("/etc/shells", "r")
if f then
	for l in f:lines() do t[l]=l; end
	f:close()
end
if not t["/bin/ksh.static"] then
	f = io.open("/etc/shells", "a"); f:write("/bin/ksh.static\n"); f:close()
end

%preun static -p <lua>
if arg[1] == "2" then
	f = io.open("/etc/shells", "r")
	if f then
		s=""
		for l in f:lines() do
			if not string.match(l,"^/bin/ksh\.static$") then
				s=s..l.."\n"
			end
		end
		f:close()
		io.open("/etc/shells", "w"):write(s)
	end
end

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
