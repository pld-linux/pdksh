'\" t
.\" $Id$
.\"
.\"{{{}}}
.\"{{{  Notes about man page
.\"     - use the pseudo-macros .sh( and .sh) to begin and end sh-specific
.\"       text and .ksh( and .ksh) for ksh specific text.
.\"     - put i.e., e.g. and etc. in italics
.\"}}}
.\"{{{  To do
.\" todo: Things not covered that should be:
.\"	- distinguish (POSIX) special built-in's, (POSIX) regular built-in's,
.\"	  and sh/ksh weirdo built-in's (put S,R,X superscripts after command
.\"	  name in built-in commands section?)
.\"	- need to be consistent about notation for `See section-name', `
.\"	  See description of foobar command', `See section section-name', etc.
.\"	- need to use the term `external command' meaning `a command that is
.\"       executed using execve(2)' (as opposed to a built-in command or
.\"       function) for more clear description.
.\"}}}
.\"{{{  Title
.TH KSH 1 "22 lutego 1999" "" "Komendy u�ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja pow�oki Korna
.\"}}}
.\"{{{  Synopsis
.SH WYWO�ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP]
[ [ \fB\-c\fP \fI�a�cuch_komend\fP [\fInazwa_komendy\fP]|\fB\-s\fP|\fIplik\fP ]
[\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP to interpreter komend zaprojektowany zar�wno
do interakcyjnej pracy z systemem, jak i do wykonywania skrypt�w.
Jego j�zyk komend jest nadzbiorem (superset) j�zyka pow�oki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Uruchamianie pow�oki"
Nast�puj�ce opcje mog� by� u�yte wy��cznie w linii komend:
.IP "\fB\-c\fP \fI�a�cuch_komend\fP"
pow�oka wykonuje komend�(y) zawart�(e) w \fI�a�cuchu_komend\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni�ej
.IP \fB\-l\fP
pow�oka zameldowania \(em patrz poni�ej
tryb interakcyjny \(em patrz poni�ej
.IP \fB\-s\fP
pow�oka wczytuje komendy ze standardowego wej�cia; wszelkie argumenty
nie b�d�ce opcjami s� argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni�ej
.PP
Ponadto wszelkie opcje, opisane w om�wieniu wbudowanej
komend� \fBset\fP, mog� r�wnie� zosta� u�yte w linii polece�.
.PP
Je�li nie zosta�a podana ani opcja \fB\-c\fP, ani opcja \fB\-s\fP,
w�wczas pierwszy argument nie b�d�cy opcj�, okre�la
plik, z kt�rego zostan� wczytane komendy. Je�li brak jest argument�w
nie b�d�cych opcjami, to pow�oka wczytuje komendy ze standardowego
wej�cia.
Nazwa pow�oki (tj. zawarto�� parametru \fB$0\fP)
jest ustalana jak nast�puje: je�li u�yto opcji \fB\-c\fP
i podano argument nie b�d�cy opcj�, to jest on nazw�;
je�li komendy s� wczytywane z pliku, w�wczas nazwa tego pliku zostaje
u�yta jako nazwa pow�oki; w ka�dym innym przypadku zostaje u�yta
nazwa, pod kt�r� pow�oka zosta�a wywo�ana
(tzn. warto�� argv[0]).
.PP
Pow�oka jest \fBinterakcyjna\fP, je�li u�yto opcji \fB\-i\fP
lub je�li zar�wno standardowe wej�cie, jak i standardowe wyj�cie b��d�w,
jest skojarzone z jakim� terminalem.
W interakcyjnej pow�oce kontrola zada� (je�li takowa jest dost�pna
w danym systemie) jest w��czona oraz ignorowane s� nast�puj�ce sygna�y:
INT, QUIT oraz TERM. Ponadto pow�oka wy�wietla zach�t� przed
odczytywaniem polece� (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych pow�ok, uaktywnia si� domy�lnie opcja \fBtrackall\fP
(patrz poni�ej: komenda \fBset\fP).
.PP
Pow�oka jest \fBograniczona\fP, je�li zastosowano opcj� \fB\-r\fP lub
gdy albo g��wna cz�� nazwy (basename), pod jak� wywo�ano pow�ok�, albo parametr
\fBSHELL\fP, pasuj� do wzorca *r*sh (na przyk�ad:
rsh, rksh, rpdksh itp.).
Po przetworzeniu przez pow�ok� wszystkich plik�w profili i \fB$ENV\fR
w��czane s� nast�puj�ce ograniczenia:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
niedost�pna jest komenda \fBcd\fP
.IP \ \ \(bu
nie mog� by� zmieniane parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP.
.IP \ \ \(bu
nazwy polece� nie mog� by� podawane z u�yciem �cie�ek bezwzgl�dnych lub
wzgl�dnych [t�um.: tj. dost�pne s� tylko przez nazw� bez �cie�ki]
.IP \ \ \(bu
niedost�pna jest opcja \fB\-p\fP wbudowanego polecenia \fBcommand\fP
.IP \ \ \(bu
nie mog� by� u�ywane przekierowania tworz�ce pliki
(np.: \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Pow�oka jest \fBuprzywilejowana\fP, je�li zastosowano opcj� \fB\-p\fP
lub je�li rzeczywisty identyfikator u�ytkownika lub jego grupy
nie jest zgodny z efektywnym identyfikatorem u�ytkownika czy grupy
(patrz: \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana pow�oka nie przetwarza ani \fI$HOME/.profile\fR, ani parametru
\fBENV\fP (patrz poni�ej), przetwarza za to plik \fI/etc/suid_profile\fR.
Wykasowanie opcji uprzywilejowania powoduje, �e pow�oka ustawia sw�j
efektywny identyfikator u�ytkownika i grupy na warto�ci faktycznego
identyfikatora u�ytkownika (user-id) i jego grupy (group-id).
.PP
Je�li g��wna cz�� nazwy, pod jak� dana pow�oka zosta�a wywo�ana
(\fItzn.\fP argv[0])
zaczyna si� od \fB\-\fP lub u�yto opcji \fB\-l\fP,
to zak�ada si�, �e pow�oka ma by� pow�ok� zg�oszeniow� i wczytywana jest
zawarto�� plik�w \fI/etc/profile\fP i \fI$HOME/.profile\fP,
je�li takie istniej� i mo�na je odczyta�.
.PP
Je�eli parametr \fBENV\fR jest ustawiony podczas uruchamiania pow�oki
(albo w wypadku pow�ok zg�oszeniowych - po przetworzeniu
dowolnych plik�w profilowych), to jego zawarto�� zostaje
poddana zast�powaniu.
Zast�powane s� parametry, komendy, wyra�enia arytmetyczne oraz tylda.
Nast�pnie wynikaj�ca z tej operacji nazwa jest
interpretowana jako nazwa pliku, podlegaj�cego wczytaniu i wykonaniu.
Je�li parametr \fBENV\fP jest pusty (i niezerowy), a pdksh zosta�
skompilowany ze zdefiniowanym makrem \fBDEFAULT_ENV\fP,
to po wykonaniu wszelkich ju� wy�ej wymienionych podstawie�,
zostaje wczytany plik okre�lony tym makrem.
.PP
Kod wyj�cia pow�oki wynosi 127, je�li plik komend
podany we linii wywo�ania nie m�g� zosta� otwarty,
lub kod wyj�cia jest niezerowy, je�li wyst�pi� krytyczny b��d sk�adni
podczas wykonywania tego skryptu.
W razie braku b��d�w krytycznych, kod wyj�cia jest r�wny kodowi ostatnio
wykonanej komendy lub zeru, je�li nie wykonano �adnej komendy.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk�adnia polece�"
.\"{{{  words and tokens
Pow�oka rozpoczyna analiz� sk�adniow� wej�cia od podzia�u go
na poszczeg�lne s�owa \fIword\fP.
S�owa, stanowi�ce ci�gi znak�w, ograniczane s� niecytowanymi
bia�ymi znakami \fIwhitespace\fP (spacja, tabulator i nowa linia)
lub \fImetaznakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza ograniczaniem s��w spacje i tabulatory s� ignorowane.
Natomiast znaki zmiany linii zwykle rozgraniczaj� komendy.
Metaznaki stosowane s� do tworzenia nast�puj�cych symboli:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIitd.\fP,
s�u��cych do okre�lania przekierowa� (patrz: "Przekierowywanie
wej�cia/wyj�cia" poni�ej);
\fB|\fP s�u�y do tworzenia potok�w;
\fB|&\fP s�u�y do tworzenia koproces�w (patrz: "Koprocesy" poni�ej);
\fB;\fP s�u�y do oddzielania komend;
\fB&\fP s�u�y do tworzenia potok�w asynchronicznych;
\fB&&\fP i \fB||\fP s�u�� do okre�lenia wykonania warunkowego;
\fB;;\fP jest u�ywany w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s� u�ywane w wyra�eniach arytmetycznych;
i w ko�cu,
\fB(\fP .. \fB)\fP s�u�� do tworzenia podpow�ok.
.PP
Bia�e znaki lub metaznaki mo�na zacytowywa� pojedynczo
przy u�yciu znaku odwrotnego uko�nika (\fB\e\fP) lub grupami w podw�jnych
(\fB"\fP) lub pojedynczych (\fB'\fP) cudzys�owach.
Zauwa�, i� nast�puj�ce znaki podlegaj� r�wnie�
specjalnej interpretacji przez pow�ok� i musz� by� cytowane,
je�li maj� by� u�yte dos�ownie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to wy�ej wspomniane symbole cytowania
(patrz: "Cytowanie" poni�ej);
\fB#\fP, na pocz�tku s�owa rozpoczyna komentarz \(em wszystko po znaku
\fB#\fP, a� do ko�ca linii jest ignorowane;
\fB$\fP s�u�y do wprowadzenia podstawienia parametru, komendy
lub wyra�enia arytmetycznego (patrz: "Podstawienia" poni�ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz: "Podstawienia" poni�ej);
\fB~\fP rozpoczyna rozwini�cie katalogu (patrz: "Rozwijanie tyld" poni�ej);
\fB{\fP i \fB}\fP obejmuj� alternacje w stylu \fIcsh\fP(1)
(patrz: "Rozwijanie nawias�w" poni�ej);
i na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s� stosowane przy tworzeniu
nazw plik�w (patrz: "Wzorce nazw plik�w" poni�ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s��w i symboli, pow�oka tworzy komendy, kt�rych
wyr�nia si� dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z�o�one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, struktury grupuj�ce i definicje funkcji.
.PP
Polecenie proste sk�ada si� z kombinacji przyporz�dkowa� warto�ci
parametrom (patrz: "Parametry"), przekierowa� wej�cia/wyj�cia
(patrz: "Przekierowania wej�cia/wyj�cia") i s��w komend;
Jedynym ograniczeniem jest to, �e wszelkie podstawienia warto�ci
parametr�w musz� wyst�powa� przed s�owami komend.
S�owa komend, je�li zosta�y podane, okre�laj� polecenie, kt�re
nale�y wykona�, wraz z jego argumentami.
Komenda mo�e by� komend� wbudowan� pow�oki, funkcj� lub
\fIkomend� zewn�trzn�\fP, \fItzn.\fP oddzielnym
plikiem wykonywalnym, kt�ry jest odnajdowany przy u�yciu
warto�ci parametru \fBPATH\fP (patrz: "Wykonywanie komend" poni�ej).
Trzeba zauwa�y�, �e wszystkie komendy maj� sw�j
\fIkod zako�czenia\fP: dla polece� zewn�trznych jest on
powi�zany z kodem zwracanym przez \fIwait\fP(2) (je�li
komenda nie zosta�a odnaleziona, w�wczas kod wynosi 127,
natomiast je�li nie mo�na by�o jej wykona�, to kod wynosi 126).
Kody zwracane przez inne polecenia (komendy wbudowane,
funkcje, potoki, listy, itp.) s� precyzyjnie okre�lone,
a ich opis towarzyszy opisowi danego konstruktu.
Kod wyj�cia komendy zawieraj�cej jedynie przyporz�dkowania
warto�ci parametrom, odpowiada kodowi ostatniego wykonanego podczas tego
podstawienia lub zeru, je�li �adne podstawienia nie mia�y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Przy pomocy symbolu \fB|\fP komendy mog� zosta� powi�zane w \fIpotoki\fP.
W potokach standardowe wyj�cie wszystkich komend poza ostatnim, zostaje
wyprowadzone (patrz \fIpipe\fP(2)) na standardowe wej�cie nast�pnej komendy.
Kod wyj�cia potoku jest r�wny kodowi zwr�conemu przez ostatni� komend�
potoku.
Potok mo�e zosta� poprzedzony zarezerwowanym s�owem \fB!\fP,
powoduj�cym zmian� kodu wyj�cia na jego logiczne przeciwie�stwo.
Tzn. je�li pierwotnie kod wyj�cia wynosi� 0, to b�dzie on mia� warto�� 1,
natomiast je�li pierwotn� warto�ci� nie by�o 0, to kodem przeciwstawnym
jest 0.
.\"}}}
.\"{{{  lists
.PP
\fIList�\fP komend tworzymy rozdzielaj�c potoki jednym z nast�puj�cych symboli:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj� warunkowe wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko wtedy, je�eli kod wyj�cia \fIcmd1\fP by� zerowy.
Natomiast \fB||\fP zachowuje si� dok�adnie odwrotnie. \(em \fIcmd2\fP
zostaje wykonane jedynie, je�li kod wyj�cia \fIcmd1\fP by�
r�ny od zera.
\fB&&\fP i \fB||\fP wi��� r�wnowa�nie, a zarazem mocniej ni�
\fB&\fP, \fB|&\fP i \fB;\fP, kt�re z kolei r�wnie� posiadaj� t� sam� si��
wi�zania.
Symbol \fB&\fP powoduje, �e poprzedzaj�ca go komenda zostanie wykonana
asynchronicznie, tzn. pow�oka uruchamia dan� komend�, jednak nie czeka na jej
zako�czenie (pow�oka �ledzi dok�adnie wszystkie asynchroniczne
komendy \(em patrz: "Kontrola zada�" poni�ej).
Je�li komenda asynchroniczna jest uruchomiona przy wy��czonej
kontroli zada� (tj. w wi�kszo�ci skrypt�w),
w�wczas jest ona uruchamiana z wy��czonymi sygna�ami INT
i QUIT oraz przekierowanym wej�ciem do /dev/null
(aczkolwiek przekierowania, ustalone w samej komendzie asynchronicznej
maj� tu pierwsze�stwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi�cy specjalnego
rodzaju komend� asynchroniczn� (patrz: "Koprocesy" poni�ej).
Zauwa�, �e po operatorach \fB&&\fP i \fB||\fP
musi wyst�powa� komenda, podczas gdy nie jest to konieczne
po \fB&\fP, \fB|&\fP i \fB;\fP.
Kodem wyj�cia listy komend jest kod ostatniego wykonanego w niej polecenia,
z wyj�tkiem list asynchronicznych, dla kt�rych kod wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Komendy z�o�one tworzymy przy pomocy nast�puj�cych s��w zarezerwowanych
\(em s�owa te s� rozpoznane tylko wtedy, gdy nie s� zacytowane
i wyst�puj� jako pierwsze wyrazy w komendzie (tj. nie s� poprzedzone
�adnymi przyporz�dkowywaniami warto�ci parametrom czy przekierowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niekt�re pow�oki (lecz nie nasza) wykonuj� polecenia steruj�ce
w podpow�oce, gdy przekierowano jeden lub wi�cej z ich deskryptor�w plik�w,
tak wi�c wszelkiego rodzaju zmiany otoczenia w nich mog� nie dzia�a�.
Aby zachowa� przeno�no�� nale�y stosowa� polecenie \fBexec\fP do
przekierowa� deskryptor�w plik�w przed poleceniem steruj�cym.
.PP
W poni�szym opisie polece� z�o�onych, listy komend (zaznaczone przez
\fIlista\fP), po kt�rych nast�puje s�owo zarezerwowane, musz� ko�czy� si� �rednikiem,
prze�amaniem wiersza lub (poprawnym gramatycznie) s�owem zarezerwowanym.
Przyk�adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s� poprawne, natomiast
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlist�\fP w podpow�oce. Nie ma bezpo�redniej mo�liwo�ci
przekazania warto�ci parametr�w podpow�oki z powrotem do jej
pow�oki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Konstrukcja z�o�ona; \fIlista\fP zostaje wykonana, lecz nie w podpow�oce.
Zauwa�, �e \fB{\fP i \fB}\fP to zarezerwowane s�owa, a nie
metaznaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs�owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra�enie \fBcase\fP stara si� dopasowa� \fIs�owo\fP do jednego
z danych \fIwzorc�w\fP; wykonywana jest \fIlista\fP powi�zana z pierwszym
poprawnie dopasowanym wzorcem.
Wzorce stosowane w wyra�eniach \fBcase\fP odpowiadaj� wzorcom
stosowanym do specyfikacji nazw plik�w z wyj�tkiem tego, �e
nie obowi�zuj� ograniczenia zwi�zane z \fB\&.\fP i \fB/\fP.
Prosz� zwr�ci� uwag� na to, �e wszelkie niecytowane bia�e
znaki przed wzorcem i po nim zostaj� usuni�te; wszelkie spacje we wzorcu
musz� by� cytowane.  Zar�wno s�owa, jak i wzorce podlegaj� podstawieniom
parametr�w, rozwini�ciom arytmetycznym oraz podstawieniu tyldy.
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i
zamykaj�cy zamiast \fBin\fP i \fBesac\fP
(w szczeg�lno�ci wi�c, \fBcase $foo { *) echo bar; }\fP).
Kodem wyj�cia wyra�enia \fBcase\fP jest kod wykonanej
\fIlisty\fP; je�li nie zosta�a wykonana �adna \fIlista\fP,
w�wczas kod wyj�cia wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest albo znakiem ko�ca linii, albo \fB;\fP.
Dla ka�dego \fIs�owa\fP w podanej li�cie s��w, parameter \fInazwa\fP zostaje
ustawiony na to s�owo i \fIlista\fP zostaje wykonana. Je�eli nie b�dzie u�yte \fBin\fP
do specyfikacji listy s��w, to zamiast tego zostan� u�yte parametry
pozycyjne (\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP).
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i
zamykajacy zamiast \fBdo\fP i \fBdone\fP
(\fIw szczeg�lno�ci\fP, \fBfor i; { echo $i; }\fP).
Kodem wyj�cia wyra�enia \fBfor\fP jest ostatni kod wyj�cia
danej \fIlisty\fP; je�li \fIlista\fP nie zosta�a w og�le
wykonana, w�wczas kod wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je�li kod wyj�cia pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je�li mamy takow�,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami. Je�li wszystkie listy po \fBif\fP
i \fBelif\fP wyka�� b��d (\fItzn.\fP zwr�c� niezerowy kod), to zostanie wykonana
\fIlista\fP po \fBelse\fP.
Kodem wyj�cia wyra�enia \fBif\fP jest kod wykonanej \fIlisty\fP,
niestanowi�cej warunku. Je�li �adna nieokre�laj�ca warunku
\fIlista\fP nie zostanie wykonana, w�wczas kod wyj�cia wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest albo prze�amaniem wiersza, albo \fB;\fP.
Wyra�enie \fBselect\fP umo�liwia automatyczn� prezentacj� u�ytkownikowi
menu, wraz z mo�liwo�ci� wyboru z niego.
Przeliczona lista wykazanych \fIs��w\fP zostaje wypisana na
standardowym wyj�ciu b��d�w, po czym zostaje
wy�wietlony symbol zach�ty (\fBPS3\fP, czyli domy�lnie `\fB#? \fP').
Nast�pnie zostaje wczytana liczba odpowiadaj�ca danemu punktowi
menu ze standardowego wej�cia, po czym \fInazwie\fP
zostaje przyporz�dkowane w ten spos�b wybrane s�owo (lub warto��
pusta, je�eli wyb�r by� niew�a�ciwy), zmiennej \fBREPLY\fP
zostaje przyporz�dkowane to, co zosta�o wczytane
(po usuni�ciu pocz�tkowych i ko�cowych bia�ych znak�w),
i \fIlista\fP zostaje wykonana.
Je�li wprowadzono pust� lini� (dok�adniej: zero lub wi�cej
znaczk�w \fBIFS\fP), w�wczas menu zostaje ponownie wy�wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zako�czone,
w�wczas przeliczona lista wybor�w zostaje wy�wietlona ponownie, je�li
\fBREPLY\fP jest zerowe, ponownie wy�wietlany jest symbol zach�ty i tak dalej.
Proces ten si� powtarza, a� do wczytania znaku ko�ca pliku,
otrzymania sygna�u przerwania lub wykonania polecenia przerwania (break)
w �rodku p�tli.
Je�li opuszczono \fBin\fP \fIs�owo\fP \fB\&...\fP, w�wczas
u�yte zostaj� parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP,
\fIitp.\fP).
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczeg�lno�ci\fP,
\fBselect i; { echo $i; }\fP).
Kodem wyj�cia wyra�enia \fBselect\fP jest zero, je�li
u�yto polecenia przerwania do wyj�cia z p�tli albo
niezero w przeciwnym wypadku.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia�a dok�adnie jak \fBwhile\fP, z wyj�tkiem tego, �e zawarto��
p�tli jest wykonywana jedynie wtedy, gdy kod wyj�cia pierwszej
\fIlisty\fP jest niezerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra�enie \fBwhile\fP okre�la p�tl� o warunku sprawdzanym przed
wykonaniem. Zawarto�� p�tli jest wykonywana dop�ki,
dop�ty kod wyj�cia pierwszej \fIlisty\fP jest zerowy.
Kodem wyj�cia wyra�enia \fBwhile\fP jest ostatni
kod wyj�cia \fIlisty\fP w zawarto�ci tej p�tli;
gdy zawarto�� nie zostanie w og�le wykonana, w�wczas kod wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcj� o nazwie \fInazwa\fP.
Patrz: "Funkcje" poni�ej.
Prosz� zwr�ci� uwag�, �e przekierowania tu� po definicji
funkcji zostaj� zastosowane podczas wykonywania jej zawarto�ci,
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fInazwa\fP \fB()\fP \fIpolecenie\fP"
Niemal dok�adnie to samo co w \fBfunction\fP.
Patrz: "Funkcje" poni�ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra�enie\fP \fB))\fP"
Warto�� wyra�enia arytmetycznego \fIwyra�enie\fP zostaje przeliczona;
r�wnowa�ne do \fBlet "\fP\fIwyra�enie\fP\fB"\fP.
patrz: "Wyra�enia arytmetyczne" i opis polecenia \fBlet\fP poni�ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (kt�re opisujemy
p�niej), z nast�puj�cymi r�nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie p�l i generacja nazw plik�w nie s� wykonywane na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub) zostaj� zast�pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok�adniej\fP: \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP)
nie mog� by� cytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczeg�lno�ci\fP, por�wnanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP,
kt�re zwracaj� prawd�, gdy pierwszy �a�cuchowy operand jest odpowiednio
mniejszy lub wi�kszy od drugiego operandu �a�cuchowego.
.IP \ \ \(bu
Jednoargumentowa posta� operacji \fBtest\fP,
kt�ra sprawdza, czy jedyny operand jest d�ugo�ci zerowej, jest
niedozwolona
- operatory zawsze musz� by� wykazywane jawnie, \fIw szczeg�lno�ci\fP,
zamiast
.ce
\fB[\fP \fIci�g\fP \fB]\fP
nale�y u�y�
.ce
\fB[[ \-n \fP\fIci�g\fP\fB ]]\fP
.IP \ \ \(bu
Podstawienia parametr�w, komend i arytmetyczne zostaj� wykonane
w trakcie wyliczania wyra�enia. Do operator�w
\fB&&\fP i \fB||\fP stosowana jest metoda uproszczonego okre�lania
ich warto�ci.
To znaczy, �e w wyra�eniu
.ce
\fB[[ -r foo && $(< foo) = b*r ]]\fP
warto�� \fB$(< foo)\fP zostaje wyliczona wtedy i tylko wtedy, gdy
plik o nazwie \fBfoo\fP istnieje i jest czytelny.
.nr PD \n(P2
.RE
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Quoting
.SS Cytowanie
Cytowanie stosuje si� do zapobiegania traktowaniu przez pow�ok� pewnych
znak�w czy s��w w specjalny spos�b.
Istniej� trzy metody cytowywania: Po pierwsze, \fB\e\fP cytuje
nast�pny znak, chyba �e mie�ci si� on na ko�cu wiersza, w�wczas
zar�wno \fB\e\fP jak i znak nowej linii zostaj� usuni�te.
Po drugie pojedynczy cudzys��w (\fB'\fP) wycytowywuje wszystko,
a� po nast�pny pojedynczy cudzys��w (wraz ze zmianami linii w��cznie).
Po trzecie, podw�jny cudzys��w (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a� po nast�pny niecytowany podw�jny
cudzys��w.
\fB$\fP i \fB`\fP wewn�trz podw�jnych cudzys�ow�w zachowuj� zwyk�e
znaczenie (tzn.
oznaczaj� podstawienie warto�ci parametru, komendy lub wyra�enia arytmetycznego),
je�li tylko nie zostanie wykonany jakikolwiek podzia� p�l na
wyniku podw�jnymi cudzys�owami wycytowanych podstawie�.
Je�li po \fB\e\fP, wewn�trz ci�gu znak�w cytowanego podw�jnymi cudzys�owami
nast�puje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zast�piony drugim z tych znak�w.
Je�li po nim nast�puje znak nowej linii, w�wczas zar�wno \fB\e\fP,
jak i znak zmiany linii zostaj� usuni�te;
w przeciwnym razie zar�wno znak \fB\e\fP, jak i nast�puj�cy po nim znak
nie podlegaj� �adnej zamianie.
.PP
Uwaga: patrz "Tryb POSIX" poni�ej pod wzgl�dem szczeg�lnych regu�
obowi�zuj�cych sekwencje znak�w postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej� dwa rodzaje alias�w: normalne aliasy komend i
aliasy �ledzone. Aliasy komend stosowane s� zwykle jako
skr�ty dla d�ugich a cz�sto stosowanych komend.
Pow�oka rozwija aliasy komend (\fItzn.\fP
podstawia pod nazw� aliasu jego zawarto��), gdy wczytuje
pierwsze s�owo komendy.
Rozwini�ty alias zostaje ponownie przetworzony, aby uwzgl�dni�
ewentualne wyst�powanie dalszych alias�w.
Je�li alias komendy ko�czy si� spacj� lub tabulatorem, to w�wczas
nast�pne s�owo zostaje r�wnie� sprawdzone pod wzgl�dem rozwini�cia
alias�w. Proces rozwijania alias�w ko�czy si� przy napotkaniu
s�owa, kt�re nie jest aliasem, gdy napotka si� wycytowane s�owo,
lub gdy napotka si� alias, kt�ry jest w�a�nie wyeksportowywany.
.PP
Nast�puj�ce aliasy s� definiowane domy�lnie przez pow�ok�:
.ft B
.RS
autoload='typeset \-fu'
.br
functions='typeset \-f'
.br
hash='alias \-t'
.br
history='fc \-l'
.br
integer='typeset \-i'
.br
local='typeset'
.br
login='exec login'
.br
newgrp='exec newgrp'
.br
nohup='nohup '
.br
r='fc \-e \-'
.br
stop='kill \-STOP'
.br
suspend='kill \-STOP $$'
.br
type='whence \-v'
.RE
.ft P
.PP
�ledzone aliasy pozwalaj� pow�oce na zapami�tanie, gdzie
odnalaz�a ona konkretn� komend�.
Gdy pow�oka po raz pierwszy szuka w �cie�ce polcenia oznaczonego jako alias
�ledzony, to zapami�tuje sobie pe�n� �cie�k� tej komendy.
Gdy pow�oka nast�pnie wykonuje dan� komend� po raz drugi,
w�wczas sprawdza, czy ta �cie�ka jest nadal aktualna i je�li
tak jest, to nie przegl�da ju� wi�cej pe�nej �cie�ki w poszukiwaniu
danej komendy.
�ledzone aliasy mo�na wy�wietli� lub stworzy� stosuj�c \fBalias
\-t\fP. Zauwa�, �e zmieniaj�c warto�� parametru \fBPATH\fP
czy�cimy r�wnie� �cie�ki dla wszelkich �ledzonych alias�w.
Je�li zosta�a w��czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP),
w�wczas pow�oka �ledzi wszelkie komendy.
Ta opcja zostaje w��czona domy�lnie dla wszelkich
nieinterakcyjnych pow�ok.
Dla pow�ok interakcyjnych jedynie nast�puj�ce komendy s�
�ledzone domy�lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki wykonuje pow�oka podczas wykonywania
prostej komendy, jest przeprowadzenia podstawie� na s�owach tej
komendy.
Istniej� trzy rodzaje podstawie�: parametr�w, komend i arytmetyczne.
Podstawienia parametr�w, kt�re dok�adniej opiszemy w nast�pnej sekcji,
maj� posta� \fB$name\fP lub \fB${\fP...\fB}\fP;
podstawienia komend maj� posta� \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je�li podstawienie wyst�puje poza podw�jnymi cudzys�owami, w�wczas
wynik tego podstawienia podlega zwykle podzia�owi s��w lub p�l, w zale�no�ci
od bie��cej warto�ci parametru \fBIFS\fP.
Parametr \fBIFS\fP okre�la list� znak�w, s�u��cych jako separatory
w podziale �a�cuch�w znakowych na pojedyncze wyrazy.
Wszelkie znaki z tego zestawu oraz tabulator, spacja i
nowa linia w��cznie, nazywane s� \fIbia�ymi znakami IFS\fP.
Ci�gi jednego lub wielu bia�ych znak�w z IFS w powi�zaniu
z zerem oraz jednym lub wi�cej bia�ych znak�w nie wymienionych w IFS,
rozgraniczaj� pola.
Wyj�tkowo pocz�tkowe i ko�cowe bia�e znaki IFS s� usuwane
(tzn. nie s� przez nie tworzone �adne pocz�tkowe czy ko�cowe
puste pola); natomiast pocz�tkowe lub ko�cowe bia�e znaki spoza IFS
tworz� puste pola.
Przyk�adowo: je�li \fBIFS\fP zawiera `<spacja>:', to ci�g
znak�w `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Prosz� zauwa�y�, �e je�li parametr \fBIFS\fP
jest ustawiony na pusty ci�g znak�w, to w�wczas �aden podzia� p�l
nie ma miejsca; gdy parametr ten nie jest ustawiony w og�le,
w�wczas stosuje si� domy�lnie jako rozgraniczniki
spacji, tabulatora i nowej linii.
.PP
Je�li nie podajemy inaczej, to wynik podstawienia
podlega r�wnie� rozwijaniu nawias�w i nazw plik�w (patrz odpowiednie
akapity poni�ej).
.PP
Podstawienie komendy zostaje zast�pione wyj�ciem, wygenerowanym
podczas wykonania danej komendy przez podpow�ok�.
Dla podstawienia \fB$(\fP\fIkomenda\fP\fB)\fP zachodz� normalne
regu�y cytowania podczas analizy \fIkomendy\fP,
cho� jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu� po nim, zostaje usuni�ty
(znak \fB\e\fP z nast�pstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyj�tkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczaj�ca podstawienie zawarto�ci pliku \fIplik\fP
($(< foo) ma wi�c ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony �aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra�enia \fB$(\fP\fIkomenda\fP\fB)\fP s� analizowane
obecnie poprzez odnajdywanie zaleg�ego nawiasu, niezale�nie od
wycytowa�. Miejmy nadziej�, �e zostanie to mo�liwie szybko poprawione.
.PP
Podstawienia arytmetyczne zostaj� zast�pione warto�ci� wyniku
danego wyra�enia.
Przyk�adowo wi�c, komenda \fBecho $((2+3*4))\fP wy�wietla 14.
Patrz: "Wyra�enia arytmetyczne", aby odnale�� opis \fIwyra�e�\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w pow�oce; mo�na im przyporz�dkowywa�
warto�ci oraz wyczytywa� je przez podstawienia parametr�w.
Nazwa parametru jest albo jednym ze znak�w
interpunkcyjnych o specjalnym znaczeniu lub cyfr�, jakie opisujemy
poni�ej, lub liter� z nast�pstwem jednej lub wi�cej liter albo cyfr
(`_' zalicza si� to liter).
Podstawienia parametr�w maj� posta� \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdzie \fInazwa\fP jest nazw�
danego parametru.
Gdy podstawienie zostanie wykonane na parametrze, kt�ry nie zosta�
ustalony, w�wczas zerowy ci�g znak�w jest jego wynikiem, chyba �e
zosta�a w��czona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP), co oznacza, �e wyst�puje w�wczas b��d.
.PP
.\"{{{  parameter assignment
Warto�ci mo�na przyporz�dkowywa� parametrom na wiele r�nych sposob�w.
Po pierwsze, pow�oka domy�lnie ustala pewne parametry, takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny spos�b, w jaki s� ustawiane
specjalnymi paraetry o d�ugo�ci jednego znaku. Po drugie, parametry zostaj�
importowane z otocznia pow�oki podczas jej uruchamiania. Po trzecie,
parametrom mo�na przypisa� warto�ci w wierszu polece�, tak jak np.
`\fBFOO=bar\fP' przypisuje parametrowi FOO warto�� bar;
wielokrotne przypisania warto�ci s� mo�liwe w jednym wierszu komendy
i mo�e po nich wyst�powa� prosta komenda, co powoduje, �e
przypisania te s� w�wczas jedynie aktualne podczas
wykonywania danej komendy (tego rodzaju przypisania
zostaj� r�wnie� wyeksportowane, patrz poni�ej, co do tego konsekwencji).
Prosz� zwr�ci� uwag�, i� aby pow�oka rozpozna�a je jako
przypisanie warto�ci parametrowi, zar�wno nazwa parametru jak i \fB=\fP
nie mog� by� cytowane.
Czwartym sposobem ustawiania parametr�w jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale "Wykonywanie komend".
Po czwarte, p�tle \fBfor\fP i \fBselect\fP ustawiaj� parametry,
tak jak i r�wnie� komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zako�czenie, parametrom mo�na przyporz�dkowywa� warto�ci stosuj�c
operatory nadania warto�ci wewn�trz wyra�e� arytmetycznych
(patrz: "Wyra�enia arytmetyczne" poni�ej) lub
stosuj�c posta� \fB${\fP\fInazwa\fP\fB=\fP\fIwarto��\fP\fB}\fP
podstawienia parametru (patrz poni�ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem eksportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP albo przez przyporz�dkowanie warto�ci
parametru z nast�puj�c� prost� komend�)
zostaj� umieszczone w otoczeniu (patrz \fIenviron\fP(5)) polece�
wykonywanych przez pow�ok� jako pary \fInazwa\fP\fB=\fP\fIwarto��\fP.
Kolejno��, w jakiej parametry wyst�puj� w otoczeniu komendy jest
bli�ej nieustalona.
Podczas uruchamiania pow�oka pozyskuje parametry ze swojego
otoczenia
i automatycznie ustawia na tych parametrach atrybut eksportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo�na stosowa� modyfikatory do postaci \fB${\fP\fInazwa\fP\fB}\fP
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs�owo\fP\fB}\fP
je�eli parametr\fInazwa\fP jest ustawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna
warto��, w przeciwnym razie zostaje podstawione \fIs�owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs�owo\fP\fB}\fP
je�li parametr \fInazwa\fP jest ustawiony i niezerowy, w�wczas zostaje podstawione
\fIs�owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs�owo\fP\fB}\fP
je�li parametr \fInazwa\fP jest ustawiony i niezerowy, w�wczas zostaje podstawiony
on sam, w przeciwnym razie zostaje mu przyporz�dkowana warto��
\fIs�owo\fP i warto�� wynikaj�ca ze \fIs�owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs�owo\fP\fB}\fP
je�eli parametr \fInazwa\fP jest ustawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna warto��, w przeciwnym razie \fIs�owo\fP
zostaje wy�wietlone na standardowym wyj�ciu b��d�w (tu� po \fInazwa\fP:)
i zachodzi b��d
(powoduj�cy normalnie zako�czenie ca�ego skryptu pow�oki, funkcji lub \&.-skryptu).
Je�li s�owo zosta�o pomini�te, w�wczas zamiast niego zostaje u�yty �a�cuch
`parameter null or not set'.
.PP
W powy�szych modyfikatorach mo�emy omin�� \fB:\fP, czego skutkiem
b�dzie, �e warunki b�d� jedynie wymaga�, aby
\fInazwa\fP by� ustawiony lub nie (a nie �eby by� ustawiony i niezerowy).
Je�li potrzebna jest warto�� \fIs�owo\fP, w�wczas zostaj� na nim wykonane
podstawienia parametr�w, komend, arytmetyczne i tyldy;
natomiast, je�li \fIs�owo\fP oka�e si� niepotrzebne, w�wczas jego
warto�� nie zostanie obliczana.
.\"}}}
.PP
Mo�na stosowa�, r�wnie� podstawienia parametr�w o nast�puj�cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Liczba parametr�w pozycyjnych, je�li \fInazw�\fP jest \fB*\fP, \fB@\fP lub nie jest podana
albo d�ugo�� ci�gu b�d�cego warto�ci� parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Liczba element�w w tablicy \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak�ada si� na pocz�tek warto�ci parametru \fInazwa\fP,
w�wczas pasuj�cy tekst zostaje pomini�ty w wynikaj�cym z tego podstawieniu.
Pojedynczy \fB#\fP oznacza najkr�tsze mo�liwe dopasowanie do wzorca, a
dwa \fB#\fP oznaczaj� jak najd�u�sze dopasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko �e dotyczy
ko�ca warto�ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nast�puj�ce specjalne parametry zostaj� ustawione domy�lnie przez pow�ok�
i nie mo�na przyporz�dkowywa� jawnie warto�ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego uruchomionego w tle procesu. Je�li nie ma aktualnie proces�w
uruchomionych w tle, w�wczas parametr ten jest nieustawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Liczba parametr�w pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj�cego danej pow�oce lub PID pierwotnej pow�oki,
je�li mamy do czynienia z podpow�ok�.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenacja bie��cych opcji jednoliterowych
(patrz komenda \fBset\fP poni�ej, aby pozna� dost�pne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Kod wyj�cia ostatniej wykonanej komendy nieasynchronicznej.
Je�li ostatnia komenda zosta�a zabita sygna�em, w�wczas \fB$?\fP
przyjmuje warto�� 128 plus numer danego sygna�u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa, pod jak� dana pow�oka zosta�a wywo�ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP, kt�ra zosta�a wywo�ana przy u�yciu opcji \fB\-c\fP
i \fBnazwa komendy\fP zosta�a podana, lub argument \fIplik\fP,
je�li taki zosta� podany.
Je�li opcja \fBposix\fP nie jest ustawiona, to \fB$0\fP zawiera
nazw� bie��cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewi�� parametr�w pozycyjnych podanych pow�oce czy
funkcji lub \fB.\fP-skryptowi.
Dost�p do dalszych parametr�w pozycyjnych odbywa si� przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj�tkiem parametru 0),
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u�yte poza podw�jnymi cudzys�owami, w�wczas parametry zostaj�
rozgraniczone w pojedyncze s�owa
(podlegaj�ce rozgraniczaniu s��w); je�li u�yte pomi�dzy
podw�jnymi cudzys�owami, w�wczas parametry zostaj� rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci�gami znak�w, je�li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj�tkiem zastosowania w podw�jnych cudzys�owach,
gdzie oddzielne s�owo zostaje wygenerowane dla ka�dego parametru
pozycyjnego z osobna \- je�li brak parametr�w pozycyjnych,
w�wczas nie generowane jest �adne s�owo
("$@" mo�e by� u�yte aby otrzyma� dost�p bezpo�redni do argument�w
bez utraty argument�w zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nast�puj�ce parametry s� ustawiane przez pow�ok�:
.\"{{{  _
.IP "\fB_\fP \fI(podkre�lenie)\fP"
Gdy jaka� komenda zostaje wykonywana przez pow�ok�, ten parametr przyjmuje
w otoczeniu odpowiedniego nowego procesu warto�� �cie�ki tej komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierwotnej pow�oce
ponadto warto�� ostatniego s�owa poprzedniej komendy
Podczas warto�ciowania wiadomo�ci typu \fBMAILPATH\fP,
parametr ten zawiera wi�c nazw� pliku, kt�ry si� zmieni�
(patrz parametr \fBMAILPATH\fP poni�ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
�cie�ka przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia�a tak samo jak
\fBPATH\fP dla katalog�w nierozpoczynaj�cych si� od \fB/\fP
w komendach \fBcd\fP.
Prosz� zwr�ci� uwag�, �e je�li CDPATH jest ustawiony i nie zawiera ani
\fB.\fP ani �cie�ki pustej, to w�wczas katalog bie��cy nie jest przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Liczba kolumn terminala lub okienka.
Obecnie ustawiany warto�ci� \fBcols\fP zwracan� przez komend�
\fIstty\fP(1), je�li ta warto�� nie jest r�wna zeru.
Parametr ten ma znaczenie w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w�a�ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je�li nie zosta� ustawiony parametr \fBVISUAL\fP, w�wczas kontroluje on
tryb edycji wiersza komendy w pow�okach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni�ej, aby si� dowiedzie�, jak to dzia�a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je�li parametr ten oka�e si� by� ustawionym po przetworzeniu
wszelkich plik�w profilowych, w�wczas jego rozwini�ta warto�� zostaje
wykorzystana jako nazwa pliku zawieraj�cego dalsze komendy inicjalizacyjne
pow�oki. Zwykle zawiera definicje funkcji i alias�w.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca�kowita warto�� odpowiadaj�ca zmiennej errno pow�oki
\(em wskazuje przyczyn� wyst�pienia b��du, gdy ostatnie wywo�anie
systemowe nie powiod�o si�.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezaimplementowane.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je�li ustawiono, to w�wczas zawiera pow�ok�, jakiej nale�y u�y�
do wykonywania komend, kt�rych nie zdo�a� wykona� \fIexecve\fP(2),
a kt�re nie zaczynaj� si� od ci�gu `\fB#!\fP \fIpow�oka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u�ywany przez komend� \fBfc\fP (patrz poni�ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je�li pow�oka natrafi na niezdefiniowan�
funkcj� podczas pracy, stosowane do lokalizacji pliku zawieraj�cego definicj�
tej funkcji.
R�wnie� przeszukiwane, gdy komenda nie zosta�a odnaleziona przy
u�yciu \fBPATH\fP.
Patrz "Funkcje" poni�ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u�ywanego do zapisu historii komend.
Je�li warto�� zosta�a ustalona, w�wczas historia zostaje za�adowana
z danego pliku.
Podobnie wielokrotne wcielenia pow�oki b�d� korzysta�y z jednej
historii, je�li dla nich warto�ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je�li HISTFILE nie zosta�o ustawione, w�wczas �aden plik historii
nie zostaje u�yty. W oryginalnej wersji pow�oki
Korna natomiast, przyjmuje si� domy�lnie \fB$HOME/.sh_history\fP;
w przysz�o�ci mo�e pdksh, b�dzie r�wnie� stosowa� domy�lny
plik historii.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Liczba komend zapami�tywana w historii, domy�lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy�lna warto�� dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz: "Rozwijanie tyldy" poni�ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewn�trzny separator p�l, stosowany podczas podstawie�
i wykonywania komendy \fBread\fP, do rozdzielania
warto�ci na oddzielne argumenty; domy�lnie spacja, tabulator i
prze�amanie wiersza. Szczeg�y zosta�y opisane w punkcie "Podstawienia"
powy�ej.
.br
\fBUwaga:\fP ten parametr nie jest importowany z otoczenia,
podczas uruchamiania pow�oki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja i data kompilacji pow�oki (tylko do odczytu).
Patrz r�wnie� na komendy wersji w "Emacsowej interakcyjnej edycji wiersza
polece�" i "Edycji wiersza polece� vi" poni�ej.
.\"}}}
.\"{{{  SH_VERSION
.\"}}}
.\"{{{  LINENO
.IP \fBLINENO\fP
Numer wiersza w funkcji lub aktualnie wykonywanym skrypcie.
.\"}}}
.\"{{{  LINES
.IP \fBLINES\fP
Ilo�� wierszy terminala lub okienka pracy.
.\"Currently set to the \fBrows\fP value as reported by \fIstty\fP(1) if that
.\"value is non-zero.
.\" todo: LINES variable
.sp
Jeszcze niezaimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je�li ustawiony, to u�ytkownik jest informowany o nadej�ciu nowej poczty
do wymienionego w tej opcji pliku docelowego.
Ten parametr jest ignorowany, je�li zosta� ustawiony parametr
\fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak cz�sto pow�oka ma sprawdza�, czy pojawi�a si� nowa poczta
w plikach podanych przez \fBMAIL\fP lub \fBMAILPATH\fP.
Je�li 0, to pow�oka sprawdza przed ka�d� now� zach�t�.
Warto�ci� domy�ln� jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
Lista plik�w sprawdzanych w poszukiwaniu nowej poczty. Lista ta rozdzielana
jest dwukropkami, ponadto po nazwie ka�dego z plik�w mo�na poda�
\fB?\fP i wiadomo��, kt�ra ma by� wy�wietlona, je�li nadesz�a nowa poczta.
Dla danej wiadomo�ci zostan� wykonane podstawienia komend, parametr�w
i arytmetyczne. Podczas podstawie� parametr \fB$_\fP zawiera nazw�
tego pliku.
Domy�lnym zawiadomieniem o nowej poczcie jest \fByou have mail in $_\fP
(\fBmasz poczt� w $_\fP).
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nieustalony, je�li \fBcd\fP nie zmieni�o z powodzeniem
katalogu od czasu uruchomienia pow�oki lub je�li pow�oka nie wie, gdzie
si� aktualnie znajduje.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
Podczas u�ywania \fBgetopts\fP zawiera argument dla aktualnie
rozpoznawanej opcji, je�li jest on oczekiwany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostatniego przetworzonego argumentu podczas u�ywania \fBgetopts\fP.
Przyporz�dkowanie 1 temu parametrowi spowoduje, �e ponownie wywo�ane
\fBgetopts\fP przetworzy argumenty od pocz�tku.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem katalog�w, kt�re s� przeszukiwane
podczas odnajdywania jakiej� komendy lub plik�w typu \fB.\fP. Pusty �a�cuch
wynikaj�cy z pocz�tkowego lub ko�cowego dwukropka, albo dw�ch s�siednich
dwukropk�w jest traktowany jako `.', czyli katalog bie��cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Ustawienie tego parametru powoduje w��czenie opcji \fBposix\fP.
Patrz: "Tryb POSIX" poni�ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzicielskiego pow�oki (tylko do odczytu).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP to podstawowy symbol zach�ty dla pow�ok interakcyjnych.
Podlega podstawieniom parametr�w, komend i arytmetycznym, ponadto
\fB!\fP zostaje zast�pione kolejnym numerem polecenia
(patrz komenda \fBfc\fP
poni�ej). Sam znak ! mo�e zosta� umieszczony w zach�cie u�ywaj�c
!! w PS1.
Zauwa�, �e poniewa� edytory wiersza komendy staraj� si� obliczy�,
jak d�ugi jest symbol zach�ty (aby m�c ustali�, ile miejsca pozostaje
wolnego do prawego brzegu ekranu), sekwencje wyj�ciowe w zach�cie
zwykle wprowadzaj� pewien ba�agan.
Istnieje mo�liwo�� podpowiedzenia pow�oce, �eby nie uwzgl�dnia�a
pewnych ci�g�w znak�w (takich jak kody wyj�cia) przez podanie
przedrostka na pocz�tku symbolu zach�ty b�d�cego niewy�wietlalnym znakiem
(takim jak np. control-A) z nast�pstwem prze�amania wiersza
oraz odgraniczaj�c nast�pnie kody wyj�cia przy pomocy tego
niewy�wietlalnego znaku.
Gdy brak niewy�wietlalnych znak�w, to nie ma �adnej rady...
Nawiasem m�wi�c, nie ja jestem odpowiedzialny za ten hack. To pochodzi
z oryginalnego ksh.
Domy�ln� warto�ci� jest `\fB$\ \fP' dla nieuprzywilejowanych
u�ytkownik�w, a `\fB#\ \fP' dla roota..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Drugorz�dna zach�ta, o domy�lnej warto�ci `\fB>\fP ', kt�ra
jest stosowana, gdy wymagane s� dalsze wprowadzenia w celu
doko�czenia komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zach�ta stosowana przez wyra�enie
\fBselect\fP podczas wczytywania wyboru z menu.
Domy�lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, kt�re zostaj� wy�wietlone podczas
�ledzenia toku pracy
(patrz polcenie \fBset \-x\fP poni�ej).
Domy�lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo�e by� nieustawiony lub zerowy, je�li
pow�oka nie wie, gdzie si� znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb pseudolosowych. Za ka�dym razem, gdy
odnosimy si� do \fBRANDOM\fP, jego warto�ci zostaje przyporz�dkowana
nast�pna liczba z przypadkowego ci�gu liczb.
Miejsce w danym ci�gu mo�e zosta� ustawione nadaj�c
warto�� \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy�lny parametr komendy
\fBread\fP, je�li nie pozostan� podane jej �adne nazwy.
Stosowany r�wnie� w p�tlach \fBselect\fP do zapisu warto�ci
wczytywanej ze standardowego wej�cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Liczba sekund, kt�re up�yn�y od czasu uruchomienia pow�oki lub je�li
parametrowi zosta�a nadana warto�� ca�kowita, liczba sekund od czasu
nadania tej warto�ci plus ta warto��.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy ustawiony na pozytywn� warto�� ca�kowit�, wi�ksz� od zera,
w�wczas ustala w interakcyjnej pow�oce czas w sekundach, przez jaki
b�dzie ona czeka�a na wprowadzenie jakiego� polecenia po wy�wietleniu podstawowego symbolu
zach�ty (\fBPS1\fP). Po przekroczeniu tego czasu pow�oka zako�czy swoje dzia�anie.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog, w kt�rym umieszczane s� tymczasowe pliki pow�oki.
Je�li parametr ten nie jest ustawiony lub gdy nie zawiera
pe�nej �cie�ki do zapisywalnego katalogu, w�wczas domy�lnie tymczasowe
pliki mieszcz� si� w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je�li zosta� ustawiony, ustala tryb edycji wiersza komend w pow�okach
interakcyjnych. Je�li ostatni element �cie�ki podanej w tym
parametrze zawiera ci�g znak�w \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odpowiednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie tyldy"
Rozwijanie znak�w tyldy, kt�re ma miejsce r�wnolegle do podstawie� parametr�w,
zostaje wykonane na s�owach rozpoczynaj�cych si� niecytowanym
\fB~\fP. Znaki po tyldzie do pierwszego
\fB/\fP, je�li taki wyst�puje, s� domy�lnie traktowane jako
nazwa u�ytkownika.  Je�li nazwa u�ytkownika jest pusta lub ma warto�� \fB+\fP albo \fB\-\fP,
to zostaj podstawiona warto�� parametr�w odpowiednio\fBHOME\fP, \fBPWD\fP lub \fBOLDPWD\fP.
W przeciwnym razie zostaje
przeszukany plik hase� (plik passwd) w celu odnalezienia danej nazwy
u�ytkownika i w miejscu wyst�pienia tyldy zostaje
podstawiony katalog domowy danego u�ytkownika.
Je�li nazwa u�ytkownika nie zostanie odnaleziona w pliku hase�
lub gdy w nazwie u�ytkownika wystepuje jakiekolwiek cytowanie albo podstawienie
parametru, w�wczas nie zostaje wykonane �adne
podstawienie.
.PP
W ustawieniach parametr�w
(tych poprzedzaj�cych proste komendy lub tych wyst�puj�cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie znak�w tyld zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP) i nazwy u�ytkownik�w zostaj� uj�te
w dwukropki.
.PP
Katalogi domowe poprzednio rozwini�tych nazw u�ytkownik�w zostaj�
umieszczone w pami�ci podr�cznej i przy ponownym u�yciu zostaj� stamt�d
pobierane. Komenda \fBalias \-d\fP mo�e by� u�yta do wylistowania,
zmiany i dodania do tej pami�ci podr�cznej
(\fIw szczeg�lno�ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie nawias�w (przemiany)"
Rozwini�cia nawias�w przyjmuj�ce posta�
.RS
\fIprefiks\fP\fB{\fP\fIci�g\fP1\fB,\fP...\fB,\fP\fIci�g\fPN\fB}\fP\fIsufiks\fP
.RE
zostaj� rozwini�te w N wyraz�w, z kt�rych ka�dy zawiera konkatenacj�
\fIprefiks\fP, \fIci�g\fPn i \fIsufiks\fP
(\fIw szczeg�lno�ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwini�te do czterech wyraz�w:
ace, abXe, abYe i ade).
Jak ju� wy�ej wspomniano, rozwini�cia nawias�w mog� by� nak�adane na siebie,
a wynikaj�ce s�owa nie s� sortowane.
Wyra�enia nawiasowe musz� zawiera� niecytowany przecinek
(\fB,\fP), aby nast�pi�o rozwijanie
(\fItak wi�c\fP \fB{}\fP i \fB{foo}\fP nie zostaj� rozwini�te).
Rozwini�cie nawias�w nast�puje po podstawieniach parametr�w i przed
generowaniem nazw plik�w.
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce nazw plik�w"
.PP
Wzorcem nazwy pliku jest s�owo zwieraj�ce jeden lub wi�cej z
niecytowanych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.
Po wykonaniu rozwini�cia nawias�w, pow�oka zamienia wzorce nazw plik�w
na uporz�dkowane nazwy plik�w, kt�re pasuj� do tego wzorca
(je�li �adne pliki nie pasuj�, w�wczas dane s�owo zostaje pozostawione
bez zmian). Elementy wzorc�w maj� nast�puj�ce znaczenia:
.IP \fB?\fP
oznacza dowolny pojedynczy znak.
.IP \fB*\fP
oznacza dowoln� sekwencj� znak�w.
.IP \fB[\fP..\fB]\fP
oznacza ka�dy ze znak�w pomi�dzy klamrami. Mo�na poda� zakresy znak�w
u�ywaj�c \fB\-\fP pomi�dzy dwoma ograniczaj�cymi zakres znakami, tzn.
\fB[a0\-9]\fP oznacza liter� \fBa\fP lub dowoln� cyfr�.
Aby przedstawi� sam znak
\fB\-\fP nale�y go albo zacytowa� albo musi by� to pierwszy lub ostatni znak
w li�cie znak�w. Podobnie \fB]\fP musi albo by� wycytowywane, albo by� pierwszym
lub ostatnim znakiem w li�cie, je�li ma oznacza� samego siebie, a nie zako�czenie
listy. R�wnie� \fB!\fP wyst�puj�cy na pocz�tku listy ma specjalne
znaczenie (patrz poni�ej), tak wi�c aby reprezentowa� samego siebie
musi zosta� wycytowany lub wyst�powa� dalej w li�cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko �e oznacza dowolny znak
niewyst�puj�cy pomi�dzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
oznacza ka�dy ci�g zawieraj�cy zero lub wi�cej wyst�pie� podanych wzorc�w.
Przyk�adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci�gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka�dy ci�g znak�w obejmuj�cy jedno lub wi�cej wyst�pie� danych
wzorc�w.
Przyk�adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci�gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
oznacza ci�g pusty lub ci�g obejmuj�cy jeden z danych wzorc�w.
Przyk�adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci�gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci�g obejmuj�cy jeden z podanych wzorc�w.
Przyk�adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy��cznie ci�gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ci�g nie obejmuj�cy �adnego z danych wzorc�w.
Przyk�adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci�gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje �adnego ci�gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci�gi (prosz� si� nad tym zastanowi�).
.PP
Prosz� zauwa�y�, �e wzorce w pdksh obecnie nigdy nie obejmuj� \fB.\fP i
\fB..\fP, w przeciwie�stwie do oryginalnej pow�oki
ksh, Bourne'a sh i basha, tak wi�c to b�dzie musia�o si� ewentualnie
zmieni� (na z�e).
.PP
Prosz� zauwa�y�, �e powy�sze elementy wzorc�w nigdy nie obejmuj� kropki
(\fB.\fP) na pocz�tku nazwy pliku ani uko�nika (\fB/\fP),
nawet gdy zosta�y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s� obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je�li zosta�a ustawiona opcja \fBmarkdirs\fP, w�wczas,
wszelkie katalogi wynikaj�ce z generacji nazw plik�w
zostaj� oznaczone ko�cz�cym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znak�w (\fItzn.\fP,
\fB[:\fP\fInazwa_klasy\fP\fB:]\fP wewn�trz wyra�enia typu \fB[\fP..\fB]\fP)
jak na razie nie zosta�y zaimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierowanie wej�cia/wyj�cia"
Podczas wykonywania komendy, jej standardowe wej�cie, standardowe wyj�cie
i standardowe wyj�cie b��d�w (odpowiednio deskryptory plik�w 0, 1 i 2)
s� zwykle dziedziczone po pow�oce.
Trzema wyj�tkami od tej regu�y s� komendy w potokach, dla kt�rych
standardowe wej�cie i/lub standardowe wyj�cie odpowiadaj� tym, ustalonym przez
potok, komendy asychroniczne, tworzone je�li kontrola prac zosta�a
wy��czona, kt�rych standardowe wej�cie zostaje ustawione na
\fB/dev/null\fP, oraz komendy, dla kt�rych zosta�o ustawione jedno lub
kilka z nast�puj�cych przekierowa�:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj�cie zostaje przekierowane do \fIplik\fP-u.
Je�li \fIplik\fP nie istnieje, w�wczas zostaje utworzony;
je�li istnieje i jest to regularny plik oraz zosta�a ustawiona
opcja \fBnoclobber\fP, w�wczas wyst�puje b��d, w przeciwnym razie
dany plik zostaje uci�ty do pocz�tku.
Prosz� zwr�ci� uwag�, i� oznacza to, �e komenda \fIjaka�_komenda < foo > foo\fP
otworzy plik \fIfoo\fP do odczytu, a nast�pnie
skasuje jego zawarto��, gdy otworzy go do zapisu,
zanim \fIjaka�_komenda\fP otrzyma szans� przeczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e zawarto�� pliku zostanie skasowana
niezale�nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e je�li dany plik ju� istnieje, to
nowe dane b�d� dopisywane do niego, zamiast kasowania poprzedniej jego zawarto�ci.
Ponadto plik ten zostaje otwarty w trybie dopisywania, tak wi�c
wszelkiego rodzaju operacje zapisu na nim dotycz� jego aktualnego ko�ca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej�cie zostaje przekierowane do \fIplik\fPu,
kt�ry jest otwierany w trybie do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko �e plik zostaje otworzony w trybie
zapisu i czytania.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj�cego tego rodzaju przekierowanie
(zwane tu-dokumentem), pow�oka kopiuje wiersze z komendy
do tymczasowego pliku, a� do natrafienia na wiersz
odpowiadaj�cy \fIznacznik\fPowi.
Podczas wykonywania polecenia jego standardowe wej�cie jest przekierowane
do pewnego pliku tymczasowego.
Je�li \fIznacznik\fP nie zawiera wycytowanych znak�w, zawarto�� danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera�a si� w
podw�jnych cudzys�owach za ka�dym razem, gdy dana komenda jest wykonywana.
Tak wi�c zostan� na nim wykonane podstawienia parametr�w,
komend i arytmetyczne wraz z interpretacj� odwrotnego uko�nika
(\fB\e\fP) i znak�w wyj�� dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enowa_linia\fP.
Je�li wiele tu-dokument�w zostanie zastosowanych w jednym i tym samym
wierszy komendy, to s� one zachowane w podanej kolejno�ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko �e pocz�tkowe tabulatory
zostaj� usuni�te z tu-dokumentu.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej�cie zostaje powielone z deskryptora pliku \fIfd\fP.
\fIfd\fP mo�e by� pojedyncz� cyfr�, wskazuj�c� na numer
istniej�cego deskryptora pliku, liter�  \fBp\fP, wskazuj�c� na plik
powi�zany w wyj�ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj�cym, �e standardowe wej�cie powinno zosta�
zamkni�te.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko �e operacja dotyczy standardowego wyj�cia.
.PP
W ka�dym z powy�szych przekierowa�, mo�na poda� jawnie deskryptor
pliku, kt�rego ma ono dotyczy�, (\fItzn.\fP standardowego wej�cia
lub standardowego wyj�cia) przez poprzedzaj�c� odpowiedni� pojedyncz� cyfr�.
Podstawienia parametr�w komend, arytmetyczne, tyld, tak jak i
(gdy pow�oka jest interakcyjna) generacje nazw plik�w -
zostan� wykonane na argumentach przekierowa� \fIplik\fP, \fIznacznik\fP
i \fIfd\fP.
Trzeba jednak zauwa�y�, �e wyniki wszelkiego rodzaju generowania nazw
plik�w zostan� u�yte tylko wtedy, gdy okre�laj� nazw� jednego pliku;
je�li natomiast obejmuj� one wiele plik�w, w�wczas zostaje zastosowane
dane s�owo bez rozwini�� wynikaj�cych z generacji nazw plik�w.
Prosz� zwr�ci� uwag�, �e w pow�okach ograniczonych,
przekierowania tworz�ce nowe pliki nie mog� by� stosowane.
.PP
Dla prostych polece�, przekierowania mog� wyst�powa� w dowolnym miejscu
komendy, w komendach z�o�onych (wyra�eniach \fBif\fP, \fIitp.\fP),
wszelkie przekierowania musz� znajdowa� si� na ko�cu.
Przekierowania s� przetwarzane po tworzeniu potok�w i w kolejno�ci,
w jakiej zosta�y podane, tak wi�c
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy�wietli b��d z numerem linii wiersza poprzedzaj�cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra�enia arytmetyczne"
Ca�kowite wyra�enia arytmetyczne mog� by� stosowane przy pomocy
komendy \fBlet\fP, wewn�trz wyra�e� \fB$((\fP..\fB))\fP,
wewn�trz odwo�a� do tablic (\fIw szczeg�lno�ci\fP,
\fInazwa\fP\fB[\fP\fIwyra�enie\fP\fB]\fP),
jako numeryczne argumenty komendy \fBtest\fP,
i jako warto�ci w przyporz�dkowywaniach do ca�kowitych parametr�w.
.PP
Wyra�enia mog� zawiera� alfanumeryczne identyfikatory parametr�w,
odwo�ania do tablic i ca�kowite sta�e. Mog� zosta� r�wnie�
po��czone nast�puj�cymi operatorami j�zyka C:
(wymienione i zgrupowane w kolejno�ci rosn�cego
priorytetu).
.TP
Operatory unarne:
\fB+ \- ! ~ ++ --\fP
.TP
Operatory binarne:
\fB,\fP
.br
\fB= *= /= %= += \-= <<= >>= &= ^= |=\fP
.br
\fB||\fP
.br
\fB&&\fP
.br
\fB|\fP
.br
\fB^\fP
.br
\fB&\fP
.br
\fB== !=\fP
.br
\fB< <= >= >\fP
.br
\fB<< >>\fP
.br
\fB+ \-\fP
.br
\fB* / %\fP
.TP
Operator trinarny:
\fB?:\fP (priorytet jest bezpo�rednio wy�szy od przyporz�dkowania)
.TP
Operatory grupuj�ce:
\fB( )\fP
.PP
Sta�e ca�kowite mog� by� podane w dowolnej bazie, stosuj�c notacj�
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesi�tn� liczb�
ca�kowit� specyfikuj�c� baz�, a \fIliczba\fP jest liczb�
zapisan� w danej bazie.
.LP
Operatory s� wyliczane w nast�puj�cy spos�b:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy��cznie dla pe�no�ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je�li argument jest zerowy, a 0 je�li nie.
.IP "\fB~\fP"
arytmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi by� zastosowanym do parametru (a nie litera�u lub
innego wyra�enia) - parametr zostaje powi�kszony o 1.
Je�li zosta� zastosowany jako operator przedrostkowy, w�wczas wynikiem jest
inkrementowana warto�� parametru, a je�li zosta� zastosowany jako
operator przyrostkowy, to wynikiem jest pierwotna warto�� parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko �e wynikiem jest zmniejszenie parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra�enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nast�pnie prawa strona. Wynikiem jest warto��
wyra�enia po prawej stronie.
.IP "\fB=\fP"
przyporz�dkowanie; zmiennej po lewej zostaje nadana warto�� po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatory przyporz�dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je�li przynajmniej jeden
z argument�w jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je�li obydwa argumenty s� niezerowe,
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewy jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkcja (bit-w-bit).
.IP "\fB==\fP"
r�wno��; wynikiem jest 1, je�li obydwa argumenty s� sobie r�wne, 0 gdy nie.
.IP "\fB!=\fP"
nier�wno��; wynikiem jest 0, je�li obydwa argumenty s� sobie r�wne, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je�li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub r�wne, wi�ksze lub r�wne, wi�ksze od. Patrz <.
.IP "\fB<< >>\fP"
przesu� w lewo (prawo); wynikiem jest lewy argument z bitami przesuni�tymi
na lewo (prawo) o liczb� p�l podan� w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, r�nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego argumentu przez prawy.
Znak wyniku jest nieustalony, je�li kt�ry� z argument�w jest ujemny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je�li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to potok stworzony poprzez operator \fB|&\fP,
kt�ry jest procesemy asynchronicznym, do kt�rego pow�oka mo�e
zar�wno pisa� (u�ywaj�c \fBprint \-p\fP), jak i czyta� (u�ywaj�c \fBread \-p\fP).
Wej�ciem i wyj�ciem koprocesu mo�na r�wnie� manipulowa�
przy pomocy przekierowa� \fB>&p\fP i odpowiednio \fB<&p\fP.
Po uruchomieniu koprocesu, nast�pne nie mog� by� uruchomione dop�ki
dany koproces nie zako�czy pracy lub dop�ki wej�cie koprocesu
nie zostanie przekierowane przez \fBexec \fP\fIn\fP\fB>&p\fP.
Je�li wej�cie koprocesu zostanie przekierowane w ten spos�b, to
nast�pny w kolejce do uruchomienia koproces b�dzie
wsp�dzieli� wyj�cie z pierwszym koprocesem, chyba �e wyj�cie pierwszego
koprocesu zosta�o przekierowane przy pomocy
\fBexec \fP\fIn\fP\fB<&p\fP.
.PP
Pewne uwagi dotycz�ce koproces�w:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
jedyn� mo�liwo�ci� zamkni�cia wej�cia koprocesu
(tak aby koproces wczyta� zako�czenie pliku) jest przekierowanie
wej�cia na numerowany deskryptor pliku, a nast�pnie zamkni�cie tego
deskryptora (w szczeg�lno�ci, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby koprocesy mog�y wsp�dzieli� jedno wyj�cie, pow�oka musi
zachowa� otwart� cz�� wpisow� danego potoku wyj�ciowego.
Oznacza to, �e zako�czenie pliku nie zostanie wykryte do czasu, a�
wszystkie koprocesy wsp�dziel�ce wyj�cie  zostan� zako�czone
(gdy zostan� one zako�czone, w�wczas  pow�oka zamyka swoj� kopi�
potoku).
Mo�na temu zapobiec przekierowuj�c wyj�cie na numerowany
deskryptor pliku
(poniewa� powoduje to r�wnie� zamkni�cie przez pow�ok� swojej kopii).
Prosz� zwr�ci� uwag�, i� to zachowanie  jest nieco odmienne od oryginalnej
pow�oki Korna, kt�ra zamyka cz�� zapisow� swojej kopii wyj�cia
koprocesu, gdy ostatnio uruchomiony koproces
(zamiast gdy wszystkie wsp�dziel�ce koprocesy) zostanie zako�czony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna� SIGPIPE podczas zapisu, je�li
dany sygna� nie zosta� przechwycony lub zignorowany; nie zachodzi to jednak,
gdy wej�cie koprocesu zosta�o powielone na inny deskryptor pliku
i stosowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje si� albo przy pomocy syntaktyki pow�oki
Korna \fBfunction\fP \fIname\fP,
albo syntaktyki pow�oki Bourne'a/POSIX-owej: \fIname\fP\fB()\fP
(patrz poni�ej, co do r�nic zachodz�cych pomi�dzy tymi dwiema formami).
Funkcje, tak jak i \fB.\fP-skrypty, s� wykonywane w bie��cym
otoczeniu, aczkolwiek, w przeciwie�stwie do \fB.\fP-skrypt�w,
argumenty pow�oki
(\fItzn.\fP argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) nigdy nie s�
widoczne wewn�trz nich.
Podczas ustalania po�o�enia komendy, funkcje s� przeszukiwane po przeszukaniu
specjalnych komend wbudowanych, za� przed regularnymi oraz nieregularnymi
komendami wbudowanymi i przed przeszukaniem \fBPATH\fP.
.PP
Istniej�ca funkcja mo�e zosta� usuni�ta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
List� funkcji mo�na otrzyma� poprzez \fBtypeset +f\fP, a definicje
funkcji mo�na otrzyma� poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo�e zosta�
u�yte do tworzenia niezdefiniowanych funkcji.
Je�li ma by� wykonana niezdefiniowana funkcja, w�wczas pow�oka
przeszukuje �cie�k� podan� w parametrze \fBFPATH\fP szukaj�c pliku
o nazwie identycznej z nazw� danej funkcji. Je�li plik taki zostanie
odnaleziony, to b�dzie wczytany i wykonany.
Je�li po wykonaniu tego pliku dana funkcja b�dzie zdefiniowana, w�wczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk�e
odnajdywanie komend
(\fItzn.\fP, pow�oka przeszukuje tablic� zwyk�ych komend wbudowanych
i \fBPATH\fP).
Prosz� zwr�ci� uwag�, �e je�li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, w�wczas zostaje podj�ta pr�ba odnalezienia
funkcji przez \fBFPATH\fP (jest to nieudokumentowanym zachowaniem
si� oryginalnej pow�oki Korna).
.PP
Funkcje mog� mie� dwa atrybuty - �ledzenia i eksportowania, kt�re
mog� by� ustawiane przez \fBtypeset \-ft\fP i odpowiednio
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji �ledzonej, opcja \fBxtrace\fP pow�oki
zostaje w��czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy��czona.
Atrybut eksportowania nie jest obecnie u�ywany.  W oryginalnej
pow�oce Korna, wyeksportowane funkcje s� widoczne dla skrypt�w pow�oki,
gdy s� one wykonywane.
.PP
Poniewa� funkcje s� wykonywane w obecnym kontek�cie pow�oki,
przyporz�dkowania parametr�w wykonane wewn�trz funkcji pozostaj�
widoczne po zako�czeniu danej funkcji.
Je�li jest to niepo��dane, w�wczas komenda \fBtypeset\fP mo�e
by� zastosowana wewn�trz funkcji do tworzenia lokalnych parametr�w.
Prosz� zwr�ci� uwag�, i� w �aden spos�b nie mo�na ograniczy� widoczno�ci
parametr�w specjalnych (tzn. \fB$$\fP, \fB$!\fP).
.PP
Kodem wyj�cia funkcji jest kod wyj�cia ostatniej wykonanej w niej komendy.
Funkcj� mo�na przerwa� bezpo�rednio przy pomocy komendy \fBreturn\fP;
mo�na to r�wnie� zastosowa� do jawnego okre�lenia kodu wyj�cia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s�owa \fBfunction\fP, s�
traktowane odmiennie w nast�puj�cych punktach od funkcji zdefiniowanych
poprzez notacj� \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje ustawiony na nazw� funkcji
(funkcje w stylu Bourne'a nie dotykaj� \fB$0\fP).
.IP \ \ \(bu
przyporz�dkowania warto�ci parametrom poprzedzaj�ce wywo�anie
funkcji nie zostaj� zachowane w bie��cym kontek�cie pow�oki
(wykonywanie funkcji w stylu Bourne'a zachowuje te
przyporz�dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostanie zachowany i skasowany
na pocz�tku oraz nast�pnie odtworzony na zako�czenie funkcji, tak wi�c
\fBgetopts\fP mo�e by� poprawnie stosowane zar�wno wewn�trz funckji, jak i poza
nimi
(funkcje w stylu Bourne'a nie dotykaj� \fBOPTIND\fP, tak wi�c
stosowanie \fBgetopts\fP wewn�trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.br
.nr PD \n(P2
W przysz�o�ci zostan� dodane r�wnie� nast�puj�ce r�nice:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Podczas wykonywania funkcji b�dzie stosowany oddzielny kontekst
�ledzenia/sygna��w.
Tak wi�c �ledzenia ustawione wewn�trz funkcji nie b�d� mia�y wp�ywu
na �ledzenia i sygna�y pow�oki, nieignorowane przez ni� (kt�re mog�
by� przechwytywane), i b�d� mia�y domy�lne ich znaczenie wewn�trz funkcji.
.IP \ \ \(bu
�ledzenie EXIT-a, je�li zostanie ustawione wewn�trz funkcji,
zostanie wykonane po zako�czeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana pow�oka ma by� w zasadzie zgodna ze standardem POSIX,
jednak, w niekt�rych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem oryginalnej
pow�oki Korna, albo z wygod� u�ytkownika.
To, jak pow�oka zachowuje si� w takich wypadkach, jest ustalane
stanem opcji posix (\fBset \-o posix\fP) \(em je�li jest ona
w��czona, to zachowuje si� zgodnie z POSIX-em, a w przeciwnym
razie - nie.
Opcja \fBposix\fP zostaje automatycznie ustawiona, je�li pow�oka startuje
w otoczeniu zawieraj�cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Pow�ok� mo�na r�wnie� skompilowa� tak, aby zachowanie zgodne z
POSIX-em by�o domy�lnie ustawione, ale jest to zwykle
niepo��dane).
.PP
A oto lista wp�yw�w ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn�trz cytowanych podw�jnymi cudzys�owami \fB`\fP..\fB`\fP
podstawie� komend:
w trybie POSIX-owym, \fB\e"\fP jest interpretowany podczas interpretacji
komendy;
w trybie nie-POSIX-owym, odwrotny uko�nik zostaje usuni�ty przed
interpretacj� podstawienia komendy.
Na przyk�ad\fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie POSIX-owym, `hi' a w trybie nie-POSIX-owym.
W celu unikni�cia problem�w, prosz� stosowa� posta� \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
wyj�cie \fBkill \-l\fP: w trybie POSIX-owym nazwy sygna��w
s� wymieniane wiersz po wierszu;
w nie-POSIX-owym trybie numery sygna��w, ich nazwy i opis zostaj� wymienione
w kolumnach.
W przysz�o�ci zostanie dodana nowa opcja (zapewne \fB\-v\fP) w celu
rozr�nienia tych dw�ch zachowa�.
.IP \ \ \(bu
kod wyj�cia \fBfg\fP: w trybie POSIX-owym, kod wyj�cia wynosi
0, je�li nie wyst�pi�y �adne b��dy;
w trybie nie-POSIX-owym, kod wyj�cia odpowiada kodowi ostatniego zadania
wykonywanego w pierwszym planie.
.IP \ \ \(bu
kod wyj�cia polecenia\fBeval\fP: je�eli argumentem eval b�dzie puste polecenie
(\fInp.\fP: \fBeval "`false`"\fP), to jego kodem wyj�cia w trybie POSIX-owym b�dzie 0.
W trybie nie-POSIX-owym, kodem wyj�cia b�dzie kod wyj�cia ostatniego podstawienia
komendy, kt�re zosta�o dokonane podczas przetwarzania argument�w polecenia eval
(lub 0, je�li nie by�o podstawie� komen).
.IP \ \ \(bu
\fBgetopts\fP: w trybie POSIX-owym, opcje musz� zaczyna� si� od \fB\-\fP;
w trybie nie-POSIX-owym, opcje mog� si� zaczyna� albo od \fB\-\fP, albo od \fB+\fP.
.IP \ \ \(bu
rozwijanie nawias�w (zwane r�wnie� przemian�): w trybie POSIX-owym
rozwijanie nawias�w jest wy��czone; w trybie nie-POSIX-owym
rozwijanie nawias�w jest w��czone.
Prosz� zauwa�y�, �e \fBset \-o posix\fP (lub ustawienie
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy��cza opcj� \fBbraceexpand\fP, mo�e ona by� jednak jawnie
w��czona p�niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie POSIX-owym, nie wy��cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-POSIX-owym, wy��cza.
.IP \ \ \(bu
kod wyj�cia \fBset\fP: w trybie POSIX-owym,
kod wyj�cia wynosi 0, je�li nie wyst�pi�y �adne b��dy;
w trybie nie-POSIX-owym, kod wyj�cia odpowiada kodowi
wszelkich podstawie� komend wykonywanych podczas generacji komendy set.
Przyk�adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie POSIX-owym,
a 1 w trybie nie-POSIX-owym.  Taka konstukcja stosowana jest w wi�kszo�ci
skrypt�w pow�oki stosuj�cych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argument�w komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP i
\fBtypeset\fP: w trybie POSIX-owym, nast�puje normalne rozwijanie argument�w;
w trybie nie-POSIX-owym, rozdzielanie p�l, dopasowywanie nazw plik�w,
rozwijanie nawias�w i (zwyk�e) rozwijanie tyld s� wy��czone, ale
rozwijanie tyld w przyporz�dkowaniach pozostaje w��czone.
.IP \ \ \(bu
specyfikacja sygna��w: w trybie POSIX-owym, sygna�y mog� by�
podawane jedynie cyframi, je�li numery sygna��w s� zgodne z
warto�ciami z POSIX-a (\fItzn.\fP HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14 i TERM=15); w trybie nie-POSIX-owym,
sygna�y  zawsze mog� by� podane cyframi.
.IP \ \ \(bu
rozwijanie alias�w: w trybie POSIX-owym, rozwijanie alias�w
zostaje jedynie wykonywane, podczas wczytywania s��w komend; w trybie
nie-POSIX-owym, rozwijanie alias�w zostaje wykonane r�wnie� na
ka�dym s�owie po jakim� aliasie, kt�re ko�czy si� bia�� przerw�.
Na przyk�ad nast�puj�ca p�tla for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u�ywa parameteru \fBi\fP w trybie POSIX-owym, natomiast \fBj\fP w
trybie nie-POSIX-owym.
.IP \ \ \(bu
test: w trybie POSIX-owym, wyra�enie "\fB-t\fP" (poprzedzone pewn�
liczb� argument�w "\fB!\fP") zawsze jest prawdziwe, gdy� jest
ci�giem o d�ugo�ci niezerowej; w nie-POSIX-owym trybie, sprawdza czy
deskryptor pliku 1 jest jakim� tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo�e zosta� pomini�ty i jest
domy�lnie r�wny 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie komend"
Po wyliczeniu argument�w wiersza komendy, wykonaniu przekierowa�
i przyporz�dkowa� parametr�w, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku, kt�ry nale�y wykona�, znajdowanego przy pomocy parametru
\fBPATH\fP.
Testy te zostaj� wykonane w wy�ej podanym porz�dku.
Specjalne wbudowane komendy r�ni� si� tym od innych komend,
�e do ich odnalezienia nie jest u�ywany parametr \fBPATH\fP, b��d
podczas ich wykonywania mo�e spowodowa� zako�czenie pow�oki nieinterakcyjnej
i przyporz�dkowania warto�ci parametr�w poprzedzaj�ce
komend� zostaj� zachowane po jej wykonaniu.
Aby tylko wprowadzi� zamieszanie, je�li opcja
posix zosta�a w��czona (patrz komenda \fBset\fP
poni�ej), to pewne specjale komendy staj� si� bardzo specjalne, gdy�
nie jest wykonywane rozdzielanie p�l, rozwijanie nazw plik�w,
rozwijanie nawias�w, ani rozwijanie tyld na argumentach,
kt�re wygl�daj� jak przyporz�dkowania.
Zwyk�e wbudowane komendy wyr�niaj� si� jedynie tym, �e
do ich odnalezienia nie jest stosowany parametr \fBPATH\fP.
.PP
Oryginalny ksh i POSIX r�ni� si� nieco w tym, jakie
komendy s� traktowane jako specjalne, a jakie jako zwyk�e:
.IP "Specjalne polecenia w POSIX"
.TS
lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB .
\&.	continue	exit	return	trap
:	eval	export	set	unset
break	exec	readonly	shift
.TE
.IP "Dodatkowe specjalne komendy w ksh"
.TS
lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB .
builtin	times	typeset		
.TE
.IP "Bardzo specjalne komendy (tryb nie-POSIX-owy)"
.TS
lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB .
alias	readonly	set	typeset	
.TE
.IP "Regularne komendy w POSIX"
.TS
lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB .
alias	command	fg	kill	umask
bg	false	getopts	read	unalias
cd	fc	jobs	true	wait
.TE
.IP "Dodatkowe regularne komendy ksh"
.TS
lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB lw(8m)fB .
[	let	pwd	ulimit	
echo	print	test	whence	
.TE
.PP
W przysz�o�ci dodatkowe specjalne komendy oraz regularne komendy ksh
mog� by� traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz�dkowania warto�ci parametr�w
zostaj� wykonane i wyeksportowane na czas trwania komendy.
.PP
Poni�ej opisujemy specjalne i regularne polecenia wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wykonaj komendy z \fIplik\fPu w bie��cym otoczeniu.
Plik zostaje odszukiwany przy u�yciu katalog�w z \fBPATH\fP.
Je�li zosta�y podane argumenty, to parametry pozycyjne mog� by�
u�ywane w celu uzyskania dost�pu do nich podczas wykonywania \fIplik\fPu.
Je�eli nie zosta�y podane �adne argumenty, to argumenty pozycyjne
odpowiadaj� tym z bie��cego otoczenia, w kt�rym dana komenda zosta�a
u�yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Kodem wyj�cia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto��1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
Bez argument�w, \fBalias\fP wy�wietla wszystkie obecne aliasy.
Dla ka�dej nazwy bez podanej warto�ci zostaje wy�wietlony istniej�cy
odpowiedni alias.
Ka�da nazwa z podan� warto�ci� definiuje alias (patrz: "Aliasy" powy�ej).
.sp
Do wy�wietlania alias�w u�ywany jest jeden z dw�ch format�w:
zwykle aliasy s� wy�wietlane jako \fInazwa\fP\fB=\fP\fIwarto��\fP, przy czym
\fIwarto��\fP jest cytowana; je�li opcje mia�y przedrostek \fB+\fP
lub samo \fB+\fP zosta�o podane we wierszu komendy, tylko \fInazwa\fP
zostaje wy�wietlona.
Ponad to, je�li zosta�a zastosowana opcja \fB\-p\fP, to dodatkow ka�dy wiersz
zaczyna si� od ci�gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP ustawia (a \fB+x\fP kasuje) atrybut eksportu dla aliasu,
lub je�li nie podano �adnych nazw, wy�wietla aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma ma �adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, �e �ledzone aliasy maj� by� wy�wietlone/ustawione
(warto�ci podane w wierszu komendy zostaj� zignorowane dla �ledzonych
alias�w).
Opcja \fB\-r\fP wskazuje, �e wszystkie �ledzone aliasy
maj� zosta� usuni�te.
.sp
Opcja \fB\-d\fP nakazuje wy�witlenie lub ustawienie alias�w katalog�w,
kt�re s� stosowane w rozwini�ciach tyld
(patrz: "Rozwini�cia tyld" powy�ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je�li nie podano �adnego zadania, to przyjmuje si� domy�lnie \fB%+\fP.
Ta komenda jest dost�pna jedynie w systemach obs�uguj�cych kontrol� zada�.
Dalsze informacje mo�na znale�� poni�ej w rozdziale "Kontrola zada�".
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Ustawienie lub wyliczenie obecnych przyporz�dkowa� klawiszy/makr w
emacsowym trybie edycji komend.
Patrz "Interakcyjna emacsowa edycja wiersza komendy" w celu pe�nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fP zagnie�d�enia w p�tlach
for, select, until lub while.
Domy�lnie \fIpoziom\fP wynosi 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan� komend� \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.
Je�li zosta� ustawiony parametr \fBCDPATH\fP, to wypisuje
list� katalog�w, w kt�rych b�dzie szuka� \fIkatalog\fPu.
Pusta zawarto�� w \fBCDPATH\fP oznacza katalog bie��cy.
Je�li zostanie u�yty niepusty katalog z \fBCDPATH\fP,
to na standardowym wyj�ciu b�dzie wy�wietlona jego pe�na �cie�ka.
Je�li nie podano \fIkatalog\fPu, to
zostanie u�yty katalog domowy \fB$HOME\fP.  Je�li \fIkatalog\fPiem jest
\fB\-\fP, to zostanie zastosowany poprzedni katalog roboczy (patrz
parametr OLDPWD).
Je�li u�yto opcji \fB\-L\fP (�cie�ka logiczna) lub je�li
nie zosta�a ustawiona opcja \fBphysical\fP
(patrz komenda \fBset\fP poni�ej), w�wczas odniesienia do \fB..\fP w
\fIkatalogu\fP s� wzgl�dne wobec �cie�ki zastosowanej do doj�cia do danego
katalogu.
Je�li podano opcj� \fB\-P\fP (fizyczna �cie�ka) lub gdy zosta�a ustawiona
opcja \fBphysical\fP, to \fB..\fP jest wzgl�dne wobec drzewa katalog�w
systemu plik�w.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj� uaktualnione tak, aby odpowiednio
zawiera�y bie��cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci�g \fInowy\fP zostaje podstawiony w zamian za \fIstary\fP w bie��cym
katalogu i pow�oka pr�buje przej�� do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je�li nie zosta�a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, to
\fIkomenda\fP
zostaje wykonana dok�adnie tak, jakby nie podano \fBcommand\fP,
z dwoma wyj�tkami: po pierwsze, \fIkomenda\fP nie mo�e by� funkcj� w pow�oce,
oraz po drugie, specjalne wbudowane komendy trac� swoj� specjalno�� (tzn.
przekierowania i b��dy w u�yciu nie powoduj�, �e pow�oka zostaje zako�czona, a
przyporz�dkowania parametr�w nie zostaj� wykonane).
Je�li podano opcj� \fB\-p\fP, zostaje zastosowana pewna domy�lna �cie�ka
zamiast obecnej warto�ci \fBPATH\fP (warto�� domy�lna �cie�ki jest zale�na
od systemu, w jakim pracujemy: w systemach POSIX-owych jest to
warto�� zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je�li podano opcj� \fB\-v\fP, to zamiast wykonania polecenia \fIkomenda\fP,
zostaje podana informacja, co by zosta�o wykonane (i to samo dotyczy
r�wnie� \fIarg1\fP ...):
dla specjalnych i zwyk�ych wbudowanych komend i funkcji,
zostaj� po prostu wy�wietlone ich nazwy,
dla alias�w, zostaje wy�wietlona komenda definiuj�ca dany alias,
oraz dla komend odnajdowanych przez przeszukiwanie zawarto�ci
parametru \fBPATH\fP, zostaje wy�wietlona pe�na �cie�ka danej komendy.
Je�li komenda nie zostanie odnaleziona, (tzn. przeszukiwanie �cie�ki
nie powiedzie si�), nic nie zostaje wy�wietlone i \fBcommand\fP zostaje
zako�czone z niezerowym kodem wyj�cia.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko �e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP skacze na pocz�tek \fIpoziom\fPu z najg��biej
zagnie�d�onej p�tli for,
select, until lub while.
\fIlevel\fP domy�lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy�wietla na standardowym wyj�ciu swoje argumenty (rozdzielone spacjami),
zako�czone prze�amaniem wiersza.
Prze�amanie wiersza nie nast�puje, je�li kt�rykolwiek z parametr�w
zawiera sekwencj� odwrotnego uko�nika \fB\ec\fP.
Patrz komenda \fBprint\fP poni�ej, co do listy innych rozpoznawanych
sekwencji odwrotnych uko�nik�w.
.sp
Nast�puj�ce opcje zosta�y dodane dla zachowania zgodno�ci ze
skryptami z system�w BSD:
\fB\-n\fP wy��cza ko�cowe prze�amanie wiersza, \fB\-e\fP w��cza
interpretacj� odwrotnych uko�nik�w (operacja zerowa, albowiem ma to
domy�lnie miejsce) oraz \fB\-E\fP wy��czaj�ce interpretacj�
odwrotnych uko�nik�w.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Argumenty zostaj� powi�zane (z przerwami pomi�dzy nimi) do jednego
ci�gu, kt�ry nast�pnie pow�oka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez rozwidlania (fork), zast�puj�c proces pow�oki.
.sp
Je�li nie podano �adnych argument�w wszelkie przekierowania wej�cia/wyj�cia
s� dozwolone i pow�oka nie zostaje zast�piona.
Wszelkie deskryptory plik�w wi�ksze ni� 2 otwarte lub z\fIdup\fP(2)-owane
w ten spos�b nie s� dost�pne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbudowanych w pow�ok�).
Zauwa�, �e pow�oka Bourne'a r�ni si� w tym:
przekazuje bowiem deskryptory plik�w.
.\"}}}
.\"{{{  exit [kod]
.IP "\fBexit\fP [\fIkod\fP]"
Pow�oka zostaje zako�czona z podanym kodem wyj�cia.
Je�li \fIkod\fP nie zosta� podany, w�wczas kod wyj�cia
przyjmuje bie��c� warto�� parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Ustawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj� przekazywane w otoczeniu do wykonywanych
komend.
Je�li podano warto�ci, to zostaj� one r�wnie� przyporz�dkowane
danym parametrom.
.sp
Je�li nie podano �adnych parametr�w, w�wczas nazwy wszystkich parametr�w
z atrybutem eksportu zostaj� wy�wietlone wiersz po wierszu, chyba �e u�yto
opcji \fB\-p\fP, wtedy zostaj� wy�wietlone komendy
\fBexport\fP definiuj�ce wszystkie eksportowane parametry wraz z ich
warto�ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda ko�cz�ca si� z niezerowym kodem powrotu.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj� komendy z historii.
Komendy mo�emy wybiera� przy pomocy ich numeru w historii
lub podaj�c ci�g znak�w okre�laj�cy ostatnio u�yt� komend� rozpoczynaj�c�
si� od tego� ci�gu.
Opcja \fB\-l\fP wy�wietla dan� komend� na stdout,
a \fB\-n\fP wy��cza domy�lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno�� komend w li�cie historii.  Bez \fB\-l\fP, wybrane
komendy podlegaj� edycji przez edytor podany poprzez opcj�
\fB\-e\fP, albo je�li nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je�li nie zosta� ustawiony ten
parametr, w�wczas stosuje si� \fB/bin/ed\fP),
i nast�pnie wykonana przez pow�ok�.
.\" -(rl)- 
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran� komend� (domy�lnie poprzedni� komend�) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je�li
podano \fB\-g\fP, w�wczas wszelkie wyst�pienia \fIstare\fP zostaj�
zast�pione przez \fInowe\fP.  Z tej komendy korzysta si� zwykle
przy pomocy zdefiniowanego domy�lnie aliasu \fBr='fc \-e \-'\fP.
.\"}}}
.\"{{{  fg [job ...]
.IP "\fBfg\fP [\fIzadanie\fP ...]"
Przywr�� na pierwszy plan zadanie(-nia).
Je�li nie podano jawnie �adnego zadania, w�wczas odnosi si� to
domy�lnie do \fB%+\fP.
Ta komenda jest jedynie dost�pna na systemach wspomagaj�cych
kontrol� zada�.
Patrz Kontrola Zada� dla dalszych informacji.
.\"}}}
.\"{{{  getopts optstring name [arg ...]
.IP "\fBgetopts\fP \fIci�gopt\fP \fInazwa\fP [\fIarg\fP ...]"
\fBgetopts\fP jest stosowany przez procedury pow�oki
do rozeznawania podanych argument�w
(lub parametr�w pozycyjnychi, je�li nie podano �adnych argument�w)
i do sprawdzenia zasadno�ci opcji.
\fIci�gopt\fP zawiera litery opcji, kt�re
\fBgetopts\fP ma rozpoznawa�.  Je�li po literze wyst�puje przecinek,
w�wczas oczekuje si�, �e opcja posiada argument.
Opcje nieposiadaj�ce argument�w mog� by� grupowane w jeden argument.
Je�li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w kt�rym si� znajduje, w�wczas reszta argumentu
zostaje potraktowana jako argument danej opcji. W przeciwnym razie
nast�pny argument jest argumentem opcji.
.sp
Za ka�dym razem, gdy zostaje wywo�ane \fBgetopts\fP,
umieszcza si� nast�pn� opcj� w parametrze pow�oki
\fInazwa\fP i indeks nast�pnego argumentu pod obr�bk�
w parametrze pow�oki \fBOPTIND\fP.
Je�li opcja zosta�a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z przedrostkiem \fB+\fP.
Je�li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze pow�oki \fBOPTARG\fP.
Je�li natrafi si� na niedopuszczaln� opcj� lub brakuje
argumentu opcji, w�wczas w \fInazwa\fP zostaje umieszczony znak zapytania
albo dwukropek
(wskazuj�c na nielegaln� opcj�, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje ustawiony na znak, kt�ry by� przyczyn� tego problemu.
Ponadto zostaje w�wczas wy�wietlony komunikat o b��dzie na standardowym
wyj�ciu b��d�w, je�li \fIci�gopt\fP nie zaczyna si� od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa prac�
niezerowym kodem wyj�cia.
Opcje ko�cz� si� na pierwszym (nie podlegaj�cym opcji) argumencie,
kt�ry nie rozpoczyna si� od \-, albo je�li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawanie opcji mo�e zosta� ponowione ustawiaj�c \fBOPTIND\fP na 1
(co nast�puje automatycznie za ka�dym razem, gdy pow�oka lub
funkcja w pow�oce zostaje wywo�ana).
.sp
Ostrze�enie: Zmiana warto�ci parametru pow�oki \fBOPTIND\fP na
warto�� wi�ksz� ni� 1, lub rozpoznawanie odmiennych zestaw�w
parametr�w bez ponowienia \fBOPTIND\fP mo�e doprowadzi� do nieoczekiwanych
wynik�w.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je�li brak argument�w, w�wczas wszystkie �cie�ki
wykonywalnych komend z kluczem s� wymieniane.
Opcja \fB\-r\fP nakazuje wyrzucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka�da \fInazwa\fP zostaje odszukiwana tak, jak by to by�a nazwa komendy
i dodana do tablicy kluczy je�li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy�wietl informacje o danych zadaniach; gdy nie podano �adnych
zada� wszystkie zadania zostaj� wy�wietlone.
Je�li podano opcj� \fB\-n\fP, w�wczas informacje zostaj� wy�wietlone
jedynie o zadaniach kt�rych stan zmieni� si� od czasu ostatniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka�dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, �e zostaje wy�wietlona jedynie
jedynie grupa procesowa ka�dego zadania.
patrz Kontrola Zada� dla informacji o formie parametru
\fIzdanie\fP i formacie w kt�rym zostaj� wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy�lij dany sygna� do danych zada�, proces�w z danym id, lub grup
proces�w.
Je�li nie podano jawnie �adnego sygna�u, w�wczas domy�lnie zostaje wys�any
sygna� TERM.
Je�li podano zadanie, w�wczas sygna� zostaje wys�any do grupy
proces�w danego zadania.
Patrz poni�ej Kontrola Zada� dla informacji o formacie \fIzadania\fP.
.IP "\fBkill \-l\fP [\fIkod_wyj�cia\fP ...]"
Wypisz nazw� sygna�u, kt�ry zabi� procesy, kt�re zako�czy�y si�
danym \fIkodem_wyj�cia\fP.
Je�li brak argument�w, w�wczas zostaje wy�wietlona lista
wszelkich sygna��w i ich numer�w, wraz z kr�tkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra�enie\fP ...]"
Ka�de wyra�enie zostaje wyliczone, patrz Wyra�enie Arytmetyczne powy�ej.
Je�li wszelkie wyra�enia zosta�y poprawnie wyliczone, kodem wyj�cia
jest 0 (1), je�li warto�ci� ostatniego wyra�enia
 nie by�o zero (zero).
Je�li wyst�pi b��d podczas rozpoznawania lub wyliczania wyra�enia,
kod wyj�cia jest wi�kszy od 1.
Poniewa� mo�e zaj�� konieczno�� wycytowania wyra�e�, wi�c
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s�odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy�wietla swe argumenty na standardowym wyj�ciu, rozdzielone
przerwami i zako�czone prze�amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy�lnemu prze�amaniu wiersza.
Domy�lnie pewne wyprowadzenia z C zostaj� odpowiednio przet�umaczone.
W�r�d nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0###
(# oznacza cyfr� w systemie �semkowym, tzn. od 0 po 3).
\ec jest r�wnowa�ne z zastosowaniem opcji \fB\-n\fP.  \e wyra�eniom
mo�na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pliku historii zamiast
standardowego wyj�cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wynosi domy�lnie 1 przy pomini�ciu),
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy�ej).
.sp
Opcja \fB\-R\fP jest stosowana do emulacji, w pewnym stopniu, komendy
echo w wydaniu BSD, kt�ra nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy�ej opcja \fB\-n\fP zapobiega ko�cowemu prze�amaniu wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bie��cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta�a ustawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni�ej), zostaje wy�wietlona �cie�ka
logiczna (tzn. �cie�ka konieczna aby wykona� \fBcd\fP do bie��cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (�cie�ka fizyczna) lub gdy
zosta�a ustawiona opcja \fBphysical\fP, zostaje wy�wietlona �cie�ka
ustalona przez system plik�w (�ledz�c katalogi \fB..\fP a� po katalog g��wny).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej�cia, rozdziela ten
wiersz na pola przy uwzgl�dnieniu parametru \fBIFS\fP (
patrz Podstawienia powy�ej), i przyporz�dkowuje pola odpowiednio danym
parametrom.
Je�li mamy wi�cej parametr�w ni� p�l, w�wczas dodatkowe parametry zostaj�
ustawione na zero, a natomiast je�li jest wi�cej p�l ni� paramter�w to
ostatni parametr otrzymuje jako warto�� wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj�cymi przerwami).
Je�li nie podano �adnych parametr�w, w�wczas zostaje zastosowany
parametr \fBREPLY\fP.
Je�li wiersz wprowadzania ko�czy si� odwrotnym uko�nikiem
i nie podano opcji \fB\-r\fP, to odwrotny uko�nik i prze�amanie
wiersza zostaj� usuni�te i zostaje wczytana dalsza cz�� danych.
Gdy nie zostanie wczytane �adne wprowadzenie, \fBread\fP ko�czy si�
niezerowym kodem wyj�cia.
.sp
Pierwszy parametr mo�e mie� do��czony znak zapytania i ci�g, co oznacza, �e
dany ci�g zostanie zastosowany jako zach�ta do wprowadzenia
(wy�wietlana na standardowym wyj�ciu b��d�w zanim
zostanie wczytane jakiekolwiek wprowadzenie) je�li wej�cie jest terminalem
(\fIe.g.\fP, \fBread nco�?'ile co�k�w: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj�, �e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bie��cego koprocesu
(patrz komentarze na ten temat w Koprocesy powy�ej).
Je�li zastosowano opcj� \fB\-s\fP, w�wczas wprowadzenie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Patrz parametr wy��cznego odczytu nazwanych parametr�w.
Je�li zosta�y podane warto�ci w�wczas zostaj� one nadane parametrom przed
ustawieniem danego atrybutu.
Po nadaniu cechy wy��cznego odczytu parametrowi, nie ma wi�cej mo�liwo�ci
wykasowania go lub zmiany jego warto�ci.
.sp
Je�li nie podano �adnych parametr�w, w�wczas zostaj� wypisane nazwy
wszystkich parametr�w w cech� wy��cznego odczytu wiersz po wierszu, chyba
�e zastosowano opcj� \fB\-p\fP, co powoduje wypisanie pe�nych komend
\fBreadonly\fP definiuj�cych parametry wy��cznego odczytu wraz z ich
warto�ciami.
.\"}}}
.\"{{{  return [kod]
.IP "\fBreturn\fP [\fIkod\fP]"
Powr�t z funkcji lub \fB.\fP skryptu, z kodem wyj�cia \fIkod\fP.
Je�li nie podano warto�ci \fIkod\fP, w�wczas zostaje domy�lnie
zastosowany kod wyj�cia ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcj� lub \fB.\fP skryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Prosz� zwr�ci� uwag�, i� pdksh traktuje zar�wno profile jak i pliki z
\fB$ENV\fP jako \fB.\fP skrypty, podczas gdy
oryginalny Korn shell jedynie profile traktuje jako \fB.\fP skrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s�u�y do ustawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opcji pow�oki, ustawiania parametr�w pozycyjnych lub
ustawiania parametru ci�gowego.
Opcje mog� by� zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe�n� nazw� pewnej opcji lub stosuj�c posta�
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow�
nazw� danej opcji (niewszystkie opcje posiadaj� jednoliterow� nazw�).
Nast�puj�ca tablica wylicza zar�wno litery opcji (gdy mamy takowe), jak i
pe�ne ich nazwy wraz z opisem wp�yw�w danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci�gowego \fInazwa\fP na \fIarg\fP ...;
Je�li zastosowano \fB\-A\fP, ci�g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je�li zastosowano \fB+A\fP, zastaj� ustawione pierwsze N element�w (gdzie N
jest ilo�ci� \fIarg\fPs�w), reszta pozostaje niezmieniona.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj� tworzone z cech� eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu� przed zach�t�.
Ma tylko znaczenia je�li zosta�a w��czona kontrola zada� (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej�cych ju� plik�w poprzez przekierowania
\fB>\fP (do wymuszenia przepisania musi zosta� zastosowane \fB>|\fP).
T}
\-e	errexit	T{
Wyjd� (po wykonaniu komendy pu�apki \fBERR\fP) tu� po wyst�pieniu
b��du lub niepomy�lnym wykonaniu jakiej� komendy
(\fItzn.\fP, je�li zosta�a ona zako�czona niezerowym kodem wyj�cia).
Nie dotyczy to komend, kt�rych kod wyj�cia zostaje jawnie przetestowany
konstruktem pow�oki takim jak wyra�enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorc�w nazw plik�w.
T}
\-h	trackall	T{
Tw�rz �ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy�ej).
Domy�lnie w��czone dla nieinterakcyjnych pow�ok.
T}
\-i	interactive	T{
W��cz tryb interakcyjny \- mo�e zosta�
w��czone/wy��czone jedynie podczas odpalania pow�oki.
T}
\-k	keyword	T{
Przyporz�dkowania warto�ci parametrom zostaj� rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Pow�oka ma by� pow�ok� zameldowania \- mo�e zosta�
w��czone/wy��czone jedynie podczas odpalania pow�oki
(patrz Odpalania Pow�oki powy�ej).
T}
\-m	monitor	T{
W��cz kontrol� zada� (domy�lne dla pow�ok interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skrypt�w (ignorowane dla interakcyjnych pow�ok).
T}
\-p	privileged	T{
Ustawiane automatycznie, je�li gdy pow�oka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Pow�oki powy�ej dla opisu, co to znaczy.
T}
-r	restricted	T{
Ustaw tryb ograniczony \(em ta opcja mo�e zosta� jedynie
zastosowana podczas odpalania pow�oki.  Patrz Odpalania Pow�oki
dla opisu, co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania pow�oki, w�wczas komendy
zostaj� wczytywane ze standardowego wej�cia.
Ustawione automatycznie, je�li pow�oka zosta�a odpalona bez jakichkolwiek
argument�w.
.sp
Je�li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, w�wczas
podane argumenty zostaj� uporz�dkowane zanim zostan� one przydzielone
parametrom pozycyjnym
(lub ci�gowi \fInazwa\fP, je�li \fB\-A\fP zosta�o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nieustawionego parametru zostaje traktowane jako b��d,
chyba �e zosta� zastosowany jeden z modyfikator�w \fB\-\fP, \fB+\fP
lub \fB=\fP.
T}
\-v	verbose	T{
Wypisuj wprowadzenia pow�oki na standardowym wyj�ciu b��d�w podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz�dkowania parametr�w podczas ich wykonywania
poprzedzone warto�ci� \fBPS4\fP.
T}
\-X	markdirs	T{
Podczas generowania nazw plik�w oznaczaj katalogi ko�cz�cym \fB/\fP.
T}
	bgnice	T{
Zadania w tle zostaj� wykonywane z ni�szym priorytetem.
T}
	braceexpand	T{
W��cz rozwijanie nawias�w (aka, alternacja).
T}
	emacs	T{
W��cz edycj� wiersza komendy  w stylu BRL emacsa (dotyczy wy��cznie
pow�ok interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W��cz edycj� wiersza komendy w stylu gmacsa (Gosling emacs)
(dotyczy wy��cznie pow�ok interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj�tkiem tego, �e przemiana (^T)
zachowuje si� nieco inaczej.
T}
	ignoreeof	T{
Pow�oka nie zostanie zako�czona je�li zostanie wczytany znak zako�czenia
pliku. Nale�y u�y� jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie��cych zada� sygna�em \fBHUP\fP gdy pow�oka zameldowania
zostaje zako�czona.
Obecnie ustawione domy�lnie, co si� jednak zmieni w przysz�o�ci w celu
poprawienia kompatybilno�ci z oryginalnym Korn shell (kt�ry nie posiada
tej opcji, aczkolwiek wysy�a sygna� \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w oryginalnej pow�oce Korn. Zapobiega sortowaniu definicji
funkcji w pliku historii.
T}
	physical	T{
Powoduje, �e komendy \fBcd\fP oraz \fBpwd\fP stosuj� `fizyczne'
(tzn. pochodz�ce od systemu plik�w) \fB..\fP katalogi zamiast `logicznych'
katalog�w (tzn., �e pow�oka interpretuje \fB..\fP, co pozwala
u�ytkownikowi nietroszczy� si� o dowi�zania symboliczne do katalog�w).
Domy�lnie wykasowane.  Prosz� zwr�ci� uwag�, i� ustawianie tej opcji
nie wp�ywa na bie��c� warto�� parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy�ej dla dalszych szczeg��w.
T}
	posix	T{
W��cz tryb POSIX-owy.  Patrz: "Tryb POSIX-owy" powy�ej.
T}
	vi	T{
W��cz edycj� wiersza komendy  w stylu vi (dotyczy tylko pow�ok
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w oryginalnej pow�oce Korna, dop�ki nie zosta�o
ustawione viraw, tryb wiersza komendy vi
pozostawia� prac� nap�dowi tty a� do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plik�w
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Dodaj przedrostek `M-' dla znak�w z ustawionym �smym bitem.
Je�li nie zostanie ustawiona ta opcja, w�wczas, znaki z zakresu
128-160 zostaj� wypisane bez zmian, co mo�e by� przyczyn� problem�w.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend/ plik�w
je�li tab (^I) zostanie wprowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo�na u�y� r�wnie� podczas odpalania pow�oki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje si� w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy�wietla
wszystkie opcja i informacj� o ich ustawieniu lub nie;
\fBset +o\fP wypisuje pe�ne nazwy opcji obecnie w��czonych.
.sp
Pozosta�e argumenty, je�li podano takowe, s� traktowane jako parametry
pozycyjne i zostaj� przyporz�dkowane, przy zachowaniu kolejno�ci,
parametrom pozycyjnym (\fItzn.\fP, \fB1\fP, \fB2\fP, \fIitd.\fP).
Je�li opcje ko�cz� si� \fB\-\-\fP i brak dalszych argument�w,
w�wczas wszystkie parametry pozycyjne zostaj� wyczyszczone.
Je�li nie podano �adnych opcji lub argument�w, w�wczas zostaj� wy�wietlone
warto�ci wszystkich nazw.
Z nieznanych historycznych powod�w, samotna opcja \fB\-\fP
zostaje traktowana specjalnie:
kasuje zar�wno opcj� \fB\-x\fP, jak i \fB\-v\fP.
.\"}}}
.\"{{{  shift [number]
.IP "\fBshift\fP [\fIliczba\fP]"
Parametry pozycyjne \fIliczba\fP+1, \fIliczba\fP+2 \fIitd.\fP\& zostaj�
przeniesione pod \fB1\fP, \fB2\fP, \fIitd.\fP
\fIliczba\fP wynosi domy�lnie 1.
.\"}}}
.\"{{{  test expression, [ expression ]
.IP "\fBtest\fP \fIwyra�enie\fP"
.IP "\fB[\fP \fIwyra�enie\fP \fB]\fP"
\fBtest\fP wylicza \fIwyra�enia\fP i zwraca kod wyj�cia zero je�li
prawda, i kod 1 jeden je�li fa�sz, a wi�cej ni� 1 je�li wyst�pi� b��d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra�e� \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nast�puj�ce podstawowe wyra�enia:
.sp
.TS
afB ltw(2.8i).
\fIci�g\fP	T{
\fIci�g\fP ma niezerow� d�ugo��.  Prosz� zwr�ci� uwag�, i� mog� wyst�pi�
trudno�ci je�li \fIci�g\fP oka�e si� by� operatorem
(\fIdok�adniej\fP, \fB-r\fP) - og�lnie lepiej jest zamiast tego stosowa�
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
(podw�jne wycytowania zostaj� zastosowane je�li
\fIci�g\fP zawiera przerwy lub znaki rozwijania plik�w).
T}
\-r \fIplik\fP	T{
\fIplik\fP istnieje i jest czytelny
T}
\-w \fIplik\fP	T{
\fIplik\fP istnieje i jest zapisywalny
T}
\-x \fIplik\fP	T{
\fIplik\fP istnieje i jest wykonywalny
T}
\-a \fIplik\fP	T{
\fIplik\fP istnieje
T}
\-e \fIplik\fP	T{
\fIplik\fP istnieje
T}
\-f \fIplik\fP	T{
\fIplik\fP jest zwyk�ym plikiem
T}
\-d \fIplik\fP	T{
\fIplik\fP jest katalogiem
T}
\-c \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem nap�du ci�gowego
T}
\-b \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem nap�du blokowego
T}
\-p \fIplik\fP	T{
\fIplik\fP jest potokiem nazwanym
T}
\-u \fIplik\fP	T{
\fIplik\fP o ustawionym bicie setuid
T}
\-g \fIplik\fP	T{
\fIplik\fP' o ustawionym bicie setgid
T}
\-k \fIplik\fP	T{
\fIplik\fP o ustawionym bicie lepko�ci
T}
\-s \fIplik\fP	T{
\fIplik\fP nie jest pusty
T}
\-O \fIplik\fP	T{
w�a�ciciel \fIpliku\fP zgadza si� z efektywnym user-id pow�oki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza si� z efektywn� group-id pow�oki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym [WK: twardym?] dowi�zaniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale�nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym dowi�zaniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP pow�oki jest ustawiona (patrz komenda \fBset\fP powy�ej
dla listy mo�liwych opcji).
Jako niestandardowe rozszerzenie, je�li opcja zaczyna si� od
\fB!\fP, to wynik testu zostaje negowany; test wypada zawsze negatywnie
gdy dana opcja nie istnieje (tak wi�c
.RS
\fB[ -o \fP\fIco�\fP \fB-o -o !\fP\fIco�\fP \fB]\fP
.RE
zwraca prawd� tylko i tylko wtedy, gdy opcja \fIco�\fP istnieje).
T}
\fIplik\fP \-nt \fIplik\fP	T{
pierwszy \fIplik\fP jest nowszy od nast�pnego \fIpliku\fP
T}
\fIplik\fP \-ot \fIplik\fP	T{
pierwszy \fIplik\fP jest starszy od nast�pnego \fIpliku\fP
T}
\fIplik\fP \-ef \fIplik\fP	T{
pierwszy \fIplik\fP jest to�samy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przyrz�dem tty.
Je�li nie zosta�a ustawiona opcja posix (\fBset \-o posix\fP,
patrz Tryb POSIX powy�ej), w�wczas \fIfd\fP mo�e zosta� pomini�ty,
co oznacza przyj�cie domy�lnej warto�ci 1
(zachowanie si� jest w�wczas odmienne z powodu specjalnych regu�
POSIX-a opisywanych powy�ej).
T}
\fIci�g\fP	T{
\fIci�g\fP jest niepusty
T}
\-z\ \fIci�g\fP	T{
\fIci�g\fP jest pusty
T}
\-n\ \fIci�g\fP	T{
\fIci�g\fP jest niepusty
T}
\fIci�g\fP\ =\ \fIci�g\fP	T{
ci�gi s� sobie r�wne
T}
\fIci�g\fP\ ==\ \fIci�g\fP	T{
ci�gi s� sobie r�wne
T}
\fIci�g\fP\ !=\ \fIci�g\fP	T{
ci�gi si� r�ni�
T}
\fIliczba\fP\ \-eq\ \fIliczba\fP	T{
liczby s� r�wne
T}
\fIliczba\fP\ \-ne\ \fIliczba\fP	T{
liczby r�ni� si�
T}
\fIliczba\fP\ \-ge\ \fIliczba\fP	T{
liczba jest wi�ksza lub r�wna od drugiej
T}
\fIliczba\fP\ \-gt\ \fIliczba\fP	T{
liczba jest wi�ksza od drugiej
T}
\fIliczba\fP\ \-le\ \fIliczba\fP	T{
liczba jest mniejsza lub r�wna od drugiej
T}
\fIliczba\fP\ \-lt\ \fIliczba\fP	T{
liczba jest mniejsza od drugiej
T}
.TE
.sp
Powy�sze podstawowe wyra�enie, w kt�rych unarne operatory maj�
pierwsze�stwo przed operatorami binarnymi, mog� by� stosowane w po��czeniu
z nast�puj�cymi operatorami
(wymienionymi w kolejno�ci odpowiadaj�cej ich pierwsze�stwu):
.sp
.TS
afB l.
\fIwyra�enie\fP \-o \fIwyra�enie\fP	logiczne lub
\fIwyra�enie\fP \-a \fIwyra�enie\fP	logiczne i
! \fIwyra�enie\fP	logiczna negacja
( \fIwyra�enie\fP )	grupowanie
.TE
.sp
W systemie operacyjny niewspomagaj�cy nap�d�w \fB/dev/fd/\fP\fIn\fP
(gdzie \fIn\fP jest numerem deskryptora pliku),
komenda \fBtest\fP stara si� je emulowa� dla wszystkich test�w
operuj�cych na plikach (z wyj�tkiem testu \fB-e\fP).
W szczeg�lno�ci., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dost�pny zapis na
deskryptor pliku 2.
.sp
Prosz� zwr�ci� uwag�, �e zachodz� specjalne regu�y
(zawdzi�czane ), je�li liczba argument�w
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od pi�ciu:
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te, tak �e pozostaje tylko
jeden argument, w�wczas zostaje przeprowadzony test d�ugo�ci ci�gu
(ponownie, nawet je�li dany argument jest unarnym operatorem);
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te tak, �e pozostaj� trzy
argumenty i drugi argument jest operatorem binarnym, w�wczas zostaje
wykonana dana binarna operacja (nawet je�li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuni�tym \fB!\fP).
.sp
\fBUwaga:\fP Cz�stym b��dem jest stosowanie \fBif [ $co� = tam ]\fP, co
daje wynik negatywny je�li parametr \fBco�\fP jest zerowy lub
nieustawiony, zawiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest operatorem jednoargumentowym,
takim jak \fB!\fP lub \fB\-n\fP.  Prosz� zamiast tego stosowa� testy typu
\fBif [ "X$co�" = Xtam ]\fP.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy�wietla zgromadzony czas w przestrzeni u�ytkownika oraz systemu,
kt�ry potrzebowa�a pow�oka i w niej wystartowane
procesy, kt�re si� zako�czy�y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna� ...\fP]"
Ustawia obrabiacz, kt�ry nale�y wykona� w razie odebrania danego sygna�u.
\fBObrabiacz\fP mo�e by� albo zerowym ci�giem, wskazuj�cym na zamiar
ignorowania sygna��w danego typu, minusem (\fB\-\fP),
wskazuj�cym, �e ma zosta� podj�ta akcja domy�lna dla danego sygna�u
(patrz signal(2 or 3)), lub ci�giem zawieraj�cym komendy pow�oki
kt�re maj� zosta� wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zako�czeniu bie��cej komendy, lub przed
wypisaniem nast�pnego symboli zach�ty \fBPS1\fP) po odebraniu
jednego z danych sygna��w.
\fBSignal\fP jest nazw� danego sygna�u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy�ej).
Istniej� dwa specjalne sygna�y: \fBEXIT\fP (r�wnie� znany jako \fB0\fP),
kt�ry zostaje wykonany tu� przed zako�czeniem pow�oki, i
\fBERR\fP kt�ry zostaje wykonany po wyst�pieniu b��du
(b��dem jest co�, co powodowa�oby zako�czenie pow�oki
je�li zosta�y ustawione opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP powy�ej).
Obrabiacze \fBEXIT\fP zostaj� wykonane w otoczeniu
ostatniej wykonywanej komendy.
Prosz� zwr�ci� uwag�, �e dla pow�ok nieinterakcyjnych obrabiacz wykrocze�
nie mo�e zosta� zmieniony dla sygna��w, kt�re by�y ignorowane podczas
startu danej pow�oki.
.sp
Bez argument�w, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykrocze�, kt�re zosta�y ustawione od czasu startu pow�oki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna��w \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i oryginalnej pow�oki Korna w funkcjach nie zosta�o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda ko�cz�ca si� zerow� warto�ci� kodu wyj�cia.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto��\fP] ...]"
Wy�wietlaj lub ustawiaj warto�ci atrybut�w parametr�w.
Bez argument�w \fInazwa\fP, zostaj� wy�wietlone atrybuty parametr�w:
je�li brak argument�w b�d�cych opcjami, zostaj� wy�wietlone atrybuty
wszystkich parametr�w jako komendy typeset; je�li podano opcj�
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto�ci posiadaj�ce dany atrybut zostaj�
wy�wietlone;
je�li opcje zaczynaj� si� od \fB+\fP, to nie zostaj� wy�wietlone warto�ci
parametr�w.
.sp
Je�li podano argumenty If \fInazwa\fP, zostaj� ustawione atrybuty
danych parametr�w (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto�ci parametr�w mog� zosta� ewentualnie podane.
Je�li typeset zostanie zastosowane wewn�trz funkcji,
wszystkie nowotworzone parametry pozostaj� lokalne dla danej funkcji.
.sp
Je�li zastosowano \fB\-f\fP, w�wczas typeset operuje na atrybutach funkcji.
Tak jak dla parametr�w, je�li brak \fInazw\fPs, zostaj� wymienione funkcje
wraz z ich warto�ciami (\fItzn.\fP, definicjami), chyba �e podano
opcje zaczynaj�ce si� od \fB+\fP, w kt�rym wypadku
zostaj� wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyr�wnania do lewego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bie��ca szeroko�� parametru
(lub szeroko�� pierwszej przyporz�dkowywanej warto�ci).
Prowadz�ce bia�e przerwy (tak jak i zera, je�li
ustawiono opcj� \fB\-Z\fP) zostaj� wykasowane.
Je�li trzeba, warto�ci zostaj� albo obci�te lub dodane przerwy
do osi�gni�cia wymaganej szeroko�ci.
T}
\-R\fIn\fP	T{
Atrybut przyr�wnania do prawego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bie��ca szeroko�� parametru
(lub szeroko�� pierwszej przyporz�dkowywanej warto�ci).
Bia�e przerwy na ko�cu zostaj� usuni�te.
Je�li trzeba, warto�ci zostaj� albo pozbawione prowadz�cych znak�w
albo przerwy zostaj� dodane do osi�gni�cia wymaganej szeroko�ci.
T}
\-Z\fIn\fP	T{
Atrybut wype�niania zerami: je�li nie skombinowany z \fB\-L\fP, to oznacza to
samo co \fB\-R\fP, tylko, �e do rozszerzania zostaje zastosowane zero
zamiast przerw.
T}
\-i\fIn\fP	T{
Atrybut ca�kowito�ci:
\fIn\fP podaje baz� do zastosowania podczas
wypisywania danej warto�ci ca�kowitej
(je�li nie podano, to baza zostaje zaczerpni�ta z
bazy zastosowanej w pierwszym przyporz�dkowaniu warto�ci).
Parametrom z tym atrybutem mog� by� przyporz�dkowywane warto�ci
zawierajace wyra�enia arytmetyczne.
T}
\-U	T{
Atrybut dodatniej ca�kowito�ci: liczby ca�kowite zostaj� wy�wietlone
jako warto�ci bez znaku
(stosowne jedynie w powi�zaniu z opcj� \fB\-i\fP).
Tej opcji brak w oryginalnej pow�oce Korna.
T}
\-f	T{
Tryb funkcji: wy�wietlaj lub ustawiaj funkcje i ich atrybuty, zamiast
parametr�w.
T}
\-l	T{
Atrybut ma�ej litery: wszystkie znaki z du�ej litery zostaj�
w warto�ci zamienione na ma�e litery.
(W oryginalnej pow�oce Korna, parametr ten oznacza� `d�ugi ca�kowity'
gdy by� stosowany w po��czeniu z opcj� \fB\-i\fP).
T}
\-p	T{
Wypisuj pe�ne komendy typeset, kt�re mo�na nast�pnie zastosowa� do
odtworzenia danych atrybut�w (lecz nie warto�ci) parametr�w.
To jest wynikiem domy�lnym (opcja ta istnieje w celu zachowania
kompatybilno�ci z ksh93).
T}
\-r	T{
Atrybut wy��cznego odczytu: parametry z danym atrybutem
nie przyjmuj� nowych warto�ci i nie mog� zosta� wykasowane.
Po ustawieniu tego atrybutu nie mo�na go ju� wi�cej odaktywni�.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla pow�oki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut �ledzenia.
Je�li zostaj� wykonywane funkcje z atrybutem �ledzenia, to
opcja pow�oki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w��czona.
T}
\-u	T{
Atrybut du�ej litery: wszystkie znaki z ma�ej litery w warto�ciach zostaj�
przestawione na du�e litery.
(W oryginalnej pow�oce Korna, ten parametr oznacza� `ca�kowity bez znaku' je�li
zosta� zastosowany w po��czeniu z opcj� \fB\-i\fP, oznacza�o to, �e
nie mo�na by�o stosowa� du�ych liter dla baz wi�kszych ni� 10.
patrz opcja \fB\-U\fP).
.sp
Dla funkcji, \fB\-u\fP to atrybut niezdefiniowania.  Patrz Funkcje powy�ej
dla implikacji tego.
T}
\-x	T{
Atrybut eksportowania: parametry (lub funkcje) zostaj� umieszczone
w otoczenia wszelkich wykonywanych komend.
Eksportowanie funkcji nie zosta�o jeszcze do tej pory zrealizowane.
T}
.TE
.\"}}}
.\"{{{  ulimit [-acdfHlmnpsStvw] [value]
.IP "\fBulimit\fP [\fB\-acdfHlmnpsStvw\fP] [\fIwarto��\fP]"
Wy�wietlij lub ustaw ograniczenia dla proces�w.
Je�li brak opcji, to ograniczenie ilo�ci plik�w (\fB\-f\fP) zostaje
przyj�te jako domy�le.
\fBwarto��\fP, je�li podana, mo�e by� albo wyra�eniem arytmetycznym
lub s�owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz� pow�oki i wszelkich proces�w przez ni� tworzonych
po nadaniu ograniczenia.
Prosz� zwr�ci� uwag�, i� niekt�re systemy mog� zabrania� podnoszenia
warto�ci ogranicze� po ich nadaniu.
Ponadto prosz� zwr�ci� uwag�, �e rodzaje dost�pnych ogranicze� zale�� od
danego systemu \- niekt�re systemy posiadaj� jedynie mo�liwo��
ograniczania \fB\-f\fP.
.RS
.IP \fB\-a\fP
Wy�wietla wszystkie ograniczenia; je�li nie podano \fB\-H\fP,
to zostaj� wy�wietlone ograniczenia mi�kkie.
.IP \fB\-H\fP
Ustaw jedynie ograniczenie twarde (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-S\fP
Ustaw jedynie ograniczenie mi�kkie (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-c\fP
Ogranicz wielko�ci plik�w zrzut�w core do \fIn\fP blok�w.
.IP \fB\-d\fP
Ogranicz wielko�� obszaru danych do \fIn\fP kilobajt�w.
.IP \fB\-f\fP
Ogranicz wielko�� plik�w zapisywanych przez pow�ok� i jej programy pochodne
do \fIn\fP plik�w (pliki dowolnej wielko�ci mog� by� wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kilobajt�w ilo�� podkluczonej (podpi�tej) fizycznej pami�ci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kilobajt�w ilo�� u�ywanej fizycznej pami�ci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie otwartych deskryptor�w plik�w.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie wykonywanych proces�w danego
u�ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kilobajt�w rozmiar obszaru stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu�ywany przez pojedyncze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kilobajt�w ilo�� u�ywanej wirtualnej pami�ci;
pod niekt�rymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kilobajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kilobajt�w ilo�� stosowanego obszaru odk�adania.
.PP
Dla \fBulimit\fP blok to zawsze 512 bajt�w.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy�wietl lub ustaw mask� zezwole� w tworzeniu plik�w, lub umask
(patrz \fIumask\fP(2)).
Je�li zastosowano opcj� \fB\-S\fP, maska jest wy�wietlana lub podawana
symbolicznie, w przeciwnym razie jako liczba �semkowa.
.sp
Symboliczne maski s� podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znak�w jest cz�ci� \fIkto\fP, a druga grupa cz�ci�
\fIop\fP, i ostatnio grupa cz�ci� \fIperm\fP.
Cz�� \fIkto\fP okre�la, kt�ra cz�� umaski ma zosta� zmodyfikowana.
Litery oznaczaj�:
.RS
.IP \fBu\fP
prawa u�ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta�ych (nieu�ytkownika, niegrupy)
.IP \fBa\fP
wszelkie prawa naraz (u�ytkownika, grupy i pozosta�ych)
.RE
.sp
Cz�� \fIop\fP wskazuj� jak prawa \fIkto\fP maj� by� zmienione:
.RS
.IP \fB=\fP
nadaj
.IP \fB+\fP
dodaj do
.IP \fB\-\fP
usu� z
.RE
.sp
Cz�� \fIperm\fP wskazuje kt�re prawa maj� zosta� nadane, dodane lub usuni�te:
.RS
.IP \fBr\fP
prawo czytania
.IP \fBw\fP
prawo zapisu
.IP \fBx\fP
prawo wykonywania
.RE
.sp
Gdy stosuje si� maski symboliczne, to opisuj� one, kt�re prawa mog� zosta�
udost�pnione (w przeciwie�stwie do masek �semkowych, w kt�rych ustawienie
bitu oznacza, �e ma on zosta� wykasowany).
Przyk�ad: `ug=rwx,o=' ustawia mask� tak, �e pliki nie b�d� odczytywalne,
zapisywalne i wykonywalne przez `innych'. Jest ono r�wnowa�ne
(w wi�kszo�ci system�w) oktalnej masce `07'.
.RE
.\"}}}
.\"{{{  unalias [-adt] name ...
.IP "\fBunalias\fP [\fB\-adt\fP] [\fInazwa1\fP ...]"
Aliasy dla danej nazwy zostaj� usuni�te.
Gdy zastosowano opcj� \fB\-a\fP, to wszelkie aliasy zostaj� usuni�te.
Gdy zastosowano opcj� \fB\-t\fP lub \fB\-d\fP, to wymienione operacje
zostaj� wykonane jedynie na �ledzonych lub odpowiednio
aliasach katalog�w.
.\"}}}
.\"{{{  unset [-fv] parameter ...
.IP "\fBunset\fP [\fB\-fv\fP] \fIparametr\fP ..."
Kasuj wymienione parametry (\fB\-v\fP, oznacza domy�lne) lub funkcje
(\fB\-f\fP).
Status zako�czenia jest niezerowy je�li kt�ry� z danych parametr�w by�
ju� wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zako�czenie danego zadania/zada�.
Kodem wyj�cia wait jest kod ostatniego podanego zadania:
je�li dane zadanie zosta�o zabite sygna�em, kod wyj�cia wynosi
128 + number danego sygna�u (patrz \fBkill \-l\fP \fIkod_wyj�cia\fP
powy�ej); je�li ostatnie dane zadanie nie mo�e zosta� odnalezione
(bo nigdy nie istnia�o, lub ju� zosta�o zako�czone), to kod wyj�cia
zako�czenia wait wynosi 127.
Patrz Kontrola Zada� poni�ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zako�czone je�li zajdzie sygna�, na kt�ry zosta�
ustawiony obrabiacz, lub gdy zostanie odebrany sygna� HUP, INT lub
QUIT.
.sp
Je�li nie podano zada�, \fBwait\fP wait czeka na zako�czenie
wszelkich obecnych zada� (je�li istniej� takowe) i ko�czy si�
zerowym kodem wyj�cia.
Je�li kontrola zada� zosta�a w��czona, to zostaje wy�wietlony
kod wyj�cia zada�
(to nie ma miejsca, je�li zadania zosta�y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka�dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je�li podano opcj� \fB\-p\fP, to zostaje odszukana �cie�ka
dla \fInazw\fP, b�d�cych zarezerwowanymi s�owami, aliasami, itp.
Bez opcji \fB\-v\fP \fBwhence\fP dzia�a podobnie do \fBcommand \-v\fP,
poza tym, �e \fBwhence\fP odszukuje zarezerwowane s�owa i nie wypisuje
alias�w jako komendy alias;
z opcj� \fB\-v\fP, \fBwhence\fP to to samo co \fBcommand \-V\fP.
Zauwa�, �e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp�ywu
na przeszukiwan� �cie�k�, tak jak dla \fBcommand\fP.
Je�li typ jednej lub wi�cej spo�r�d nazw nie m�g� zosta� ustalony
to kod wyj�cia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola zada�"
Kontrola zada� oznacza zdolno�� pow�oki to monitorowania i kontrolowania
wykonywanych \fBzada�\fP,
kt�re s� procesami lub grupami proces�w tworzonych przez komendy lub
potoki.
Pow�oka przynajmniej �ledzi status obecnych zada� w tle
(\fItzn.\fP, asynchronicznych); t� informacj� mo�na otrzyma�
wykonuj�c komend� \fBjobs\fP.
Je�li zosta�a uaktywniona pe�na kontrola zada�
(stosuj�c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w pow�okach interakcyjnych,
to procesy pewnego zadania zostaj� umieszczane we w�asnej grupie
proces�w, pierwszoplanowe zadnia mog� zosta� zatrzymane przy pomocy
klawisza wstrzymania z terminalu (zwykle ^Z),
zadania mog� zosta� ponownie podj�te albo na pierwszym planie albo
w tle, stosuj�c odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nast�pnie odtworzony, je�li
zadanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Prosz� zwr�ci� uwag�, �e tylko komendy tworz�ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podpow�ok i niewbudowane komendy
nie b�d�ce funkcjami) mog� zosta� wstrzymane; takie komendy
jak \fBread\fP nie mog� tego.
.sp
Gdy zostaje stworzone zadanie, to przyporz�dkowuje mu si� numer zadania.
Dla interakcyjnych pow�ok, numer ten zostaje wy�wietlony w \fB[\fP..\fB]\fP,
i w nast�pstwie identyfikatory proces�w w zadaniu, je�li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo�emy odnosi� si� w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i
\fBwait\fP albo poprzez id ostatniego procesu w potoku komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj�c
numer zadania znakiem procentu (\fB%\fP).
R�wnie� nast�puj�ce sekwencj� z procentem mog� by� stosowane do
odnoszenia si� do zada�:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie lub, gdy brak zatrzymanych zada�, najstarsze
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, kt�re by�oby pod \fB%+\fP gdyby nie zosta�o zako�czone.
T}
%\fIn\fP	T{
Zadanie z numerem zadania \fIn\fP.
T}
%?\fIci�g\fP	T{
Zadanie zawieraj�ce ci�g \fIci�g\fP (wyst�puje b��d, gdy odpowiada mu
kilka zada�).
T}
%\fIci�g\fP	T{
Zadanie zaczynaj�ce si� ci�giem \fIci�g\fP (wyst�puje b��d, gdy odpowiada
mu kilka zada�).
T}
.TE
.sp
Je�li zadanie zmienia status (\fItzn.\fP, gdy zadanie w tle
zostaje zako�czone lub zadanie na pierwszym planie zostaje wstrzymane),
pow�oka wy�wietla nast�puj�ce informacje o statusie:
.RS
\fB[\fP\fInumer\fP\fB]\fP \fIflaga status komenda\fP
.RE
gdzie
.IP "\ \fInumer\fP"
to numer danego zadania.
.IP "\ \fIflaga\fP"
jest \fB+\fP lub \fB-\fP je�li zadaniem jest odpowiednio zadanie z
\fB%+\fP lub \fB%-\fP, lub przerwa je�li nie jest ani jednym ani drugim.
.IP "\ \fIstatus\fP"
Wskazuje obecny stan danego zadania
i mo�e to by�
.RS
.IP "\fBRunning\fP"
Zadanie nie jest ani wstrzymane ani zako�czone (prosz� zwr�ci� uwag�, i�
przebieg nie koniecznie musi oznacza� spotrzebowywanie
czasu CPU \(em proces mo�e by� zablokowany, czekaj�c na pewne zaj�cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zako�czone. \fInumer\fP to kod wyj�cia danego zadania,
kt�ry zostaje pomini�ty, je�li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna�\fP\fB)\fP]"
zadanie zosta�o wstrzymane danym sygna�em \fIsygna�\fP (gdy brak sygna�u,
to zadanie zosta�o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna�u\fP [\fB(core dumped)\fP]"
zadanie zosta�o zabite sygna�em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opis�w sygna��w).
Wiadomo�� \fB(core\ dumped)\fP wskazuje, �e proces stworzy� plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, kt�ra stworzy�a dany proces.
Je�li dane zadanie zawiera kilka proces�w, to ka�dy proces zostanie wy�wietlony
w osobnym wierszy pokazuj�cym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je�li jest on odmienny od statusu poprzedniego procesu.
.PP
Je�li pr�buje si� zako�czy� pow�ok�, podczas gdy istniej� zadania w
stanie zatrzymania, to pow�oka ostrzega u�ytkownika, �e s� zadania w stanie
zatrzymania i nie ko�czy pracy.
Gdy tu� potem zostanie podj�ta ponowna pr�ba zako�czenia pow�oki, to
zatrzymane zadania otrzymuj� sygna� \fBHUP\fP i pow�oka ko�czy prac�.
podobnie, je�li nie zosta�a ustawiona opcja \fBnohup\fP,
i s� zadania w pracy, gdy zostanie podj�ta pr�ba zako�czenia pow�oki
zameldowania, pow�oka ostrzega u�ytkownika i nie ko�czy pracy.
Gdy tu� potem zostanie ponownie podj�ta pr�ba zako�czenia pracy pow�oki,
to bie��ce procesy otrzymuj� sygna� \fBHUP\fP i pow�oka ko�czy prac�.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna edycja wiersza polece� w trybie emacs"
Je�li zosta�a ustawiona opcja \fBemacs\fP,jest w��czona interakcyjna
edycja wiersza wprowadze�.  \fBOstrze�enie\fP: Ten tryb zachowuje si�
nieco inaczej ni� tryb emacsa w oryginalnej pow�oce Korna
i 8-my bit zostaje wykasowany w trybie emacsa.
W trybie tym r�ne komendy edycji (zazwyczaj pod��czone pod jeden lub wi�cej
znak�w steruj�cych) powoduj� natychmiastowe akcje bez odczekiwania
nast�pnego prze�amania wiersza.  Wiele komend edycji jest zwi�zywanych z
pewnymi znakami steruj�cymi podczas odpalania pow�oki; te zwi�zki mog� zosta�
zmienione przy pomocy nast�puj�cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi�zki zostaj� wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci�g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi�zana pod dany \fBci�g\fP, kt�ry
powinien sk�ada� si� ze znaku steruj�cego (zapisanego przy pomocy
strza�ki w g�r� \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dw�ch znak�w przedsionkownych.  Wprowadzenie danego
\fIci�gu\fP b�dzie w�wczas powodowa�o bezpo�rednie wywo�anie danej
komendy edycji.  Prosz� zwr�ci� uwag�, �e cho� tylko
dwa znaki przedsionkowe (zwykle ESC i ^X) s� wspomagane, to
mog� r�wnie� zosta� podane niekt�re ci�gi wieloznakowe.
Nast�puj�ce pod��cza klawisze terminala ANSI lub xterm
(kt�re s� w domy�lnych podwi�zaniach).  Oczywi�cie niekt�re
sekwencje wyprowadzenia nie chc� dzia�a� tak g�adko:
.sp
.RS
\fBbind '^[['=prefix\-2
.br
bind '^XA'=up\-history
.br
bind '^XB'=down\-history
.br
bind '^XC'=forward\-char
.br
bind '^XD'=backward\-char\fP
.RE
.\"}}}
.\"{{{  bind -l
.IP "\fBbind \-l\fP"
Wymie� nazwy funkcji do kt�rych mo�na pod�aczy� klawisze.
.\"}}}
.\"{{{  bind -m string=[substitute]
.IP "\fBbind \-m\fP \fIci�g\fP\fB=\fP[\fIpodstawienie\fP]"
Dany ci�g wprowadzenia \fIci�g\fP zostanie zamieniony bezpo�rednio na
dane \fIpodstawienie\fP, kt�re mo�e zawiera� komendy edycji.
.\"}}}
.PP
Nast�puje lista dost�pnych komend edycji.
Ka�dy z poszczeg�lnych opis�w zaczyna si� nazw� komendy,
liter� \fIn\fP, je�li komenda mo�e zosta� poprzedzona licznikiem,
i wszelkimi klawiszami, do kt�rych dana komenda jest pod��czona
domy�lnie (w zapisie stosuj�cym notacj� strza�kow�, \fItzn.\fP,
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj�cy komend� wprowadzamy stosuj�c ci�g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci�g sk�adaj�cy si� z jednej
lub wi�cej cyfr;
chyba �e podano inaczej licznik, je�li zosta� pomini�ty, wynosi
domy�lnie 1.
Prosz� zwr�ci� uwag�, �e nazwy komend edycji stosowane s� jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy�lne podwi�zania zosta�y wybrane
tak, aby by�y zgodne z odpowiednimi podwi�zaniami Emacsa.
Znaki u�ytkownika tty (\fIw szczeg�lno�ci\fP, ERASE) zosta�y
pod��czenia do stosownych podstawie� i kasuj� domy�lne
pod��czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania_historii\fP
do przerwania tego szukania.
.\"}}}
.\"{{{  auto-insert n
.IP "\fBauto-insert\fP \fIn\fP"
Powoduje po prostu wy�wietlenie znaku jako bezpo�rednie wprowadzenie.
Wi�kszo�� zwyk�ych znak�w jest pod to pod��czona.
.\"}}}
.\"{{{  backward-char	n ^B
.IP "\fBbackward-char\fP  \fIn\fP \fB^B\fP"
Przesuwa kursor \fIn\fP znak�w wstecz.
.\"}}}
.\"{{{  backward-word  n ^[B
.IP "\fBbackward-word\fP  \fIn\fP \fB^[B\fP"
Przesuwa kursor wstecz na pocz�tek s�owa; s�owa sk�adaj� si� ze
znak�w alfanumerycznych, podkre�lenia (_) i dolara ($).
.\"}}}
.\"{{{  beginning-of-history ^[<
.IP "\fBbeginning-of-history ^[<\fP"
Przesuwa na pocz�tek historii.
.\"}}}
.\"{{{  beginning-of-line ^A
.IP "\fBbeginning-of-line ^A\fP"
Przesuwa kursor na pocz�tek edytowanego wiersza wprowadzenia.
.\"}}}
.\"{{{  capitalize-word n ^[c, ^[C
.IP "\fBcapitalize-word\fP \fIn\fP \fB^[c\fP, \fB^[C\fP"
Przemienia pierwszy znak w nast�pnych \fIn\fP s�owach na du�� liter�,
pozostawiaj�c kursor za ko�cem ostatniego s�owa.
.\"}}}
.\"{{{  comment ^[#
Je�li bie��cy wiersz nie zaczyna si� od znaku komentarza, zostaje on
dodany na pocz�tku wiersza i wiersz zostaje wprowadzony (tak jakby
naci�ni�to prze�amanie wiersza), w przeciwnym razie istniej�ce znaki
komentarza zostaj� usuni�te i kursor zostaje umieszczony na pocz�tku
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope�nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj�cej kursor.  Je�li ca�a pozosta�a cz��
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy�wietlona
po wype�nieniu, chyba �e jest to nazwa katalogu, w kt�rym to razie zostaje
do��czone \fB/\fP.  Je�li nie ma komendy lub nazwy pliku zaczynaj�cej
si� od takiej cz�ci s�owa, to zostaje wyprowadzony znak dzwonka
(zwykle powodujacy s�yszalne zabuczenie).
.\"}}}
.\"{{{  complete-command ^X^[
.IP "\fBcomplete-command ^X^[\fP"
Automatycznie dope�nia tyle ile jest jednoznaczne z nazwy komendy
zawieraj�cej cz�ciowe s�owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy�ej.
.\"}}}
.\"{{{  complete-file ^[^X
.IP "\fBcomplete-file ^[^X\fP"
Automatycznie dope�nia tyle ile jest jednoznaczne z nazwy pliku
zawieraj�cego cz�ciowe s�owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy�ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymie� mo�liwe dope�nienia bie��cego s�owa.
.\"}}}
.\"{{{  delete-char-backward n ERASE, ^?, ^H
.IP "\fBdelete-char-backward\fP \fIn\fP \fBERASE\fP, \fB^?\fP, \fB^H\fP"
Skasuj \fIn\fP znak�w przed kursorem.
.\"}}}
.\"{{{  delete-char-forward n
.IP "\fBdelete-char-forward\fP \fIn\fP"
Skasuj \fIn\fP znak�w po kursorze.
.\"}}}
.\"{{{  delete-word-backward n ^[ERASE, ^[^?, ^[^H, ^[h
.IP "\fBdelete-word-backward\fP \fIn\fP \fB^[ERASE\fP, \fB^[^?\fP, \fB^[^H\fP, \fB^[h\fP"
Skasuj \fIn\fP s��w przed kursorem.
.\"}}}
.\"{{{  delete-word-forward n ^[d
.IP "\fBdelete-word-forward\fP \fIn\fP \fB^[d\fP"
Kasuje znaki po kursorze, a� do ko�ca \fIn\fP s��w.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historii w prz�d \fIn\fP wierszy (p�niej).
Ka�dy wiersz wprowadzenia zaczyna si� oryginalnie tu� po ostatnim
miejscu w buforze historii, tak wi�c
\fBdown-history\fP nie jest przydatny dop�ki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Zamie� na ma�e litery nast�pnych \fIn\fP s��w.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porusza do ko�ca historii.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na koniec wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia�a jako koniec pliku; Jest to przydatne, albowiem tryb edycji
wprowadzenia wy��cza normaln� regularyzacj� wprowadzenia terminala.
.\"}}}
.\"{{{  eot-or-delete n ^D
.IP "\fBeot-or-delete\fP \fIn\fP \fB^D\fP"
Dzia�a jako eot je�li jest samotne na wierszu; w przeciwnym razie
dzia�a jako delete-char-forward.
.\"}}}
.\"{{{  error
.IP "\fBerror\fP"
Error (ring the bell).
.\"}}}
.\"{{{  exchange-point-and-mark ^X^X
.IP "\fBexchange-point-and-mark ^X^X\fP"
Umie�� kursor na znaczniku i ustaw znacznik na miejsce, w kt�rym by�
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bie��cego s�owa i zast�puje dane s�owo wynikiem
rozwini�cia nazwy pliku na danym s�owie.
Gdy nie pasuj� �adne pliki, zadzwo�.
.\"}}}
.\"{{{  forward-char n ^F
.IP "\fBforward-char\fP \fIn\fP \fB^F\fP"
Przesuwa kursor naprz�d o \fIn\fP znak�w.
.\"}}}
.\"{{{  forward-word n ^[f
.IP "\fBforward-word\fP \fIn\fP \fB^[f\fP"
Przesuwa kursor naprz�d na zako�czenie \fIn\fP-tego s�owa.
.\"}}}
.\"{{{  goto-history n ^[g
.IP "\fBgoto-history\fP \fIn\fP \fB^[g\fP"
Przemieszcza do historii numer \fIn\fP.
.\"}}}
.\"{{{  kill-line KILL
.IP "\fBkill-line KILL\fP"
Kasuje ca�y wiersz wprowadzenia.
.\"}}}
.\"{{{  kill-region ^W
.IP "\fBkill-region ^W\fP"
Kasuje wprowadzenie pomi�dzy kursorem a znacznikiem.
.\"}}}
.\"{{{  kill-to-eol n ^K
.IP "\fBkill-to-eol\fP \fIn\fP \fB^K\fP"
Je�li omini�to \fIn\fP, to kasuje wprowadzenia od kursora do ko�ca wiersza,
w przeciwnym razie kasuje znaki pomi�dzy kursorem a \fIn\fP-t� kolumn�.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend lub nazw plik�w
(je�li s� takowe), kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursor.
Do nazw katalog�w zostaje do��czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend
(je�li s� takowe), kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursor.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw plik�w
(je�li s� takowe), kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursor.
Specyfikatory rodzaju plik�w zostaj� do��czone tak jak powy�ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bie��cego wiersza wprowadze� przez pow�ok�.
Kursor mo�e znajdowa� si� aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bie��cego wiersza wprowadze� przez pow�ok�,
po czym nast�pny wiersz z historii staje si� wierszem bie��cym.
Ma to tylko sens po poprzednim up-history lub search-history.
.\"}}}
.\"{{{  no-op QUIT
.IP "\fBno-op QUIT\fP"
Nie robi nic.
.\"}}}
.\"{{{  prefix-1 ^[
.IP "\fBprefix-1 ^[\fP"
Przedsionek 1-znakowej sekwencji komendy.
.\"}}}
.\"{{{  prefix-2 ^X and ^[[
.IP "\fBprefix-2 ^X\fP"
.IP "\fBprefix-2 ^[[\fP"
Przedsionek 2-znakowej sekwencji komendy.
.\"}}}
.\"{{{  prev-hist-word ^[. ^[_
.IP "\fBprev-hist-word\fP \fIn\fP \fB^[.\fP, \fB^[_\fP"
Ostatnie (\fIn\fP-te) s�owo poprzedniej komendy zostaje wprowadzone
na miejscu kursora.
.\"}}}
.\"{{{  quote ^^
.IP "\fBquote ^^\fP"
Nast�pny znak zostaje wzi�ty dos�ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zach�t� i bie��cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty� w bie��cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w prz�d w bie��cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd� w krocz�cy tryb szukania.  Wewn�trzna lista historii zostaje
przeszukiwana wstecz za komendami odpowiadaj�cymi wprowadzeniu.
pocz�tkowe \fB^\fP w szukanym ci�gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan� wykonywane po opuszczeniu trybu szukania.
Ponowne komendy \fBsearch-history\fP kontynuuj� szukanie wstecz
do nast�pnego poprzedniego wyst�pienia wzorca.  Bufor historii
zawiera tylko sko�czon� ilo�� wierszy; dla potrzeby najstarsze zostaj�
wyrzucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bie��cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj�cymi, wypycha pod��czony znak  z powrotem
do wej�cia terminala, gdzie mo�e on zosta� specjalnie przetworzony przez
terminal.  Jest to przydatne np. dla opcji BRL \fB^T\fP minisystata.
.\"}}}
.\"{{{  stuff-reset
.IP "\fBstuff-reset\fP"
Dzia�a tak jak \fBstuff\fP, a potem przerywa wprowadzenie tak jak
przerwanie.
.\"}}}
.\"{{{  transport-chars ^T
.IP "\fBtranspose-chars ^T\fP"
Na ko�cu wiersza lub je�li w��czono opcj� \fBgmacs\fP,
zamienia dwa poprzedzaj�ce znaki; w przeciwnym razie zamienia
poprzedni i bie��cy znak, po czym przesuwa kursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historii \fIn\fP wierszy wstecz (wcze�niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nast�pnych \fIn\fP s��w w du�e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisuje wersj� ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci�ni�ty jakikolwiek klawisz
(po czym ten klawisz zostaje przetworzony, chyba �e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad� ostatnio skasowany ci�g tekstu na bie��c� pozycj� kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo�rednio po \fByank\fP, zamienia wprowadzony tekst na
nast�pny poprzednio skasowany ci�g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny tryb edycji wiersza polece� vi"
Edytor vi wiersza komendy w ksh obs�uguje w zasadzie te same komendy co
edytor vi (patrz \fIvi\fP(1)), poza nast�puj�cymi wyj�tkami:
.nr P2 \n(PD
.IP \ \ \(bu
zaczyna w trybie wprowadzania,
.IP \ \ \(bu
ma komendy uzupe�niania nazw plik�w i komend
(\fB=\fP, \fB\e\fP, \fB*\fP, \fB^X\fP, \fB^E\fP, \fB^F\fP i,
opcjonalnie, \fB<tab>\fP),
.IP \ \ \(bu
komenda \fB_\fP dzia�a odmiennie (w ksh jest to komenda ostatniego argumentu,
a w vi przechodzenie do pocz�tku bie��cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fP poruszaj� si� w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
brak jest komend, kt�re nie maj� znaczenia w edytorze obs�uguj�cym jeden
wiersz (\fIw szczeg�lno�ci\fP, przewijanie ekranu, komendy ex \fB:\fP,
\fIitp.\fP).
.nr PD \n(P2
.LP
Prosz� zwr�ci� uwag�, �e \fB^X\fP oznacza control-X; oraz \fB<esc>\fP,
\fB<space>\fP i \fB<tab>\fP stosowane s� za escape, space i tab,
odpowiednio (bez �art�w).
.\"}}}
.\"{{{  modes
.PP
Tak jak w vi, s� dwa tryby: tryb wprowadzania i tryb komend.
W trybie wprowadzania, wi�kszo�� znak�w zostaje po prostu umieszczona
w buforze na bie��cym miejscu kursora w kolejno�ci ich wpisywania,
chocia� niekt�re znaki zostaj� traktowane specjalnie.
W szczeg�lno�ci nast�puj�ce znaki odpowiadaj� obecnym ustawieniom tty
(patrz \fIstty\fP(1)) i zachowuj� ich normalne znaczenia
(normalne warto�ci s� podane w nawiasach):
skasuj (\fB^U\fP), wyma� (\fB^?\fP), wyma� s�owo (\fB^W\fP), eof (\fB^D\fP),
przerwij (\fB^C\fP) i zako�cz (\fB^\e\fP).
Poza powy�szymi dodatkowo r�wnie� nast�puj�ce znaki zostaj� traktowane
specjalnie w trybie wprowadzania:
.TS
expand;
afB lw(4.5i).
^H	T{
kasuje poprzedni znak
T}
^V	T{
bezpo�rednio nast�pny: nast�pny naci�ni�ty znak nie zostaje traktowany
specjalnie (mo�na tego u�y� do wprowadzenia opisywanych tu znak�w)
T}
^J ^M	T{
koniec wiersza: bie��cy wiersz zostaje wczytany, rozpoznany i wykonany
przez pow�ok�
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni�ej)
T}
^E	T{
wyliczanie komend i nazw plik�w (patrz poni�ej)
T}
^F	T{
dope�nianie nazw plik�w (patrz poni�ej).
Je�li zostanie u�yte dwukrotnie, to w�wczas wy�wietla list� mo�liwych
dope�nie�;
je�li zostanie u�yte trzykrotnie, to kasuje dope�nienie.
T}
^X	T{
rozwijanie nazw komend i plik�w (patrz poni�ej)
T}
<tab>	T{
opcjonalnie dope�nianie nazw plik�w i komend (patrz \fB^F\fP powy�ej),
w��czane przez \fBset \-o vi-tabcomplete\fP
T}
.TE
.\"}}}
.\"{{{  display
.PP
Je�li jaki� wiersz jest d�u�szy od szeroko�ci ekranu
(patrz parametr \fBCOLUMNS\fP),
to zostaje wy�wietlony znak \fB>\fP, \fB+\fP lub \fB<\fP
w ostatniej kolumnie, wskazuj�cy odpowiednio na wi�cej znak�w po, przed i po, oraz
przed obecn� pozycj�.
Wiersz jest przewijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka�dy znak zostaje interpretowany jako komenda.
Znaki kt�rym nie odpowiada �adna komenda, kt�re s� niedopuszczaln�
komend� lub s� komendami nie do wykonania, wszystkie wyzwalaj� dzwonek.
W nast�puj�cych opisach komend, \fIn\fP wskazuje, �e komend� mo�na
poprzedzi� numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znak�w); gdy brak przedrostka numerowego, to zak�ada si�, �e \fIn\fP
jest r�wne 1, chyba �e powiemy inaczej.
Zwrot `bie��ca pozycja' odnosi si� do pozycji pomi�dzy kursorem
a znakiem przed nim.
`S�owo' to ci�g liter, cyfr lub podkre�le�
albo ci�g nie nieliter, niecyfr, niepodkre�le�, niebia�ych-znak�w
(\fItak wi�c\fP, ab2*&^ zawiera dwa s�owa), oraz `du�e s�owo' jest ci�giem
niebia�ych znak�w.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nast�puj�cych komend brak lub s� one odmienne od tych w normalnym
edytorze plik�w vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad� przerw� z nast�pstwem \fIn\fP-tego du�ego s�owa
z ostatniej komendy w historii na bie��cej pozycji i wejd� w tryb
wprowadzania; je�li nie podano \fIn\fP to domy�lnie zostaje wprowadzone
ostatnie s�owo.
.IP "\fB#\fP"
wprowad� znak komentarza (\fB#\fP) na pocz�tku bie��cego wiersza
i przeka� ten wiersz do pow�oki ( tak samo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z tym �e, je�li nie podano \fIn\fP
to dotyczy to ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj�c edytor vi;
je�li nie podano \fIn\fP, to edytuje bie��cy wiersz.
W�a�ciw� wykonywan� komend� jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope�nianie komendy lub nazwy pliku zostaje zastosowane do obecnego du�ego
s�owa (po dodaniu *, je�li to s�owo nie zawiera �adnych znak�w dope�niania
nazw plik�w) - du�e s�owo zostaje zast�pione s�owami wynikowymi.
Je�li bie��ce du�e s�owo jest pierwszym w wierszu (lub wyst�puje po
jednym z nast�puj�cych znak�w: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera uko�nika (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wykonane rozwijanie nazwy plik�w.
Rozwijanie komend podpasowuje du�e s�owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i r�wnie� wszelkie wykonywalne pliki odnajdywane
przeszukuj�c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plik�w dopasowuje du�e s�owo do nazw plik�w w bie��cym
katalogu.
Po rozwini�ciu, kursor zostaje umieszczony tu� po
ostatnim s�owie na ko�cu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope�nianie nazw komend/plik�w:
zast�puje bie��ce du�e s�owo najd�u�szym, jednoznacznym
dopasowaniem otrzymanym przez rozwini�cie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je�li zosta�a w��czona opcja
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je�li zosta�a w��czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je�li podano \fIn\fP to zostaje u�yte \fIn\fP-te mo�liwe
dope�nienie (z tych zwracanych przez komend� wyliczania dope�nie� nazw
komend/plik�w).
.IP "\fB=\fP and \fB^E\fP"
wyliczanie nazw komend/plik�w: wymie� wszystkie komendy lub pliki
pasuj�ce pod obecne du�e s�owo.
.IP "\fB^V\fP"
wy�wietl wersj� pdksh; jest ona wy�wietlana do nast�pnego naci�ni�cia
klawisza (ten klawisz zostaje zignorowany).
.IP "\fB@\fP\fIc\fP"
rozwini�cie makro: wykonaj komendy znajduj�ce si� w aliasie _\fIc\fP.
.RE
.\"}}}
.\"{{{  Intra-line movement commands
.IP "Komendy przemieszczania w wierszu"
.RS
.IP "\fIn\fP\fBh\fP and \fIn\fP\fB^H\fP"
przesu� si� na lewo \fIn\fP znak�w.
.IP "\fIn\fP\fBl\fP and \fIn\fP\fB<space>\fP"
przesu� si� w prawo \fIn\fP znak�w.
.IP "\fB0\fP"
przesu� si� do kolumny 0.
.IP "\fB^\fP"
przesu� si� do pierwszego niebia�ego znaku.
.IP "\fIn\fP\fB|\fP"
przesu� si� do kolumny \fIn\fP.
.IP "\fB$\fP"
przesu� si� do ostatniego znaku.
.IP "\fIn\fP\fBb\fP"
przesu� si� wstecz \fIn\fP s��w.
.IP "\fIn\fP\fBB\fP"
przesu� si� wstecz \fIn\fP du�ych s��w.
.IP "\fIn\fP\fBe\fP"
przesu� si� na prz�d do ko�ca s�owo \fIn\fP razy.
.IP "\fIn\fP\fBE\fP"
przesu� si� na prz�d do ko�ca du�ego s�owa \fIn\fP razy.
.IP "\fIn\fP\fBw\fP"
przesu� si� na prz�d o \fIn\fP s��w.
.IP "\fIn\fP\fBW\fP"
przesu� si� na prz�d o \fIn\fP du�ych s��w.
.IP "\fB%\fP"
odnajd� wz�r: edytor szuka do przodu najbli�szego nawiasu
zamykaj�cego (okr�g�ego, prostok�tnego lub klamrowego),
a nast�pnie przesuwa si� mi�dzy nim a odpowiadaj�cym mu
nawiasem otwieraj�cym.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesu� si� w prz�d do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesu� si� w ty� do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesu� si� w prz�d tu� przed \fIn\fP-te wyst�pienie znaku \fIc\fP.
.IP "\fIn\fP\fBT\fP\fIc\fP"
przesu� si� w ty� tu� przed \fIn\fP-te wyst�pienie znaku \fIc\fP.
.IP "\fIn\fP\fB;\fP"
powtarza ostatni� komend� \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP.
.IP "\fIn\fP\fB,\fP"
powtarza ostatni� komend� \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP,
lecz porusza si� w przeciwnym kierunku.
.RE
.\"}}}
.\"{{{  Inter-line movement commands
.IP "Komendy przemieszczania mi�dzy wierszami"
.RS
.IP "\fIn\fP\fBj\fP i \fIn\fP\fB+\fP i \fIn\fP\fB^N\fP"
przejd� do \fIn\fP-tego nast�pnego wiersza w historii.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd� do \fIn\fP-tego poprzedniego wiersza w historii.
.IP "\fIn\fP\fBG\fP"
przejd� do wiersza \fIn\fP w historii; je�li brak \fIn\fP, to przenosi
si� do pierwszego zapami�tanego wiersza w historii.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, �e je�li nie podano \fIn\fP to idzie do
ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci�g\fP"
szukaj wstecz w historii \fIn\fP-tego wiersza zawieraj�cego
\fIci�g\fP; je�li \fIci�g\fP zaczyna si� od \fB^\fP, to reszta ci�gu
musi wyst�powa� na samym pocz�tku wiersza historii aby pasowa�a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, �e szuka do przodu w historii.
.IP "\fIn\fP\fBn\fP"
szukaj \fIn\fP-tego wyst�pienia ostatnio szukanego ci�gu; kierunek jest
ten sam co kierunek ostatniego szukania.
.IP "\fIn\fP\fBN\fP"
szukaj \fIn\fP-tego wyst�pienia ostatnio szukanego ci�gu; kierunek jest
przeciwny do kierunku ostatniego szukania.
.RE
.\"}}}
.\"{{{  Edit commands
.IP "Komendy edycji"
.RS
.IP "\fIn\fP\fBa\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania tu� po
bie��cej pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t� r�nic�, �e dodaje do ko�ca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bie��cej
pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t� r�nic�, �e dodaje do tu� przed pierwszym niebia�ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamie� nast�pnych \fIn\fP znak�w (\fItzn.\fP, skasuj te znaki i przejd�
do trybu wprowadzania).
.IP "\fBS\fP"
zast�p ca�y wiersz: wszystkie znaki od pierwszego niebia�ego znaku
do ko�ca wiersza zostaj� skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd� z bie��cej pozycji do pozycji wynikaj�cej z \fIn\fP
\fIkomenda-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wejd� w tryb
wprowadzania);
je�li \fIkomend�-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia�ego znaku pocz�wszy.
.IP "\fBC\fP"
zmie� od obecnej pozycji do ko�ca wiersza (\fItzn.\fP skasuj do ko�ca
wiersza i przejd� do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nast�pnych \fIn\fP znak�w.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znak�w.
.IP "\fBD\fP"
skasuj do ko�ca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikaj�cej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo�e by� komend� przemieszczania (patrz powy�ej) lub \fBd\fP,
co powoduje skasowanie bie��cego wiersza.
.IP "\fIn\fP\fBr\fP\fIc\fP"
zamie� nast�pnych \fIn\fP znak�w na znak \fIc\fP.
.IP "\fIn\fP\fBR\fP"
zamie�: wejd� w tryb wprowadzania lecz przepisuj istniejace znaki
zamiast wprowadzania przed istniej�cymi znakami.  Zamiana zostaje wykonana
\fIn\fP krotnie.
.IP "\fIn\fP\fB~\fP"
zmie� wielko�� nast�pnych \fIn\fP znak�w.
.IP "\fIn\fP\fBy\fP\fImove-cmd\fP"
wytnij od obecnej pozycji po pozycj� wynikaj�c� z \fIn\fP krotnego
\fImove-cmd\fP do bufora wycinania; je�li \fImove-cmd\fP jest \fBy\fP, to
ca�y wiersz zostaje wyci�ty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do ko�ca wiersza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto�� bufora wycinania tu� po bie��cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko �e bufor zostaje wklejony na bie��cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "R�ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bie��cy wiersz zostaje wczytany, rozpoznany i wykonany przez pow�ok�.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bie��cy wiersz.
.IP "\fIn\fP\fB.\fP"
wykonaj ponownie ostatni� komend� edycji \fIn\fP razy.
.IP "\fBu\fP"
odwr�� ostatni� komend� edycji.
.IP "\fBU\fP"
odwr�� wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zako�czenia powoduj� skasowania bie��cego
wiersza i wy�wietlenie nowej zach�ty.
.RE
.\"Has all vi commands except:
.\"    movement: { } [[ ]] ^E ^Y ^U ^D ^F ^B H L M ()
.\"    tag commands: ^T ^]
.\"    mark commands: m ` '
.\"    named-buffer commands: " @
.\"    file/shell/ex-commands: Q ZZ ^^ : ! &
.\"    multi-line change commands: o O J
.\"    shift commands: << >>
.\"    status command: ^G
.\"}}}
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Files
.SH PLIKI
~/.profile
.br
/etc/profile
.br
/etc/suid_profile
.\"}}}
.\"{{{  Bugs
.SH B��DY
Wszelkie b��dy w pdksh nale�y zg�asza� pod adresem pdksh@cs.mun.ca.
Prosz� poda� wersj� pdksh (echo $KSH_VERSION), maszyn�,
system operacyjny i stosowany kompilator oraz opis jak powt�rzy� dany b��d
(najlepiej ma�y skrypt pow�oki demonstruj�cy dany b��d).
Nast�puj�ce mo�e by� r�wnie� pomocne, je�li ma znaczenie
(je�li nie jeste� pewny to podaj to r�wnie�):
stosowane opcje (zar�wno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo�na otrzyma� z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta pow�oka powsta�a z publicznego klonu si�dmego wydania pow�oki
Bourne'a wykonanego przez Charlesa Forsytha i z cz�ci pow�oki
BRL autorstwa Doug A.\& Gwyna, Douga Kingstona,
Rona Natalie;a, Arnolda Robbinsa, Lou Salkinda i innych.  Pierwsze wydanie
pdksh stworzy� Eric Gisin, a nast�pnie troszczyli si� ni� kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji �r�de� zawiera bardziej kompletn�
list� ludzi i ich wk�adu do rozwoju tej pow�oki.
.PP
T�umaczenie tego podr�cznika na j�zyk polski wykona� Marcin Dalecki
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "ZOBACZ TAK�E"
awk(1),
sh(1),
csh(1), ed(1), getconf(1), getopt(1), sed(1), stty(1), vi(1),
dup(2), execve(2), getgid(2), getuid(2), open(2), pipe(2), wait(2),
getopt(3), rand(3), signal(3), system(3),
environ(5)
.PP
.IR "The KornShell Command and Programming Language" ,
Morris Bolsky i David Korn, 1989, ISBN 0-13-516972-0.
.PP
.\" XXX ISBN missing
.IR "UNIX Shell Programming" ,
Stephen G.\& Kochan, Patrick H.\& Wood, Hayden.
.PP
.IR "IEEE Standard for information Technology \- Portable Operating System Interface (POSIX) \- Part 2: Shell and Utilities" ,
IEEE Inc, 1993, ISBN 1-55937-255-9.
