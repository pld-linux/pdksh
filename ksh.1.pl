'\" t
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
.TH KSH 1 "22 Lutego, 1999" "" "Komendy u�ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja otoczki Korn-a
.\"}}}
.\"{{{  Synopsis
.SH WYWO�ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP] [ [ \fB\-c\fP \fIci�g-komenda\fP [\fInazwa-komendy\fP] | \fB\-s\fP | \fIplik\fP ] [\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP, to interpretator komend nadaj�cy si�, zar�wno jako otoczka
do interakcyjnej pracy z systemem, jak i do wykonywania skrypt�w.
J�zyk komend przeze� rozumiany to nadzbi�r j�zyka otoczki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Odpalanie Otoczki"
Nast�puj�ce opcje mog� zosta� zastosowane w wierszu komendy:
.IP "\fB\-c\fP \fIci�g-komenda\fP"
otoczka wykonuje rozkaz(y) zawarte w \fIci�g-komenda\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni�ej
.IP \fB\-l\fP
otoczka zameldowania \(em patrz poni�ej
interakcyjny tryb \(em patrz poni�ej
.IP \fB\-s\fP
otoczka wczytuje komendy ze standardowego wej�cia; wszelkie argumenty
nie b�d�ce opcjami, s� argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni�ej
.PP
Ponad to wszelkie opcje, opisane w zwi�zku z wmontowan�
komend� \fBset\fP, mog� r�wnie� zosta� u�yte w wierszu komendy.
.PP
Je�li ani opcja \fB\-c\fP, ani opcja \fB\-s\fP, nie zosta�y
podane, w�wczas pierwszy argument nie b�d�cy opcj�, okre�la
plik z kt�rego zostan� wczytywane komendy. Je�li brak jest argument�w
nie b�d�cych opcjami, to otoczka wczytuje komendy ze standardowego
wej�cia.
Nazwa otoczki (\fItzn.\fP, zawarto�� parametru \fB$0\fP)
jest ustalana jak nast�puje: je�li u�yto opcji \fB\-c\fP i zosta�
podany nieopcyjny argument, to jest on nazw�; 
je�li komendy s� wczytywane z pliku, w�wczas nazwa danego pliku zostaje
u�yta jako nasza nazwa; w kazdym innym przypadku zostaje u�yta
nazwa, pod jak� dana otoczka zosta�a wywo�ana 
(\fItzn.\fP, warto�� argv[0]).
.PP
Otoczka jest \fBinterakcyjna\fP, je�li u�yto opcji \fB\-i\fP 
lub je�li zar�wno standardowe wej�cie, jak i standardowe wyj�cie,
s� skojarzone z jakim� terminalem.
W interakcyjnej otoczce kontrola zada� (je�li takowa jest dost�pna
w danym systemie) jest w��czona i ignoruje nast�puj�ce sygna�y:
INT, QUIT oraz TERM. Ponadto wy�wietla ona zach�cacze przed
wczytywaniem wprowadze� (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych otoczek, uaktywnia si� domy�lnie opcja \fBtrackall\fP
(patrz poni�ej: komenda \fBset\fP).
.PP
Otoczka jest \fBograniczona\fP je�li zastosowano opcj� \fB\-r\fP lub
gdy, albo podstawa nazwy pod jak� wywo�ano otoczk�, albo parametr
\fBSHELL\fP, pasuj� pod wzorzec *r*sh (\fIw szczeg�lno�ci\fP, 
rsh, rksh, rpdksh, \fIitp.\fP).
Nast�puj�ce ograniczenia zachodz� w�wczas po przetworzeniu przez
otoczk� wrzelkich plik�w profilowych i plik�w z \fB$ENV\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
komenda \fBcd\fP jest wy��czona
.IP \ \ \(bu
parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP, nie mog� by� modyfikowane
.IP \ \ \(bu
nazwy komend nie mog� by� podane przy pomocy absolutnych lub
wzgl�dnych trop�w
.IP \ \ \(bu
opcja \fB\-p\fP wbudowanej komendy \fBcommand\fP jest niedost�pna
.IP \ \ \(bu
przekierowania, kt�re stwarzaj� pliki, nie mog� zosta� zastosowane
(\fIw szczeg�lno�ci\fP, \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Otoczka jest \fBuprzywilejowana\fP, je�li zastosowano opcj� \fB\-p\fP,
lub, je�li rzeczywisty id u�ytkownika lub jego grupy
nie jest zgodny z efektywnym id u�ytkownika czy grupy
(patrz \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana otoczka nie przetwarza ani $HOME/.profile, ani parametru
\fBENV\fP (patrz poni�ej), w zamian zostaje przetworzony plik
/etc/suid_profile.
Wykasowanie opcji uprzywilejowania powoduje, �e otoczka ustawia sw�j
efektywny id u�ytkownika i grupy na warto�ci faktycznego id u�ytkownika
(user-id) i jego grupy (group-id).
.PP
Je�li podstawa nazwy pod jak� dana otoczka zosta�a wywo�ana 
(\fItzn.\fP, argv[0])
zaczyna si� od \fB\-\fP, lub je�li podano opcj� \fB\-l\fP,
to zak�ada si�, �e otoczka ma by� otoczk� zameldowania i wczytuje
zawarto�� plik�w \fB/etc/profile\fP i \fB$HOME/.profile\fP,
je�li takowe istniej� i s� odczytywalne.
.PP
Je�li podczas odpalania otoczki zosta� ustawiony parametr \fBENV\fP
(albo, w wypadku otoczek zameldowania, po przetworzeniu
wszelkich plik�w profilowych), to jego zawarto�� zostaje
poddana podstawieniom komend, arytmetycznym oraz szlaczka, a nast�pnie
wynikaj�ca z tej operacji nazwa (je�li takowa istnieje), zostaje
zinterpretowana jako nazwa pliku, podlegaj�cego nast�pnemu
wczytaniu i wykonaniu.
Je�li parametr \fBENV\fP jest pusty (i niezerowy), oraz pdksh zosta�
skompilowany ze zdefiniowanym makro \fBDEFAULT_ENV\fP, 
to (po wykonaniu wszelkich ju� wy�ej wymienionych podstawie�)
plik przeze� okre�lany zostaje wczytany.
.PP
Status zako�czenia otoczki wynosi 127, je�li plik komend
podany we wierszu wywo�ania nie m�g� zosta� otwarty,
albo jest niezerowy, je�li wyst�pi� fatalny b��d w sk�adni
podczas wykonywania tego� skryptu.
W wypadku braku wszelkich b��d�w, status jest r�wny statusowi ostaniej
wykonanej komendy lub, je�li nie wykonano �adnej komendy, zeru.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk�adnia Komend"
.\"{{{  words and tokens
Otoczka rozpoczyna analiz� sk�adni swych wprowadze� od podzia�u
na poszczeg�lne s�owa \fIword\fPs.
S�owa, stanowi�ce ci�gi znak�w, rozgranicza si� niewycytowanymi
znakami \fIbia�ymi\fP (spacja, tabulator i przerwanie wiersza) 
lub \fImeta-znakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza rozgraniczeniami s��w przerwy i tabulatory s� ignorowane.
Natomiast przerwania wierszy zwykle rozgraniczaj� komendy.
meta-znaki stosowane s� do tworzenia nast�puj�cych kawa�k�w:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIetc.\fP,
kt�re s�u�� do specyfikacji przekierowa� (patrz: przekierowywanie
wej�cia/wyj�cia poni�ej);
\fB|\fP s�u�y do tworzenia ruroci�g�w;
\fB|&\fP s�u�y do tworzenia koproces�w (patrz: Koprocesy poni�ej);
\fB;\fP s�u�y do oddzielania komend;
\fB&\fP s�u�y do tworzenia asynchronicznych ruroci�g�w;
\fB&&\fP i \fB||\fP s�u�� do specyfikacji warkunkowego wykonania;
\fB;;\fP jest u�ywany w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s� u�ywane w wyra�eniach arytmetycznych;
i na zako�czenie,
\fB(\fP .. \fB)\fP s�u�� do tworzenia podotoczek.
.PP
Bia�e przerwy lub meta-znaki mo�na wycytowywa� indywidualnie
przy u�yciu wstecznika (\fB\e\fP), lub grupami poprzez
podw�jne (\fB"\fP) lub pojedy�cze (\fB'\fP)
cudzys�owy.
Porsz� zwr�ci� uwag�, i� nast�puj�ce znaki podlegaj� r�wnie� 
specjalnej interpretacji przez otoczk� i musz� zosta� wycytowane
je�li maj� reprezentowa� samych siebie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to powy�ej wspomniane symbole wycytowywania
(patrz wycytowywanie poni�ej);
\fB#\fP, na pocz�tu s�owa rozpoczyna komentarz \(em wszysko do
\fB#\fP, po zako�czenie bierz�cego wiersza, zostaje zignorowane;
\fB$\fP s�u�y do wprowadzenia podstawienia  parametru, komendy lub arytmetycznego
wyra�enia (patrz Podstawienia poni�ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz Podstawienia poni�ej);
\fB~\fP rozpoczyna rozwini�cie katalogu (patrz Rozwijanie Szlaczka poni�ej);
\fB{\fP i \fB}\fP obejmuj� alternacje w stylu \fIcsh\fP(1)
(patrz Rozwijanie Nawias�w poni�ej);
i, na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s� stosowane
w generacji nazw plik�w (patrz Wzorce Nazw Plik�w poni�ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s��w i kawa�k�w, otoczka tworzy komendy, z kt�rych
wyr�nia si� dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z�o�one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, konstrukty grupujace i definicje funkcji.
.PP
Prosta komenda sk�ada si� z kombinacji przyporz�dkowa� warto�ci 
parametrom (patrz Parametry ponizej), przekierowa� wej�cia/wyj�cia
(patrz Przekierowania Wej�cia/Wyj�cia poni�ej), i s��w komend;
Jedynym ograniczeniem jest to, �e wszelkie przyporz�dkowania warto�ci
parametrom musz� poprzedza� s�owa komendy.
S�owa komendy, je�li zosta�y takowe podane, okre�laj� komend�, kt�r�
nale�y wykona�, wraz z jej argumentami.
Komenda mo�e by� wbudowan� komend� otoczki, funkcj� lub
\fIzewn�trzn� komend�\fP, \fItzn.\fP, oddzielnym
plikiem wykonywalnym, kt�ry zostaje zlokalizowany przy u�yciu
warto�ci parametru \fBPATH\fP (patrz Wykonywanie Kommend poni�ej).
Prosz� zwr�ci� uwag� i� wszelkie konstrukty komendowe posiadaj� 
\fIstatus zako�czenia\fP: dla zewn�trznych komend, jest on
powi�zany ze statusem zwracanym przez \fIwait\fP(2) (je�li
komenda nie zosta�a odnaleziona, w�wczas status wynosi 127, 
natomiast je�li nie mo�na by�o jej wykona�, to status wynosi 126);
statusy zwracane przez inne konstrukty komendowe (komendy wbudowane,
funkcje, ruroci�gi, listy, \fIitp.\fP) s� precyzyjnie okre�lone
i opisano je w zwi�zku z opisem danego konstruktu.
Status zako�czenia komendy zawieraj�cej jedynie przyporz�dkowania
warto�ci parametrom, odopwiada statusowi ostaniego wykonanego podczas tego
przyporz�dkowywnia podstawienia lub zeru, je�li �adne podstawienia nie mia�y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Komendy mog� zosta� powi�zane przy pomocy oznacznika \fB|\fP w
\fIruroci�gi\fP, w kt�rych standardowe wyj�cie
wszyskich komend poza ostatni�, zostaje pod��czone
(patrz \fIpipe\fP(2)) do standardowego wej�cia nast�pnej z szeregu
komend.
Status zako�czeniowy ruroci�gu, odpowiada statusowi ostatniej komendy
w nim.
Ruroci�g mo�e zosta� poprzedzony zarezerwowanym s�owem \fB!\fP,
dzi�ki czemu status ruroci�gu zostanie zamieniony na jego
logiczny komplement. Tzn. je�li pierwotnie status wynosi�
0, to b�dzie on mia� warto�� 1, natomiast je�li pierwotn� warto�ci�
nie by�o 0, to komplementarnym statusem jest 0.
.\"}}}
.\"{{{  lists
.PP
\fIList�\fP komend tworzymy rozdzielaj�c ruroci�gi
poprzez jeden z nast�puj�cych oznacznik�w:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj� warunkowe wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko, je�li status zako�czenia \fIcmd1\fP by� zerowy.
Natomiast \fB||\fP zachowuje si� dok�adnie przeciwstawnie. \(em \fIcmd2\fP 
zostaje wykonane jedynie, je�li status zako�czeniowy \fIcmd1\fP by�
r�ny od zera.
\fB&&\fP i \fB||\fP wi��� r�wnowa�nie, a zarazem mocniej ni�
\fB&\fP, \fB|&\fP i \fB;\fP, kt�re r�wnie� posiadaj� t� sam� si�� wi�zania.
Oznacznik \fB&\fP powoduje, �e poprzedzaj�ca go komenda zostanie wykonana
asynchronicznie, tzn., otoczka odpala dan� komend�, jednak nie czeka na jej
zako�czenie (otoczka �ledzi dok�adnie wszystkie asynchronicznye
komendy \(em patrz Kontroloa Zada� poni�ej).
Ja�li asynchroniczna komenda zostaje zastartowana z wy��czony�
kontrol� zada� (\fInp.\fP, w wi�kszo�ci skrypt�w), 
w�wczas komenda zostaje odpalona z wy��czonymi sygna�ami INT
i QUIT, oraz przekierowanym wej�ciem na /dev/null
(aczkolwiek przekierowania, ustalone w samej asynchronicznej komendzie
maj� tu pierwsze�stwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi�cy specjalnego
rodzaju asynchroniczn� komend� (patrz Koprocesy poni�ej).
Prosz� zwr�ci� uwag�, i� po operatorach \fB&&\fP i \fB||\fP 
musi wyst�powa� komenda, podczas gdy niekoniecznie
po \fB&\fP, \fB|&\fP i \fB;\fP.
Statusem zako�czenia listy komend jest status ostatniej wykonanej w niej
komendy z wyj�tkiem asynchronicznych list, dla kt�rych status wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Z�o�none komendy tworzymy przy pomocy nast�puj�cych zarezerwowanych s��w
\(em s�owa te zostaj� jedynie rozpoznane, gdy nie s� wycytowane i
wystepuj� jako pierwsze wyrazy w komendzie (\fIdok�aniej\fP, nie s� poprzedzane
�adnymi przyporz�dkowywaniami warto�ci parametrom
lub przekierowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niekt�re otoczki (lecz nie nasza) wykonuj� rozkazy kontrolne, 
je�li jeden lub wi�cej z ich deskryptor�w plik�w zosta�y przekierowane, 
w podotoczce tak wi�c wszekiego rodzaju zmiany otoczenia w nich mog�
nie dzia�a�.
Aby zachowa� portabilijno�� nale�y stosowa� rozkaz \fBexec\fP,
zamiast przekierowa� deskryptor�w plik�w przed rozkazem kontrolnym.
.PP
W nast�puj�cym opisie z�o�onych komend, listy komend (zanaczone przez 
\fIlista\fP) ko�cz�ce si� zarezerwowanym s�owem
musz� ko�czy� si� �rednikiem lub prze�amaniem wiersza lub (poprawnym
gramatycznie) zarezerwowanym s�owem.
Przyk�adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s� poprawne, naotmiast
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlist�\fP w podotoczce.  Nie ma bezpo�redniej mo�liwo�ci
przekazania warto�ci parametr�w podotoczki zpowrotem do jej
otoczki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Z�o�ony konstrukt; \fIlista\fP zostaje wykonana, lecz nie w podotoczce.
Prosze zauwa�y�, i� \fB{\fP i \fB}\fP, to zarezerwowane s�owa, a nie
meta-znaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs�owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra�enie \fBcase\fP stara si� podpasowa� \fIs�owo\fP pod jeden
z danych \fIwzorc�w\fP; \fIlista\fP, powi�zana z pierwszym
poprawnie podpasowanym wzorcem, zostaje wykonana.  
Wzorce stosowane w wyra�eniach \fBcase\fP odpowiadaj� wzorcom
stosowanymi do specyfikacji wzorc�w nazw plik�w z wyj�tkeim tego, �e
ograniczenia zwi�zane z \fB\&.\fP i \fB/\fP nie zachodz�.  
Prosz� zwr�ci� uwag� na to, �e wszelkie niewycytowane bia�e
przerwy przed i po wzorcu zostaj� usuni�te; wszelkie przerwy we wzorcu
musz� by� wycytowane.  Zar�wno s�owa jak i wzorce podlegaj� podstawieniom
parametr�w, rozwini�ciom arytmetycznym jak te� i podstawieniu szlaczka.
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykaj�cy zamiast \fBin\fP i \fBesac\fP 
(\fIw szczeg�no�ci wi�c\fP, \fBcase $foo { *) echo bar; }\fP).
Statusem wykonania wyra�enia \fBcase\fP jest status wykonanej
\fIlisty\fP; je�li nie zosta�a wykanana �adna \fIlista\fP, 
w�wczas status wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest, albo przerwaniem wiersza, albo \fB;\fP.
Dla ka�dego \fIs�owa\fP w podanej li�cie s��w, parameter \fInazwa\fP zostaje
ustawiony na to s�owo i \fIlista\fP wykonana. Je�li nie u�yjemy \fBin\fP 
do specyfikacji listy s��w, w�wczas zostaj� u�yte parametry pozycyjne
(\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP) wzamian.
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP 
(\fIw szczeg�lno�ci\fP, \fBfor i; { echo $i; }\fP).
Statusem wykonania wyra�enia \fBfor\fP jest ostatni status
wykonania danej \fIlisty\fP; je�li \fIlista\fP nie zosta�a w og�le
wykonana, w�wczas status wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je�li status wykonania pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je�li mamy takow�,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami.  Je�li wszystkie listy po \fBif\fP
i \fBelif\fPs wyka�� b��d (\fItzn.\fP, zwr�c� niezerowy status), to
\fIlista\fP po \fBelse\fP zostanie wykonana.
Statusem wyra�enia \fBif\fP jest status wykonanej \fIlisty\fP,
nieokre�laj�cej warunek; Je�li �adna nieokre�laj�ca warunek
\fIlista\fP niezostanie wykonana, w�wczas status wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest, albo prze�amaniem wiersza albo \fB;\fP.
Wyra�enie \fBselect\fP umo�liwia automatyczn� prezentacj� u�ytkownikowi
menu, wraz z mo�liwo�ci� wyboru z niego.
Przeliczona lista wykazanych \fIs��w\fP zostaje wypisana na
standardowym wyj�ciu b��d�w, poczym zostaje
wy�wietlony zach�cacz (\fBPS3\fP, czyli domy�lnie `\fB#? \fP').
Nast�pnie zostaje wczytana liczba odpowiadaj�ca danemu punktowi
menu ze standardowego wej�cia, poczym \fInazwie\fP 
zostaje przyporz�dkowane w ten spos�b wybrane s�owo (lub warto��
pusta, je�li dane wyb�r by� niew�a�ciwy), \fBREPLY\fP
zostaje przyporz�dkowane to co zosta�o wczytane
(po usuni�ciu pocz�tkowych i ko�cowych bia�ych przerw),
i \fIlista\fP zostaje wykonan.
Je�li wprowadzono pusty wiersz (\fIdok�adniej\fP, zero lub wi�cej
znaczk�w \fBIFS\fP) w�wczas menu zostaje podownie wy�wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zako�czone, 
w�wczas przeliczona lista wybor�w zostaje wy�wietlona ponownie, je�li
\fBREPLY\fP jest zerowe, zach�cacz zostaje ponownie podany i tak dalej.
Proces ten powtarza si�, a� do wczytania znaku zako�czenia pliku,
otrzymania sygna�u przerwania, lub wykonania wyra�enia przerwania
w �rodku wst�gi.
Je�li opuszczono \fBin\fP \fIs�owo\fP \fB\&...\fP, w�wczas
u�yte zostaj� parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP, 
\fIitp.\fP).
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczeg�lno�ci\fP, 
\fBselect i; { echo $i; }\fP).
Statusem zako�czenia wyra�enia \fBselect\fP jest zero, je�li
uzyta wyra�enia przerwania do wyjscia ze wst�gi, albo
nie-zero w wypadku przeciwnym.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia�a dok�adnie jak \fBwhile\fP, z wyj�tkiem tego, �e zawarto��
wst�gi zostaje wykonana jedynie gdy status pierwszej 
\fIlisty\fP jest nie-zerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra�enie \fBwhile\fP okre�la wst�g� o przedbiegowym warunku jej
wykonania.  Zawarto�� wst�gi zostaje wykonywana dopuki,
doputy status wykonania pierwszej \fIlisty\fP jest zerowy.
Statusem zako�czeniowym wyra�enia \fBwhile\fP jest ostatni 
status zako�czenia \fIlisty\fP w zawarto�ci tej wst�gi; 
gdy zawarto�� nie zostanie wog�le wykonana w�wczas status wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcj� o nazwie \fInazwa\fP.
Patrz Funkcje poni�ej.
Prosz� zwr�ci� uwag�, �e przekierowania tu� po definicji
funkcji zostaj� zastosowane podczas wykonywania jej zawarto�ci, 
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fIname\fP \fB()\fP \fIcommand\fP"
Niemal dok�adnie to samo co w \fBfunction\fP.
Patrz Funkcje poni�ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra�enie\fP \fB))\fP"
Warto�� wyra�enia arytmetycznego \fIwyra�enie\fP zostaje przeliczona;
r�wnowa�ne do \fBlet "\fP\fIwyra�enie\fP\fB"\fP.
patrz Wyra�enia Arytmetyczne i komenda \fBlet\fP poni�ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (kt�re opisyjemy 
p�niej), z nast�puj�cymi r�nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie p�l i generacja nazw plik�w nies� wykonywana na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub), zostaj� zast�pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok�adniej.\fP, \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP) 
musz� by� wycytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczeg�lno�ci\fP, por�wnanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP
kt�re zwracaj� prawd�, gdy pierwszy ci�gowy operand jest mniejszy lub 
odpowiednio wi�kszy do drugiego operanda ci�gowego.
.IP \ \ \(bu
Jednoargumentowa posta� operacji \fBtest\fP,
w kt�rej sprawdza si� czy jedyny operand jest d�ugo�ci zeroweji, jest 
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
\fB&&\fP i \fB||\fP zostaje zastosowana metoda ogr�dkowego wyliczania
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
.SS Wycytowywanie
Wycytowywanie stosuje si� to zapobiegania, aby otoczka trakotwa�a
znaki lub s�owa w specjalny sos�b.
Istniej� trzy metody wycytowywania: Po pierwsze, \fB\e\fP wycytowywuje
nast�pny znak, gdy tylko nie mie�ci si� on na ko�cu wiersza, gdzie
zar�wna \fB\e\fP jak i przeniesienie wiersza zostaj� usuni�te.
po drugie pojedy�czy cydzys�ow (\fB'\fP) wycytowywuje wszystko,
a� po nast�pny pojedy�czy cudzys��w (wraz z prze�amaniami wierszy w��cznie).
Po trzecie, podw�jny cudzys��w (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a� po nast�pny niewycytowany podw�jny 
cudzys��w.
\fB$\fP i \fB`\fP wewnatrz podw�jnych cudzys�ow�w zachowuj� zwyk�e 
znacznie (\fItzn.\fP,
znaczaj� podstawienie warto�ci parametru, komendy lub wyra�enia arytmetycznego),
je�li tylko niezostanie wykonany jakikolwiek podzia� p�l na
wyniku podw�jnymi cudzys�owami wycytowanych podstawie�.
Je�li po \fB\e\fP, wewnatrz podw�jnymi cudzys�owami wycytowanego
ci�gu znak�w, nast�puje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zast�piony drugim z tych znak�w;
je�li nast�pne jest prze�amanie wierszu, w�wczas zar�wno \fB\e\fP 
jak i prze�amanie wirszu zostaj� usuni�te;
w przeciwnym razie zar�wno znak \fB\e\fP jak i nast�puj�cy po nim znak
nie podlegaj� �adnej zamianie.
.PP
Uwaga: patrz Tryb POSIX poni�ej pod wzgl�dem szczeg�lnych reg�
obowi�zuj�cych sekwencje znak�w postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej� dwa rodzaje alias�w: normalne aliasy komend i
�ledzone aliasy.  Aliasy komend stosowane s� zwykle jako
skr�ty dla d�ugich a cz�sto stosowanych komend. 
Otoczka rozwija aliasy komend (\fItzn.\fP,
odstawia pod nazw� aliasu jest zawarto��), gdy wczytuje
pierwsze s�owo komendy. 
Roziwni�ty alias zostaje ponownie przetworzony, aby uwzgl�dni�
ewentualne wyst�powanie dlaszych alias�w.  
Je�li alias komendy ko�czy si� przerw� lub tabulatorem, to w�wczas
nast�pne s�owo zostaje r�wnie� sprawdzone pod wzgl�dem rozwini�cia
alias�w. Proces rozwijania alias�w ko�czy si� przy napotkaniu
s�owa, kt�re nie jest aliasen, gdy napotknie si� na wycytowane s�owo,
lub gdy napotka si� na alias, kt�ry jest w�a�nie wyeksportowywany.
.PP
Nast�puj�ce aliasy s� definiowane domy�lnie przez otoczk�:
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
�ledzone aliasy pozwalaj� otoczce na zapami�tanie, gdzie
odnalaz�a ona konkretn� komend�.
Gdy otoczka po raz pierwszy odszukuje komendy po tropie, kt�ra
zosta�a naznaczona �ledzonym aliasem, wowczas zapami�tywuje ona
sobie pe�ny trop do tej komendy.
Gdy otoczka nast�pnie wykonuje dan� komend� poraz drugi,
w�wczas sprawdza ona czy ten trop wci�� jest nadal aktualny i je�li
tak nie przegl�da ju� wi�cej pe�nego tropu w poszukiwaniu
danej komendy.
�ledzone aliasy mo�na wy�wietli� lub stworzy� stosuj�c \fBalias
\-t\fP.  Prosz� zauwa�y�, �e zmieniajac warto�� parametru \fBPATH\fP 
r�wnie� wyczyszczamy tropy dla wszelkich �ledzoenych alias�w.
Je�li zosta�a w��czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP), 
w�wczas otoczka �ledzi wszelkie komendy. 
Ta opcja zostaje w��czona domy�lnie dla wszelkich
nieinterakcyjnych otoczek.
Dla otoczek interakcyjnych, jedynie nast�puj�ce komendy, s� 
�ledzone domy�lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki otoczka wykonyje, podczas wykonywania
prostej komendy, jest przeprowadzenia podstawie� na s�owach tej�e
komendy.
Istniej� trzy rodzaje podstawie�: parameter�w, komend i arytmetyczne.
Podstawienia parametr�w, kt�re dok�adniej opiszemy w nast�pnej sekcji,
maj� posta� \fB$name\fP lub \fB${\fP...\fB}\fP; 
podstawienia komend maj� posta� \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je�li podstawienie wyst�puje poza podw�jnymi cudzys�owami, w�wczas 
wynik tego podstawienia podlega zwykle podzia�owi s��w lub p�l, w zale�no�ci
od bierz�cej warto�ci parametru \fBIFS\fP.
Parametr \fBIFS\fP specyfikuje list� znaczk�w, kt�re
s�u�� jako rozgraniczniki w podziale ci�g�w znak�w na pojedy�cze 
wyrazy;
wszelkie znaki wymienione w tym zbiorze oraz tabulator, przerywacz i 
prze�amanie wiersza w��cznie, nazywane s� \fIIFS bia�ymi przerywaczami\fP.
Ci�gi jednego lub wielu bia�ych przerywaczy z IFS w powi�zaniu
z zerem oraz jednym lub wi�cej bia�ych przerywaczy nie wymienionych w IFS,
rozgraniczaj� pola.
Jako wyj�tek poprzedajace i ko�cowe bia�e przerywacze z IFS zostaj� usuni�te
(\fItzn.\fP, nie powstaj� przeze� �adne prowadz�ce lub zaka�czaj�ce
puste pola); natomiast prowadz�ce lub ko�cz�ce bia�e przerwy nie z IFS
definiuj� okre�laj� puste pola.
Przyk�adowo: je�li \fBIFS\fP zawiera `<spacja>:', to ci�g
znak�w `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Prosz� zauwa�y�, �e je�li parametr \fBIFS\fP 
jest ustawiony na pusty ci�g znak�w, to w�wczas �aden podzia� p�l
nie ma miejsca; gdy paramter ten nie jest ustawiony w og�le,
w�wczas stosuje si� domy�lnie jako rozgraniczniki
przerwy, tabulatora i przerwania wiersza.
.PP
Je�li nie podajemy inaczej, to wynik podstwaienia
podlega r�wnie� rozwijaniu nawias�w i nazw plik�w (patrz odpowiednie
akapity poni�ej).
.PP
Podstawienie komendy zostaje zast�pione wyj�ciem, wygenerowanym
podczas wykonania danej komendy przez podotoczk�.
Dla podstawienia \fB$(\fP\fIkomeda\fP\fB)\fP zachodz� normalne
reg�y wycytowywania, podczas analizy \fIkomendy\fP,
cho� jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu� po nim, zostaje usuni�ty
(znak \fB\e\fP z nast�pstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyjatkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczajaca podstawienie zawarto�ci pliku \fIplik\fP 
($(< foo) ma wi�c ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony �aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra�enia \fB$(\fP\fIkomendacommand\fP\fB)\fP s� analizowane
obecnie poprzez odnajdywanie zaleg�ego nawiasu, niezale�nie od
wycytowa�.  Miejmy nadziej�, �e to zostanie jak najszybciej
skorygowane.
.PP
Podstwaienia arytmetyczne zostaja zast�pione warto�ci� wyniku
danego wyra�enia.
Przyk�adowo wi�c, komenda \fBecho $((2+3*4))\fP wy�wietla 14.
Patrz Wyra�enia Arytmetyczne aby odnale�� opis \fIwyra�e�\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w otoczce; mo�na im przyporz�dkowywa� 
warto�ci, oraz wyczytywa� je poprzez podstwaienia parametrowe.
Nazwa parametru jest albo jednym ze znak�w 
intperpunkyjnych o specjalnym znaczeniu lub cyfr�, jakie opisujemy 
poni�ej, lub liter� z nast�pstwem jednej lub wi�cej liter albo cyfr
(`_' zalicza si� to liter).
Podstawienia parametr�w posiadaj� posta� \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdziee \fInazwa\fP jest nazw�
danego parametru.
Gdy podstawienia zostanie wykonane na parametrzy, kt�ry nie zosta�
ustalony, w�wczas zerowy ci�g znak�w jest jego wynikiem, chyba �e
zosta�a w�aczona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP) co oznacza, �e wyst�puje w�wczas b��d.
.PP
.\"{{{  parameter assignment
Warto�ci mo�na przyporz�dkowywa� parametrom na wiele r�nych sposob�w.
Po pierwsze, otoczka domy�lnie ustala pewne parametry takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny spos�b w jaki parametry zwi�zana 
ze specjalnymi jednoznakami s� ustawiane.  Po drugie, parametry zostaj� 
importowane z otocznia otoczki podczas jej odpalania.  Po przecie,
parametrom mo�na przyporz�dkowa� warto�ci we wierszu komendy, tak jak np.,
`\fBFOO=bar\fP' przyporz�dkowywuje parametrowi FOO warto�� bar;
wielokrotne przyporz�dkowania warto�ci s� mo�liwe w jednym wierszu komendy
i mo�e po nich wyst�powa� prosta komenda, co powoduje, �e
przyporz�dkowania te s� w�wczas jedynie aktualne podczas
wykonywywania danej komendy (tego rodzaju przyporz�dkowywania
zostaj� r�wnie� wyekstportowane, patrz poni�ej co do tego konsekwencji).
Prosz� zwr�ci� uwag�, i�, aby otoczka rozpozna�a je jako
przyporz�dkowanie warto�ci parametrowi, zar�wno nazwa parametru jak i \fB=\fP
nie mog� by� wycytowane.
Czwartym sposobem ustawiania parametr�w jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale Wykonywanie Komend.
Po czwarte wst�gi \fBfor\fP i \fBselect\fP ustawiaj� parametry,
tak jak i r�wnie� komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zako�czenie, paramerom mo�na przyporz�dkowywa� warto�ci stosuj�c
operatory nadania warto�ci wewn�trz wyra�e� arytmetycznych
(patrz Wyra�enia Arytmetyczne poni�ej) lub
stosujac posta� \fB${\fP\fInazwa\fP\fB=\fP\fIwarto��\fP\fB}\fP
podstawienia parametru (patrz poni�ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem exportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP,albo poprzez przyporz�dkowywanie warto�ci
parametru z nast�puj�c� prost� komend�) 
zostaj� umieszczone w otoczeniu (patrz \fIenviron\fP(5)) komend
wykonywanych przez otoczke jako pary \fInazwa\fP\fB=\fP\fIwarto��\fP.
Kolejno�� w jakiej parametry wyst�puj� w otoczeniu komendy jest 
nieustalona bli�ej.
Podczas odpalania otoczka pozyskuje parametry ze swojego
otoczenia,
i automatycznie ustawia na tych�e parametrach atrybut exportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo�na stosowa� modyfikatory do postaciu \fB${\fP\fInazwa\fP\fB}\fP 
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna
warto��, w przeciwnym razie zostaje podstawione \fIs�owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje podstawione 
\fIs�owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastwaiony i niezerowy, w�wczas zostaje podstawiony 
on sam, w przeciwnym razie zostaje my przyporz�dkowana warto��
\fIs�owo\fP i warto�� wynikaj�ca ze \fIs�owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna warto��, w przeciwnym razie \fIs�owo\fP
zostaje wy�wietlone na standardowym wyj�ciu b��d�w (tu� po \fInazwa\fP:)
i zachodzi b��d
(powoduj�cy normalnie zako�czenie ca�ego skryptu otoczki, funkcji lub \&.-scryptyu).
Je�li s�owo zosta�o pomini�te, w�wczas zostaje u�yty ci�g 
`parameter null or not set' w zamian.
.PP
W powy�szych modyfikatorach mo�emy omin�� \fB:\fP, czego skutkiem
b�dzie, �e warunki b�d� jedynie wymaga� aby
\fInazwa\fP by� nastawiony lub nie (a nie �eby by� ustawiony i niezerowy).
Je�li potrzebna jest warto�� \fIs�owo\fP, w�wczas zostaj� na� wykonane
podstawienia parametr�w, komend, arytmetyczne i szlaczka;
natomiast, je�li \fIs�owo\fP oka�e si� by� niepotrzebne, w�wczas jego
warto�� nie zostanie obliczona.
.\"}}}
.PP
Mo�na stosowa�, r�wnie� podstawienia parametr�w o nast�puj�cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Ilo�� parametr�w pozycyjnych, je�li \fInazw�\fP jest \fB*\fP, \fB@\fP lub
niczego nie podano, lub d�ugo�� ci�gu b�d�cego wasto�ci� parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Ilo�� elemnt�w w ci�gu \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak�ada si� na pocz�tek warto�ci parametru \fInazwa\fP,
w�wczas pasuj�cy teks zostaje pomini�ty w wynikajacym z tego podstawieniu. 
Pojedy�czy \fB#\fP oznacza najkr�tsze mo�liwe podpasowanie pod wzorzec, a daw \fB#\fP
oznaczaj� jak najd�u�sze podpasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko �e dotyczy
ko�ca warto�ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nast�puj�ce specjalne parametry zostaja ustawione domy�nie przez otoczk�
i nie mo�na przyporz�dkowywa� jawnie warto�ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego zastartowanego w tle procesu. Je�li nie ma
aktualnie proces�w zastartowanych w tle, w�wczas parametr ten jest 
nienastawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Ilo�� parametr�w pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj�cego danej otoczce lub PID pierwotnej otoczki,
je�li mamy do czynienia z  podotoczk�.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenecja bierz�cych opcji jednoliterkowych
(patrz komenda \fBset\fP poni�ej, aby pozna� dost�pne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Status wynikowy ostatniej wykonanej  nieasynchronicznej komendy.
Je�li ostatnia komenda zosta�a zabita sygna�em, w�wczas, \fB$?\fP 
przyjmuje warto�� 128 plus numer danego sygna�u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa pod jak� dana otoczka zosta�a wywo�ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP je�li zosta�a ona wywo�ana przy urzyciu opcji \fB\-c\fP 
i \fBnazwa komendy\fP zosta�a podana, lub argument \fIplik\fP,
je�li takowy zosta� podany.
Je�li opcja \fBposix\fP nie jest nastawiona, to \fB$0\fP zawiera
nazw� bie��cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewi�c parametr�w pozycyjnych podanych otoczce, czy
funkcji lub \fB.\fP-skriptowi.
Dost�p do dlaszych parametr�w pozycyjnych odbywa si� przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj�tkiem parametru 0), 
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u�yte poza podw�jnymi cudzys�owami, w�wczas parametry zostaj�
rozgraniczone w pojedy�cze s�owa
(podlegaj�ce rozgraniczaniu s��w); je�li u�yte pomi�dzy 
podw�jnymi cudzys�owami, wowczas parametry zostaj� rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci�gami znak�w, je�li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj�tkiem zastosowania w podw�jnych cudzys�owach,
gdzie oddzielne s�owo zostaje wygenerowane dla ka�dego parametru
pozycyjnego z osobna \- je�li brak parametr�w pozycyjnych,
w�wczas nie generowane jest �adne s�owo
("$@" mo�e by� uzyte aby otrzyma� dost� bezpo�redni do argument�w
bez utraty argument�w zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nast�puj�ce parametry zostaj� nastawione przez otoczk�:
.\"{{{  _
.IP "\fB_\fP \fI(podkre�lenie)\fP"
Gdy jaka� komenda zostaje wykonywana prze otoczk�, ten parametrt przyjmuje
w otoczeniu odpowiedniego nowego procesu warto�� tropu prowadz�cego
do tej�e komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierowtej otoczce
ponadto warto�� ostatniego s�owo poprzedniej komendy
Podczas warto�ciowania wiadomosci typu \fBMAILPATH\fP,
parametr ten zawiera wi�c nazw� pliku kt�ry si� zmieni�
(patrz parametr \fBMAILPATH\fP poni�ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
Trop do przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia�a tak samo jak
\fBPATH\fP dla katalog�w nierozpoczynajacych si� od \fB/\fP 
w komendach \fBcd\fP.
Prosz� zwr�ci� uwag�, i� je�li CDPATH jest nastawiony i nie zwaiera ani
\fB.\fP ani pustego tropu, to w�wczas katalog bie��cy nie zostaje przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Ilo�� kolumn terminala lub okienka.
Obecnie nastawiany warto�ci� \fBcols\fP zwracan� przez komend�
\fIstty\fP(1), je�li ta warto�� nie wynosi zera.
Parametr ten ma znaczenia w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w�a�ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je�li nie zosta� nastawiony parametr \fBVISUAL\fP, w�wczas kontroluje on
tryb edycj wiersza komendy w otoczkach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni�ej, aby dowiedzie� si� jak to dzia�a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je�li parametr ten oka�e si� by� nastawionym po przetworzeniu
wszelkich plik�w profilowych, w�wczas jego rozwinieta warto�� zostaje
wyko�ystana jako nazwa pliku zawieraj�cego dalsze komendy inicjalizacyjne
otoczki.  Zwykle zwiera on definicje funkcji i alias�w.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca�kowita warto�� odpowiadaj�ca zmiennej errno otoczki 
\(em wskazuje przyczyn� wyst�pienia b��du, gdy ostatnie wywoa�nie
systemowe nie powiod�o si�.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezimplementowe.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je�li nastawiono, to w�wczas zawiera otoczk�, jakiej nale�y u�y�
do wykonywania komend kt�rych niezdo�a� wykona� \fIexecve\fP(2) 
i kt�re nie zaczynaja si� od ci�gu `\fB#!\fP \fIotoczka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u�ywany przez komend� \fBfc\fP (patrz poni�ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je�li otoczka natrafi na niezdefiniowan� 
funkcj� podczas pracy, stosowane do lokalizacji pliku zawieraj�cego definicj�
tej funkcji.
R�wnie� przeszukiwane, gdy komenda nie zosta�a odnaleziona przy
u�yciu \fBPATH\fP.
Patrz Funkcje poni�ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u�ywanego do zapisu histori komend.
Je�li warto�� zosta�a ustalona, w�wczas historia zostaje za�adowana
z danego pliku.
Podobnie wielokrotne wcielenia otoczki b�d� ko�ysta�y z jednej
historii, je�li dla nich warto�ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je�li HISTFILE nie zosta�o ustawione, w�wczas �aden plik histori
nie zostaje u�yty.  W originalnej wersji otoczki
Korna natomiast, przyjmuje si� domy�lnie \fB$HOME/.sh_history\fP;
w przysz�o�ci mo�e pdksh, b�dzie r�wnie� sotoswa� domy�lny
plik histori.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Ilo�� komend zapami�tywana w histori, domy�lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy�lna warto�� dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz Rozwijanie Szlaczka poni�ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewn�trzny separator p�l, sotoswany podczas podstawie�
i wykonywania komendy \fBread\fP, do rozdzielania
warto�ci na oddzielne argumenty; domy�nie przerwa, tabulator i 
prze�amanie wiersza. Szczeg�ly zosta�y opisane w punkcie Podstawienia
powy�ej.
.br
\fBUwaga:\fP ten parametr nie zostaje importowany z otoczenia, 
podczas odpalania otoczki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja i data kompilacji otoczki (tylko do otczytu).
Patrz r�wnie� na komedy wersji w Emacsowej Interakcyjnej Edycji Wiersza 
Komendy i Edycji Wiersza Vi poni�ej.
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
Jeszcze nie zimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je�li nastawiony, to u�ytkownik jest informaowany
o nadej�ciu nowej poczty do ustawionego tam pliku docelowego.
Ten parametr jest ignorowany, je�li
zosta� nastawiony parametr \fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak cz�sto otoczka ma sprawdza�, czy pojawi�a si�
w plikach podanych poprzez \fBMAIL\fP lub \fBMAILPATH\fP nowa poczta. 
Je�li 0, to otoczka sprawdza przed ka�d� now� zach�t�.  
Warto�ci� domy�ln� jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
Lista plik�w sprawdzanych o now� poczt�.  Lista ta jest rozdzielana
dwukropkami, ponadto po nazwie ka�dego z plik�w mo�na poda�
\fB?\fP i wiadomo�� kt�ra ma by� wy�wietlona, je�li nadesz�a nowa poczta.  
Podstawienia komend parametr�w i arytmetyczne zostaj� wykonane na
danej wiadomo�ci. Podczas postawie� parametr \fB$_\fP
zawiera nazw� tego� pliku.
Domy�lnym zawiadomieniem jest \fByou have mail in $_\fP 
(\fBmasz poczt� w $_\fP).
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nieustalony, je�li \fBcd\fP nie zmieni�o z powodzeniem
katalogu od czasu odpalenie otoczki lub je�li otoczka nie wie gdzie
si� aktualnie obraca.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
Podczas u�ywania \fBgetopts\fP, zawiera argument dla aktulanie
rozpoznawanej opcji, je�li jest on oczekiwany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostoaniego przetworzonego argumentu podczas u�ywania \fBgetopts\fP.
Przyporz�dkowanie 1 temu parametrowi powoduje, �e \fBgetopts\fP
przetwarza arugmenty od pocz�tku, gdy zostanie wywo�ane ponownie.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem od siebie katalog�w, kt�re s� przeszukiwane
podczas odnajdywania jakiej� komendy lub plik�w typu \fB.\fP.
Pusty ci�g wynikaj�cy z poprzedzaj�cego lub nast�puj�cego dwukropka,
albo dwuch s�siednich dwukropk�w, jest trakowany jako `.',
czyli katalog bierz�cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Nstawienie tego parametru powoduje w��czenie opcji \fBposix\fP.
Patrz Tryp POSIX-owy poni�ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzicielskiego otoczki (tylko odczyt).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP zach�cacz pierwszego rz�du dla otoczek interakcyjnych.
Podlega podstawieniom parametr�w, komend i arytmetycznym, poand to
\fB!\fP zostaje zast�pione numerem kolejnym aktualnej komendy
(patrz komenda \fBfc\fP
poni�ej).  Sam znak ! mo�e zosta� umieszczony w zach�caczu stosuj�c 
!! w PS1.
Zauwa�, �e poniewa� edytory wiersza komendy staraj� si� obliczy�,
jak d�ugi jest zach�cacz, (aby m�c ustali�, ile miejsca pozostaje
wolnego do  parwego brzegu ekranu), sekwencje wyj�ciowe w zach�caczu 
zwykle wprowadzaj� pewien ba�agan.
Istnije mo�liwo�� podpowiedzenia otoczce, �eby nie uwzgl�dnia�a
pewnych ci�g�w znak�w (takich jak kody wyj�cia) poprzez podanie
predsionka na pocz�tku zach�cacza b�d�cego niewy�wietlalnym znakiem
(takim jak np. control-A) z nast�pstwem prze�amania wiersza,
oraz odgraniczaj�c nast�pnie kody wyj�cia przy pomocy tego 
niewy�wietlalnego znaku.
Gdy brak niewy�wietlalnych znak�w, to nie ma �adnej rady...
Nawiasem m�wi�c nie ja jestem odpowiedzialny za ten hack. To pochodzi
z orginalnego ksh.
Domy�ln� warto�ci� jest `\fB$\ \fP' dla nieuprzywilejownych
u�ytkownik�w, a `\fB#\ \fP' dla root-a..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Durugorz�dny zach�cacz, o domy�lnej warto�ci `\fB>\fP ', kt�ry
jest stosowany, gdy wymagane s� dalsze wprowadzenia w celu
skompletowania komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zach�cacz stosowany przez wyra�enie
\fBselect\fP podczas wczytywania wyboru z menu.
Domy�lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, kt�re zostaj� wy�wietlone podczas
�ledzenia toku pracy
(patrz komenda \fBset \-x\fP poni�ej).
Domy�lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo�e by� nienastawiony lub zerowy, je�li
otoczka nie wie gdzie si� znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb pseudo przypadkowych. Za ka�dym razem, gdy
odnosimy si� do \fBRANDOM\fP jego warto�ci zostaje przyporz�dkowana
nast�pna liczba z przypadkowego ci�gu liczb.
Miejsce w danym ci�gu mo�e zosta� ustawione nadaj�c
warto�� \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy�lny parametr dla komendy
\fBread\fP, je�li nie pozostan� podane jej �adne nazwy.
Stosowany r�wnie� we wst�gach \fBselect\fP do zapisu warto�ci
wczytywanej ze standardowego wej�cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Sekundy, kt�re up�yn�y od czasu odpalenia otoczki, lub je�li
parametrowi zosta�a nadana warto�� ca�kowita, ilo�� sekund od czasu
nadania tej warto�ci plus ta warto��.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy nastawiony na pozytywn� warto�� ca�kowit�, wi�ksz� od zera,
w�wczas ustala w interkacyjnej otoczce czas w sekundach, przez jaki
b�dzie ona czeka�a na wprowadzenie po wy�wietleniu pierwszorz�dnego
zach�cacza (\fBPS1\fP).  Po przekroczeniu tego czasu otoczka zostaje 
opuszczona.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog w kt�rym tymczasowe pliki otoczki zostaj� umieszczone.
Je�li dany parametr nie zosta� nastawiony, lub gdy nie zawiera 
pe�nego tropu zapisywalnego katalogy, w�wczas domy�lnie tymczasowe
pliki mieszcz� si� w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je�li zosta� nastawiony, ustala tryb edycji wiersza komend w otoczkach
interakcyjnych. Je�li sotatni cz�onek tropu podanego w danym
parametrze zawierz ci�g znak�w \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odopiwednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie Szlaczk�w"
Roziwaje szlaczk�w, kt�re ma miejsce r�wnolegle do podstawie� parametr�w,
zostaje wykonane na s�owach rozpoczynaj�cych si� niewycytowanym
\fB~\fP.  Znaki po szlaczku do pierwszego
\fB/\fP, je�li wyst�puje takowy, s� domy�lnie traktowane jako
nazwa u�ytkownika.  Je�li nazwa u�ytkownia jest pusta, to \fB+\fP lub \fB\-\fP,
warto�� parametr�w \fBHOME\fP, \fBPWD\fP, lub \fBOLDPWD\fP zostaje
odpowiednio podstawiona.  W przeciwnym razie zostaje 
przeszukany plik kod�w dost�pu w celu odnalezienia danej nazwy
u�ytkownika, i w miejsce rozwini�cia szlaczka zostaje
podstawiony katalog domowy danego u�ytkownika
Je�li nazwa u�ytkownika nie zostaje odnalezione w pliku hase�,
lub gdy jakiekolwiek wycytowanie albo podstawienie parametru
wyst�puje  w nazwie u�ytkownika, w�wczas nie zostaje wykonane �adne 
podstawienie.
.PP
W nastawieniach parametr�w
(tych poprzedzaj�cych proste komendy lub tych wyst�puj�cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie szlaczk�w zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP), i nazwy u�ytkownik�w zostaj� uj�te
w dwukropki.
.PP
Katalogi domowe poprzednio rozwinietych nazw u�ytkownik�w zostaj�
umieszczone w pami�ci podr�cznej i w ponownym u�yciu zostaj� stamt�d
pobierane.  Komenda \fBalias \-d\fP mo�e by� u�yta do wylistowania, 
zmiany i dodawnia do tej pami�ci podr�cznej
(\fIw szczeg�lno�ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie Nawias�w (przemiany)"
Rozwini�cia nawias�w przyjmuj�ce posta�
.RS
\fIprefiks\fP\fB{\fP\fIci�g\fP1\fB,\fP...\fB,\fP\fIci�g\fPN\fB}\fP\fIsuffiks\fP
.RE
zostaj� rozwini�te w N wyraz�w, z kt�rych ka�dy zawiera konkatenacj�
\fIprefiks\fP, \fIci�g\fPi i  \fIsuffiks\fP
(\fIw szczeg�no�ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwini�te do czterech wyraz�w:
ace, abXe, abYe, and ade).
Jak ju� wy�ej wspomniano, rozwini�ci nawias�w mog� by� nak�adane na siebie
i wynikaj�ce s�owa nie s� sortowane.
Wyra�enia nawiasowe musz� zawiera� niewycytowany przecinek
(\fB,\fP) aby nast�pi�o rozwijanie
(\fItak wi�c\fP, \fB{}\fP i \fB{foo}\fP nie zostaj� rozwini�te).
Rozwini�cie nawias�w nast�puje po podstawnieniach parametr�w i przed
generacj� nazw plik�w
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce Nazw Plik�w"
.PP
Wzorcem nazwy pliku jest s�owo zwieraj�ce jeden lub wi�cej z 
niewycytownych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.  
Po wykoaniu rozwini�ci� nawias�w, otoczka zamienia wzorce nazw plik�w
na uporz�dkowane nazwy plik�w kt�re pod nadym wzorzec pasuj�
(je�li �adne pliki nie pasuj�, w�wczas dane s�owo zostaje pozostawione
bez zmian).  Elemety wzorc�w posiadaj�nast�puj�ce znaczenia:
.IP \fB?\fP
obejmuje dowolny pojedy�czy znak.
.IP \fB*\fP
obejmuje dowoln� sekwencj� znaczk�w.
.IP \fB[\fP..\fB]\fP
obejmuje ka�dy ze znaczk�w pomi�czy klamrami.  Zakresy znaczk�w mog�
zosta� podane rozczielajac dwa znaczki poprzez \fB\-\fP, \fItzn.\fP,
\fB[a0\-9]\fP objemuje liter� \fBa\fP lub dowoln� cyfr�.
Aby przedstawi� sam znak
\fB\-\fP nale�y go albo wycytowa� albo musi by� to pierwszy lub ostatni znak
w li�cie znak�w.  Podobnie \fB]\fP musi by� wycytowywane albo pierwszym
lub ostatnim znakiem w li�cie je�li ma oznacza� samego siebie a nie zako�czenie
listy.  R�wnie� \fB!\fP wyst�puj�cy na pocz�tmu listy posiada specjalne
znaczenie (patrz poni�ej), tak wi�c aby reprezentowa� samego siebie
musi zosta� wycytowny lub wyst�powa� dalej w li�cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko, �e obejmuje dowolny znak
nie wyst�puj�cy pomi�dzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka�dy ci�g zawierajacy zero lub wi�cej wyst�pie� podanych wzorc�w.
Przyk�adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci�gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka�dy ci�g znak�w obejumj�cy jedno lub wi�cej wyst�pie� danych
wzorc�w.
Przyk�adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci�gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci�g pusty lub ci�g obejmuj�cy jeden z danych wzorc�w.
Przyk�adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci�gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci�g obejmuj�cy jeden z podanych wzorc�w.
Przyk�adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy��cznie ci�gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ciag nie obejmujacy �adnego z danych wzorc�w.
Przyk�adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci�gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje �adnego ci�gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci�gi (prosz� si� nad tym zastanowi�).
.PP
Prosz� zauwa�y�, �e wzorce w pdksh obecnie nigdy nie obejmuj� \fB.\fP i
\fB..\fP, w przeciwie�stwie do roginalnej otoczki
ksh, Bourn-a sh i bash-a, tak wi�c to b�dziemusia�o si� ewentualnie 
zmieni� (na z�e).
.PP
Prosz� zauwa�y�, �e powy�sze elementy wzorc�w nigdy nie obejmuj� propki
(\fB.\fP) na pocz�tku nazwy pliku ani pochy�ka (\fB/\fP), 
nawet gdy zosta�y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s� obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je�li zosta�a nastawiona opcja \fBmarkdirs\fP, w�wczas, 
wszelkie katalogi wynikaj�ce z generacji nazw plik�w
zostaj� oznaczone zako�czeniowym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znak�w (\fItzn.\fP,
\fB[:\fP\fInazwa-klasy\fP\fB:]\fP wewn�trz wyra�enia typu \fB[\fP..\fB]\fP)
jak narazie nie zosta�y zimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierunkowywanie Wej�cia/Wyj�cia"
Podczas wykonywania komendy, jej standardowe wej�cie, standardowe wyj�cie
i standardowe wyj�cie b��d�w (odpowienio deskryptory plik�w 0, 1 i 2),
zostaj� zwykle dziedziczone po otoczce.
Trzema wyj�taki do tej reg�y s�, komendy w rurociagach, dla kt�rych
standardowe lub standardowe wuj�cie odpowieadaj� tym stalonym przez
rurociag,  komendy asychroniczne stwarzane je�li kontrola prac zosta�a
wy�aczona, dla kt�rych standardowe wej�cie zostaje ustawnioe na
\fB/dev/null\fP, oraz komendy dla kt�rych jedno lub wiele z nast�puj�cych
przekierunkowa� zosta�o nastawione:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj�cie zostaje przekierowane do \fIplik\fP-u.  
Je�li \fIplik\fP nie istnieje, w�wczas zostaje stworzony; 
je�li istnieje i jest to regularny plik oraz zosta�a nastawiona
opcja \fBnoclobber\fP, w�wczas wyst�puje b��d, w przeciwnym razie
dany plik zostaje odci�ty do pocz�tku.
Prosz� zwr�ci� uwag� i� oznacza to, �e komenda \fIjaka� < foo > foo\fP 
otworzy plik \fIfoo\fP do odczytu a nazt�pnie
stasuje jego zawarto�� gdy otworzy go do zapisu,
zanim \fIjaka�\fP otrzyma szans� wyczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e zawarto�� pliku zostaje skasowana
niezale�nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e je�li dany plik ju� istnieje
zostaje on rozszerzany zamiast kasowania poprzedniej jego zawaro�ci.  
Ponad to plik ten zostaje otwarty w trybie rozszerzania, tak wi�c
wszelkiego rodzaju operacje zapisu na nim dotycz� jego aktualnego ko�ca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej�cie zostaje przekierunkowane na \fIplik\fP, 
kt�ry zostaje otorzony do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko �e plik zostaje otworzony w trybie
wpisu i czytanie.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj�cego tego rodzaju przekierunkowanie
(zwane tu-dokumentem), otoczka kopiuje wiersze z komendy
do tymczasowego pliku a� po natrafienie na wiersz
odpowiadaj�cy \fIznacznik\fPowi.
podczas wykonywania komendy standardowe wej�cie zostaje przekierunkowane
na dany plik tymczasowy.
Je�li \fIznacznik\fP nie zawiera wycytowanych znak�w, zawarto�� danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera�a si� w 
podwujnych cudzys�owach za, ka�dym razem gdy dana komenda zostaje wykonana.
Tak wi�c zostaj� na nim wykonane podstawienia parametr�w,
komend i arytmetyczne wraz z interpretacj� wstecznego pochylnika 
(\fB\e\fP) i znak�w wyj�� dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enewline\fP.
Je�li wiele tu-dokument�w zostaje zastosowanych w jednym i tymsamym
wierszy komendy, w�wczas zostaj� one zachowane w podanej kolejno�ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko �e pocz�tkowe tabulatory
zostaj� usuni�te w tu-dokumencie.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej�cie zostaje powielone  z deskryptora pliku \fIfd\fP.
\fIfd\fP mo�e by� pojedy�cz� cyfr�, wskazuj�c� na number
istniej�cego deskryptora pliku, literk�  \fBp\fP, wskazujac� na plik
powi�zany w wyj�ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj�cym, �e standardowe wej�cie powinno zosta�
zamkni�te.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko �e operacja dotyczy standardowego wyj�cia.
.PP
W ka�dym z powy�szych przekierunkowa�, mo�e zosta� podany jawnie deskryptor
pliku, kt�rego ma ono dotyczy�, (\fItzn.\fP, standardowego wej�cia
lub standard wyj�cia) poprzez poprzedzaj�c� odpowiedni� pojedy�cz� cyfr�.
podstawienia paramert�r komend, arytmetyczne, szlaczk�w tak jak i
(gdy otoczka jest interakcyjna) generacje nazw plik�w wszystkie 
zostaj� wykonane na argumentach przekierowa� \fIplik\fP, \fInacznik\fP 
i \fIfd\fP.
Prosz� jednak zwr�ci� uwag�, i� wyniki wszelkiego rodzaju przekierunkowa� 
plik�w zostaj� jedynie u�yte je�li zawieraj� jedynie nazw� jednego pliku;
je�li natomiast obejmuj� one wiele plik�w, w�wczas zostaje zastosowane
dane s�owo bez rozwini�c wynikaj�cych z generacji nazw plik�w.
prosz� zwr�ci� uwag�, i� w otoczkach ograniczonych, 
przekierunkowania tworz�ce nowe pliki nie mog� by� stosowane.
.PP
Dla prostych komend, przekierunkowania mog� wyst�powa� w dowolnym miejscu
komendy, w komendach z�o�onych (wyra�eniach \fBif\fP, \fIitp.\fP), 
wszelkie przekierunkowani musz� znajdowa� si� na ko�cu.
Przekierunkowania s� przetwarzane po tworzeniu ruroci�g�w i w kolejno�ci
w kt�rej zosta�y podane, tak wi�c
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy�wietli b��d z numerem lini wiersza poprzedzaj�cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra�enia Arytmetyczne"
Ca�kowite wyra�enia arytmetyczne mog� by� stosowane przy pomocy
komendy \fBlet\fP, wewn�trz wyra�e� \fB$((\fP..\fB))\fP,
wewn�trz dereferencji �a�cuch�w (\fIw szczeg�lno�ci\fP, 
\fInzwa\fP\fB[\fP\fIwyra�enie\fP\fB]\fP),
jako numerbyczne argumenty komendy \fBtest\fP,
i jako warto�ci w przyporz�dkowywaniach do ca�kowitych parametr�w.
.PP
Wyra�enia mog� zawiera� alfa-numeryczne identyfikatory parametr�w,
dereferencje �a�cuch�w i ca�kowite sta�e. Mog� zosta� r�wnie�
po��czone nast�puj�cymi operatorami j�zyka C:
(wymienione i ugrupowane z kolejno�ci odpowiadaj�cej zwi�kszonej
ich precedencji).
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
Operatory trinarne:
\fB?:\fP (precedencja jest bezpo�redino wy�sza od przyporz�dkowania)
.TP
Operatory grupuj�ce:
\fB( )\fP
.PP
Sta�e ca�kowite mog� zosta� podane w dowolnej bazie, stosuj�c notacj�
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesi�tn� liczb�
ca�kowit� specyfikuj�c� baz�, a \fIliczba\fP jest liczb�
zapisan� w danej bazie.
.LP
Operatory zostaj� wyliczane w nastepuj�cy spos�b:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy��cznie dla pe�no�ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je�li argument jest zerowy, a 0 je�li nie.
.IP "\fB~\fP"
arithmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi by� zastosowanym do parametru (a nie litera�u lub
innego wyra�enia) - parametr zostaje powi�kszony o 1.
Je�li zosta� zastosowany jako operator prefiksowy, w�wczas wynikiem jest 
inkrementowana warto�� parametru, a je�li zosta� zastosowany jako
operator postfiksowy, to wynikiem jest pierwotna warto�� parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko, �e wynikiem jest dekrement parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra�enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nast�pnie prawa strona. Wynikiem jest warto��
wyra�enia po prawej stronie.
.IP "\fB=\fP"
przyporz�dkowanie; zmiennej po lewej zostaje nadana warto�� po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatoray przyporz�dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP 
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je�il przynajmniej jeden 
z argument�w jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je�li obydwa argumenty s� niezerowe, 
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewey jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkacja (bit-w-bit).
.IP "\fB==\fP"
r�wno��; wynikiem jest 1, je�li obydwa argumenty s� sobie r�wne, 0 gdy nie.
.IP "\fB!=\fP"
nier�wno�c; wynikiem jest 0, je�li obydwa arguemnty s� sobie r�wne, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je�li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub r�wne, wieksze lub r�wne, wi�ksze od.  Patrz <.
.IP "\fB<< >>\fP"
przesu� w lewo (prawo); wynikiem jst lewy argument z bitami przesuni�tymi
na lewo (prawo) o ilo�� p�l podan� w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, r�nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego arguemntu prze prawy.  
Znak wyniku jest nieustalony, je�li jeden z argument�w jest negatywny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je�li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to ruroci�g stworzony poprzez operator \fB|&\fP,
kt�ry jest asynchronicznym proecsem do kt�rego otoczka mo�e 
zr�wno pisa� (u�ywaj�c \fBprint \-p\fP) i czyta� (u�ywaj�c \fBread \-p\fP).
Wej�cie i wyj�cie koprocesu mog� by� ponadto manipulowane
przy pomocy przekietowa� \fB>&p\fP i odpowiednio \fB<&p\fP.
Po odpaleniu koprocesu, nast�pne nie mog� by� odpalane zanim
dany koproces zako�czy prac�, lub zanim wej�cie kopocesu
nie zosta�o przekierowane poprzez \fBexec \fP\fIn\fP\fB>&p\fP.
Je�li wej�cie koprocesu zostaje przekierowane w ten spos�b,
w�wczas nast�pny w kolejce do odpalenia koproces b�dzie
wsp�ldzieli� wyj�cie z pierwszym koprocesem, chyba �e wyj�cie pierwszego
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
deskryptora (\fIw szczeg�lno�ci\fP, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby kopreocesy m�g�y wsp�dzieli� jedno wyj�cie, otoczka musi
zachowa� otwart� cz�ci wpisow� danego ruroci�gu wyj�ciowego.
Oznacza to, �e zako�czenie pliku nie zostanie wykryte do czasu a�
wszystkie koprocesy wsp�dziel�ce wyj�cie koproces�w zostan� zako�czone
(gdy zostan� one zako�czone, w�wczas  otoczka zamyka swoj� kopi�
ruroci�gu).
Mo�na temu zapobiec przekierunkowuj�ca wyj�cie na numerowany
deskryptor pliku
(poniewa� powoduje to r�wnie� zamkni�cie przez otoczk� swojej kopi).
Prosz� zwr�ci� uwag� i� to zachowani� si� jest nieco odmienne od orginalnej
otoczki Korn-a, kt�ra zamyka swoj� cz��� zapisow� swojej kopi wyj�cia
koprocesu, gdy ostatnio odpalony koproces 
(zamiast gdy wszystkie wsp�dziel�ce koprocesy) zostanie zako�czony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna�u SIGPIPE poczas zapisu, je�li
dany sygna� nie zosta� od�apany lub zignorowany; nie zachodzi to jednak
, gdy wej�cie koprocesu zosta�o powielone na inny deskryptor pliku
i sotsowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje si� albo przy pomocy syntaktyki otoczki
Korn-a \fBfunction\fP \fIname\fP,
albo syntaktyki otoczki Bourn-a/POSIX-owej \fIname\fP\fB()\fP
(patrz poni�ej co do r�nic zachodz�cych pomi�dzy tymi dwoma formami).
Funkcje, tak jak i \fB.\fP-skrypty, zostaj� wykonywane w bierz�cym
otoczeniu, aczkolwiek, w przeciwie�stwie do \fB.\fP-skrypt�w,
argumenty otoczki
(\fItzn.\fP, argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) niegdy nie s�
widoczne wewn�trz nich.
Podczas ustalania lokacji komendy funkcje s� przeszukiwane po przeszukani
specjalnych wbydowanych komend i przed regularnymi oraz nieregularnymi
komendami wbudowanymi, a zanim \fBPATH\fP zostanie przeszukany.
.PP
Istniej�ca funkcja mo�e zosta� usuni�ta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
List� funkcji mo�na otrzyma� poprzez \fBtypeset +f\fP, a definicje
funkcji mo�na otrzyma� poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo�e zosta�
u�yte do tworzenia niezdefiniowanych funkcji;
je�li ma by� wykonana niezdefiniowana funkcja, w�wczas otoczka
przeszukuje trop podany w parametrze \fBFPATH\fP za plikiem o nazwie
identycznej do nazwy danej funkcji, kt�ry, gdy zostanie odnaleziony 
takowy, zostaje wczytany i wykonany.
Je�li po wykonaniu tego pliku dana funkcja b�dzie zdefiniowany, w�wczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk�e
odnajdywanie komend
(\fItzn.\fP, otoczka przeszukuje tablic� zwyk�ych komend wbudowanych
i \fBPATH\fP).
Prosz� zwr�ci� uwag�, �e je�li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, w�wczas zostaje podj�ta pr�ba odnalezienia
funkcji poprzez \fBFPATH\fP (jest to niezdokumentowanym zachowaniem
si� orginalnej otoczki Korn-a).
.PP
Funkcje mog� mie� dwa atrybuty �ledzenia i eksportowania, kt�re
mog� by� ustwaieane przez \fBtypeset \-ft\fP i odpowiednio 
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji �ledzonej, opcja \fBxtrace\fP otoczki
zostaje w��czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy��czona.
Atrybut exportowania nie jest obecnie u�ywany.  W orginalnej
otoczce Korn-a, wyexportowane funkcje s� widoczne dla skryt�w otoczki,
gdy s� one wykonywane.
.PP
Poniewa� funckje zostaj� wykonywane w obecnym konketscie otoczki,
przyporz�dkowania parametr�w wykonane wewn�trz funkcji pozostaj�
widoczne po zako�czeniu danej funkcji.
Je�li jest to nieporz�dane, w�wczas komenda \fBtypeset\fP mo�e
by� zastosowana wewn�trz funkcji do tworzenia lokalnych parametr�w.
Prosz� zwr�cic uwag� i� specjale parametry
(\fItzn.\fP, \fB$$\fP, \fB$!\fP) nie mog� zosta� ograniczone w 
ich widoczno�ci w ten spos�b.
.PP
Statusem zako�czeniownym kuncji jest status ostatniej
wykonanej w niej komendy.
Funkcj� mo�na przerwa� bezpo�redino przy pomocy komendy \fBreturn\fP;
mo�na to r�wnie� zastosowa� do jawnej specyfikacji statusu zako�czenia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s�owa \fBfunction\fP, s�
traktowane odmiennie w nast�puj�cych punktach od funkcji zdefiniowanych
poprzez notacj� \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje nastawiony na nazw� funkcji
(funkcje w stylu Bourne-a nie tykaj� \fB$0\fP).
.IP \ \ \(bu
przyporz�dkowania warto�ci parametrom poprzedzaj�ce wywo�anie
funkcji nie zostaj� zaczowane w bierz�cym kontekscie otoczki
(wykonywanie funkcji w stylu Bourne-a functions zachowuje te
przyporz�dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostake zachowany i skasowany 
na pocz�tku oraz nast�pnie odtworzony na zako�czenie funkcji, tak wi�c
\fBgetopts\fP mo�e by� poprawnie stosowane zar�wno wewn�trz jak i poza
funkcjami
(funkcje w stylu Bourne-a nie tykaj� \fBOPTIND\fP, tak wi�c
stosowanie \fBgetopts\fP wewn�trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.nr PD \n(P2
W przysz�o�ci nast�puj�ce r�nice zostan� r�wnie� dodane:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Oddzielny kontekst �ledznia/sygna��w b�dzie stosowany podczas sykonywania
funkcji.
Tak wi�c �ledzenia nastawione wewn�trz funkcji nie b�d� mia�y wp�ywu 
na �ledzenia i sygna�y otoczki nie ignorowane przez ni� (kt�re mog�
by� przechwytywane) b�d� mia�y domy�lne ich znaczenie wewn�trz funkcji.
.IP \ \ \(bu
�ledzenie EXIT-a, je�li zostanie nastawione wewn�trz funkcji, 
zostanie wykonane, po zako�czeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana otoczka ma by� w zasadzie zgodna ze standardem POSIX, 
aczkolwiej jednak, w niekt�rych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem orginalnej
otocznik Korn-a albo wygod� u�ytkownika.
Jak otoczka zachowuje si� w takich wypadkach jest ustalane poprzez
status opcji posix (\fBset \-o posix\fP) \(em je�li jest ona
w��czona w�wczas zachowuje si� zgodnie z POSIX-em, a w przeciwnym 
razie nie.
Opcja \fBposix\fP zostaje automatycznie nastawiona je�li otoczka startuje
w otoczeniu zawieraj�cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Otoczk� mo�na r�wnie� skompilowa� tak aby zachowanie zgodne z
POSIX-em by�o domy�lnie ustawione, aczkolwiek jest to zwykle 
nieporz�dane).
.PP
A oto lista wp�yw�w ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn�trz wycytowanych podw�jnymi cuczys�owami \fB`\fP..\fB`\fP 
podstwie� komend:
w trybie posix-owym, the \fB\e"\fP zostaje zinterpretowane podczas interpretacji
komendy;
w trybie nie posix-ownym, pochy�ek w lewo zostaje usuniety przed
interpretacj� podstawienia komendy. 
Przyk�adowo \fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie posix-owym, `hi' a w trybie nie-posix-owym.  
W celu unikni�cia problem�w prosz� stosowa� posta� \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
\fBkill \-l\fP wyj�cie: w trybie posix-owym, nazwy sygna�ow
zostaj� wymieniane wiersz po wierszu;
w nie-posix-owym trybie, numery sygna��w ich nazwy i opis zostaj� wymienione
w kolumnach.
W przysz�o�ci nowa opcja zostanie dodana (pewnie \fB\-v\fP) w celu
rozr�nienia tych dw�ch zachowa�.
.IP \ \ \(bu
\fBfg\fP status zako�czenia: w trybie posix-owym, status zako�czenia wynosi
0, je�li nie wyst�pi�y �adne b��dy;
w trybie nie-posix-owym, status zako�czeniowy odpowiada statusowi
ostatniego zadania wykonywanego w pierwszym planie.
.IP \ \ \(bu
\fBgetopts\fP: w trybie posix-owym, optcje musz� zaczyna� si� od \fB\-\fP;
w trybie nie-posix-owym, opcje mog� si� zaczyna� od albo \fB\-\fP albo \fB+\fP.
.IP \ \ \(bu
rozwijanie nawias�w (zwane r�wnie� przemian�): w trybie posix opwym, 
rozwijanie nawias�w jest wy��czoen; w trybie nie-posix-owym, 
rozwijanie nawias�w jest w��czone.
Prosz� zauwa�y�, �e \fBset \-o posix\fP (lub nastawienie 
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy��cza opcj� \fBbraceexpand\fP, mo�e ona by� jednak jawnie
w��czona pu�niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie posix-owym, nie wy��cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-posix-owym, wy��cza.
.IP \ \ \(bu
\fBset\fP status zako�czenia: w trybie posix-owym, 
status zako�czenia wynosi 0, je�li nie wyst�pi�y �adne b��dy; 
w trybie nie-posix-owym, status zako�czeniowy odpowiada statusie
wszelkich podstawieb komend wykonywanych podczas
generacji komendy set.
Przyk�adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie posix,
a 1 w tybie nie-posix.  Ten konstrukt jest stosowany w wi�kszo�ci
skrytp�w otoczji stosujacych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argument�w dla komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP, i
\fBtypeset\fP: w trybie posix-owym, nast�puje normalme rozwijanie argument�w;
w trybie nie-posix-owym, rozdzielanie p�l, rozszerzanie plik�w, 
rozwijanie nawias�w i (zwyk�e) rozwijanie szlaczk�w s� wy��czone, oraz
rozwijanie szlaczk�w w przyporz�dkowania pozostaje w��czone.
.IP \ \ \(bu
specyfikacja sygna��w: w trybie posix-owym, signa�y mog� by�
podawane jedynie cyframi, je�li numery sygna��w s� one zgodne z 
warto�ciami z POSIX-a (\fItzn.\fP, HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14, and TERM=15); w trybie nie-posix-owym, 
sygna�u mog� zawsze cyframi.
.IP \ \ \(bu
rozwijanie alias�w: w trybie posix-owym, rozwijanie alias�w
zostaje jedynie wykonywane, podczas wczytywania s��w komend; w trybie 
nie-posix-owym, rozwijanie alias�w zostaje wykonane r�wnie� na
ka�dym s�owie po jakim� aliasie, kt�re ko�czy si� bia�� przerw�.
Przyk�adowo w nast�puj�ca wst�ga for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u�ywa parameteru \fBi\fP w tybie posix-owym, natomiast \fBj\fP w
trybie nie-posix-owym.
.IP \ \ \(bu
test: w trybie posix-owym, wyra�enia "\fB-t\fP" (poprzedzone pewn�
ilo�ci� argument�w "\fB!\fP") zawsze jest prawdziwe, gdy� jest
ci�giem o d�ugo�ci niezerowej; w nie-posix-owym trybie, sprawdza czy
descryptor pliku 1 jest jakim� tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo�e zosta� pomini�ty i jest
domy�lnie r�wny 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie Komend"
Po wyliczeniu argument�w wiersza komnedy, wykonaniu przekierunkowa�
i przyporz�dkowa� parametr�w, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku kt�ry nale�y wykona� przy pomocy parametru
\fBPATH\fP.
Testy te zostaj� wykonane w wy�ej podanym porz�dku.
Specjalne wbudowane komendy r�ni� si� tym od innych komend, 
�e pramert \fBPATH\fP nie jest u�ywany do ich odnalezienie, b��d
podczas ich wykonywania mo�e spowodowa� zako�czenie nieinterakcyjnej
otocz i przyporz�dkowania wartosci parametr�w poprzedzaj�ce
komend� zostaj� zachowane po jej wykonaniu.
Aby tylko wprowadzi� zamieszanie, je�li opcja
posix zosta�a w��czona (patrz komenda \fBset\fP
poni�ej) pewne specjale komendy staj� si� bardzo specjalne, gdy�
nie wykonywane s� rozdzielanie p�l, rozwijanie nazw plik�w,
rozwijanie nawias�w ani rozwijanie szlaczk�w na argumentach, 
kt�re wygl�daj� jak przyporz�dkowania.
Zwyk�e wbudowane komendy wyr�niaj�si� jedynie tym,�e
parametr \fBPATH\fP nie jest stosowany do ich odnalezienia.
.PP
Orignalny ksh i POSIX r�ni� si� nieco w tym jakie
komendy s� traktowane jako specjalne a jakie jako zwyk�e:
.IP "Specjalne komend w POSIX"
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
.IP "Bardzo specjalne komendy (tyb nie-posix-owy)"
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
W przysz�o�ci dodatkowe specjalne komendy ksh oraz regularne komendy
mog� by� traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz�dkowania warto�ci parametr�w
zostaj� wykonane i wyeksportowane na czas trwania komendy.
.PP
W nast�puj�cym opisujemy specjalne i regularne komendy wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wyknoaj komendy w \fIplik\fP w bierz�dym otoczeniu.
Plik zostaje odszukiwany przy u�yciu katalog�w z \fBPATH\fP.
Je�li zosta�y podane argumenty, w�wczas parametry pozycyjne mog� by�
u�ywane do dost�pu do nich podczas wykonywania \fIplik\fP-u.
Je�li nie zosta�y podane �adne argumenty, w�wczas argumenty pozycyjne
odpowiadaja tym z bierz�cego otoczenia, w kt�rym dana komenda zosta�a
u�yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Statusem zako�czenia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto��1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
bez argument�w, \fBalias\fP wylicza wszystkie obecne aliasy.
Dla ka�dej nazwy bez podanej warto�ci zostaje wliczony istniej�cy
odpowiedni alias.
Ka�da nazwa z podan� warto�ci� definiuje alias (patrz aliasy Aliases powy�ej).
.sp
podczas wyliczania alias�w mo�na u�y� jednego z dwuch format�w: 
zwykle aliasy s� wyliczane jako \fInazwa\fP\fB=\fP\fIwarto��\fP, przy czym
\fIwarto��\fP jest wycytowana; je�li opcje mia�y przedsionek \fB+\fP 
lub same \fB+\fP zosta�o podane we wierszu komendy, tyko \fInazwa\fP
zostaje wy�wietlona.
Ponad to, je�li zosta�a zstosowana opcja \fB\-p\fP, ka�dy wiersz zostaje
zacz�ty dodtakowo od ci�gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP nastawia, (a \fB+x\fP kasuje) atrybut eksportu dla aliasa,
lub, je�li nie podano �adnych nazw, wylicza aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma posiada �adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, �e �ledzone aliasy maj� by� wyliczone ustawione
(warto�ci podane we wierszu komendy zostaj� zignorowane dla �ledzonych
alias�w).
Opcja \fB\-r\fP wskazuje, �e wszystkie �ledzone aliasy
maj� zosta� usuni�te.
.sp
Opcja \fB\-d\fP nakazuje wyliczenie lub ustawienie alias�w katalog�w, 
kt�re s� stosowane w rozwini�cziach szlaczk�w
(patrz Rozwini�cia Szlaczk�w powy�ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je�li nie podana �adnego zadaniam w�wczas przyjmuje si� domy�lnie \fB%+\fP.
Ta komenda jest jeynie dost�pna na systemach wspomagaj�cych kontrol� zada�.
Patrz Kontrola Zada� poni�ej co do dalszych informacji.
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Nastawienie lub wyliczenie obecnych przyporz�dkowa� klwaiszy/mark w 
emacs-owym trybie edycji komend.
Patrz Emacs-owa Interakcyjna Edycja Wiersza Komendy w celu pe�nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fPth zagnie�d�enia we wst�gach
for, select, until, lub while.
\fIpoziom\fP wynosi domy�lnie 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan� komend� \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.  
Je�li zosta� nastawiony parameter \fBCDPATH\fP, to wypisuje
list� katalog�w, w kt�rych nale�y szuka� pod-\fIkatalog\fP.
Pusta zawarto�� w \fBCDPATH\fP oznacza katalog bie��cy.
Je�li niepusty katalog z \fBCDPATH\fP zostanie zastosowany,
w�wczas zostanie wy�wietlony pe�ny wynikaj�cy trop na standardowym
wyj�ciu.
Je�li nie podano \fIkatalog\fP, w�wczas
zostaje u�yty katalog domowy \fB$HOME\fP.  Je�li \fIkatalog\fP-iem jest
\fB\-\fP, to porzedni katalog roboczy zostaje zastosowany (patrz
parametr OLDPWD).
Je�li u�yto opcji \fB\-L\fP (logiczny trop) lub je�li opcja \fBphysical\fP
nie zosta�a nastawiona
(patrz komenda \fBset\fP poni�ej), w�wczas odniesienia do \fB..\fP w 
\fIkatalogu\fP s� wzgl�dnymi wobec tropu zastosowanego do doj�ci� do danego
katalogu.
Je�li podano opcj� \fB\-P\fP (fizyczny trop) lub gdy zosta�a nastawiona
opcja \fBphysical\fP, w�wczas \fB..\fP jest wzgl�dne wobec drzewa katalog�w 
systemu plik�w.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj� uaktualnione taki, aby odpowiednio
zawiera�y bie��cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci�g \fInowy\fP zostaje podstawiony wzamian za \fIstary\fP w bie��cym
katalogu, i otoczka pr�buje przej�� do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je�li nie zosta�a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, w�wczas
\fIkomenda\fP
zostaje wykonana dok�adnie tak jakby nie podano \fBcommand\fP,
z dwoma wyj�takami: po pierwsze, \fIkomenda\fP nie mo�e by� funkcj� w otoczce,
oraz po drugie, specjalne wbudowane komendy trac� swoj� specjalno�� (\fItzn.\fP,
przekierowania i b��dy w u�yciu nie powoduj�, �e otoczka zostaje zako�czona, a
przyporz�dkowania parametr�w nie zostaj� wykonane).
Je�li podano opcj� \fB\-p\fP, zostaje stosowany pewien domy�lny trop
zamiast obecnej warto�ci \fBPATH\fP (warto�� domy�lna tropu jest zale�na
od systemy w jakim pracujemy: w systemach POSIX-owatych, jest to
warto�� zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je�li podano opcj� \fB\-v\fP, w�wczas zamiast wykonania \fIkomenda\fP, 
zostaje podana informacja co by zosta�o wykonane (i to same dotyczny 
r�wnia� \fIarg1\fP ...):
dla specjalnych i zwyklych wbudowanych komend i funkcji,
zostaj� po prostu wy�wietlone ich nazwy,
dla alias�w, zostaje wy�wietlona komenda definiuj�ca dany alias,
oraz dla komend odnajdownych poprzez przeszukiwanie zawarto�ci
parametru \fBPATH\fP, zostaje wy�wietlony pe�ny trop danej komendy.
Je�li komenda nie zostanie odnaleziona, (\fItzn.\fP, przeszukiwanie tropu
nie powiedzie si�), nic nie zostaje wy�wietlone i \fBcommand\fP zostaje
zako�czone z niezerowym statusem.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko �e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP stacze na pocz�tek \fIpoziom\fP-u z najg��biej
zagnie�d�onej wst�gi for,
select, until, lub while.
\fIlevel\fP domy�lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy�wietla na standardowym wyj�ciu swoje argumenty (rozdzielone przerwami)
zako�czone prze�amaniem wiersza.
Prze�amanie wiersza nie nast�puje je�li kt�rykolwiek z parametr�w
zawiera sekwencj� pochy�ka wstecznego \fB\ec\fP.
Patrz komenda \fBprint\fP poni�ej, co do listy innych rozpoznawanych
sekwencji pochy�k�w wstecznych.
.sp
Nast�puj�ce opcje zosta�y dodane dla zachowania zgodno�ci ze
skryptami z system�w BSD:
\fB\-n\fP wy��cza ko�cowe prze�amanie wiersza, \fB\-e\fP w��cza
interpretacj� pochy�k�w wstecznych (operacja zerowa, albowiem ma to
domy�lnie miejsce), oraz \fB\-E\fP wy��czaj�ce interpretacj�
pochy�k�w wstecznych.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Zrgumenty zostaj� powi�zane (z przerwami pomi�dzy nimi) do jednego
ci�gu, kt�ry nast�pnie otoczka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez forkowania, zast�puj�c proces otoczki.
.sp
Je�li nie podano �adnych argument�w wszelkie przekierowania wej�cia/wyj�cia
s� dozwolone i otocznia nie zostaje zast�piona.
Wszelkie deskryptory plik�w wi�ksze ni� 2 otwarte lub z\fIdup\fP(2)-owane
w ten sops�b nie s� dost�pne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbydownych w otoczk�).
Prosz� zwr�ci� uwag� i� otoczka Bourne-a r�ni si� w tym: 
przekazuje bowiem deskryptory plik�w.
.\"}}}
.\"{{{  exit [status]
.IP "\fBexit\fP [\fIstatus\fP]"
Otoczka zostaje zako�czona z podanym statusem.
Je�li \fIstatus\fP nie zosta� podany, w�wczas status zako�czenia
przyjmuje bie��c� warto�� parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Nastawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj� przekazywane w otoczeniu do wykonywanych
komend.
Je�il podano warto�ci w�wczas zostaj� one r�wnia� przyporz�dkowany
danym parametrom.
.sp
Je�li nie podano �adnych parametr�, w�wczas nazwy wszystkich parametr�w
z atrybutem eksportu zostaj� wy�wietlone wiersz po wierszu, chyba �e u�yto
opcji \fB\-p\fP, w kt�rym to wypadu zostaj� wy�wietlone komendy
\fBexport\fP definiuj�ce wszystkie eksportowane parametry wraz z ich
warto�ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda ko�cz�ca si� z niezerowym statusem.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj� komendy z histori.
Komendy mo�emy wybiera� przy pomocy ich numeru w historji
lub podaj�c ci�g znak�w okre�laj�cy ostatnio u�yt� komend� rozpoczynaj�c�
si� od tego� ci�gu.
Opcja \fB\-l\fP wy�wietla dan� komend� na stdout,
a \fB\-n\fP wy��cza domy�lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno�� koemnd w li�cie historji.  Bez \fB\-l\fP, wybrane
komendy podlegaj� edycji przez edytor podany poprzez opcj�
\fB\-e\fP, albo je�lki nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je�li nie zosta� nastawiony ten
parametr, w�wczas sotsuje si� \fB/bin/ed\fP),
i nast�pnie wykonana przez otoczk�.
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran� konend� (domy�lnie poprzedni� komend�) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je�li
podano \fB\-g\fP, w�wczas wszelkie wysotmpienia \fIstare\fP zostaj�
zast�pione przez \fInowe\fP.  Z tej komendy ko�ysta si� zwykle
przy pomocy zdefiniowanego domy�lnie aliasa \fBr='fc \-e \-'\fP.
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
\fBgetopts\fP jest stosowany przez procedury otoczki
do rozeznawania podanych argument�w
(lub parametr�w pozycyjnychi, je�li nie podano �adnych argument�w)
i do sprawdzenia zasadno�ci opcji.
\fIci�gopt\fP zawiera litery opcji, kt�re 
\fBgetopts\fP ma rozpoznawa�.  Je�li po literze wyst�puje przecinek,
w�wczas oczekuje si�, �e opcja posiada argument.
Opcje nieposiadaj�ce argument�w mog� by� grupowane w jeden argument.
Je�li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w kt�rym si� znajduje, w�wczas reszta argumentu 
zsotaje potraktowana jako argument danej opcji. W przeciwnym razie
nast�pny argument jest argumentem opcji.
.sp
Za ka�dym razem, gdy zostaje wywo�ane \fBgetopts\fP, 
umieszcza si� nast�pn� opcj� w parametrze otoczki
\fInazwa\fP i indeks nast�pnego argumentu pod obr�bk�
w parmaetrze otoczki \fBOPTIND\fP.
Je�li opcja zosta�a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z prefiksem \fB+\fP.
Je�li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze otoczki \fBOPTARG\fP.
Je�li natrafi si� na niedopuszczaln� opcj� lub brakuje
argumentu opcji, w�wczas znak zapytania albo dwukropek zostaje
umieszczony w \fInazwa\fP
(wskazuj�c na nielegaln� opcj�, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje nastawiony na znak kt�ry by� przyczyn� tego problemu.
Ponadto zostaje w�wczas wy�wietlony komunikat o b��dzie na standardowym
wyj�ciu b��d�w, je�li \fIci�gopt\fP nie zaczyna si� od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa prac�
niezerowym statusem zako�czenia.
Opcje ko�cz� si� na pierwszym (nie podlegaj�cym opcji) argumencie,
kt�ry nie rozpoczyna si� od \-, albo je�li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawania opcji mo�e zosta� ponowione ustawiaj�c \fBOPTIND\fP na 1
(co nast�puje automatycznie za ka�dym razem, gdy otoczka lub 
funkcja w otoczce zostaje wywo�ana).
.sp
Ostrze�enie: Zmiana warto�ci parametru otoczki \fBOPTIND\fP na
warto�� wi�ksz� ni� 1, lub rozpoznawanie odmiennych zestaw�w
parametr�w bez ponowienia \fBOPTIND\fP mo�e doprowadzi� do nieoczekiwanych
wynik�w.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je�li brak argument�w, w�wczas wszelkie tropy wykonywalnych komend z
kluczem zostaj� wymienione.
Opcja \fB\-r\fP nakazuje wy�ucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka�da \fInazwa\fP zostaje odszukiwana tak jak by to by�a nazwa komedy
i dodna do tablicy kluczy je�li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy�wietlij informacje o danych zadaniach; gdy nie podano �adnych
zada� wszystkie zadania zostaj� wy�wietlone.
Je�li podano opcj� \fB\-n\fP, w�wczas informacje zostaj� wy�wietlone
jedynie o zadaniach kt�rych stan zmieni� si� od czasu ostaniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka�dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, �e zostaje wy�wietlona jedynie
jedynie grupa procesowa kadego zadania.
patrz Kontrola Zada� dla informacji o formie parametru
\fIzdanie\fP i formacie w kt�rym zostaj� wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy�lij dany sygna� do doanych zada�, proces�w z danym id-em, lub grup
proces�w.
Je�li nie podano jawnie �adnego sygna�u, w�wczas domy�lnie zostaje wys�any
sygna� TERM.
Je�li podano zadanie, w�wczas sygna� zostaje wys�any do grupy 
proces�w danego zadnia.
Patrz poni�ej Kontrola Zadab dla informacji o formacie \fIzadania\fP.
.\"}}}
.\"{{{  kill -l [exit-status ...]
.IP "\fBkill \-l\fP [\fIstatus-zako�czenia\fP ...]"
Wypisz nazw� sygna�u, kt�ry zabi� procesy, kt�re zako�czy�y si�
danym \fIstatusem-zako�czenia\fP.
Je�li brak argument�w, w�wczas zostaje wy�wietlona lista
wszelkich sygna��w i ich numer�w, wraz z kr�tkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra�enie\fP ...]"
Ka�de wyra�enie zostaje wyliczone, patrz Wyra�enie Arytmetyczne powy�ej.
Je�li wszelkie wyra�enia zosta�y poprawnie wyliczone,statusem zako�czenia
jest 0 (1), je�li warto�ci� ostatniego wyra�enia
 nie by�o zero (zero).
Je�li wyst�pi b��d podczas rozpoznawania lub wyliczania wyra�enia,
status zako�czenia jest wi�kszy od 1.
Poniewa� m�e zaj�� konieczno�� wycytowania wyra�e�, wi�c
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s�odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy�wietla swe argumenty na standardowym wyj�ciu, rozdzielone
przerwami i zako�czone prze�amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy�lnemu prze�amaniu wiersza. 
Domy�lnie pewne wyprowadzenia z C zostaj� odpowiednio przet�umaczone.
Wsr�d nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0### 
(# oznacza cyfr� w systemie �semkowym, tzn. od 0 po 3).
\ec jest r�wnowa�ne z zastosowaniem opcji \fB\-n\fP.  \e wyra�eniom
mo�na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pilku historji zamiast
standardowego wyj�cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wyno�i domy�lnie 1 przy pomini�ciu), 
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy�ej).
.sp
Opcja \fB\-R\fP jest stowoana do emulacji, w pewnym stopniu, komendy 
echo w wydaniu BSD, kt�ra nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy�ej opcja \fB\-n\fP zapobiega zakonieczeniowemu prze�amaniu
wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bierz�cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta�a nastawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni�ej), zostaje wy�wietlony trop
logiczny (\fItzn.\fP, trop knieczny aby wykona� \fBcd\fP 
do bierz�cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (fizyczny trop) lub gdy
opcja \fBphysical\fP zosta�a nastawiona, zostaje wy�wietlony trop
ustalone przez wystem plik�w (�ledz�c katalogi \fB..\fP
a� po katalog pniowy).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej�cia, rozdziela ten
wiersz na pola przy uwzgl�dnieniu parametru \fBIFS\fP (
patrz Podstawienia powy�ej), i przyporz�dkowywuje pola odpowienio danym 
parametrom.
Je�li mamy wi�cej parametr�w ni� pul, w�wczas dodatkowe parametry zostaj�
ustawione na zero, a natomiast je�li jest wi�cej p�l ni� paramtr�w to
ostatni parametr otrzymuje jako warto�� wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj�cymi przerwami).
Je�li nie podano �adnych parametr�w, w�wczas zostaje zastosowany
parametr \fBREPLY\fP.
Je�li wiersz wprowadzenie ko�czy si� na pochy�ku wstecznym
i nie podano opcji \fB\-r\fP, to pochy�ek wsteczny i prze�amanie
wiersza zostaj� usuni�te i wi�cej wprowadznia zostaje wczytane.
Gdy nie zostanie wczytane �adne wprowadznie, \fBread\fP zaka�cza si�
niezerowym statusem.
.sp
Pierwszy parametro mo�e mie� do��czony znak zapytania i ci�g, co oznacza, �e
dany ci�g zostania zastosowany jako zach�ta do wprowadzenia 
(wy�wietlana na standardowym wyj�ciu b�ed�w zanim
zostanie wczytane jakiekolwiek wprowadzenie) je�li wej�cie jest tty-em
(\fIe.g.\fP, \fBread nco�?'ile co�k�w: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj� �e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bierz�cego ko-procesu 
(patrz komenta�e na ten temat w Ko-procesy powy�ej).
Je�li zastosowano opcj� \fB\-s\fP, w�wczas wprowadznie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Patrz parametr wy��cznego odczytu nazwanych parametr�w.
Je�li zosta�y podane warto�ci w�wczas zostaj� one nadane parametrom przed
ustawieniem danego strybutu.
Po nadaniu cechy wy��cznego odczytu parametrowi, nie ma wi�cej mo�liwo�ci
wykasowania go lub zmiany jego warto�ci.
.sp
Je�li nie podano �adnych parametr�w, w�wczas zostaj� wypisane nazwy
wszystkich parametr�w w cech� wy��cznego odczytu wiersz po wierszu, chyba
�e zastosowano opcj� \fB\-p\fP, co powoduje wypisanie pe�nych komend
\fBreadonly\fP definiuj�cych parametry wy��czneg odczytu wraz z ich
warto�ciami.
.\"}}}
.\"{{{  return [status]
.IP "\fBreturn\fP [\fIstatus\fP]"
Powr�t z funkcji lub \fB.\fP scryptu, ze statusem zako�czenia \fIstatus\fP.
Je�li nie podano warto�ci \fIstatus\fP, w�wczas zostaje domy�lnie
zastosowany status ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcji lub \fB.\fP scryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Prosz� zwr�ci� uwag� i� pdksh traktuje zar�wno profile jak i pliki z 
\fB$ENV\fP jako \fB.\fP scrypty, podczas gdy
orginalny Korn shell jedynie profile traktuje jako \fB.\fP scrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s�u�y do nastawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opkcji otoczki, nastawiania prarmetr�w pozycyjnych, lub
nastawiania parametru ci�gowego.
Opcje mog� by� zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe�n� nazw� pewnej opcji, lub stosuj�c posta�
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow�
nazw� danej opcji (niewszystkie opcje posiadaj� jednoliterow� naz�).
Nast�puj�ca tablica wylicza zar�wno litery opcji (gdy mamy takowe), jak i
pe�ne ich nazwy wraz z opisem wp�yw�w danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci�gowego \fInazwa\fP na \fIarg\fP ...;
Je�li zastosowano \fB\-A\fP, ci�g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je�li zastosowano \fB+A\fP, zastaj� nastawione pierwsze N element�w (gdzie N
jest ilo�ci� \fIarg\fPs�w), reszta pozostaje niezmienioa.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj� tworzone z cecha eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu� przed zach�t�.
Ma tylko znaczenia je�li zosta�a w��czona kontrola zada� (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej�cych ju� plik�w poprzez przekierunkowania
\fB>\fP (\fB>|\fP musi zosta� zastosowane do wymuszenia przepisania).
T}
\-e	errexit	T{
Wyjd� (po wykoaniu komendy pu�apki \fBERR\fP) tu� po wyst�pieniu
b��du lub niepomy�lnym wykoaniu jakiej� komendy
(\fItzn.\fP, je�li zosta�a ona zako�czona niezerowym statusem).
Niedotyczy to komend kt�rych status zako�czenia zostaje jawnie przetestowny
konstruktem otoczki takim jak wyra�enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorc�w nazw plik�w.
T}
\-h	trackall	T{
Tw� �ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy�ej).
Domy�lnie w��czone dla nieinterakcyjnych otoczek.
T}
\-i	interactive	T{
W��cz tryb interakcyjny \- mo�e zosta� 
w��czone/wy��czone jedynie podczas odpalania otoczki.
T}
\-k	keyword	T{
Przyporz�dkowania warto�ci parametrom zostaj� rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Otoczka ma by� otoczk� zameldowania \- mo�e zosta� 
w��czone/wy��czone jedynie podczas odpalania otoczki
(patrz Odpalania Otoczki powy�ej).
T}
\-m	monitor	T{
W��cz kontrlo� zadab� (domy�lne dla otoczek interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skrypt�w (ignorowane dla interakcyjnych otoczek).
T}
\-p	privileged	T{
Nastawiane automatycznie, je�li gdy otoczka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Otoczki powy�ej dla opisu co to znaczy.
T}
-r	restricted	T{
Nastaw tryb ograniczony \(em ta opcja mo�e zosta� jedynie
zastosowan podczas odpalania otoczki.  Patrz Odpalania Otoczki
dla opisy co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania otoczki, w�wczas komendy
zostaj� wczytywane ze standardowego wej�cia.
Nastawione automatycznie, je�li otoczka zosta�a odpalona bez jakichkolwiek
argument�w.
.sp
Je�li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, w�wczas
podane argumenty zostaj� uporz�dkowane zanim zostan� one przyczielone
parametrom pozycyjnym
(lub ci�gowi \fInazwa\fP, je�li \fB\-A\fP zosta�o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nienastawionego parametru zostaje traktowane jako b��d,
chyba �e jeden z modyfikator�w \fB\-\fP, \fB+\fP lub \fB=\fP 
zosta� zastosowany.
T}
\-v	verbose	T{
Wypisuj wprowadzenia otoczki na standardowym wyj�ciu b��d�w podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz�dkowania parametr�w podczas ich wykonywania
poprzedzone warto�ci� \fBPS4\fP.
T}
\-X	markdirs	T{
Naznaczaj katalogi nast�puj�cym \fB/\fP podczas generacji nazw
plik�w.
T}
	bgnice	T{
Zadania w tle zostaj� wykonywane z ni�szym priorytetem.
T}
	braceexpand	T{
W��cz rozwijanie nawias�w (aka, alternacja).
T}
	emacs	T{
W��cz edycj� wiersza komendy  w stylu BRL emacs-a (dotyczy wy��cznie
otoczek interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W��cz edycj� wiersza koemndy w stylo gmacs-like (Gosling emacs) 
(dotyczy wy��cznie otoczek interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj�tkiem tego, �e przemiana (^T) 
zachowuje si� nieco inaczej.
T}
	ignoreeof	T{
Otoczka nie zostanie zako�czona je�li zostanie wczytany znak zako�czenia
pliku. Nale�y u�y� jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie��cych zada� sygna�em \fBHUP\fP gdy otoczka zameldowania
zostaje zako�czona.
Obecnie nastawione domy�lnie, co si� jednak zmieni w przysz�o�ci w celu
poprawienia kompatybilijnos� z orginalnym Korn shell (kt�ry nie posiada
tej opcji, aczkolwiek wysy�a sygna� \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w originalej otoczce Korn. Zapobiega sortowaniu definicji
funkcji w pliku histori.
T}
	physical	T{
Powoduje, �e komendy \fBcd\fP oraz \fBpwd\fP stosuj� `fizyczne'
(\fItzn.\fP, pochodz�ce od systemu plik�w) \fB..\fP katalogi zamiast `logicznych'
katalog�w (\fItzn.\fP,  �e otoczka interpretuje \fB..\fP, co pozwala
u�ytkownikowi nietroszczy� si� o pod��czenia symboliczne do katalog�w).
Domy�lnie wykasowane.  Prosz� zwr�ci� uwag� i� nastawianie tej opcji
nie wp�ywa na bie��c� warto�� parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy�ej dla dalszych szczegu��w.
T}
	posix	T{
W��cz try posix-owy.  Patrz Tryb POSIX-owy powy�ej.
T}
	vi	T{
W��cz edycj� wiersza komendy  w stylu vi (dotyczy tylko otoczek 
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w orginalnej otoczce Korn-a, dopuki nie zosta�o 
nastawione viraw, tryb wiersza komendy vi
pozostawia� prac� nap�dowi tty a� do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plik�w
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Prefiksuj znaki z nastawionym �smym bitem poprzez `M-'.
Je�li nie zostanie nastawiona ta opcja, w�wczas, znaki z zakresu
128-160 zostaj� wypisane bez zmian co mo�e by� przyczyn� problem�w.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonyj rozwiania koemnd/ plik�w
je�li tab (^I) zostanie wrowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo�na urzy� r�wnie� podczas odpalania otoczki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje si� w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy�wietla
wszystki opcja i informacj� o ich nastawieniu lub nie;
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
kasuje zar�no opcj� \fB\-x\fP, jak i \fB\-v\fP.
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
\fBtest\fP wylicza \fIwyra�enia\fP i zwraca status zero je�li
prawda, i status 1 jeden je�li fa�sz, awi�cej ni� 1 je�li wyst�pi� b��d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra�e� \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nast�puj�ce podstawowe wyra�enia:
.sp
.TS
afB ltw(2.8i).
\fIci�g\fP	T{
\fIci�g\fP ma niezerow� d�ugo��.  Prosz� zwr�ci� uwag� i� mog� wyst�pi�
tr�dno�ci je�li \fIci�g\fP oka�e si� by� operatorem 
(\fIdok�adniej\fP, \fB-r\fP) - og�lnie lepiej jest stosowa�
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
wzamian (podw�jne wycytowania zostaj� zastosowaneje�li
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
\fIplik\fP jest nazwanym ruroci�giem
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
w�a�ciciel \fIpliku\fP zgadza si� z efektywnym user-ID otoczki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza si� z efektywn� group-ID otoczki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod��czeniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale�nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod��czeniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP otoczki jest nastawiona (patrz komenda \fBset\fP powy�ej
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
pierwszy \fIplik\fP jest torzsamy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przy��dem tty.
Je�li nie zosta�a nastawiona opcja posix-a (\fBset \-o posix\fP, 
patrz Tryb POSIX powy�ej), w�wczas \fIfd\fP mo�e zosta� pomini�ty, 
co oznacza przyj�cie domu�lnej warto�ci 1
(zachowanie si� jest w�wczas odmienne z powodu specjalnych reg�
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
W.sz., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dost�pny zapis na
deskryptor pliku 2.
.sp
Prosz� zwr�ci� uwag� �e zachodz� specjalne reg�y
(zawdzi�czane POSIX-owi), je�li liczba argument�w
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od pi�ciu: 
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te tak �e pozostaje tylko
jeden argument, w�wczas zostaje przeprowadzony test d�ugosci ci�gu
(ponownie, nawet je�li dany argument jest unarnym operatorem);
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te tak, �e pozostaj� trzy
argumenty i drugi argument jest operatorem binarnym, w�wczas zostaje
wykonana dana binarna operacja (nawet je�li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuni�tym \fB!\fP).
.sp
\fBUwaga:\fP Cz�stym b��dem jest stosowanie \fBif [ $co� = tam ]\fP co
daje wynik negatywny je�li parametr \fBco�\fP jest zerowy lub
nienastawiony, zwiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest unarnym operatorem, takim jak
\fB!\fP lub \fB\-n\fP.  Prosz� stosowa� testy typu 
\fBif [ "X$co�" = Xtam ]\fP wzamian.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy�wietla zgromadzony czas w przestrzeniu u�ytkownika oraz systemu,
kt�ry spotrzebowa�a otoczka i w niej wystartowane 
procesy kt�re w si� zako�czy�y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna� ...\fP]"
Nastawia obrabiacz, kt�ry nale�y wykona� w razie odebrania danego sygna�u.
\fBObrabiacz\fP mo�e by� albo zerowym ci�giem, wskazujacym na zamiar
ignorowania sygna��w danego typu, minusem (\fB\-\fP), 
wskazuj�cym, �e ma zosta� podj�ta akcja domy�lna dla danego sygna�u
(patrz signal(2 or 3)), lub ci�giem zawierajacym komendy otoczki
kt�re maj� zosta� wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zako�czeniu bierz�cej komendy, lub przed
wypisaniem nast�pnego zach�cacza \fBPS1\fP) po odebraniu
jednego z danych sygna��w.
\fBSigna�\fP jest nazw� danego wygna�u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy�ej).
Istnieja dwa specjalne sygna�y: \fBEXIT\fP (r�wnie� znany jako \fB0\fP),
kt�ry zostaje wykonany tu� przed zako�czeniem otoczki, i
\fBERR\fP kt�ry zostaje wykonany po wyst�pieniu b�edu
(b��dem jest co� co powodowa�oby zakonczenie otoczki
je�li zosta�y nastawioe opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP opwy�ej).
Obrabiacze \fBEXIT\fP zostaj� wykonane w otoczeniu
ostatniej wykonywanej komendy.
Prosz� zwr�ci� uwage, �e dla otoczek nieinterakcyjnych obrabiacz wykrocze�
nie mo�e zosta� zmieniony dla sygna��w kt�re by�y ignorowane podczas
startu danej otoczki.
.sp
Bez argument�w, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykrocze�, kt�re zosta�y nastawione od czasu staru otoczki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna��w \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i orginalnej otoczki Korn'a w funkcjach nie zosta�o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda zako�czaj�ca si� zerow� warto�ci� statusu.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto��\fP] ...]"
Wy�wietlaj lub nastawiaj warto�ci atrybut�w parametr�w.
Bez argument�w \fInazwa\fP, zostaj� wy�wietlone atrybuty parametr�w: 
je�li brak argument�w opcyjnych, zostaja wy�wietlone atrybuty
wszystkich paramet�r jako komendy typeset; je�li podano opcj�
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto�ci posiadaj�ce dany atrybut zostaj� 
wy�wietlone;
je�li opcje zaczynaj� si� od \fB+\fP, to nie zostaj� wy�wietlone warto�ci
oparametr�w.
.sp
Je�li podano argumenty If \fInazwa\fP, zostaj� nastawione atrybuty
danych parametr�w (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto�ci parametr�w mog� zosta� ewentualnie podane.
Je�li typeset zostanie zastosowane wewn�trz funkcji, 
wszystkie nowotworzone parametry pozostaj� lokalne dla danej funkcji.
.sp
Je�li zastosowano \fB\-f\fP, w�wczas typeset operuje na atrybutach funkcji.
Tak jak dla parametr�w, je�li brak \fInazw\fPs, zostaj� wymienione funkcje
wraz z ich warto�ciami (\fItzn.\fP, definicjami) chyba, �e opdano
opcje zaczynaj�ce si� od \fB+\fP, w kt�rym wypadku
zostaj� wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyr�wnania do lewego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bierz�ca szeroko�� parametru 
(lub szeroko�� pierwszej przyporz�dkowywanej warto�ci).
Prowadz�ce bia�e przerwy (tak jak i zera, je�li
nastawiono opcj� \fB\-Z\fP) zostaj� wykasowane.
Je�li trzeba, warto�ci zostaj� albo obci�te lub dodane przerwy
do osi�gni�cia wymaganej szeroko�ci.
T}
\-R\fIn\fP	T{
Atrybut przyr�wnania do prawego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bierz�ca szeroko�� parametru
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
Tej opcji brak w orginalnej otoczce Korn'a.
T}
\-f	T{
Tryb funkcji: wy�wietlaj lub nastawiaj funkcje i ich atrybuty, zamiast
parametr�w.
T}
\-l	T{
Atrybut ma�ej litery: wszystkie znaki z du�ej litery zostaj� 
w wartosci zamienione na ma�e litery.
(W orignalnej otoczce Korn'a, parametr ten oznacza� `d�ugi ca�kowity' 
gdy by� stosowany w po��czeniu z opcj� \fB\-i\fP).
T}
\-p	T{
Wypisuj pe�ne komendy typeset, kt�re mo�na nast�pnie zastosowa� do
odtworzenia danych atrybut�w (lecz nie warto�ci) parametr�w.
To jest wynikiem domy�lnym (opcja ta istnieje w celu zachowania
kompatybilijno�ci z ksh93).
T}
\-r	T{
Atrybut wy�acznego odczytu: parametry z danym atrybutem
nie przyjmuj� nowych warto�ci i nie mog� zosta� wykasowane.
Po nastawieniu tego atrybutu nie mo�na go ju� wi�cej odaktywni�.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla otoczki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut �ledzenia.
Je�li zostaj� wykonywane funkcje z atrybutem �ledzenia, to
opcja otoczki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w�aczona.
T}
\-u	T{
Atrybut du�ej litery: wszystkie znaki z ma�ej litery w warto�ciach zostaj�
przestawione na du�e litery.
(W orginalnej otoczce Korn'a, ten parametr oznacza� `ca�kowity bez znaku' je�li
zosta� zastosowany w po��czeniu z opcj� \fB\-i\fP, oznacza�o to, �e
nie mo�na by�o sotsowa� du�ych liter dla baz wi�kszych ni� 10.  
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
Wy�wietlij lub nastaw ograniczenia dla proces�w.
Je�li brak opcji, to ograniczenie ilo�ci plik�w (\fB\-f\fP) zostaje
przyj�te jako domy�le.
\fBwarto��\fP, je�li podana, mo�e by� albo wyra�eniem arytmetycznym
lub s�owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz� otoczki i wszelkich proces�w przez ni� tworzonych
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
Nastaw jedynie ograniczenie twarde (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-S\fP
Nastaw jedynie ograniczenie mi�kkie (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-c\fP
Ogranicz wielko�ci plik�w zrzut�w core do \fIn\fP blk�w.
.IP \fB\-d\fP
Ogranicz wielko�� area�u danych do \fIn\fP kbyt�w.
.IP \fB\-f\fP
Ogranicz wielkos� plik�w zapisywanych przez otoczk� i jej programy pochodne
do \fIn\fP plik�w (pliki dowolnej wielko�ci mog� by� wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kbyt�w ilo�� podkluczonej (podpi�tej) fizycznej pami�ci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kbyt�w ilo�� uzywanej fizycznej pami�ci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie otwartych deskryptor�w plik�w.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie wykonywanych proces�w danego
u�ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kbyt�w rozmiar area�u stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu�ywany przez pojedy�cze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kbyt�w ilo�� u�ywanej wirtualnej pami�ci;
pod niekt�rymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kbajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kbyt�w ilo�� stosowanego obszaru odk�adania.
.PP
Dla \fBulimit\fP blok to zawsze512 bajt�w.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy�wietl lub nastaw mask� zezwole� w tworzeniu plik�w, lub umask 
(patrz \fIumask\fP(2)).
Je�li zastosowano opcj� \fB\-S\fP, maska jest wy�wietlana lub podawana
symbolicznie, natomias jako liczba oktalna w przeciwnym razie.
.sp
Symboliczne maski s� podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znak�w jest cz�ci� \fIkto\fP, a druga grupa cz�sci�
\fIop\fP, i ostatnio grupa cz�ci� \fIperm\fP.
Cz�� \fIkto\fP okre�la kt�ra cz�� umaski ma zosta� zmodyfikowana.
Litery oznaczaj�:
.RS
.IP \fBu\fP
prawa u�ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta�ych (nie-u�ytkownika, nie-groupy)
.IP \fBa\fP
wszelkie prawa naraz (u�ytkownika, grupy i pozosta�ych)
.RE
.sp
Cz�� \fIop\fP wskazuj� jak prawa \fIkto\fP maj� by� zmienioe:
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
Gdy stosuje si� symboliczne maski, do opisuj� one kt�re prawa mog� zosta�
udost�pnioe (w przeciwie�stwie do masek oktalnych, w kt�rych nastawienie
bita oznacze, �e ma on zosta� wykasowany).
przyk�ad: `ug=rwx,o=' nastawia mask� tak, �e pliki nie b�d� odczytywalne,
zapisywalne i wykonywalne przez `innych', i jest ekwiwalnetne
(w wi�kszo�ci system�w) do oktalnej maski `07'.
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
Statusem zako�czenia jest nie-zerowy je�li kt�ry� z danych parametr�w by�
ju� wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zako�czenie danego zadania/zada�.
Statusem zako�czenia wait jest status ostaniego podanego zadania:
je�li dane zadanie zosta�o zabite sygna�em, status zako�czenia wynosi
128 + number danego sygna�u (patrz \fBkill \-l\fP \fIstatus-zako�czenia\fP
powy�ej); je�li ostatnie dane zadanie nie mo�e zosta� odnalezione
(bo nigdy nie istnia�o, lub ju� zosta�o zako�czone), to status
zako�czenia wait wynosi 127.
Patrz Kontrola Zada� poni�ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zako�czone je�li zajdzie sygna� na kt�ry zosta�
nastawiony obrabiacz, lub gdy zostanie odebrany sygna� HUP, INT lub
QUIT.
.sp
Je�li nie podano zada�, \fBwait\fP wait czeka na zako�czenie
wszelkich obecnych zada� (je�li istnieja takowe) i ko�czy si�
statusem zerowym.
Je�li kontrola zada� zosta�a w��czona, to zostaje wy�wietlony
status zako�czeniowy zada�
(to nie ma miejsca, je�li zadania zosta�y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka�dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je�li podano opcj� \fB\-p\fP, to zostaje odszykany trop
dla \fInazw\fP, b�d�cych zarezerwowanymi z�owami, aliasmi, \fIitp.\fP
Bez opcji \fB\-v\fP \fBwhence\fP dzia�a podobnie do \fBcommand \-v\fP,
poza tym, �e \fBwhence\fP odszukuje zarezerwowane s�owa i nie wypisuje
alias�w jako komendy alias;
z opcj� \fB\-v\fP, \fBwhence\fP to tosamo co \fBcommand \-V\fP.
Prosz� zwr�ci� uwag�, �e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp�ywu
na przeszukiwany trop, tak jak dla \fBcommand\fP.
Je�li typ jednej lub wi�cej sposr�d nazw niem�g� zosta� ustalony 
do status zako�czenia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola Zada�"
Kontrola zada� oznacza zdolno�� otoczki to monitorowania i kontrolowania
wykonywanych \fBzada�\fP,
kt�re s� procesami lub grupami proces�w tworzonych przez komendy lub 
ruroci�gi.
Otoczka przynajmniej �ledzi status obecnych zada� w tle
(\fItzn.\fP, asynchronicznych); t� informacj� mo�na otrzyma�
wykonyj�� komend� \fBjobs\fP.
Je�li zosta�a uaktywnioa pe�na kontrola zada�
(stosuj�c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w otoczkach interakcjynych,
to procesy pewnego zadania zostaj� umieszczane we w�asnej grupie
proces�w, pierwszoplanowe zadnia mog� zosta� zatrzymane przy pomocy
klawisza wstrzymania z termialu (zwykle ^Z),
zadania mog� zosta� ponownie podj�te albo na pierwszym planie albo
w tle, stosujac odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nast�pnie odtworzony, je�li
zatanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Prosz� zwr�ci� uwga�, �e tylko komendy tworz�ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podotoczek, i niewbudowane komendy
nie b�d�ce funkcjami) mog� zosta� wstrzymane; takie komendy
jak \fBread\fP nie mog� tego.
.sp
Gdy zostaje stworzone zadnie, to przyporzadkowywuje mu si� numer zadania.
Dla interakcyjnych otoczek, numer ten zostaje wy�wietlone w \fB[\fP..\fB]\fP,
i w nast�pstwie identyfikatory proces�w w zadaniu, je�li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo�emy odnosi� si� w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i 
\fBwait\fP albo poprzez id ostatniego procesu w ruroci�gu komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj�c
numer zadania znakiem procentu (\fB%\fP).
R�wnie� nast�puj�ce sekwencj� z procentem mog� by� stosowane do
odnoszenia si� do zada�:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie, lub, gdy brak zatrzymanych zada�, najstarsze 
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, kt�re wy�oby pod \fB%+\fP gdyby nie zosta�o zako�czone.
T}
%\fIn\fP	T{
Zadanie z numeram zadania \fIn\fP.
T}
%?\fIci�g\fP	T{
Zadanie zawieracjace ci�g \fIci�g\fP (wyst�puje b��d, gdy odpowiada mu 
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
otoczka wy�wietla nast�puj�ce informacje o statusie:
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
Wskazuje opbecny stan danego zadania
i mo�e to by�
.RS
.IP "\fBRunning\fP"
Zadania nie jest ani wstrzymane ani zako�czone (prosz� zwr�ci� uwag�, i�
przebieg nie koniecznie musi oznacza� spotrzebowywanie
czasu CPU \(em proces mo�e by� zablokowany, czekaj�c na pewne zaj�cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zako�czone. \fInumer\fP to status zako�czeniowy danego zadania,
kt�ry zostaje pominiety, je�li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna�\fP\fB)\fP]"
zadanie zosta�o wstrzymane danym sygna�em \fIsygna�\fP (gdy brak sygna�u,
to zadnie zosta�o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna�u\fP [\fB(core dumped)\fP]"
zadanie zosta�o zabite sygna�em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opis�w sygna��w).
Wiadomos� \fB(core\ dumped)\fP wskazuje, �e proces stworzy� plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, kt�ra stworzy�a dany proces.
Je�li dane zadania zwiera kilka proces�w, to k�dy proces zostanie wy�wietlony
w osobnym wierszy pokazujacym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je�li jest on odmienny od statusu poprzedniego procesu.
.PP
Je�li pr�buje si� zako�czy� otoczk�, podczas gdy istniej� zadania w
stanie zatrzymania, to otoczka ostrzega u�ytkownika, �e s� zadania w stanie
zatrzymania i nie zaka�cza si�.
Gdy tu� potem zostanie podj�ta ponowna pr�ba zako�czenia otoczki, to
zatrzymane zadania otrzymuj� sygna� \fBHUP\fP i otoczka ko�czy prac�.
podobnie, je�li nie zosta�a nastawiona opcja \fBnohup\fP,
i s� zadania w pracy, gdy zostanie podjeta pr�ba zako�czenia otoczki
zameldowania, otoczka ostrzega u�ytkownika i nie ko�czy pracy.
Gdy tu� potem zotanie ponownie podjeta pr�ba zako�czenia pracy otoczki,
to bierz�ce procesy otrzymuj� sygna� \fBHUP\fP i otoczka ko�czy prac�.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna Edycja Wiersza Wprowadze� w Trybie Emacs"
Je�li zosta�a nastawiona opcja \fBemacs\fP,jest w��czona interakcyjna
edycja wiersza wprowadze�.  \fBOstrze�enie\fP: Ten tryb zachowuje si�
nieco inaczej ni� tryb emacs-a w orginalnej otoczce Korn-a
i 8-smy bit zostaje wykasowany w trybie emacs-a.
W trybie tym r�ne komendy edycji (zazwyczaj pod��czone pod jeden lub wiecej
znak�w kontrolnych) powoduj� natychmiastowe akcje bez odczekiwania
nast�pnego prze�amania wiersza.  Wiele komend edycji jest zwi�zywana z 
pewnymi znakami kontrolnymi podczas odpalania otoczki; te zwi�zki mog� zosta�
zmienione przy pomocy nast�puj�cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi�zki zostaj� wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci�g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi�zana pod dany \fBci�g\fP, kt�ry
powinnien sk�ada� si� ze znaku kontrolnego (zapisanego przy pomocy
strza�ki w g�r� \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dw�ch znak�w przedsionkownych.  Wprowadzenie danego
\fIci�gu\fP b�dzie w�wczas powodowa�o bezpo�rednie wywo�anie danej
komendy edycji.  Prosz� zwr�ci� uwag�, �e cho� tylko
dwa znaki przedsionkowe mog� (zwykle ESC i ^X) s� wspomagane, to
r�wnie� niekt�re ci�gi wieloznakowe r�wnie� mog� zosta� podane.  
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
dane \fIpodstawienie\fP kt�re mo�e zawiera� komendy edycji.
.\"}}}
.PP
Nast�puje lista dost�pnych komend edycji.
Ka�dy z poszczeg�lnych opis�w zaczyna si� nazw� komendy,
liter� \fIn\fP, je�li komenda mo�e zosta� poprzedzona licznikiem,
i wszelkimi klawiszami do kt�rych dana komenda jest pod�aczona
domy�lnie (w zapisie sotsujacym notacj� strza�kow�, \fItzn.\fP, 
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj�cy komend� wprowadzamy stosuj�c ci�g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci�g sk�adaj�cy si� z jednej
lub wi�cej cyfr;
chyba, �e podano inaczej licznik, je�li zosta� pomini�ty, wynosi 
domy�lnie 1.
Prosz� zwr�ci� uwag�, �e nazwy komend edycji stosowane s� jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy�lne podwi�zania zosta�y wybrane
tak, aby by�y zgodne z odpowiednimi podwi�zaniami EMACS-a.  
Znaki u�ytkownika tty (\fIw szczeg�lno�ci\fP, ERASE) zosta�y
pod��czenia do stosownych podstawnie� i przekasowywuj� domy�lne
pod��czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania-histori\fP 
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
Przesuwa na pocz�tek histori.
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
Je�li bierz�cy wiersz nie zaczyna si� od znaku komentarza, zostaje on
dodany na pocz�tku wiersza i wiesz zostaje wprowadzony (tak jakby
naci�ni�to prze�amanie wiersza), w przeciwnym razie istniej�ce znaki
komentarza zostaj� usuni�te i kursor zostaje umieszczony na pocz�tku 
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope�nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj�cej kursor.  Je�li ca�a pozosta�a cz��
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy�wietlona
po wype�nieniy, chyba �e jest to nazwa katalogu, w kt�rym to razie zostaje
do��czone \fB/\fP.  Je�li nie ma komendy lub nazwy pliku zaczynajacej
si� od takiej cz�sci s�owa, to zostaje wyprowadzony znak dzwonka 
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
Automatycznie dope�nia tyle ile jest jednoznaczne z nazwy plikyu
zawieraj�cego cz�ciowe s�owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy�ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymie� mo�liwe dope�nienia bierz�cego s�owa.
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
Kasuje znaki po koursorze, a� do ko�ca \fIn\fP s��w.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historji w prz�d \fIn\fP wierszy (p�niej).  
Ka�dy wiersz wprowadzenia zaczyna si� orginalnie tu� po ostatnim
miejscu w buforze historji, tak wi�c
\fBdown-history\fP nie jest przydaten dopuki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Przemie� na ma�e litery nast�pnych \fIn\fP s��w.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porousza do ko�ca historji.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na konie� wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia�a jako koniec-pliku; Jest to przydatne, albowiem tryb edycji
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
Umie�� kursor na znaczniku i nastaw znacznik na miejsce w kt�rym by�
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bierz�cego s�owa i zast�puje dane s�owo wynikiem
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
Przemieszcza do historji numer \fIn\fP.
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
w przeciwnym razie kasuje znaki pomi�dzu cursorem a
\fIn\fP-t� kolumn�.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend lub nazw plik�w
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
Do nazw katalog�w zostaje do��czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw plik�w
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
Specyfikatory rodzaju plik�w zostaj� do��czone tak jak powy�ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bierz�cego wiersza wprowadze� przez otoczk�.
Kursor mo�e znajdowa� si� aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bierz�cego wiersza wprowadze� przez otoczk�,
po czym nast�pny wiersz z histori staje si� wierszem bierz�cym.
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
Nast�puj�cy znak zostaje wzi�ty dos�ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zach�cacz i bierz�cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty� w bierz�cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w prz�d w bierz�cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd� w krocz�cy tryb szukania.  Wewn�trzna lista historji zostaje
przeszukiwana wstecz za komendami odpowiadaj�cymi wprowadzeniu.  
pocz�tkowe \fB^\fP w szukanym ci�gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan� wykonywane po opuszczeniu trybu szukania.  
Ponowne komendy \fBsearch-history\fP kontynuuj� szukanie wstecz
do nast�pnego poprzedniego wyst�pienia wzorca.  Bufor historji
zawiera tylko sko�czon� ilo�� wierszy; dla potrzeby najstarsze zostaj�
wy�ucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bierz�cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj�cymi, wypycha pod��czony znak spowrotem
do wej�cia terminala, dzie mo�e on zosta� specjalnie przetworzony przez
terminal.  Jest to przydatne n.p. dla opcji BRL \fB^T\fP mini-systat'a.
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
poprzedni i birz�cy znak, po czym przesuwa cursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historji \fIn\fP wierszy wstecz (wcze�niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nast�pnych \fIn\fP s��w w du�e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisuj� wersj� ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci�ni�ty jakikolwiek klawisz 
(po czym ten klawisz zostaje przetworzony, chyba �e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad� ostatnio skasowny ci�g tekstu na bierz�c� pozycj� kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo�rednio po \fByank\fP, zamienia wprowadzony tekst na
nast�pny poprzednio skasowany ci�g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny Tryb Edycji Wiersza Wprowadze� Vi"
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
komenda \fB_\fP dzia�a odmiennie (w ksh jst to komenda ostatniego argumentu,
a w vi przechodzenie do pocz�tku bierz�cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fPporuszaj� si� w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
i brak jest komend, kt�re nie maj� znaczenia w edytorze obs�ugujacym jeden 
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
W trybie wprowadzania, wi�kszo�� znakow zostaje po prostu umieszczona
w buforze na bierz�cym miejscu kursora w kolejno�ci ich wpisywania, 
chocia� niekt�re znaki zostaj� traktowane specjalnie.
W szczeg�lno�ci nast�puj�ce znaki odpowiadaj� obecnym ustawieniom tty'a
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
bazpo�renio nast�pny: nast�pny naci�ni�ty znak nie zostaje traktowany 
specjalnie (mo�na tego u�y� do wprowadzenia opisywanych tu znak�w)
T}
^J ^M	T{
kiniec wiersza: bierz�cy wiersz zostaje wczytany, rozpoznany i wykonany
przez otoczk�
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni�ej)
T}
^E	T{
wyliczanie komend i nazw plik�w (patrz poni�ej)
T}
^F	T{
dope�nianie nazw plik�w (patrz poni�ej).
Je�li zostanie u�yte dwukrotnie, zo w�wczas wy�wietla list� mo�liwych
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
w ostatniej kolumnie, wskazujacy odpowiednio na wi�cej znak�w po, przed i po, oraz 
przed obecn� pozycj�.
Wiersz jest przwijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka�dy znak zostaje interpretowany jako komenda.
Znaki kt�rym nie odpowiada �adna komenda, kt�re s� niedopuszczaln� 
komend� lub s� komendami niedowykonania, wszystkie wyzwalaj� dzwonek.
W nast�puj�cych opisach komend, \fIn\fP wskazuje �e komed� mo�na
poprzedzi� numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znak�w); gdy brak przedsionka numerowego, to zak�ada si�, �e \fIn\fP 
jest r�wne 1, chyba �e powiemy inaczej.
Zwrot `bierz�ca pozycja' odnosi si� do pozycji pomi�dzy cursorem
a znakiem przed nim.
`S�owo' to ci�g liter, cyfr lub podkre�le�
albo ci�g nie nie-liter, nie-cyfr, nie-podkre�le�, niebia�ych-znak�w
(\fItak wi�c\fP, ab2*&^ zawiera dwa s�owa), oraz `du�e s�owo' jest ci�giem
niebia�ych znak�w.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nast�puj�cych komend brak, lub s� one odmienne od tych w normalnym
edytorze plik�w vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad� przerw� z nast�pstwem \fIn\fP-tego du�ego s�owa
z ostatniej komendy w historji na bierz�cej pozycji w wejd� z tryp
wprowadzania; je�li nie podano \fIn\fP to domy�lnie zostaje wprowadzone
ostatnie s�owo.
.IP "\fB#\fP"
wprowad� znak komenta�a (\fB#\fP) na pocz�tku bierz�cego wiersza
i przeka� ten wiersz do otoczki (taksoamo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z wyj�tkiem, �e je�li nie podano \fIn\fP 
to dotyczy to ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj�c edytor vi; 
je�li nie podano \fIn\fP, to edytuje bierz�cy wiersz.
W�a�ciw� wykonywan� komend� jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope�nianie komendy lub nazwy pliku zostaje zastosowane do
 obecnego du�ego s�owa
(po dodaniu *, je�li to s�owo nie zawiera �adnych znak�w dope�niania nazw
plik�w) - du�e s�owo zostaje zast�pione s�owami wynikowymi.
Je�li bierz�ce du�e s�owo jest pierwszym w wierszu (lub wyst�puke po
jednym z nast�puj�cych znak�w: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera pochy�ka (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wyknoane rozwijanie nazwy plik�w.
Rozwijanie komend podpasowuje du�e s�owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i r�wnie� wszelkie wykonywalne pliki odnajdywane
przeszukuj�c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plik�w dopasowywuje du�e s�owo do nazw plik�w w bierz�cym
katalogu.
Po rozwini�ciu, kursor zostaje umieszczony tu� po
ostatnim s�owie na ko�cu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope�nianie nazw komend/plik�w: 
zast�puje bierz�ce du�e s�owo najd�uzszym, jednoznacznym
dopasowaniem otrzymanym przez rozwini�cie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je�li zosta�a w��czona opcja 
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je�li zosta�a w��czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je�li podano \fIn\fP to zostaje u�yte \fIn\fP-te mo�liwe 
dope�nienie (z tych zwracanych przez komen� wyliczania dope�nie� nazw
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
przsu� si� do kolumny 0.
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
odnajd� wz�r: edytor szuka do przodu najbli�szego nawiasu okr�g�ego
prostok�tnego lub zawi�ego i nast�pnie przesuwa si� od odpowiadaj�cego mu
nawiasu okr�g�ego prostok�tne lub zawi�ego.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesu� si� w prz�d do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesu� si� w ty� do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesu� si� w przod tu� przed \fIn\fP-te wyst�pienie znaku \fIc\fP.
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
przejd� do \fIn\fP-tego nast�pnego wiersza w historji.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd� do \fIn\fP-tego poprzedniego wiersza w historji.
.IP "\fIn\fP\fBG\fP"
przejd� do wiersza \fIn\fP w historji; je�li brak \fIn\fP, to przenosi
si� do pierwszego zapamietanego wiersza w historji.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, �e je�li nie podan \fIn\fP to idzie do
ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci�g\fP"
szukaj wstecz w historji \fIn\fP-tego wiersza zawieraj�cego
\fIci�g\fP; je�li \fIci�g\fP zaczyna si� od \fB^\fP, to reszta ci�gu
musi wyst�powa� na samym pocz�tku wiersza historji aby pasowa�a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, �e szuka do przodu w histori.
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
bierz�cej pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t� r�nic� �e dodaje do ko�ca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bierz�cej
pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t� r�nic� �e dodaje do tu� przed pierwszym niebia�ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamie� nast�pnych \fIn\fP znak�w (\fItzn.\fP, skasuj te znaki i przejd�
do trybu wprowadzania).
.IP "\fBS\fP"
zast�p ca�y wiersz: wszystkie znaki od pierwszego niebia�ego znaku
do ko�ca wiersza zostaj� skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd� z bierz�cej pozycji do pozycji wynikajacej z \fIn\fP
\fIkomend-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wej� w tryb
wprowadzania);
je�li \fIkomend�-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia�ego znaku pocz�wszy.
.IP "\fBC\fP"
zmie� od obecnej pozycji op koniec wiersza (\fItzn.\fP, skasuj do ko�ca wiersza
i przejd� do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nast�pnych \fIn\fP znak�w.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znak�w.
.IP "\fBD\fP"
skasuj do ko�ca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikajacej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo�e by� komend� przemieszczania (patrz powy�ej) lub \fBd\fP,
co powoduje skasowanie bierz�cego wiersza.
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
ca�y wierz zostaje wyci�ty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do ko�ca wiesza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto�� bufora wycinania tu� po bierz�cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko �e bufor zostaje wklejony na bierz�cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "R�ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bierz�cy wiersz zostaje wczytany, rozpoznany i wykonany przez otoczk�.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bierz�cy wiersz.
.IP "\fIn\fP\fB.\fP"
wyknoaj ponownie ostatni� komend� edycji \fIn\fP razy.
.IP "\fBu\fP"
odwr�� ostatni� komend� edycji.
.IP "\fBU\fP"
odwr�� wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zako�czenia powoduj� skasowania bierz�cego
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
Wszelkie b��dy w pdksh nale�y zg�asza� pod adres pdksh@cs.mun.ca.  
Prosz� poda� wersj� pdksh (echo $KSH_VERSION pokazuje j�), maszyn�,
system operacyjny i stosowany kompilator oraz opis jak powt�rzy� dany b��d
(najlepiej ma�y skrypt otoczki demonstruj�cy dany b��d).  
Nast�puj�ce mo�e by� r�wnie� pomocne, je�li ma znaczenie 
(je�li nie jeste� pewny to podaj to r�wnie�): 
stosowane opcje (zar�wno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo�na otrzyma� z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta otoczka powsta�a z publicznego klona 7-mego wydania otoczki
Bourne-a wykonwnego przez Charlesa Forsytha i z cz�ci otoczki
BRL autorstwa Doug A.\& Gwyn, Doug Kingston,
Ron Natalie, Arnold Robbins, Lou Salkind i innych.  Pierwsze wydanie
pdksh stworzy� Eric Gisin, a nast�pnie troszczyli si� ni� kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji �r�de� zawiera bardziej kompletn�
list� ludzi i ich wk�adu do rozwoju tej otoczki.
.PP
T�umaczenie tego podr�cznika na j�zyk Polski wykona� Marcin Dalecki 
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "PATRZ R�WNIE�"
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
.\"}}}
'\" t
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
.TH KSH 1 "22 Lutego, 1999" "" "Komendy u�ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja otoczki Korn-a
.\"}}}
.\"{{{  Synopsis
.SH WYWO�ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP] [ [ \fB\-c\fP \fIci�g-komenda\fP [\fInazwa-komendy\fP] | \fB\-s\fP | \fIplik\fP ] [\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP, to interpretator komend nadaj�cy si�, zar�wno jako otoczka
do interakcyjnej pracy z systemem, jak i do wykonywania skrypt�w.
J�zyk komend przeze� rozumiany to nadzbi�r j�zyka otoczki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Odpalanie Otoczki"
Nast�puj�ce opcje mog� zosta� zastosowane w wierszu komendy:
.IP "\fB\-c\fP \fIci�g-komenda\fP"
otoczka wykonuje rozkaz(y) zawarte w \fIci�g-komenda\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni�ej
.IP \fB\-l\fP
otoczka zameldowania \(em patrz poni�ej
interakcyjny tryb \(em patrz poni�ej
.IP \fB\-s\fP
otoczka wczytuje komendy ze standardowego wej�cia; wszelkie argumenty
nie b�d�ce opcjami, s� argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni�ej
.PP
Ponad to wszelkie opcje, opisane w zwi�zku z wmontowan�
komend� \fBset\fP, mog� r�wnie� zosta� u�yte w wierszu komendy.
.PP
Je�li ani opcja \fB\-c\fP, ani opcja \fB\-s\fP, nie zosta�y
podane, w�wczas pierwszy argument nie b�d�cy opcj�, okre�la
plik z kt�rego zostan� wczytywane komendy. Je�li brak jest argument�w
nie b�d�cych opcjami, to otoczka wczytuje komendy ze standardowego
wej�cia.
Nazwa otoczki (\fItzn.\fP, zawarto�� parametru \fB$0\fP)
jest ustalana jak nast�puje: je�li u�yto opcji \fB\-c\fP i zosta�
podany nieopcyjny argument, to jest on nazw�; 
je�li komendy s� wczytywane z pliku, w�wczas nazwa danego pliku zostaje
u�yta jako nasza nazwa; w kazdym innym przypadku zostaje u�yta
nazwa, pod jak� dana otoczka zosta�a wywo�ana 
(\fItzn.\fP, warto�� argv[0]).
.PP
Otoczka jest \fBinterakcyjna\fP, je�li u�yto opcji \fB\-i\fP 
lub je�li zar�wno standardowe wej�cie, jak i standardowe wyj�cie,
s� skojarzone z jakim� terminalem.
W interakcyjnej otoczce kontrola zada� (je�li takowa jest dost�pna
w danym systemie) jest w��czona i ignoruje nast�puj�ce sygna�y:
INT, QUIT oraz TERM. Ponadto wy�wietla ona zach�cacze przed
wczytywaniem wprowadze� (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych otoczek, uaktywnia si� domy�lnie opcja \fBtrackall\fP
(patrz poni�ej: komenda \fBset\fP).
.PP
Otoczka jest \fBograniczona\fP je�li zastosowano opcj� \fB\-r\fP lub
gdy, albo podstawa nazwy pod jak� wywo�ano otoczk�, albo parametr
\fBSHELL\fP, pasuj� pod wzorzec *r*sh (\fIw szczeg�lno�ci\fP, 
rsh, rksh, rpdksh, \fIitp.\fP).
Nast�puj�ce ograniczenia zachodz� w�wczas po przetworzeniu przez
otoczk� wrzelkich plik�w profilowych i plik�w z \fB$ENV\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
komenda \fBcd\fP jest wy��czona
.IP \ \ \(bu
parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP, nie mog� by� modyfikowane
.IP \ \ \(bu
nazwy komend nie mog� by� podane przy pomocy absolutnych lub
wzgl�dnych trop�w
.IP \ \ \(bu
opcja \fB\-p\fP wbudowanej komendy \fBcommand\fP jest niedost�pna
.IP \ \ \(bu
przekierowania, kt�re stwarzaj� pliki, nie mog� zosta� zastosowane
(\fIw szczeg�lno�ci\fP, \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Otoczka jest \fBuprzywilejowana\fP, je�li zastosowano opcj� \fB\-p\fP,
lub, je�li rzeczywiste id u�ytkownika lub jego grupy
nie jest zgodne z efektywnym id u�ytkownika czy grupy
(patrz \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana otoczka nie przetwarza ani $HOME/.profile, ani parametru
\fBENV\fP (patrz poni�ej), w zamian zostaje przetworzony plik
/etc/suid_profile.
Wykasowanie opcji uprzywilejowania powoduje, �e otoczka ustawia swoje
efektywne id u�ytkownika i grupy na warto�ci faktycznych id u�ytkownika
(user-id) i jego grupy (group-id).
.PP
Je�li podstawa nazwy pod jak� dana otoczka zosta�a wywo�ana 
(\fItzn.\fP, argv[0])
zaczyna si� od \fB\-\fP, lub je�li podano opcj� \fB\-l\fP,
to zak�ada si�, �e otoczka ma by� otoczk� zameldowania i wczytuje
zawarto�� plik�w \fB/etc/profile\fP i \fB$HOME/.profile\fP,
je�li takowe istniej� i s� czytelne.
.PP
Je�li podczas odpalania otoczki zosta� ustawiony parametr \fBENV\fP
(albo, w wypadku otoczek zameldowania, po przetworzeniu
wszelkich plik�w profilowych), to jego zawarto�� zostaje
poddana podstawieniom komend, arytmetycznym i szlaczka, a nast�pnie
wynikaj�ca z tej operacji nazwa (je�li takowa istnieje), zostaje
zinterpretowana jako nazwa pliku, podlegaj�cego nast�pnemu
wczytaniu i wykonaniu.
Je�li parametr \fBENV\fP jest pusty (i niezerowy), oraz pdksh zosta�
skompilowany ze zdefiniowanym makro \fBDEFAULT_ENV\fP, 
to (po wykonaniu wszelkich ju� wy�ej wymienionych podstawie�)
plik przeze� okre�lany zostaje wczytany.
.PP
Status zako�czenia otoczki wynosi 127, je�li plik komend
podany we wierszu wywo�ania nie m�g� zosta� otwarty,
lub jest niezerowy, je�li wyst�pi� fatalny b��d w sk�adni
podczas wykonywania tego� skryptu.
W wypadku braku wszelkich b��d�w status jest r�wny statusowi ostaniej
wykonanej komendy lub zero, je�li nie wykonano �adnej komendy.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk�adnia Komend"
.\"{{{  words and tokens
Otoczka rozpoczyna analiz� sk�adni swych wprowadze� od podzia�u
na poszczeg�lne s�owa \fIword\fPs.
S�owa, stanowi�ce ci�gi znak�w, rozgranicza si� niewycytowanymi
znakami \fIbia�ymi\fP (spacja, tabulator i przerwanie wierszu) 
lub \fImeta-znakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza rozgraniczeniami s��w spacje i tabulatory s� ignorowane,
podczas gdy, przerwania wierszy zwykle rozgraniczaj� komendy.
meta-znaki stosowane s� to tworzenia nast�puj�cych kawa�k�w:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIetc.\fP,
kt�re s�u�� do specyfikacji przekierowa� (patrz: przekierowywanie
wej�cia/wyj�cia poni�ej);
\fB|\fP s�u�y do tworzenia ruroci�g�w;
\fB|&\fP s�u�y do tworzenia co-proces�w (patrz Co-Procesy poni�ej);
\fB;\fP s�u�y do rozgraniczania komend;
\fB&\fP s�u�y do tworzenia asynchronicznych ruroci�g�w;
\fB&&\fP i \fB||\fP s�u�� do specyfikacji warkunkowego wykonania;
\fB;;\fP jest u�ywania w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s� u�ywane w wyra�eniach arytmetycznych;
i na zako�czenie,
\fB(\fP .. \fB)\fP s�u�� do tworzenia podotoczek.
.PP
Bia�e przerwy lub meta-znaki mo�na wycytowywa� indywidualnie
przy u�yciu wstecznika (\fB\e\fP), lub grupami poprzez
podw�jne (\fB"\fP) lub pojedy�cze (\fB'\fP)
cudzys�owy.
Porsz� zwr�ci� uwag�, i� nast�puj�ce znaki podlegaj� r�wnie� 
specjalnej interpretacji przez otoczk� i musz� zosta� wycytowane
je�li maj� reprezentowa� same siebie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to powy�ej wspomniane symbole wycytowywania
(patrz wycytowywanie poni�ej);
\fB#\fP, na pocz�tu s�owa rozpoczyna komentarz \(em wszysko do
\fB#\fP, po zako�czenie bierz�cego wiersza, zostaje zignorowane;
\fB$\fP s�u�y do wprowadzenia podstawienia  parametru, komendy lub arytmetycznego
wyra�enia (patrz Podstawienia poni�ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz Podstawienia poni�ej);
\fB~\fP rozpoczyna rozwini�cie katalugo (patrz Rozwijanie Szlaczka poni�ej);
\fB{\fP i \fB}\fP obejmuj� alternacje w stylu \fIcsh\fP(1)
(patrz Rozwijanie Nawias�w poni�ej);
i, na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s� stosowane
w generacji nazw plik�w (patrz Wzorce Nazw Plik�w poni�ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s��w i kawa�k�w, otoczka tworzy komendy, z kt�rych
wyr�nia si� dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z�o�one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, konstrukty grupujace i definicje funkcji.
.PP
Prosta komenda sk�ada si� z kombinacji przyporz�dkowa� warto�ci 
parametrom (patrz Parametry ponizej), przekierowa� wej�cia/wyj�cia
(patrz Przekierowania Wej�cia/Wyj�cia poni�ej), i s��w komend;
Jedynym ograniczeniem jest to, �e wszelkie przyporz�dkowania warto�ci
parametrom musz� wyprzedza� s�owa komendy.
S�owa komendy, je�li zosta�y takowe podane, okre�laj� komend�, kt�r�
nale�y wykona�, wraz z jej argumentami.
Komenda mo�e by� wbudowan� komend� otoczki, funkcj� lub
\fIzewn�trzn� komend�\fP, \fItzn.\fP, oddzielnym
plikiem wykonywalnym, kt�ry zostaje zlokalizowany przy u�yciu
warto�ci parametru \fBPATH\fP (patrz Wykonywanie Kommend poni�ej).
Prosz� zwr�ci� uwag� i� wszelkie konstrukty komendowe posiadaj� 
\fIstatus zako�czenia\fP: dla zewn�trznych komend, jest to
powi�zane ze statusem zwracanym przez \fIwait\fP(2) (je�li
komenda niezosta�a odnaleziona, w�wczas status wynosi 127, 
natomiast je�li nie mo�na by�o jej wykona�, wowczas status wynosi 126);
statusy zwracane przez inne konstrukcje komendowe (komendy wbudowane,
funkcje, rurociagi, listy, \fIitp.\fP) s� dok�adnie okre�lone
i  opisano je w kontekscie opisu danej konstrukcji.
Status zako�czenia komendy zawieraj�cej jedynie przyporz�dkowania
warto�ci parametrom, odopwiada statusowi ostaniej wykonanej podczas tego
przyporz�dkowywnia substytucji lub zeru, je�li �adne podstawienia nie mia�y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Komendy mog� zosta� powi�zane przy pomocy oznacznika \fB|\fP w
\fIruroci�gi\fP, w kt�rych standardowe wyj�cie
wszyskich komend poza ostatni�, zostaje pod��czone
(patrz \fIpipe\fP(2)) do standardowego wej�cia nast�pnej w szeregu
komend.
Status zako�czeniowy ruroci�gu, odpowiada statusowi ostatniej komendy
w nim.
Ruroci�g mo�e zosta� poprzedzony zarezerwowanym s�owem \fB!\fP,
dzi�ki czemu status ruroci�gu zostanie zamieniony na jego
logiczny komplement. Tzn. je�li pierwotnie status wynosi�
0 w�wczas b�dzie on mia� warto�� 1, natomiast je�li pierwotn� warto�ci�
nie by�o 0, w�wczas komplementarny status wynosi 0.
.\"}}}
.\"{{{  lists
.PP
\fIList�\fP komend tworzymy rozdzielaj�c ruroci�gi
poprzez jeden z nast�puj�cych oznacznik�w:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj� uwarunkowane wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko, je�li status zako�czenia \fIcmd1\fP by� zerowy.
Natomiast \fB||\fP zachowuje si� dok�adnie przeciwstawnie. \(em \fIcmd2\fP 
zostaje wykonane jedynie, je�li status zako�czeniowy \fIcmd1\fP by�
r�ny od zera.
\fB&&\fP i \fB||\fP wi��� r�wnowa�nie, a zarazem mocniej ni�
\fB&\fP, \fB|&\fP i \fB;\fP, kt�re r�wnie� posiadaj� t� sam� si�� wi�zania.
Oznacznik \fB&\fP powoduje, �e poprzedzaj�ca go komenda zostanie wykonana
asynchronicznie, tzn., otoczka odpala dan� komend�, jednak nie czeka na jej
zako�czenie (otoczka �ledzi dok�adnie wszystkie asynchronicznye
komendy \(em patrz Kontroloa Zada� poni�ej).
Ja�li asynchroniczna komenda zostaje zastartowana z wy��czony�
kontrol� zada� (\fInp.\fP, w wi�kszo�ci skrypt�w), 
w�wczas komenda zostaje odpalona z wy��czonymi sygna�ami INT
i QUIT, oraz przekierowanym wej�ciem na /dev/null
(aczkolwiek przekierowania, ustalone w samej asynchronicznej komendzie
maj� tu pierwsze�stwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi�cy specjalnego
rodzaju asynchroniczn� komend� (patrz Koprocesy poni�ej).
Prosz� zwr�ci� uwag�, i� po operatorach \fB&&\fP i \fB||\fP 
musi wyst�powa� komenda, podczas gdy niekoniecznie
po \fB&\fP, \fB|&\fP i \fB;\fP.
Statusem zako�czenia listy komend jest status ostatniej wykonanej w niej
komendy z wyj�tkiem asynchronicznych list, dla kt�rych status wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Z�o�none komendy tworzymy przy pomocy nast�puj�cych zarezerwowanych s��w
\(em s�owa te zostaj� wy�acznie rozpoznane, je�li nie s� wycytowane i
wystepuj� jako pierwsze wyrazy w komendzie (\fIdok�aniej\fP, nie s� poprzedzane
�adnymi przyporz�dkowywaniami warto�ci parametrom
lub przekierunkowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niekt�re otoczki (lecz nie nasza) wykonuj� rozkazy kontrolne
w podotoczce, je�li jeden lub wi�cej z ich deskryptor�w plik�w zosta�y
przekierowane, tak wi�c wszekiego rodzaju zmiany otoczenia w nich mog�
nie dzia�a�.
Aby zachowa� portabilijno�� nale�y stosowa� rozkaz \fBexec\fP,
zamiast przekierowa� deskryptor�w plik�w przed rozkazem kontrolnym.
.PP
W nast�puj�cym opisie z�o�onych komend, listy komend (zanaczone przez 
\fIlista\fP) ko�cz�ce si� zarezerwowanym s�owem
musz� ko�czy� si� �rednikiem lub prze�amaniem wiersza lub (poprawnym
gramatycznie) zarezerwowanym s�owem.
Przyk�adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s� poprawne, lecz
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlist�\fP w podotoczce.  Nie ma bezpo�redniej mo�liwo�ci
przekazania warto�ci parametr�w podotoczki z powrotem do jej
otoczki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Z�o�ony konstrukt; \fIlista\fP zostaje wykonana, lecz nie w podotoczce.
Prosze zauwa�u�, i� \fB{\fP i \fB}\fP, to zarezerwowane s�owa, a nie
meta-znaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs�owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra�enie \fBcase\fP stara si� podpasowa� \fIs�owo\fP pod jeden
z danych \fIwzorc�w\fP; \fIlista\fP, powi�zana z pierwszym
poprawnie podpasowanym wzorcem, zostaje wykonana.  
Wzorce stosowane w wyra�eniach \fBcase\fP odpowiadaj� wzorcom
stosowanymi do specyfikacji wzorc�w nazw plik�w z wyj�tkeim tego, �e
ograniczenia zwi�zane z \fB\&.\fP i \fB/\fP niezachodz�.  
Prosz� zwr�ci� uwag� na to, �e wszelkie niewycytowane bia�e
przerwy przed i po wzorcu zostaj� usuni�te; wszelkie przerwy we wzorcu
musz� by� wycytowane.  Zar�wno s�owa jak i wzorce podlegaj� podstawieniom
parametr�w, rozwini�ciom arytmetycznym jak i podstawieniu szlaczka.
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykaj�cy zamiast \fBin\fP i \fBesac\fP 
(\fIw szczeg�no�ci wi�c\fP, \fBcase $foo { *) echo bar; }\fP).
Statusem wykonania wyra�enia \fBcase\fP jest status wykonanej
\fIlisty\fP; je�li niezosta�a wykanana �adna \fIlista\fP, 
w�wczas status wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest, albo przerwaniem wiersza, albo \fB;\fP.
Dla ka�dego \fIs�owa\fP w podanej li�cie s��w, parameter \fInazwa\fP zostaje
ustawiony na to s�owo i \fIlista\fP wykonana. Je�li nie u�yjemy \fBin\fP 
do specyfikacji listy s��w, w�wczas zostaj� u�yte parametry pozycyjne
(\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP) wzamian.
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP 
(\fIw szczeg�lno�ci\fP, \fBfor i; { echo $i; }\fP).
Statusem wykonania wyra�enia \fBfor\fP jest ostatni status
wykonania danej \fIlisty\fP; je�li \fIlista\fP nie zosta�a w og�le
wykonana, w�wczas status wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je�li status wykonania pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je�li mamy takow�,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami.  Je�li wszystkie listy po \fBif\fP
i \fBelif\fPs wyka�� b��d (\fItzn.\fP, zwr�c� niezerowy status), to
\fIlista\fP po \fBelse\fP zostanie wykonana.
Statusem wyra�enia \fBif\fP jest status wykonanej \fIlisty\fP,
nieokre�laj�cej warunek; Je�li �adna nieokre�laj�ca warunek
\fIlista\fP niezostanie wykonana, w�wczas status wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs�owo\fP ... \fIzako�czenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzako�czenie\fP jest, albo prze�amaniem wiersza albo \fB;\fP.
Wyra�enie \fBselect\fP umo�liwia automatyczn� prezentacj� u�ytkownikowi
menu, wraz z mo�liwo�ci� wyboru z niego.
Przeliczona lista wykazanych \fIs��w\fP zostaje wypisana na
standardowym wyj�ciu b��d�w, poczym zostaje
wy�wietlony zach�cacz (\fBPS3\fP, czyli domy�lnie `\fB#? \fP').
Nast�pnie zostaje wczytana liczba odpowiadaj�ca danemu punktowi
menu ze standardowego wej�cia, poczym \fInazwie\fP 
zostaje przyporz�dkowane w ten spos�b wybrane s�owo (lub warto��
pusta, je�li dane wyb�r by� niew�a�ciwy), \fBREPLY\fP
zostaje przyporz�dkowane to co zosta�o wczytane
(po usuni�ciu pocz�tkowych i ko�cowych bia�ych przerw),
i \fIlista\fP zostaje wykonan.
Je�li wprowadzono pusty wiersz (\fIdok�adniej\fP, zero lub wi�cej
znaczk�w \fBIFS\fP) w�wczas menu zostaje podownie wy�wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zako�czone, 
w�wczas przeliczona lista wybor�w zostaje wy�wietlona ponownie, je�li
\fBREPLY\fP jest zerowe, zach�cacz zostaje ponownie podany i tak dalej.
Proces ten powtarza si�, a� do wczytania znaku zako�czenia pliku,
otrzymania sygna�u przerwania, lub wykonania wyra�enia przerwania
w �rodku wst�gi.
Je�li opuszczono \fBin\fP \fIs�owo\fP \fB\&...\fP, w�wczas
u�yte zostaj� parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP, 
\fIitp.\fP).
Ze wzgl�d�w historycznych, mo�emy zastosowa� nawiasy otwieraj�cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczeg�lno�ci\fP, 
\fBselect i; { echo $i; }\fP).
Statusem zako�czenia wyra�enia \fBselect\fP jest zero, je�li
uzyta wyra�enia przerwania do wyjscia ze wst�gi, albo
nie-zero w wypadku przeciwnym.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia�a dok�adnie jak \fBwhile\fP, z wyj�tkiem tego, �e zawarto��
wst�gi zostaje wykonana jedynie gdy status pierwszej 
\fIlisty\fP jest nie-zerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra�enie \fBwhile\fP okre�la wst�g� o przedbiegowym warunku jej
wykonania.  Zawarto�� wst�gi zostaje wykonywana dopuki,
doputy status wykonania pierwszej \fIlisty\fP jest zerowy.
Statusem zako�czeniowym wyra�enia \fBwhile\fP jest ostatni 
status zako�czenia \fIlisty\fP w zawarto�ci tej wst�gi; 
gdy zawarto�� nie zostanie wog�le wykonana w�wczas status wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcj� o nazwie \fInazwa\fP.
Patrz Funkcje poni�ej.
Prosz� zwr�ci� uwag�, �e przekierowania tu� po definicji
funkcji zostaj� zastosowane podczas wykonywania jej zawarto�ci, 
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fIname\fP \fB()\fP \fIcommand\fP"
Niemal dok�adnie to samo co w \fBfunction\fP.
Patrz Funkcje poni�ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra�enie\fP \fB))\fP"
Warto�� wyra�enia arytmetycznego \fIwyra�enie\fP zostaje przeliczona;
r�wnowa�ne do \fBlet "\fP\fIwyra�enie\fP\fB"\fP.
patrz Wyra�enia Arytmetyczne i komenda \fBlet\fP poni�ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (kt�re opisyjemy 
p�niej), z nast�puj�cymi r�nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie p�l i generacja nazw plik�w nies� wykonywana na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub), zostaj� zast�pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok�adniej.\fP, \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP) 
musz� by� wycytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczeg�lno�ci\fP, por�wnanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP
kt�re zwracaj� prawd�, gdy pierwszy ci�gowy operand jest mniejszy lub 
odpowiednio wi�kszy do drugiego operanda ci�gowego.
.IP \ \ \(bu
Jednoargumentowa posta� operacji \fBtest\fP,
w kt�rej sprawdza si� czy jedyny operand jest d�ugo�ci zeroweji, jest 
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
\fB&&\fP i \fB||\fP zostaje zastosowana metoda ogr�dkowego wyliczania
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
.SS Wycytowywanie
Wycytowywanie stosuje si� to zapobiegania, aby otoczka trakotwa�a
znaki lub s�owa w specjalny sos�b.
Istniej� trzy metody wycytowywania: Po pierwsze, \fB\e\fP wycytowywuje
nast�pny znak, gdy tylko nie mie�ci si� on na ko�cu wiersza, gdzie
zar�wna \fB\e\fP jak i przeniesienie wiersza zostaj� usuni�te.
po drugie pojedy�czy cydzys�ow (\fB'\fP) wycytowywuje wszystko,
a� po nast�pny pojedy�czy cudzys��w (wraz z prze�amaniami wierszy w��cznie).
Po trzecie, podw�jny cudzys��w (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a� po nast�pny niewycytowany podw�jny 
cudzys��w.
\fB$\fP i \fB`\fP wewnatrz podw�jnych cudzys�ow�w zachowuj� zwyk�e 
znacznie (\fItzn.\fP,
znaczaj� podstawienie warto�ci parametru, komendy lub wyra�enia arytmetycznego),
je�li tylko niezostanie wykonany jakikolwiek podzia� p�l na
wyniku podw�jnymi cudzys�owami wycytowanych podstawie�.
Je�li po \fB\e\fP, wewnatrz podw�jnymi cudzys�owami wycytowanego
ci�gu znak�w, nast�puje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zast�piony drugim z tych znak�w;
je�li nast�pne jest prze�amanie wierszu, w�wczas zar�wno \fB\e\fP 
jak i prze�amanie wirszu zostaj� usuni�te;
w przeciwnym razie zar�wno znak \fB\e\fP jak i nast�puj�cy po nim znak
nie podlegaj� �adnej zamianie.
.PP
Uwaga: patrz Tryb POSIX poni�ej pod wzgl�dem szczeg�lnych reg�
obowi�zuj�cych sekwencje znak�w postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej� dwa rodzaje alias�w: normalne aliasy komend i
�ledzone aliasy.  Aliasy komend stosowane s� zwykle jako
skr�ty dla d�ugich a cz�sto stosowanych komend. 
Otoczka rozwija aliasy komend (\fItzn.\fP,
odstawia pod nazw� aliasu jest zawarto��), gdy wczytuje
pierwsze s�owo komendy. 
Roziwni�ty alias zostaje ponownie przetworzony, aby uwzgl�dni�
ewentualne wyst�powanie dlaszych alias�w.  
Je�li alias komendy ko�czy si� przerw� lub tabulatorem, to w�wczas
nast�pne s�owo zostaje r�wnie� sprawdzone pod wzgl�dem rozwini�cia
alias�w. Proces rozwijania alias�w ko�czy si� przy napotkaniu
s�owa, kt�re nie jest aliasen, gdy napotknie si� na wycytowane s�owo,
lub gdy napotka si� na alias, kt�ry jest w�a�nie wyeksportowywany.
.PP
Nast�puj�ce aliasy s� definiowane domy�lnie przez otoczk�:
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
�ledzone aliasy pozwalaj� otoczce na zapami�tanie, gdzie
odnalaz�a ona konkretn� komend�.
Gdy otoczka po raz pierwszy odszukuje komendy po tropie, kt�ra
zosta�a naznaczona �ledzonym aliasem, wowczas zapami�tywuje ona
sobie pe�ny trop do tej komendy.
Gdy otoczka nast�pnie wykonuje dan� komend� poraz drugi,
w�wczas sprawdza ona czy ten trop wci�� jest nadal aktualny i je�li
tak nie przegl�da ju� wi�cej pe�nego tropu w poszukiwaniu
danej komendy.
�ledzone aliasy mo�na wy�wietli� lub stworzy� stosuj�c \fBalias
\-t\fP.  Prosz� zauwa�y�, �e zmieniajac warto�� parametru \fBPATH\fP 
r�wnie� wyczyszczamy tropy dla wszelkich �ledzoenych alias�w.
Je�li zosta�a w��czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP), 
w�wczas otoczka �ledzi wszelkie komendy. 
Ta opcja zostaje w��czona domy�lnie dla wszelkich
nieinterakcyjnych otoczek.
Dla otoczek interakcyjnych, jedynie nast�puj�ce komendy, s� 
�ledzone domy�lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki otoczka wykonyje, podczas wykonywania
prostej komendy, jest przeprowadzenia podstawie� na s�owach tej�e
komendy.
Istniej� trzy rodzaje podstawie�: parameter�w, komend i arytmetyczne.
Podstawienia parametr�w, kt�re dok�adniej opiszemy w nast�pnej sekcji,
maj� posta� \fB$name\fP lub \fB${\fP...\fB}\fP; 
podstawienia komend maj� posta� \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je�li podstawienie wyst�puje poza podw�jnymi cudzys�owami, w�wczas 
wynik tego podstawienia podlega zwykle podzia�owi s��w lub p�l, w zale�no�ci
od bierz�cej warto�ci parametru \fBIFS\fP.
Parametr \fBIFS\fP specyfikuje list� znaczk�w, kt�re
s�u�� jako rozgraniczniki w podziale ci�g�w znak�w na pojedy�cze 
wyrazy;
wszelkie znaki wymienione w tym zbiorze oraz tabulator, przerywacz i 
prze�amanie wiersza w��cznie, nazywane s� \fIIFS bia�ymi przerywaczami\fP.
Ci�gi jednego lub wielu bia�ych przerywaczy z IFS w powi�zaniu
z zerem oraz jednym lub wi�cej bia�ych przerywaczy nie wymienionych w IFS,
rozgraniczaj� pola.
Jako wyj�tek poprzedajace i ko�cowe bia�e przerywacze z IFS zostaj� usuni�te
(\fItzn.\fP, nie powstaj� przeze� �adne prowadz�ce lub zaka�czaj�ce
puste pola); natomiast prowadz�ce lub ko�cz�ce bia�e przerwy nie z IFS
definiuj� okre�laj� puste pola.
Przyk�adowo: je�li \fBIFS\fP zawiera `<spacja>:', to ci�g
znak�w `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Prosz� zauwa�y�, �e je�li parametr \fBIFS\fP 
jest ustawiony na pusty ci�g znak�w, to w�wczas �aden podzia� p�l
nie ma miejsca; gdy paramter ten nie jest ustawiony w og�le,
w�wczas stosuje si� domy�lnie jako rozgraniczniki
przerwy, tabulatora i przerwania wiersza.
.PP
Je�li nie podajemy inaczej, to wynik podstwaienia
podlega r�wnie� rozwijaniu nawias�w i nazw plik�w (patrz odpowiednie
akapity poni�ej).
.PP
Podstawienie komendy zostaje zast�pione wyj�ciem, wygenerowanym
podczas wykonania danej komendy przez podotoczk�.
Dla podstawienia \fB$(\fP\fIkomeda\fP\fB)\fP zachodz� normalne
reg�y wycytowywania, podczas analizy \fIkomendy\fP,
cho� jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu� po nim, zostaje usuni�ty
(znak \fB\e\fP z nast�pstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyjatkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczajaca podstawienie zawarto�ci pliku \fIplik\fP 
($(< foo) ma wi�c ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony �aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra�enia \fB$(\fP\fIkomendacommand\fP\fB)\fP s� analizowane
obecnie poprzez odnajdywanie zaleg�ego nawiasu, niezale�nie od
wycytowa�.  Miejmy nadziej�, �e to zostanie jak najszybciej
skorygowane.
.PP
Podstwaienia arytmetyczne zostaja zast�pione warto�ci� wyniku
danego wyra�enia.
Przyk�adowo wi�c, komenda \fBecho $((2+3*4))\fP wy�wietla 14.
Patrz Wyra�enia Arytmetyczne aby odnale�� opis \fIwyra�e�\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w otoczce; mo�na im przyporz�dkowywa� 
warto�ci, oraz wyczytywa� je poprzez podstwaienia parametrowe.
Nazwa parametru jest albo jednym ze znak�w 
intperpunkyjnych o specjalnym znaczeniu lub cyfr�, jakie opisujemy 
poni�ej, lub liter� z nast�pstwem jednej lub wi�cej liter albo cyfr
(`_' zalicza si� to liter).
Podstawienia parametr�w posiadaj� posta� \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdziee \fInazwa\fP jest nazw�
danego parametru.
Gdy podstawienia zostanie wykonane na parametrzy, kt�ry nie zosta�
ustalony, w�wczas zerowy ci�g znak�w jest jego wynikiem, chyba �e
zosta�a w�aczona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP) co oznacza, �e wyst�puje w�wczas b��d.
.PP
.\"{{{  parameter assignment
Warto�ci mo�na przyporz�dkowywa� parametrom na wiele r�nych sposob�w.
Po pierwsze, otoczka domy�lnie ustala pewne parametry takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny spos�b w jaki parametry zwi�zana 
ze specjalnymi jednoznakami s� ustawiane.  Po drugie, parametry zostaj� 
importowane z otocznia otoczki podczas jej odpalania.  Po przecie,
parametrom mo�na przyporz�dkowa� warto�ci we wierszu komendy, tak jak np.,
`\fBFOO=bar\fP' przyporz�dkowywuje parametrowi FOO warto�� bar;
wielokrotne przyporz�dkowania warto�ci s� mo�liwe w jednym wierszu komendy
i mo�e po nich wyst�powa� prosta komenda, co powoduje, �e
przyporz�dkowania te s� w�wczas jedynie aktualne podczas
wykonywywania danej komendy (tego rodzaju przyporz�dkowywania
zostaj� r�wnie� wyekstportowane, patrz poni�ej co do tego konsekwencji).
Prosz� zwr�ci� uwag�, i�, aby otoczka rozpozna�a je jako
przyporz�dkowanie warto�ci parametrowi, zar�wno nazwa parametru jak i \fB=\fP
nie mog� by� wycytowane.
Czwartym sposobem ustawiania parametr�w jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale Wykonywanie Komend.
Po czwarte wst�gi \fBfor\fP i \fBselect\fP ustawiaj� parametry,
tak jak i r�wnie� komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zako�czenie, paramerom mo�na przyporz�dkowywa� warto�ci stosuj�c
operatory nadania warto�ci wewn�trz wyra�e� arytmetycznych
(patrz Wyra�enia Arytmetyczne poni�ej) lub
stosujac posta� \fB${\fP\fInazwa\fP\fB=\fP\fIwarto��\fP\fB}\fP
podstawienia parametru (patrz poni�ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem exportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP,albo poprzez przyporz�dkowywanie warto�ci
parametru z nast�puj�c� prost� komend�) 
zostaj� umieszczone w otoczeniu (patrz \fIenviron\fP(5)) komend
wykonywanych przez otoczke jako pary \fInazwa\fP\fB=\fP\fIwarto��\fP.
Kolejno�� w jakiej parametry wyst�puj� w otoczeniu komendy jest 
nieustalona bli�ej.
Podczas odpalania otoczka pozyskuje parametry ze swojego
otoczenia,
i automatycznie ustawia na tych�e parametrach atrybut exportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo�na stosowa� modyfikatory do postaciu \fB${\fP\fInazwa\fP\fB}\fP 
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna
warto��, w przeciwnym razie zostaje podstawione \fIs�owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje podstawione 
\fIs�owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastwaiony i niezerowy, w�wczas zostaje podstawiony 
on sam, w przeciwnym razie zostaje my przyporz�dkowana warto��
\fIs�owo\fP i warto�� wynikaj�ca ze \fIs�owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs�owo\fP\fB}\fP
je�li \fInazwa\fP jest nastawiony i niezerowy, w�wczas zostaje
podstawiona jego w�asna warto��, w przeciwnym razie \fIs�owo\fP
zostaje wy�wietlone na standardowym wyj�ciu b��d�w (tu� po \fInazwa\fP:)
i zachodzi b��d
(powoduj�cy normalnie zako�czenie ca�ego skryptu otoczki, funkcji lub \&.-scryptyu).
Je�li s�owo zosta�o pomini�te, w�wczas zostaje u�yty ci�g 
`parameter null or not set' w zamian.
.PP
W powy�szych modyfikatorach mo�emy omin�� \fB:\fP, czego skutkiem
b�dzie, �e warunki b�d� jedynie wymaga� aby
\fInazwa\fP by� nastawiony lub nie (a nie �eby by� ustawiony i niezerowy).
Je�li potrzebna jest warto�� \fIs�owo\fP, w�wczas zostaj� na� wykonane
podstawienia parametr�w, komend, arytmetyczne i szlaczka;
natomiast, je�li \fIs�owo\fP oka�e si� by� niepotrzebne, w�wczas jego
warto�� nie zostanie obliczona.
.\"}}}
.PP
Mo�na stosowa�, r�wnie� podstawienia parametr�w o nast�puj�cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Ilo�� parametr�w pozycyjnych, je�li \fInazw�\fP jest \fB*\fP, \fB@\fP lub
niczego nie podano, lub d�ugo�� ci�gu b�d�cego wasto�ci� parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Ilo�� elemnt�w w ci�gu \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak�ada si� na pocz�tek warto�ci parametru \fInazwa\fP,
w�wczas pasuj�cy teks zostaje pomini�ty w wynikajacym z tego podstawieniu. 
Pojedy�czy \fB#\fP oznacza najkr�tsze mo�liwe podpasowanie pod wzorzec, a daw \fB#\fP
oznaczaj� jak najd�u�sze podpasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko �e dotyczy
ko�ca warto�ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nast�puj�ce specjalne parametry zostaja ustawione domy�nie przez otoczk�
i nie mo�na przyporz�dkowywa� jawnie warto�ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego zastartowanego w tle procesu. Je�li nie ma
aktualnie proces�w zastartowanych w tle, w�wczas parametr ten jest 
nienastawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Ilo�� parametr�w pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj�cego danej otoczce lub PID pierwotnej otoczki,
je�li mamy do czynienia z  podotoczk�.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenecja bierz�cych opcji jednoliterkowych
(patrz komenda \fBset\fP poni�ej, aby pozna� dost�pne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Status wynikowy ostatniej wykonanej  nieasynchronicznej komendy.
Je�li ostatnia komenda zosta�a zabita sygna�em, w�wczas, \fB$?\fP 
przyjmuje warto�� 128 plus numer danego sygna�u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa pod jak� dana otoczka zosta�a wywo�ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP je�li zosta�a ona wywo�ana przy urzyciu opcji \fB\-c\fP 
i \fBnazwa komendy\fP zosta�a podana, lub argument \fIplik\fP,
je�li takowy zosta� podany.
Je�li opcja \fBposix\fP nie jest nastawiona, to \fB$0\fP zawiera
nazw� bie��cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewi�c parametr�w pozycyjnych podanych otoczce, czy
funkcji lub \fB.\fP-skriptowi.
Dost�p do dlaszych parametr�w pozycyjnych odbywa si� przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj�tkiem parametru 0), 
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u�yte poza podw�jnymi cudzys�owami, w�wczas parametry zostaj�
rozgraniczone w pojedy�cze s�owa
(podlegaj�ce rozgraniczaniu s��w); je�li u�yte pomi�dzy 
podw�jnymi cudzys�owami, wowczas parametry zostaj� rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci�gami znak�w, je�li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj�tkiem zastosowania w podw�jnych cudzys�owach,
gdzie oddzielne s�owo zostaje wygenerowane dla ka�dego parametru
pozycyjnego z osobna \- je�li brak parametr�w pozycyjnych,
w�wczas nie generowane jest �adne s�owo
("$@" mo�e by� uzyte aby otrzyma� dost� bezpo�redni do argument�w
bez utraty argument�w zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nast�puj�ce parametry zostaj� nastawione przez otoczk�:
.\"{{{  _
.IP "\fB_\fP \fI(podkre�lenie)\fP"
Gdy jaka� komenda zostaje wykonywana prze otoczk�, ten parametrt przyjmuje
w otoczeniu odpowiedniego nowego procesu warto�� tropu prowadz�cego
do tej�e komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierowtej otoczce
ponadto warto�� ostatniego s�owo poprzedniej komendy
Podczas warto�ciowania wiadomosci typu \fBMAILPATH\fP,
parametr ten zawiera wi�c nazw� pliku kt�ry si� zmieni�
(patrz parametr \fBMAILPATH\fP poni�ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
Trop do przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia�a tak samo jak
\fBPATH\fP dla katalog�w nierozpoczynajacych si� od \fB/\fP 
w komendach \fBcd\fP.
Prosz� zwr�ci� uwag�, i� je�li CDPATH jest nastawiony i nie zwaiera ani
\fB.\fP ani pustego tropu, to w�wczas katalog bie��cy nie zostaje przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Ilo�� kolumn terminala lub okienka.
Obecnie nastawiany warto�ci� \fBcols\fP zwracan� przez komend�
\fIstty\fP(1), je�li ta warto�� nie wynosi zera.
Parametr ten ma znaczenia w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w�a�ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je�li nie zosta� nastawiony parametr \fBVISUAL\fP, w�wczas kontroluje on
tryb edycj wiersza komendy w otoczkach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni�ej, aby dowiedzie� si� jak to dzia�a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je�li parametr ten oka�e si� by� nastawionym po przetworzeniu
wszelkich plik�w profilowych, w�wczas jego rozwinieta warto�� zostaje
wyko�ystana jako nazwa pliku zawieraj�cego dalsze komendy inicjalizacyjne
otoczki.  Zwykle zwiera on definicje funkcji i alias�w.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca�kowita warto�� odpowiadaj�ca zmiennej errno otoczki 
\(em wskazuje przyczyn� wyst�pienia b��du, gdy ostatnie wywoa�nie
systemowe nie powiod�o si�.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezimplementowe.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je�li nastawiono, to w�wczas zawiera otoczk�, jakiej nale�y u�y�
do wykonywania komend kt�rych niezdo�a� wykona� \fIexecve\fP(2) 
i kt�re nie zaczynaja si� od ci�gu `\fB#!\fP \fIotoczka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u�ywany przez komend� \fBfc\fP (patrz poni�ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je�li otoczka natrafi na niezdefiniowan� 
funkcj� podczas pracy, stosowane do lokalizacji pliku zawieraj�cego definicj�
tej funkcji.
R�wnie� przeszukiwane, gdy komenda nie zosta�a odnaleziona przy
u�yciu \fBPATH\fP.
Patrz Funkcje poni�ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u�ywanego do zapisu histori komend.
Je�li warto�� zosta�a ustalona, w�wczas historia zostaje za�adowana
z danego pliku.
Podobnie wielokrotne wcielenia otoczki b�d� ko�ysta�y z jednej
historii, je�li dla nich warto�ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je�li HISTFILE nie zosta�o ustawione, w�wczas �aden plik histori
nie zostaje u�yty.  W originalnej wersji otoczki
Korna natomiast, przyjmuje si� domy�lnie \fB$HOME/.sh_history\fP;
w przysz�o�ci mo�e pdksh, b�dzie r�wnie� sotoswa� domy�lny
plik histori.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Ilo�� komend zapami�tywana w histori, domy�lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy�lna warto�� dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz Rozwijanie Szlaczka poni�ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewn�trzny rodzielacz p�l, sotoswany podczas podstawie�
i wykonywania komendy \fBread\fP, do rozgraniczania
warto�ci w oddzielne argumenty; domy�nie ustawiony na przerw�, tabulator i 
prze�amanie wiersza. Szczeg�ly zosta�y opisane w punkcie Podstawienia
powy�ej.
.br
\fBUwaga:\fP ten parametr nie zostaje importowany z otoczenia, 
podczas odpalania otoczki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja otoczki i data jest stworzenia (tylko otczyt mo�liwy).
Patrz r�wnie� komedy wersji w Emacsowej Interakcyjnej Edycji Wiersza 
Komendy i Vi Edycji Wiersza poni�ej.
.\"}}}
.\"{{{  SH_VERSION
.\"}}}
.\"{{{  LINENO
.IP \fBLINENO\fP
Numer wiersza w funkcji lub aktualnie wykonywanym skrypcie.
.\"}}}
.\"{{{  LINES
.IP \fBLINES\fP
Ilo�� wierszy na terminalu lub w okienku.
.\"Currently set to the \fBrows\fP value as reported by \fIstty\fP(1) if that
.\"value is non-zero.
.\" todo: LINES variable
.sp
Jeszcze nie zimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je�li nastawione, w�wczas u�ytkownik zostanie poinformaowany
o nadej�ciu poczty w ustawionym tam pliku.
Ten parametr zostaje zignorowany, je�li
zosta� nastawiony parametr \fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak cz�sto otoczka ma sprawdza�, czy nadesz�a nowa poczta
w plikach podanych poprzez \fBMAIL\fP lub \fBMAILPATH\fP. 
Je�li 0, w�wczas otoczka sprawdza przed ka�d� zach�t�.  
Warto�ci� domy�ln� jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
lista plik�w sprawdzanych o poczt�.  Lista ta jest rozdzielana
dwukropkami, ponadto po nazwie ka�dego z plik�w mo�na poda�
\fB?\fP i wiwdomo�� jaka powinna zosta� wy�wietlona,
je�li nadesz�a nowa poczta.  
podstawienia komend parametr�w i arytmetyczne zostaj� wykonane na
danej wiadomo�ci, i podczas postawiania parametr \fB$_\fP
zawiera nazw� tego� pliku.
Domy�lnym zawiadomieniem jest \fByou have mail in $_\fP.
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nienastawiony, je�li \fBcd\fP nie zmieni� z powodzeniem
katalogu od czasu odpalenie otoczki, lub je�li otoczka nie wie gdzie
si� aktualnie obraca.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
podczas u�ywania \fBgetopts\fP, zawiera argument dla aktulanie
rozpoznawanej opcji, je�li takowy jest wymagany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostoaniego przetwo�onego argumentu podczas u�ywania \fBgetopts\fP.
Przyporz�dkowanie 1 temu parametrowi powoduje, �e \fBgetopts\fP
przetwarza arugmenty od pocz�tku, gdy zostanie odpalone nast�pny raz.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem od siebie katalog�w, kt�re s� przeszukiwane
podczas odnajdywania jakiej� komendy lub plik�w \fB.\fP.
Puszty ci�g wynikaj�cy z poprzedzaj�cego lub nast�puj�cego dwukropka,
albo dwuch s�siednich dwukropk�w jest trakowany jako `.',
czyli katalod bierz�cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Gdy parametr ten zostanie nastawiony, w�wczas zostaje w��czona opcja
\fBposix\fP.
Patrz Tryp POSIX Mode poni�ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzimego otoczki (tylko wyczyt).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP zach�cacz pierwszego rz�du dla otoczek interakcyjnych.
Podlega substytucji parametr�w, komend i arytmetycznym, oraz
\fB!\fP zostaje zast�pioen numerem kolejnym aktualnej komendy
(patrz komenda \fBfc\fP
poni�ej).  Sam znak ! mo�e zosta� umieszczony w zach�caczu umieszczaja� 
!! w PS1.
Zauwa�, �e poniewa� edytory wiersza komendy staraj� si� obliczy�,
jak d�ugi jest zach�cacz, (aby m�c ustali�i, ile miejsca pozostaje do 
parwego brzegu ekranu), sekwencje wyj�ciowe w zach�caczu zwykle wprowadzaj� 
ba�agan.
Istnije mo�liwo�� podpowiedzenia otoczce, aby nie uwzgl�dnia�a
pewnych ci�g�w znak�w (takich jak kody wyj�cia) poprzez podanie
prefiksu na pocz�tku zach�cacza b�d�cego niewy�wietlywalnym znakiem
(takim jak no control-A) z nast�pstwem prze�amania wiersza, oraz rozgraniczaj�c
nast�pnie kody wyj�cia przy pomocy tego niewy�wietlalnego znaku.
Gdy brak niewy�wietlalnych znak�w, w�wczas nie ma �adnej rady...
Nawias� m�wi�c nie ja jestem odpowiedzialny za ten hack. To pochodzi
z orginalnego ksh.
Domy�ln� warto�ci� jest `\fB$\ \fP' dla nieuprzywilejownych
u�ytkownik�w, a `\fB#\ \fP' dla root-a..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Durugorz�dny zach�cacz, o domy�lnej warto�ci `\fB>\fP ', kt�ry
jest stosowany, gdy wymagane s� dalsze wprowadzenia w celu
skompletowania komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zach�cacz stosowany przez wyra�enie
\fBselect\fP podczas wczytywania wybory z menu.
Domy�lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, kt�re zostaj� wy�wietlane podczas
�ledzenia pracy
(patrz komenda \fBset \-x\fP poni�ej).
Domy�lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo�e by� nienastawione lub zerowe je�li
otoczka nie wie gdzie si� znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb przypadkowych. Za ka�dym razem, gdy
odnosimy si� do \fBRANDOM\fP zostaje jego warto�ci przyporz�dkowana
nast�pna liczba z przypadkowego ci�gu liczb.
Miejsce w danym ci�gu mo�e zosta� ustawione nadaj�c
warto�� \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy�lny parametr dla komendy
\fBread\fP, je�li nie pozostan� podane jej �adne nazwy.
Sotsowany r�wnie� we wst�gach \fBselect\fP do zapisu warto�ci
wczytywanej ze standardowego wej�cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Sekundy, kt�re up�yn�y od czasu odpalenia otoczki, lub je�li
parametrowi zosta�a nadana warto�� ca�kowita, ilo�� sekund od czasu
nadania tej warto�ci plus dana warto��.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy nastawiony na pozytywn� warto�� ca�kowit�, wi�ksz� od zera,
w�wczas ustala w interkacyjnej otoczce czas w sekundach, przez jaki
b�dzie ona czeka�a na wprowadzenie po wy�wietleniu pierwszorz�dnego
zach�cacza (\fBPS1\fP).  Po przekroczeniu tego czasu otoczka zostaje 
opuszczona.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog w kt�rym tymczasowe pliki otoczki zostaj� umieszczone.
Je�li dany parametr nie zosta� nastawiony, lub gdy nie zawiera 
pe�nego tropu zapisywalnego katalogy, w�wczas domy�lnie tymczasowe
pliki mieszcz� si� w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je�li zosta� nastawiony, ustala tryb edycji wiersza komend w otoczkach
interakcyjnych. Je�li sotatni cz�onek tropu podanego w danym
parametrze zawierz ci�g znak�w \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odopiwednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie Szlaczk�w"
Roziwaje szlaczk�w, kt�re ma miejsce r�wnolegle do podstawie� parametr�w,
zostaje wykonane na s�owach rozpoczynaj�cych si� niewycytowanym
\fB~\fP.  Znaki po szlaczku do pierwszego
\fB/\fP, je�li wyst�puje takowy, s� domy�lnie traktowane jako
nazwa u�ytkownika.  Je�li nazwa u�ytkownia jest pusta, to \fB+\fP lub \fB\-\fP,
warto�� parametr�w \fBHOME\fP, \fBPWD\fP, lub \fBOLDPWD\fP zostaje
odpowiednio podstawiona.  W przeciwnym razie zostaje 
przeszukany plik kod�w dost�pu w celu odnalezienia danej nazwy
u�ytkownika, i w miejsce rozwini�cia szlaczka zostaje
podstawiony katalog domowy danego u�ytkownika
Je�li nazwa u�ytkownika nie zostaje odnalezione w pliku hase�,
lub gdy jakiekolwiek wycytowanie albo podstawienie parametru
wyst�puje  w nazwie u�ytkownika, w�wczas nie zostaje wykonane �adne 
podstawienie.
.PP
W nastawieniach parametr�w
(tych poprzedzaj�cych proste komendy lub tych wyst�puj�cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie szlaczk�w zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP), i nazwy u�ytkownik�w zostaj� uj�te
w dwukropki.
.PP
Katalogi domowe poprzednio rozwinietych nazw u�ytkownik�w zostaj�
umieszczone w pami�ci podr�cznej i w ponownym u�yciu zostaj� stamt�d
pobierane.  Komenda \fBalias \-d\fP mo�e by� u�yta do wylistowania, 
zmiany i dodawnia do tej pami�ci podr�cznej
(\fIw szczeg�lno�ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie Nawias�w (przemiany)"
Rozwini�cia nawias�w przyjmuj�ce posta�
.RS
\fIprefiks\fP\fB{\fP\fIci�g\fP1\fB,\fP...\fB,\fP\fIci�g\fPN\fB}\fP\fIsuffiks\fP
.RE
zostaj� rozwini�te w N wyraz�w, z kt�rych ka�dy zawiera konkatenacj�
\fIprefiks\fP, \fIci�g\fPi i  \fIsuffiks\fP
(\fIw szczeg�no�ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwini�te do czterech wyraz�w:
ace, abXe, abYe, and ade).
Jak ju� wy�ej wspomniano, rozwini�ci nawias�w mog� by� nak�adane na siebie
i wynikaj�ce s�owa nie s� sortowane.
Wyra�enia nawiasowe musz� zawiera� niewycytowany przecinek
(\fB,\fP) aby nast�pi�o rozwijanie
(\fItak wi�c\fP, \fB{}\fP i \fB{foo}\fP nie zostaj� rozwini�te).
Rozwini�cie nawias�w nast�puje po podstawnieniach parametr�w i przed
generacj� nazw plik�w
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce Nazw Plik�w"
.PP
Wzorcem nazwy pliku jest s�owo zwieraj�ce jeden lub wi�cej z 
niewycytownych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.  
Po wykoaniu rozwini�ci� nawias�w, otoczka zamienia wzorce nazw plik�w
na uporz�dkowane nazwy plik�w kt�re pod nadym wzorzec pasuj�
(je�li �adne pliki nie pasuj�, w�wczas dane s�owo zostaje pozostawione
bez zmian).  Elemety wzorc�w posiadaj�nast�puj�ce znaczenia:
.IP \fB?\fP
obejmuje dowolny pojedy�czy znak.
.IP \fB*\fP
obejmuje dowoln� sekwencj� znaczk�w.
.IP \fB[\fP..\fB]\fP
obejmuje ka�dy ze znaczk�w pomi�czy klamrami.  Zakresy znaczk�w mog�
zosta� podane rozczielajac dwa znaczki poprzez \fB\-\fP, \fItzn.\fP,
\fB[a0\-9]\fP objemuje liter� \fBa\fP lub dowoln� cyfr�.
Aby przedstawi� sam znak
\fB\-\fP nale�y go albo wycytowa� albo musi by� to pierwszy lub ostatni znak
w li�cie znak�w.  Podobnie \fB]\fP musi by� wycytowywane albo pierwszym
lub ostatnim znakiem w li�cie je�li ma oznacza� samego siebie a nie zako�czenie
listy.  R�wnie� \fB!\fP wyst�puj�cy na pocz�tmu listy posiada specjalne
znaczenie (patrz poni�ej), tak wi�c aby reprezentowa� samego siebie
musi zosta� wycytowny lub wyst�powa� dalej w li�cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko, �e obejmuje dowolny znak
nie wyst�puj�cy pomi�dzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka�dy ci�g zawierajacy zero lub wi�cej wyst�pie� podanych wzorc�w.
Przyk�adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci�gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka�dy ci�g znak�w obejumj�cy jedno lub wi�cej wyst�pie� danych
wzorc�w.
Przyk�adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci�gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci�g pusty lub ci�g obejmuj�cy jeden z danych wzorc�w.
Przyk�adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci�gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci�g obejmuj�cy jeden z podanych wzorc�w.
Przyk�adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy��cznie ci�gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ciag nie obejmujacy �adnego z danych wzorc�w.
Przyk�adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci�gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje �adnego ci�gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci�gi (prosz� si� nad tym zastanowi�).
.PP
Prosz� zauwa�y�, �e wzorce w pdksh obecnie nigdy nie obejmuj� \fB.\fP i
\fB..\fP, w przeciwie�stwie do roginalnej otoczki
ksh, Bourn-a sh i bash-a, tak wi�c to b�dziemusia�o si� ewentualnie 
zmieni� (na z�e).
.PP
Prosz� zauwa�y�, �e powy�sze elementy wzorc�w nigdy nie obejmuj� propki
(\fB.\fP) na pocz�tku nazwy pliku ani pochy�ka (\fB/\fP), 
nawet gdy zosta�y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s� obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je�li zosta�a nastawiona opcja \fBmarkdirs\fP, w�wczas, 
wszelkie katalogi wynikaj�ce z generacji nazw plik�w
zostaj� oznaczone zako�czeniowym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znak�w (\fItzn.\fP,
\fB[:\fP\fInazwa-klasy\fP\fB:]\fP wewn�trz wyra�enia typu \fB[\fP..\fB]\fP)
jak narazie nie zosta�y zimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierunkowywanie Wej�cia/Wyj�cia"
Podczas wykonywania komendy, jej standardowe wej�cie, standardowe wyj�cie
i standardowe wyj�cie b��d�w (odpowienio deskryptory plik�w 0, 1 i 2),
zostaj� zwykle dziedziczone po otoczce.
Trzema wyj�taki do tej reg�y s�, komendy w rurociagach, dla kt�rych
standardowe lub standardowe wuj�cie odpowieadaj� tym stalonym przez
rurociag,  komendy asychroniczne stwarzane je�li kontrola prac zosta�a
wy�aczona, dla kt�rych standardowe wej�cie zostaje ustawnioe na
\fB/dev/null\fP, oraz komendy dla kt�rych jedno lub wiele z nast�puj�cych
przekierunkowa� zosta�o nastawione:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj�cie zostaje przekierowane do \fIplik\fP-u.  
Je�li \fIplik\fP nie istnieje, w�wczas zostaje stworzony; 
je�li istnieje i jest to regularny plik oraz zosta�a nastawiona
opcja \fBnoclobber\fP, w�wczas wyst�puje b��d, w przeciwnym razie
dany plik zostaje odci�ty do pocz�tku.
Prosz� zwr�ci� uwag� i� oznacza to, �e komenda \fIjaka� < foo > foo\fP 
otworzy plik \fIfoo\fP do odczytu a nazt�pnie
stasuje jego zawarto�� gdy otworzy go do zapisu,
zanim \fIjaka�\fP otrzyma szans� wyczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e zawarto�� pliku zostaje skasowana
niezale�nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko �e je�li dany plik ju� istnieje
zostaje on rozszerzany zamiast kasowania poprzedniej jego zawaro�ci.  
Ponad to plik ten zostaje otwarty w trybie rozszerzania, tak wi�c
wszelkiego rodzaju operacje zapisu na nim dotycz� jego aktualnego ko�ca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej�cie zostaje przekierunkowane na \fIplik\fP, 
kt�ry zostaje otorzony do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko �e plik zostaje otworzony w trybie
wpisu i czytanie.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj�cego tego rodzaju przekierunkowanie
(zwane tu-dokumentem), otoczka kopiuje wiersze z komendy
do tymczasowego pliku a� po natrafienie na wiersz
odpowiadaj�cy \fIznacznik\fPowi.
podczas wykonywania komendy standardowe wej�cie zostaje przekierunkowane
na dany plik tymczasowy.
Je�li \fIznacznik\fP nie zawiera wycytowanych znak�w, zawarto�� danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera�a si� w 
podwujnych cudzys�owach za, ka�dym razem gdy dana komenda zostaje wykonana.
Tak wi�c zostaj� na nim wykonane podstawienia parametr�w,
komend i arytmetyczne wraz z interpretacj� wstecznego pochylnika 
(\fB\e\fP) i znak�w wyj�� dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enewline\fP.
Je�li wiele tu-dokument�w zostaje zastosowanych w jednym i tymsamym
wierszy komendy, w�wczas zostaj� one zachowane w podanej kolejno�ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko �e pocz�tkowe tabulatory
zostaj� usuni�te w tu-dokumencie.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej�cie zostaje powielone  z deskryptora pliku \fIfd\fP.
\fIfd\fP mo�e by� pojedy�cz� cyfr�, wskazuj�c� na number
istniej�cego deskryptora pliku, literk�  \fBp\fP, wskazujac� na plik
powi�zany w wyj�ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj�cym, �e standardowe wej�cie powinno zosta�
zamkni�te.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko �e operacja dotyczy standardowego wyj�cia.
.PP
W ka�dym z powy�szych przekierunkowa�, mo�e zosta� podany jawnie deskryptor
pliku, kt�rego ma ono dotyczy�, (\fItzn.\fP, standardowego wej�cia
lub standard wyj�cia) poprzez poprzedzaj�c� odpowiedni� pojedy�cz� cyfr�.
podstawienia paramert�r komend, arytmetyczne, szlaczk�w tak jak i
(gdy otoczka jest interakcyjna) generacje nazw plik�w wszystkie 
zostaj� wykonane na argumentach przekierowa� \fIplik\fP, \fInacznik\fP 
i \fIfd\fP.
Prosz� jednak zwr�ci� uwag�, i� wyniki wszelkiego rodzaju przekierunkowa� 
plik�w zostaj� jedynie u�yte je�li zawieraj� jedynie nazw� jednego pliku;
je�li natomiast obejmuj� one wiele plik�w, w�wczas zostaje zastosowane
dane s�owo bez rozwini�c wynikaj�cych z generacji nazw plik�w.
prosz� zwr�ci� uwag�, i� w otoczkach ograniczonych, 
przekierunkowania tworz�ce nowe pliki nie mog� by� stosowane.
.PP
Dla prostych komend, przekierunkowania mog� wyst�powa� w dowolnym miejscu
komendy, w komendach z�o�onych (wyra�eniach \fBif\fP, \fIitp.\fP), 
wszelkie przekierunkowani musz� znajdowa� si� na ko�cu.
Przekierunkowania s� przetwarzane po tworzeniu ruroci�g�w i w kolejno�ci
w kt�rej zosta�y podane, tak wi�c
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy�wietli b��d z numerem lini wiersza poprzedzaj�cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra�enia Arytmetyczne"
Ca�kowite wyra�enia arytmetyczne mog� by� stosowane przy pomocy
komendy \fBlet\fP, wewn�trz wyra�e� \fB$((\fP..\fB))\fP,
wewn�trz dereferencji �a�cuch�w (\fIw szczeg�lno�ci\fP, 
\fInzwa\fP\fB[\fP\fIwyra�enie\fP\fB]\fP),
jako numerbyczne argumenty komendy \fBtest\fP,
i jako warto�ci w przyporz�dkowywaniach do ca�kowitych parametr�w.
.PP
Wyra�enia mog� zawiera� alfa-numeryczne identyfikatory parametr�w,
dereferencje �a�cuch�w i ca�kowite sta�e. Mog� zosta� r�wnie�
po��czone nast�puj�cymi operatorami j�zyka C:
(wymienione i ugrupowane z kolejno�ci odpowiadaj�cej zwi�kszonej
ich precedencji).
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
Operatory trinarne:
\fB?:\fP (precedencja jest bezpo�redino wy�sza od przyporz�dkowania)
.TP
Operatory grupuj�ce:
\fB( )\fP
.PP
Sta�e ca�kowite mog� zosta� podane w dowolnej bazie, stosuj�c notacj�
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesi�tn� liczb�
ca�kowit� specyfikuj�c� baz�, a \fIliczba\fP jest liczb�
zapisan� w danej bazie.
.LP
Operatory zostaj� wyliczane w nastepuj�cy spos�b:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy��cznie dla pe�no�ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je�li argument jest zerowy, a 0 je�li nie.
.IP "\fB~\fP"
arithmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi by� zastosowanym do parametru (a nie litera�u lub
innego wyra�enia) - parametr zostaje powi�kszony o 1.
Je�li zosta� zastosowany jako operator prefiksowy, w�wczas wynikiem jest 
inkrementowana warto�� parametru, a je�li zosta� zastosowany jako
operator postfiksowy, to wynikiem jest pierwotna warto�� parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko, �e wynikiem jest dekrement parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra�enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nast�pnie prawa strona. Wynikiem jest warto��
wyra�enia po prawej stronie.
.IP "\fB=\fP"
przyporz�dkowanie; zmiennej po lewej zostaje nadana warto�� po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatoray przyporz�dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP 
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je�il przynajmniej jeden 
z argument�w jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je�li obydwa argumenty s� niezerowe, 
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewey jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkacja (bit-w-bit).
.IP "\fB==\fP"
r�wno��; wynikiem jest 1, je�li obydwa argumenty s� sobie r�wne, 0 gdy nie.
.IP "\fB!=\fP"
nier�wno�c; wynikiem jest 0, je�li obydwa arguemnty s� sobie r�wne, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je�li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub r�wne, wieksze lub r�wne, wi�ksze od.  Patrz <.
.IP "\fB<< >>\fP"
przesu� w lewo (prawo); wynikiem jst lewy argument z bitami przesuni�tymi
na lewo (prawo) o ilo�� p�l podan� w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, r�nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego arguemntu prze prawy.  
Znak wyniku jest nieustalony, je�li jeden z argument�w jest negatywny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je�li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to ruroci�g stworzony poprzez operator \fB|&\fP,
kt�ry jest asynchronicznym proecsem do kt�rego otoczka mo�e 
zr�wno pisa� (u�ywaj�c \fBprint \-p\fP) i czyta� (u�ywaj�c \fBread \-p\fP).
Wej�cie i wyj�cie koprocesu mog� by� ponadto manipulowane
przy pomocy przekietowa� \fB>&p\fP i odpowiednio \fB<&p\fP.
Po odpaleniu koprocesu, nast�pne nie mog� by� odpalane zanim
dany koproces zako�czy prac�, lub zanim wej�cie kopocesu
nie zosta�o przekierowane poprzez \fBexec \fP\fIn\fP\fB>&p\fP.
Je�li wej�cie koprocesu zostaje przekierowane w ten spos�b,
w�wczas nast�pny w kolejce do odpalenia koproces b�dzie
wsp�ldzieli� wyj�cie z pierwszym koprocesem, chyba �e wyj�cie pierwszego
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
deskryptora (\fIw szczeg�lno�ci\fP, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby kopreocesy m�g�y wsp�dzieli� jedno wyj�cie, otoczka musi
zachowa� otwart� cz�ci wpisow� danego ruroci�gu wyj�ciowego.
Oznacza to, �e zako�czenie pliku nie zostanie wykryte do czasu a�
wszystkie koprocesy wsp�dziel�ce wyj�cie koproces�w zostan� zako�czone
(gdy zostan� one zako�czone, w�wczas  otoczka zamyka swoj� kopi�
ruroci�gu).
Mo�na temu zapobiec przekierunkowuj�ca wyj�cie na numerowany
deskryptor pliku
(poniewa� powoduje to r�wnie� zamkni�cie przez otoczk� swojej kopi).
Prosz� zwr�ci� uwag� i� to zachowani� si� jest nieco odmienne od orginalnej
otoczki Korn-a, kt�ra zamyka swoj� cz��� zapisow� swojej kopi wyj�cia
koprocesu, gdy ostatnio odpalony koproces 
(zamiast gdy wszystkie wsp�dziel�ce koprocesy) zostanie zako�czony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna�u SIGPIPE poczas zapisu, je�li
dany sygna� nie zosta� od�apany lub zignorowany; nie zachodzi to jednak
, gdy wej�cie koprocesu zosta�o powielone na inny deskryptor pliku
i sotsowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje si� albo przy pomocy syntaktyki otoczki
Korn-a \fBfunction\fP \fIname\fP,
albo syntaktyki otoczki Bourn-a/POSIX-owej \fIname\fP\fB()\fP
(patrz poni�ej co do r�nic zachodz�cych pomi�dzy tymi dwoma formami).
Funkcje, tak jak i \fB.\fP-skrypty, zostaj� wykonywane w bierz�cym
otoczeniu, aczkolwiek, w przeciwie�stwie do \fB.\fP-skrypt�w,
argumenty otoczki
(\fItzn.\fP, argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) niegdy nie s�
widoczne wewn�trz nich.
Podczas ustalania lokacji komendy funkcje s� przeszukiwane po przeszukani
specjalnych wbydowanych komend i przed regularnymi oraz nieregularnymi
komendami wbudowanymi, a zanim \fBPATH\fP zostanie przeszukany.
.PP
Istniej�ca funkcja mo�e zosta� usuni�ta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
List� funkcji mo�na otrzyma� poprzez \fBtypeset +f\fP, a definicje
funkcji mo�na otrzyma� poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo�e zosta�
u�yte do tworzenia niezdefiniowanych funkcji;
je�li ma by� wykonana niezdefiniowana funkcja, w�wczas otoczka
przeszukuje trop podany w parametrze \fBFPATH\fP za plikiem o nazwie
identycznej do nazwy danej funkcji, kt�ry, gdy zostanie odnaleziony 
takowy, zostaje wczytany i wykonany.
Je�li po wykonaniu tego pliku dana funkcja b�dzie zdefiniowany, w�wczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk�e
odnajdywanie komend
(\fItzn.\fP, otoczka przeszukuje tablic� zwyk�ych komend wbudowanych
i \fBPATH\fP).
Prosz� zwr�ci� uwag�, �e je�li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, w�wczas zostaje podj�ta pr�ba odnalezienia
funkcji poprzez \fBFPATH\fP (jest to niezdokumentowanym zachowaniem
si� orginalnej otoczki Korn-a).
.PP
Funkcje mog� mie� dwa atrybuty �ledzenia i eksportowania, kt�re
mog� by� ustwaieane przez \fBtypeset \-ft\fP i odpowiednio 
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji �ledzonej, opcja \fBxtrace\fP otoczki
zostaje w��czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy��czona.
Atrybut exportowania nie jest obecnie u�ywany.  W orginalnej
otoczce Korn-a, wyexportowane funkcje s� widoczne dla skryt�w otoczki,
gdy s� one wykonywane.
.PP
Poniewa� funckje zostaj� wykonywane w obecnym konketscie otoczki,
przyporz�dkowania parametr�w wykonane wewn�trz funkcji pozostaj�
widoczne po zako�czeniu danej funkcji.
Je�li jest to nieporz�dane, w�wczas komenda \fBtypeset\fP mo�e
by� zastosowana wewn�trz funkcji do tworzenia lokalnych parametr�w.
Prosz� zwr�cic uwag� i� specjale parametry
(\fItzn.\fP, \fB$$\fP, \fB$!\fP) nie mog� zosta� ograniczone w 
ich widoczno�ci w ten spos�b.
.PP
Statusem zako�czeniownym kuncji jest status ostatniej
wykonanej w niej komendy.
Funkcj� mo�na przerwa� bezpo�redino przy pomocy komendy \fBreturn\fP;
mo�na to r�wnie� zastosowa� do jawnej specyfikacji statusu zako�czenia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s�owa \fBfunction\fP, s�
traktowane odmiennie w nast�puj�cych punktach od funkcji zdefiniowanych
poprzez notacj� \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje nastawiony na nazw� funkcji
(funkcje w stylu Bourne-a nie tykaj� \fB$0\fP).
.IP \ \ \(bu
przyporz�dkowania warto�ci parametrom poprzedzaj�ce wywo�anie
funkcji nie zostaj� zaczowane w bierz�cym kontekscie otoczki
(wykonywanie funkcji w stylu Bourne-a functions zachowuje te
przyporz�dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostake zachowany i skasowany 
na pocz�tku oraz nast�pnie odtworzony na zako�czenie funkcji, tak wi�c
\fBgetopts\fP mo�e by� poprawnie stosowane zar�wno wewn�trz jak i poza
funkcjami
(funkcje w stylu Bourne-a nie tykaj� \fBOPTIND\fP, tak wi�c
stosowanie \fBgetopts\fP wewn�trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.nr PD \n(P2
W przysz�o�ci nast�puj�ce r�nice zostan� r�wnie� dodane:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Oddzielny kontekst �ledznia/sygna��w b�dzie stosowany podczas sykonywania
funkcji.
Tak wi�c �ledzenia nastawione wewn�trz funkcji nie b�d� mia�y wp�ywu 
na �ledzenia i sygna�y otoczki nie ignorowane przez ni� (kt�re mog�
by� przechwytywane) b�d� mia�y domy�lne ich znaczenie wewn�trz funkcji.
.IP \ \ \(bu
�ledzenie EXIT-a, je�li zostanie nastawione wewn�trz funkcji, 
zostanie wykonane, po zako�czeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana otoczka ma by� w zasadzie zgodna ze standardem POSIX, 
aczkolwiej jednak, w niekt�rych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem orginalnej
otocznik Korn-a albo wygod� u�ytkownika.
Jak otoczka zachowuje si� w takich wypadkach jest ustalane poprzez
status opcji posix (\fBset \-o posix\fP) \(em je�li jest ona
w��czona w�wczas zachowuje si� zgodnie z POSIX-em, a w przeciwnym 
razie nie.
Opcja \fBposix\fP zostaje automatycznie nastawiona je�li otoczka startuje
w otoczeniu zawieraj�cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Otoczk� mo�na r�wnie� skompilowa� tak aby zachowanie zgodne z
POSIX-em by�o domy�lnie ustawione, aczkolwiek jest to zwykle 
nieporz�dane).
.PP
A oto lista wp�yw�w ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn�trz wycytowanych podw�jnymi cuczys�owami \fB`\fP..\fB`\fP 
podstwie� komend:
w trybie posix-owym, the \fB\e"\fP zostaje zinterpretowane podczas interpretacji
komendy;
w trybie nie posix-ownym, pochy�ek w lewo zostaje usuniety przed
interpretacj� podstawienia komendy. 
Przyk�adowo \fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie posix-owym, `hi' a w trybie nie-posix-owym.  
W celu unikni�cia problem�w prosz� stosowa� posta� \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
\fBkill \-l\fP wyj�cie: w trybie posix-owym, nazwy sygna�ow
zostaj� wymieniane wiersz po wierszu;
w nie-posix-owym trybie, numery sygna��w ich nazwy i opis zostaj� wymienione
w kolumnach.
W przysz�o�ci nowa opcja zostanie dodana (pewnie \fB\-v\fP) w celu
rozr�nienia tych dw�ch zachowa�.
.IP \ \ \(bu
\fBfg\fP status zako�czenia: w trybie posix-owym, status zako�czenia wynosi
0, je�li nie wyst�pi�y �adne b��dy;
w trybie nie-posix-owym, status zako�czeniowy odpowiada statusowi
ostatniego zadania wykonywanego w pierwszym planie.
.IP \ \ \(bu
\fBgetopts\fP: w trybie posix-owym, optcje musz� zaczyna� si� od \fB\-\fP;
w trybie nie-posix-owym, opcje mog� si� zaczyna� od albo \fB\-\fP albo \fB+\fP.
.IP \ \ \(bu
rozwijanie nawias�w (zwane r�wnie� przemian�): w trybie posix opwym, 
rozwijanie nawias�w jest wy��czoen; w trybie nie-posix-owym, 
rozwijanie nawias�w jest w��czone.
Prosz� zauwa�y�, �e \fBset \-o posix\fP (lub nastawienie 
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy��cza opcj� \fBbraceexpand\fP, mo�e ona by� jednak jawnie
w��czona pu�niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie posix-owym, nie wy��cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-posix-owym, wy��cza.
.IP \ \ \(bu
\fBset\fP status zako�czenia: w trybie posix-owym, 
status zako�czenia wynosi 0, je�li nie wyst�pi�y �adne b��dy; 
w trybie nie-posix-owym, status zako�czeniowy odpowiada statusie
wszelkich podstawieb komend wykonywanych podczas
generacji komendy set.
Przyk�adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie posix,
a 1 w tybie nie-posix.  Ten konstrukt jest stosowany w wi�kszo�ci
skrytp�w otoczji stosujacych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argument�w dla komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP, i
\fBtypeset\fP: w trybie posix-owym, nast�puje normalme rozwijanie argument�w;
w trybie nie-posix-owym, rozdzielanie p�l, rozszerzanie plik�w, 
rozwijanie nawias�w i (zwyk�e) rozwijanie szlaczk�w s� wy��czone, oraz
rozwijanie szlaczk�w w przyporz�dkowania pozostaje w��czone.
.IP \ \ \(bu
specyfikacja sygna��w: w trybie posix-owym, signa�y mog� by�
podawane jedynie cyframi, je�li numery sygna��w s� one zgodne z 
warto�ciami z POSIX-a (\fItzn.\fP, HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14, and TERM=15); w trybie nie-posix-owym, 
sygna�u mog� zawsze cyframi.
.IP \ \ \(bu
rozwijanie alias�w: w trybie posix-owym, rozwijanie alias�w
zostaje jedynie wykonywane, podczas wczytywania s��w komend; w trybie 
nie-posix-owym, rozwijanie alias�w zostaje wykonane r�wnie� na
ka�dym s�owie po jakim� aliasie, kt�re ko�czy si� bia�� przerw�.
Przyk�adowo w nast�puj�ca wst�ga for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u�ywa parameteru \fBi\fP w tybie posix-owym, natomiast \fBj\fP w
trybie nie-posix-owym.
.IP \ \ \(bu
test: w trybie posix-owym, wyra�enia "\fB-t\fP" (poprzedzone pewn�
ilo�ci� argument�w "\fB!\fP") zawsze jest prawdziwe, gdy� jest
ci�giem o d�ugo�ci niezerowej; w nie-posix-owym trybie, sprawdza czy
descryptor pliku 1 jest jakim� tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo�e zosta� pomini�ty i jest
domy�lnie r�wny 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie Komend"
Po wyliczeniu argument�w wiersza komnedy, wykonaniu przekierunkowa�
i przyporz�dkowa� parametr�w, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku kt�ry nale�y wykona� przy pomocy parametru
\fBPATH\fP.
Testy te zostaj� wykonane w wy�ej podanym porz�dku.
Specjalne wbudowane komendy r�ni� si� tym od innych komend, 
�e pramert \fBPATH\fP nie jest u�ywany do ich odnalezienie, b��d
podczas ich wykonywania mo�e spowodowa� zako�czenie nieinterakcyjnej
otocz i przyporz�dkowania wartosci parametr�w poprzedzaj�ce
komend� zostaj� zachowane po jej wykonaniu.
Aby tylko wprowadzi� zamieszanie, je�li opcja
posix zosta�a w��czona (patrz komenda \fBset\fP
poni�ej) pewne specjale komendy staj� si� bardzo specjalne, gdy�
nie wykonywane s� rozdzielanie p�l, rozwijanie nazw plik�w,
rozwijanie nawias�w ani rozwijanie szlaczk�w na argumentach, 
kt�re wygl�daj� jak przyporz�dkowania.
Zwyk�e wbudowane komendy wyr�niaj�si� jedynie tym,�e
parametr \fBPATH\fP nie jest stosowany do ich odnalezienia.
.PP
Orignalny ksh i POSIX r�ni� si� nieco w tym jakie
komendy s� traktowane jako specjalne a jakie jako zwyk�e:
.IP "Specjalne komend w POSIX"
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
.IP "Bardzo specjalne komendy (tyb nie-posix-owy)"
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
W przysz�o�ci dodatkowe specjalne komendy ksh oraz regularne komendy
mog� by� traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz�dkowania warto�ci parametr�w
zostaj� wykonane i wyeksportowane na czas trwania komendy.
.PP
W nast�puj�cym opisujemy specjalne i regularne komendy wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wyknoaj komendy w \fIplik\fP w bierz�dym otoczeniu.
Plik zostaje odszukiwany przy u�yciu katalog�w z \fBPATH\fP.
Je�li zosta�y podane argumenty, w�wczas parametry pozycyjne mog� by�
u�ywane do dost�pu do nich podczas wykonywania \fIplik\fP-u.
Je�li nie zosta�y podane �adne argumenty, w�wczas argumenty pozycyjne
odpowiadaja tym z bierz�cego otoczenia, w kt�rym dana komenda zosta�a
u�yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Statusem zako�czenia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto��1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
bez argument�w, \fBalias\fP wylicza wszystkie obecne aliasy.
Dla ka�dej nazwy bez podanej warto�ci zostaje wliczony istniej�cy
odpowiedni alias.
Ka�da nazwa z podan� warto�ci� definiuje alias (patrz aliasy Aliases powy�ej).
.sp
podczas wyliczania alias�w mo�na u�y� jednego z dwuch format�w: 
zwykle aliasy s� wyliczane jako \fInazwa\fP\fB=\fP\fIwarto��\fP, przy czym
\fIwarto��\fP jest wycytowana; je�li opcje mia�y przedsionek \fB+\fP 
lub same \fB+\fP zosta�o podane we wierszu komendy, tyko \fInazwa\fP
zostaje wy�wietlona.
Ponad to, je�li zosta�a zstosowana opcja \fB\-p\fP, ka�dy wiersz zostaje
zacz�ty dodtakowo od ci�gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP nastawia, (a \fB+x\fP kasuje) atrybut eksportu dla aliasa,
lub, je�li nie podano �adnych nazw, wylicza aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma posiada �adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, �e �ledzone aliasy maj� by� wyliczone ustawione
(warto�ci podane we wierszu komendy zostaj� zignorowane dla �ledzonych
alias�w).
Opcja \fB\-r\fP wskazuje, �e wszystkie �ledzone aliasy
maj� zosta� usuni�te.
.sp
Opcja \fB\-d\fP nakazuje wyliczenie lub ustawienie alias�w katalog�w, 
kt�re s� stosowane w rozwini�cziach szlaczk�w
(patrz Rozwini�cia Szlaczk�w powy�ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je�li nie podana �adnego zadaniam w�wczas przyjmuje si� domy�lnie \fB%+\fP.
Ta komenda jest jeynie dost�pna na systemach wspomagaj�cych kontrol� zada�.
Patrz Kontrola Zada� poni�ej co do dalszych informacji.
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Nastawienie lub wyliczenie obecnych przyporz�dkowa� klwaiszy/mark w 
emacs-owym trybie edycji komend.
Patrz Emacs-owa Interakcyjna Edycja Wiersza Komendy w celu pe�nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fPth zagnie�d�enia we wst�gach
for, select, until, lub while.
\fIpoziom\fP wynosi domy�lnie 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan� komend� \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.  
Je�li zosta� nastawiony parameter \fBCDPATH\fP, to wypisuje
list� katalog�w, w kt�rych nale�y szuka� pod-\fIkatalog\fP.
Pusta zawarto�� w \fBCDPATH\fP oznacza katalog bie��cy.
Je�li niepusty katalog z \fBCDPATH\fP zostanie zastosowany,
w�wczas zostanie wy�wietlony pe�ny wynikaj�cy trop na standardowym
wyj�ciu.
Je�li nie podano \fIkatalog\fP, w�wczas
zostaje u�yty katalog domowy \fB$HOME\fP.  Je�li \fIkatalog\fP-iem jest
\fB\-\fP, to porzedni katalog roboczy zostaje zastosowany (patrz
parametr OLDPWD).
Je�li u�yto opcji \fB\-L\fP (logiczny trop) lub je�li opcja \fBphysical\fP
nie zosta�a nastawiona
(patrz komenda \fBset\fP poni�ej), w�wczas odniesienia do \fB..\fP w 
\fIkatalogu\fP s� wzgl�dnymi wobec tropu zastosowanego do doj�ci� do danego
katalogu.
Je�li podano opcj� \fB\-P\fP (fizyczny trop) lub gdy zosta�a nastawiona
opcja \fBphysical\fP, w�wczas \fB..\fP jest wzgl�dne wobec drzewa katalog�w 
systemu plik�w.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj� uaktualnione taki, aby odpowiednio
zawiera�y bie��cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci�g \fInowy\fP zostaje podstawiony wzamian za \fIstary\fP w bie��cym
katalogu, i otoczka pr�buje przej�� do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je�li nie zosta�a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, w�wczas
\fIkomenda\fP
zostaje wykonana dok�adnie tak jakby nie podano \fBcommand\fP,
z dwoma wyj�takami: po pierwsze, \fIkomenda\fP nie mo�e by� funkcj� w otoczce,
oraz po drugie, specjalne wbudowane komendy trac� swoj� specjalno�� (\fItzn.\fP,
przekierowania i b��dy w u�yciu nie powoduj�, �e otoczka zostaje zako�czona, a
przyporz�dkowania parametr�w nie zostaj� wykonane).
Je�li podano opcj� \fB\-p\fP, zostaje stosowany pewien domy�lny trop
zamiast obecnej warto�ci \fBPATH\fP (warto�� domy�lna tropu jest zale�na
od systemy w jakim pracujemy: w systemach POSIX-owatych, jest to
warto�� zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je�li podano opcj� \fB\-v\fP, w�wczas zamiast wykonania \fIkomenda\fP, 
zostaje podana informacja co by zosta�o wykonane (i to same dotyczny 
r�wnia� \fIarg1\fP ...):
dla specjalnych i zwyklych wbudowanych komend i funkcji,
zostaj� po prostu wy�wietlone ich nazwy,
dla alias�w, zostaje wy�wietlona komenda definiuj�ca dany alias,
oraz dla komend odnajdownych poprzez przeszukiwanie zawarto�ci
parametru \fBPATH\fP, zostaje wy�wietlony pe�ny trop danej komendy.
Je�li komenda nie zostanie odnaleziona, (\fItzn.\fP, przeszukiwanie tropu
nie powiedzie si�), nic nie zostaje wy�wietlone i \fBcommand\fP zostaje
zako�czone z niezerowym statusem.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko �e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP stacze na pocz�tek \fIpoziom\fP-u z najg��biej
zagnie�d�onej wst�gi for,
select, until, lub while.
\fIlevel\fP domy�lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy�wietla na standardowym wyj�ciu swoje argumenty (rozdzielone przerwami)
zako�czone prze�amaniem wiersza.
Prze�amanie wiersza nie nast�puje je�li kt�rykolwiek z parametr�w
zawiera sekwencj� pochy�ka wstecznego \fB\ec\fP.
Patrz komenda \fBprint\fP poni�ej, co do listy innych rozpoznawanych
sekwencji pochy�k�w wstecznych.
.sp
Nast�puj�ce opcje zosta�y dodane dla zachowania zgodno�ci ze
skryptami z system�w BSD:
\fB\-n\fP wy��cza ko�cowe prze�amanie wiersza, \fB\-e\fP w��cza
interpretacj� pochy�k�w wstecznych (operacja zerowa, albowiem ma to
domy�lnie miejsce), oraz \fB\-E\fP wy��czaj�ce interpretacj�
pochy�k�w wstecznych.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Zrgumenty zostaj� powi�zane (z przerwami pomi�dzy nimi) do jednego
ci�gu, kt�ry nast�pnie otoczka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez forkowania, zast�puj�c proces otoczki.
.sp
Je�li nie podano �adnych argument�w wszelkie przekierowania wej�cia/wyj�cia
s� dozwolone i otocznia nie zostaje zast�piona.
Wszelkie deskryptory plik�w wi�ksze ni� 2 otwarte lub z\fIdup\fP(2)-owane
w ten sops�b nie s� dost�pne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbydownych w otoczk�).
Prosz� zwr�ci� uwag� i� otoczka Bourne-a r�ni si� w tym: 
przekazuje bowiem deskryptory plik�w.
.\"}}}
.\"{{{  exit [status]
.IP "\fBexit\fP [\fIstatus\fP]"
Otoczka zostaje zako�czona z podanym statusem.
Je�li \fIstatus\fP nie zosta� podany, w�wczas status zako�czenia
przyjmuje bie��c� warto�� parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Nastawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj� przekazywane w otoczeniu do wykonywanych
komend.
Je�il podano warto�ci w�wczas zostaj� one r�wnia� przyporz�dkowany
danym parametrom.
.sp
Je�li nie podano �adnych parametr�, w�wczas nazwy wszystkich parametr�w
z atrybutem eksportu zostaj� wy�wietlone wiersz po wierszu, chyba �e u�yto
opcji \fB\-p\fP, w kt�rym to wypadu zostaj� wy�wietlone komendy
\fBexport\fP definiuj�ce wszystkie eksportowane parametry wraz z ich
warto�ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda ko�cz�ca si� z niezerowym statusem.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj� komendy z histori.
Komendy mo�emy wybiera� przy pomocy ich numeru w historji
lub podaj�c ci�g znak�w okre�laj�cy ostatnio u�yt� komend� rozpoczynaj�c�
si� od tego� ci�gu.
Opcja \fB\-l\fP wy�wietla dan� komend� na stdout,
a \fB\-n\fP wy��cza domy�lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno�� koemnd w li�cie historji.  Bez \fB\-l\fP, wybrane
komendy podlegaj� edycji przez edytor podany poprzez opcj�
\fB\-e\fP, albo je�lki nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je�li nie zosta� nastawiony ten
parametr, w�wczas sotsuje si� \fB/bin/ed\fP),
i nast�pnie wykonana przez otoczk�.
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran� konend� (domy�lnie poprzedni� komend�) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je�li
podano \fB\-g\fP, w�wczas wszelkie wysotmpienia \fIstare\fP zostaj�
zast�pione przez \fInowe\fP.  Z tej komendy ko�ysta si� zwykle
przy pomocy zdefiniowanego domy�lnie aliasa \fBr='fc \-e \-'\fP.
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
\fBgetopts\fP jest stosowany przez procedury otoczki
do rozeznawania podanych argument�w
(lub parametr�w pozycyjnychi, je�li nie podano �adnych argument�w)
i do sprawdzenia zasadno�ci opcji.
\fIci�gopt\fP zawiera litery opcji, kt�re 
\fBgetopts\fP ma rozpoznawa�.  Je�li po literze wyst�puje przecinek,
w�wczas oczekuje si�, �e opcja posiada argument.
Opcje nieposiadaj�ce argument�w mog� by� grupowane w jeden argument.
Je�li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w kt�rym si� znajduje, w�wczas reszta argumentu 
zsotaje potraktowana jako argument danej opcji. W przeciwnym razie
nast�pny argument jest argumentem opcji.
.sp
Za ka�dym razem, gdy zostaje wywo�ane \fBgetopts\fP, 
umieszcza si� nast�pn� opcj� w parametrze otoczki
\fInazwa\fP i indeks nast�pnego argumentu pod obr�bk�
w parmaetrze otoczki \fBOPTIND\fP.
Je�li opcja zosta�a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z prefiksem \fB+\fP.
Je�li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze otoczki \fBOPTARG\fP.
Je�li natrafi si� na niedopuszczaln� opcj� lub brakuje
argumentu opcji, w�wczas znak zapytania albo dwukropek zostaje
umieszczony w \fInazwa\fP
(wskazuj�c na nielegaln� opcj�, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje nastawiony na znak kt�ry by� przyczyn� tego problemu.
Ponadto zostaje w�wczas wy�wietlony komunikat o b��dzie na standardowym
wyj�ciu b��d�w, je�li \fIci�gopt\fP nie zaczyna si� od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa prac�
niezerowym statusem zako�czenia.
Opcje ko�cz� si� na pierwszym (nie podlegaj�cym opcji) argumencie,
kt�ry nie rozpoczyna si� od \-, albo je�li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawania opcji mo�e zosta� ponowione ustawiaj�c \fBOPTIND\fP na 1
(co nast�puje automatycznie za ka�dym razem, gdy otoczka lub 
funkcja w otoczce zostaje wywo�ana).
.sp
Ostrze�enie: Zmiana warto�ci parametru otoczki \fBOPTIND\fP na
warto�� wi�ksz� ni� 1, lub rozpoznawanie odmiennych zestaw�w
parametr�w bez ponowienia \fBOPTIND\fP mo�e doprowadzi� do nieoczekiwanych
wynik�w.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je�li brak argument�w, w�wczas wszelkie tropy wykonywalnych komend z
kluczem zostaj� wymienione.
Opcja \fB\-r\fP nakazuje wy�ucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka�da \fInazwa\fP zostaje odszukiwana tak jak by to by�a nazwa komedy
i dodna do tablicy kluczy je�li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy�wietlij informacje o danych zadaniach; gdy nie podano �adnych
zada� wszystkie zadania zostaj� wy�wietlone.
Je�li podano opcj� \fB\-n\fP, w�wczas informacje zostaj� wy�wietlone
jedynie o zadaniach kt�rych stan zmieni� si� od czasu ostaniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka�dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, �e zostaje wy�wietlona jedynie
jedynie grupa procesowa kadego zadania.
patrz Kontrola Zada� dla informacji o formie parametru
\fIzdanie\fP i formacie w kt�rym zostaj� wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy�lij dany sygna� do doanych zada�, proces�w z danym id-em, lub grup
proces�w.
Je�li nie podano jawnie �adnego sygna�u, w�wczas domy�lnie zostaje wys�any
sygna� TERM.
Je�li podano zadanie, w�wczas sygna� zostaje wys�any do grupy 
proces�w danego zadnia.
Patrz poni�ej Kontrola Zadab dla informacji o formacie \fIzadania\fP.
.\"}}}
.\"{{{  kill -l [exit-status ...]
.IP "\fBkill \-l\fP [\fIstatus-zako�czenia\fP ...]"
Wypisz nazw� sygna�u, kt�ry zabi� procesy, kt�re zako�czy�y si�
danym \fIstatusem-zako�czenia\fP.
Je�li brak argument�w, w�wczas zostaje wy�wietlona lista
wszelkich sygna��w i ich numer�w, wraz z kr�tkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra�enie\fP ...]"
Ka�de wyra�enie zostaje wyliczone, patrz Wyra�enie Arytmetyczne powy�ej.
Je�li wszelkie wyra�enia zosta�y poprawnie wyliczone,statusem zako�czenia
jest 0 (1), je�li warto�ci� ostatniego wyra�enia
 nie by�o zero (zero).
Je�li wyst�pi b��d podczas rozpoznawania lub wyliczania wyra�enia,
status zako�czenia jest wi�kszy od 1.
Poniewa� m�e zaj�� konieczno�� wycytowania wyra�e�, wi�c
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s�odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy�wietla swe argumenty na standardowym wyj�ciu, rozdzielone
przerwami i zako�czone prze�amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy�lnemu prze�amaniu wiersza. 
Domy�lnie pewne wyprowadzenia z C zostaj� odpowiednio przet�umaczone.
Wsr�d nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0### 
(# oznacza cyfr� w systemie �semkowym, tzn. od 0 po 3).
\ec jest r�wnowa�ne z zastosowaniem opcji \fB\-n\fP.  \e wyra�eniom
mo�na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pilku historji zamiast
standardowego wyj�cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wyno�i domy�lnie 1 przy pomini�ciu), 
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy�ej).
.sp
Opcja \fB\-R\fP jest stowoana do emulacji, w pewnym stopniu, komendy 
echo w wydaniu BSD, kt�ra nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy�ej opcja \fB\-n\fP zapobiega zakonieczeniowemu prze�amaniu
wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bierz�cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta�a nastawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni�ej), zostaje wy�wietlony trop
logiczny (\fItzn.\fP, trop knieczny aby wykona� \fBcd\fP 
do bierz�cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (fizyczny trop) lub gdy
opcja \fBphysical\fP zosta�a nastawiona, zostaje wy�wietlony trop
ustalone przez wystem plik�w (�ledz�c katalogi \fB..\fP
a� po katalog pniowy).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej�cia, rozdziela ten
wiersz na pola przy uwzgl�dnieniu parametru \fBIFS\fP (
patrz Podstawienia powy�ej), i przyporz�dkowywuje pola odpowienio danym 
parametrom.
Je�li mamy wi�cej parametr�w ni� pul, w�wczas dodatkowe parametry zostaj�
ustawione na zero, a natomiast je�li jest wi�cej p�l ni� paramtr�w to
ostatni parametr otrzymuje jako warto�� wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj�cymi przerwami).
Je�li nie podano �adnych parametr�w, w�wczas zostaje zastosowany
parametr \fBREPLY\fP.
Je�li wiersz wprowadzenie ko�czy si� na pochy�ku wstecznym
i nie podano opcji \fB\-r\fP, to pochy�ek wsteczny i prze�amanie
wiersza zostaj� usuni�te i wi�cej wprowadznia zostaje wczytane.
Gdy nie zostanie wczytane �adne wprowadznie, \fBread\fP zaka�cza si�
niezerowym statusem.
.sp
Pierwszy parametro mo�e mie� do��czony znak zapytania i ci�g, co oznacza, �e
dany ci�g zostania zastosowany jako zach�ta do wprowadzenia 
(wy�wietlana na standardowym wyj�ciu b�ed�w zanim
zostanie wczytane jakiekolwiek wprowadzenie) je�li wej�cie jest tty-em
(\fIe.g.\fP, \fBread nco�?'ile co�k�w: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj� �e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bierz�cego ko-procesu 
(patrz komenta�e na ten temat w Ko-procesy powy�ej).
Je�li zastosowano opcj� \fB\-s\fP, w�wczas wprowadznie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto��\fP]] ..."
Patrz parametr wy��cznego odczytu nazwanych parametr�w.
Je�li zosta�y podane warto�ci w�wczas zostaj� one nadane parametrom przed
ustawieniem danego strybutu.
Po nadaniu cechy wy��cznego odczytu parametrowi, nie ma wi�cej mo�liwo�ci
wykasowania go lub zmiany jego warto�ci.
.sp
Je�li nie podano �adnych parametr�w, w�wczas zostaj� wypisane nazwy
wszystkich parametr�w w cech� wy��cznego odczytu wiersz po wierszu, chyba
�e zastosowano opcj� \fB\-p\fP, co powoduje wypisanie pe�nych komend
\fBreadonly\fP definiuj�cych parametry wy��czneg odczytu wraz z ich
warto�ciami.
.\"}}}
.\"{{{  return [status]
.IP "\fBreturn\fP [\fIstatus\fP]"
Powr�t z funkcji lub \fB.\fP scryptu, ze statusem zako�czenia \fIstatus\fP.
Je�li nie podano warto�ci \fIstatus\fP, w�wczas zostaje domy�lnie
zastosowany status ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcji lub \fB.\fP scryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Prosz� zwr�ci� uwag� i� pdksh traktuje zar�wno profile jak i pliki z 
\fB$ENV\fP jako \fB.\fP scrypty, podczas gdy
orginalny Korn shell jedynie profile traktuje jako \fB.\fP scrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s�u�y do nastawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opkcji otoczki, nastawiania prarmetr�w pozycyjnych, lub
nastawiania parametru ci�gowego.
Opcje mog� by� zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe�n� nazw� pewnej opcji, lub stosuj�c posta�
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow�
nazw� danej opcji (niewszystkie opcje posiadaj� jednoliterow� naz�).
Nast�puj�ca tablica wylicza zar�wno litery opcji (gdy mamy takowe), jak i
pe�ne ich nazwy wraz z opisem wp�yw�w danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci�gowego \fInazwa\fP na \fIarg\fP ...;
Je�li zastosowano \fB\-A\fP, ci�g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je�li zastosowano \fB+A\fP, zastaj� nastawione pierwsze N element�w (gdzie N
jest ilo�ci� \fIarg\fPs�w), reszta pozostaje niezmienioa.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj� tworzone z cecha eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu� przed zach�t�.
Ma tylko znaczenia je�li zosta�a w��czona kontrola zada� (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej�cych ju� plik�w poprzez przekierunkowania
\fB>\fP (\fB>|\fP musi zosta� zastosowane do wymuszenia przepisania).
T}
\-e	errexit	T{
Wyjd� (po wykoaniu komendy pu�apki \fBERR\fP) tu� po wyst�pieniu
b��du lub niepomy�lnym wykoaniu jakiej� komendy
(\fItzn.\fP, je�li zosta�a ona zako�czona niezerowym statusem).
Niedotyczy to komend kt�rych status zako�czenia zostaje jawnie przetestowny
konstruktem otoczki takim jak wyra�enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorc�w nazw plik�w.
T}
\-h	trackall	T{
Tw� �ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy�ej).
Domy�lnie w��czone dla nieinterakcyjnych otoczek.
T}
\-i	interactive	T{
W��cz tryb interakcyjny \- mo�e zosta� 
w��czone/wy��czone jedynie podczas odpalania otoczki.
T}
\-k	keyword	T{
Przyporz�dkowania warto�ci parametrom zostaj� rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Otoczka ma by� otoczk� zameldowania \- mo�e zosta� 
w��czone/wy��czone jedynie podczas odpalania otoczki
(patrz Odpalania Otoczki powy�ej).
T}
\-m	monitor	T{
W��cz kontrlo� zadab� (domy�lne dla otoczek interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skrypt�w (ignorowane dla interakcyjnych otoczek).
T}
\-p	privileged	T{
Nastawiane automatycznie, je�li gdy otoczka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Otoczki powy�ej dla opisu co to znaczy.
T}
-r	restricted	T{
Nastaw tryb ograniczony \(em ta opcja mo�e zosta� jedynie
zastosowan podczas odpalania otoczki.  Patrz Odpalania Otoczki
dla opisy co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania otoczki, w�wczas komendy
zostaj� wczytywane ze standardowego wej�cia.
Nastawione automatycznie, je�li otoczka zosta�a odpalona bez jakichkolwiek
argument�w.
.sp
Je�li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, w�wczas
podane argumenty zostaj� uporz�dkowane zanim zostan� one przyczielone
parametrom pozycyjnym
(lub ci�gowi \fInazwa\fP, je�li \fB\-A\fP zosta�o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nienastawionego parametru zostaje traktowane jako b��d,
chyba �e jeden z modyfikator�w \fB\-\fP, \fB+\fP lub \fB=\fP 
zosta� zastosowany.
T}
\-v	verbose	T{
Wypisuj wprowadzenia otoczki na standardowym wyj�ciu b��d�w podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz�dkowania parametr�w podczas ich wykonywania
poprzedzone warto�ci� \fBPS4\fP.
T}
\-X	markdirs	T{
Naznaczaj katalogi nast�puj�cym \fB/\fP podczas generacji nazw
plik�w.
T}
	bgnice	T{
Zadania w tle zostaj� wykonywane z ni�szym priorytetem.
T}
	braceexpand	T{
W��cz rozwijanie nawias�w (aka, alternacja).
T}
	emacs	T{
W��cz edycj� wiersza komendy  w stylu BRL emacs-a (dotyczy wy��cznie
otoczek interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W��cz edycj� wiersza koemndy w stylo gmacs-like (Gosling emacs) 
(dotyczy wy��cznie otoczek interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj�tkiem tego, �e przemiana (^T) 
zachowuje si� nieco inaczej.
T}
	ignoreeof	T{
Otoczka nie zostanie zako�czona je�li zostanie wczytany znak zako�czenia
pliku. Nale�y u�y� jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie��cych zada� sygna�em \fBHUP\fP gdy otoczka zameldowania
zostaje zako�czona.
Obecnie nastawione domy�lnie, co si� jednak zmieni w przysz�o�ci w celu
poprawienia kompatybilijnos� z orginalnym Korn shell (kt�ry nie posiada
tej opcji, aczkolwiek wysy�a sygna� \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w originalej otoczce Korn. Zapobiega sortowaniu definicji
funkcji w pliku histori.
T}
	physical	T{
Powoduje, �e komendy \fBcd\fP oraz \fBpwd\fP stosuj� `fizyczne'
(\fItzn.\fP, pochodz�ce od systemu plik�w) \fB..\fP katalogi zamiast `logicznych'
katalog�w (\fItzn.\fP,  �e otoczka interpretuje \fB..\fP, co pozwala
u�ytkownikowi nietroszczy� si� o pod��czenia symboliczne do katalog�w).
Domy�lnie wykasowane.  Prosz� zwr�ci� uwag� i� nastawianie tej opcji
nie wp�ywa na bie��c� warto�� parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy�ej dla dalszych szczegu��w.
T}
	posix	T{
W��cz try posix-owy.  Patrz Tryb POSIX-owy powy�ej.
T}
	vi	T{
W��cz edycj� wiersza komendy  w stylu vi (dotyczy tylko otoczek 
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w orginalnej otoczce Korn-a, dopuki nie zosta�o 
nastawione viraw, tryb wiersza komendy vi
pozostawia� prac� nap�dowi tty a� do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plik�w
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Prefiksuj znaki z nastawionym �smym bitem poprzez `M-'.
Je�li nie zostanie nastawiona ta opcja, w�wczas, znaki z zakresu
128-160 zostaj� wypisane bez zmian co mo�e by� przyczyn� problem�w.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonyj rozwiania koemnd/ plik�w
je�li tab (^I) zostanie wrowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo�na urzy� r�wnie� podczas odpalania otoczki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje si� w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy�wietla
wszystki opcja i informacj� o ich nastawieniu lub nie;
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
kasuje zar�no opcj� \fB\-x\fP, jak i \fB\-v\fP.
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
\fBtest\fP wylicza \fIwyra�enia\fP i zwraca status zero je�li
prawda, i status 1 jeden je�li fa�sz, awi�cej ni� 1 je�li wyst�pi� b��d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra�e� \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nast�puj�ce podstawowe wyra�enia:
.sp
.TS
afB ltw(2.8i).
\fIci�g\fP	T{
\fIci�g\fP ma niezerow� d�ugo��.  Prosz� zwr�ci� uwag� i� mog� wyst�pi�
tr�dno�ci je�li \fIci�g\fP oka�e si� by� operatorem 
(\fIdok�adniej\fP, \fB-r\fP) - og�lnie lepiej jest stosowa�
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
wzamian (podw�jne wycytowania zostaj� zastosowaneje�li
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
\fIplik\fP jest nazwanym ruroci�giem
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
w�a�ciciel \fIpliku\fP zgadza si� z efektywnym user-ID otoczki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza si� z efektywn� group-ID otoczki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod��czeniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale�nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod��czeniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP otoczki jest nastawiona (patrz komenda \fBset\fP powy�ej
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
pierwszy \fIplik\fP jest torzsamy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przy��dem tty.
Je�li nie zosta�a nastawiona opcja posix-a (\fBset \-o posix\fP, 
patrz Tryb POSIX powy�ej), w�wczas \fIfd\fP mo�e zosta� pomini�ty, 
co oznacza przyj�cie domu�lnej warto�ci 1
(zachowanie si� jest w�wczas odmienne z powodu specjalnych reg�
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
W.sz., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dost�pny zapis na
deskryptor pliku 2.
.sp
Prosz� zwr�ci� uwag� �e zachodz� specjalne reg�y
(zawdzi�czane POSIX-owi), je�li liczba argument�w
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od pi�ciu: 
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te tak �e pozostaje tylko
jeden argument, w�wczas zostaje przeprowadzony test d�ugosci ci�gu
(ponownie, nawet je�li dany argument jest unarnym operatorem);
je�li pierwsze argumenty \fB!\fP mog� zosta� pomini�te tak, �e pozostaj� trzy
argumenty i drugi argument jest operatorem binarnym, w�wczas zostaje
wykonana dana binarna operacja (nawet je�li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuni�tym \fB!\fP).
.sp
\fBUwaga:\fP Cz�stym b��dem jest stosowanie \fBif [ $co� = tam ]\fP co
daje wynik negatywny je�li parametr \fBco�\fP jest zerowy lub
nienastawiony, zwiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest unarnym operatorem, takim jak
\fB!\fP lub \fB\-n\fP.  Prosz� stosowa� testy typu 
\fBif [ "X$co�" = Xtam ]\fP wzamian.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy�wietla zgromadzony czas w przestrzeniu u�ytkownika oraz systemu,
kt�ry spotrzebowa�a otoczka i w niej wystartowane 
procesy kt�re w si� zako�czy�y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna� ...\fP]"
Nastawia obrabiacz, kt�ry nale�y wykona� w razie odebrania danego sygna�u.
\fBObrabiacz\fP mo�e by� albo zerowym ci�giem, wskazujacym na zamiar
ignorowania sygna��w danego typu, minusem (\fB\-\fP), 
wskazuj�cym, �e ma zosta� podj�ta akcja domy�lna dla danego sygna�u
(patrz signal(2 or 3)), lub ci�giem zawierajacym komendy otoczki
kt�re maj� zosta� wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zako�czeniu bierz�cej komendy, lub przed
wypisaniem nast�pnego zach�cacza \fBPS1\fP) po odebraniu
jednego z danych sygna��w.
\fBSigna�\fP jest nazw� danego wygna�u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy�ej).
Istnieja dwa specjalne sygna�y: \fBEXIT\fP (r�wnie� znany jako \fB0\fP),
kt�ry zostaje wykonany tu� przed zako�czeniem otoczki, i
\fBERR\fP kt�ry zostaje wykonany po wyst�pieniu b�edu
(b��dem jest co� co powodowa�oby zakonczenie otoczki
je�li zosta�y nastawioe opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP opwy�ej).
Obrabiacze \fBEXIT\fP zostaj� wykonane w otoczeniu
ostatniej wykonywanej komendy.
Prosz� zwr�ci� uwage, �e dla otoczek nieinterakcyjnych obrabiacz wykrocze�
nie mo�e zosta� zmieniony dla sygna��w kt�re by�y ignorowane podczas
startu danej otoczki.
.sp
Bez argument�w, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykrocze�, kt�re zosta�y nastawione od czasu staru otoczki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna��w \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i orginalnej otoczki Korn'a w funkcjach nie zosta�o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda zako�czaj�ca si� zerow� warto�ci� statusu.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto��\fP] ...]"
Wy�wietlaj lub nastawiaj warto�ci atrybut�w parametr�w.
Bez argument�w \fInazwa\fP, zostaj� wy�wietlone atrybuty parametr�w: 
je�li brak argument�w opcyjnych, zostaja wy�wietlone atrybuty
wszystkich paramet�r jako komendy typeset; je�li podano opcj�
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto�ci posiadaj�ce dany atrybut zostaj� 
wy�wietlone;
je�li opcje zaczynaj� si� od \fB+\fP, to nie zostaj� wy�wietlone warto�ci
oparametr�w.
.sp
Je�li podano argumenty If \fInazwa\fP, zostaj� nastawione atrybuty
danych parametr�w (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto�ci parametr�w mog� zosta� ewentualnie podane.
Je�li typeset zostanie zastosowane wewn�trz funkcji, 
wszystkie nowotworzone parametry pozostaj� lokalne dla danej funkcji.
.sp
Je�li zastosowano \fB\-f\fP, w�wczas typeset operuje na atrybutach funkcji.
Tak jak dla parametr�w, je�li brak \fInazw\fPs, zostaj� wymienione funkcje
wraz z ich warto�ciami (\fItzn.\fP, definicjami) chyba, �e opdano
opcje zaczynaj�ce si� od \fB+\fP, w kt�rym wypadku
zostaj� wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyr�wnania do lewego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bierz�ca szeroko�� parametru 
(lub szeroko�� pierwszej przyporz�dkowywanej warto�ci).
Prowadz�ce bia�e przerwy (tak jak i zera, je�li
nastawiono opcj� \fB\-Z\fP) zostaj� wykasowane.
Je�li trzeba, warto�ci zostaj� albo obci�te lub dodane przerwy
do osi�gni�cia wymaganej szeroko�ci.
T}
\-R\fIn\fP	T{
Atrybut przyr�wnania do prawego brzegu: \fIn\fP oznacza szeroko�� pola.
Je�li brak \fIn\fP, to zostaje zastosowana bierz�ca szeroko�� parametru
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
Tej opcji brak w orginalnej otoczce Korn'a.
T}
\-f	T{
Tryb funkcji: wy�wietlaj lub nastawiaj funkcje i ich atrybuty, zamiast
parametr�w.
T}
\-l	T{
Atrybut ma�ej litery: wszystkie znaki z du�ej litery zostaj� 
w wartosci zamienione na ma�e litery.
(W orignalnej otoczce Korn'a, parametr ten oznacza� `d�ugi ca�kowity' 
gdy by� stosowany w po��czeniu z opcj� \fB\-i\fP).
T}
\-p	T{
Wypisuj pe�ne komendy typeset, kt�re mo�na nast�pnie zastosowa� do
odtworzenia danych atrybut�w (lecz nie warto�ci) parametr�w.
To jest wynikiem domy�lnym (opcja ta istnieje w celu zachowania
kompatybilijno�ci z ksh93).
T}
\-r	T{
Atrybut wy�acznego odczytu: parametry z danym atrybutem
nie przyjmuj� nowych warto�ci i nie mog� zosta� wykasowane.
Po nastawieniu tego atrybutu nie mo�na go ju� wi�cej odaktywni�.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla otoczki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut �ledzenia.
Je�li zostaj� wykonywane funkcje z atrybutem �ledzenia, to
opcja otoczki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w�aczona.
T}
\-u	T{
Atrybut du�ej litery: wszystkie znaki z ma�ej litery w warto�ciach zostaj�
przestawione na du�e litery.
(W orginalnej otoczce Korn'a, ten parametr oznacza� `ca�kowity bez znaku' je�li
zosta� zastosowany w po��czeniu z opcj� \fB\-i\fP, oznacza�o to, �e
nie mo�na by�o sotsowa� du�ych liter dla baz wi�kszych ni� 10.  
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
Wy�wietlij lub nastaw ograniczenia dla proces�w.
Je�li brak opcji, to ograniczenie ilo�ci plik�w (\fB\-f\fP) zostaje
przyj�te jako domy�le.
\fBwarto��\fP, je�li podana, mo�e by� albo wyra�eniem arytmetycznym
lub s�owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz� otoczki i wszelkich proces�w przez ni� tworzonych
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
Nastaw jedynie ograniczenie twarde (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-S\fP
Nastaw jedynie ograniczenie mi�kkie (domy�lnie zostaj� ustawione zar�wno
ograniczenie twarde jak te� i mi�kkie).
.IP \fB\-c\fP
Ogranicz wielko�ci plik�w zrzut�w core do \fIn\fP blk�w.
.IP \fB\-d\fP
Ogranicz wielko�� area�u danych do \fIn\fP kbyt�w.
.IP \fB\-f\fP
Ogranicz wielkos� plik�w zapisywanych przez otoczk� i jej programy pochodne
do \fIn\fP plik�w (pliki dowolnej wielko�ci mog� by� wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kbyt�w ilo�� podkluczonej (podpi�tej) fizycznej pami�ci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kbyt�w ilo�� uzywanej fizycznej pami�ci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie otwartych deskryptor�w plik�w.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo�� jednocze�nie wykonywanych proces�w danego
u�ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kbyt�w rozmiar area�u stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu�ywany przez pojedy�cze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kbyt�w ilo�� u�ywanej wirtualnej pami�ci;
pod niekt�rymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kbajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kbyt�w ilo�� stosowanego obszaru odk�adania.
.PP
Dla \fBulimit\fP blok to zawsze512 bajt�w.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy�wietl lub nastaw mask� zezwole� w tworzeniu plik�w, lub umask 
(patrz \fIumask\fP(2)).
Je�li zastosowano opcj� \fB\-S\fP, maska jest wy�wietlana lub podawana
symbolicznie, natomias jako liczba oktalna w przeciwnym razie.
.sp
Symboliczne maski s� podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znak�w jest cz�ci� \fIkto\fP, a druga grupa cz�sci�
\fIop\fP, i ostatnio grupa cz�ci� \fIperm\fP.
Cz�� \fIkto\fP okre�la kt�ra cz�� umaski ma zosta� zmodyfikowana.
Litery oznaczaj�:
.RS
.IP \fBu\fP
prawa u�ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta�ych (nie-u�ytkownika, nie-groupy)
.IP \fBa\fP
wszelkie prawa naraz (u�ytkownika, grupy i pozosta�ych)
.RE
.sp
Cz�� \fIop\fP wskazuj� jak prawa \fIkto\fP maj� by� zmienioe:
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
Gdy stosuje si� symboliczne maski, do opisuj� one kt�re prawa mog� zosta�
udost�pnioe (w przeciwie�stwie do masek oktalnych, w kt�rych nastawienie
bita oznacze, �e ma on zosta� wykasowany).
przyk�ad: `ug=rwx,o=' nastawia mask� tak, �e pliki nie b�d� odczytywalne,
zapisywalne i wykonywalne przez `innych', i jest ekwiwalnetne
(w wi�kszo�ci system�w) do oktalnej maski `07'.
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
Statusem zako�czenia jest nie-zerowy je�li kt�ry� z danych parametr�w by�
ju� wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zako�czenie danego zadania/zada�.
Statusem zako�czenia wait jest status ostaniego podanego zadania:
je�li dane zadanie zosta�o zabite sygna�em, status zako�czenia wynosi
128 + number danego sygna�u (patrz \fBkill \-l\fP \fIstatus-zako�czenia\fP
powy�ej); je�li ostatnie dane zadanie nie mo�e zosta� odnalezione
(bo nigdy nie istnia�o, lub ju� zosta�o zako�czone), to status
zako�czenia wait wynosi 127.
Patrz Kontrola Zada� poni�ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zako�czone je�li zajdzie sygna� na kt�ry zosta�
nastawiony obrabiacz, lub gdy zostanie odebrany sygna� HUP, INT lub
QUIT.
.sp
Je�li nie podano zada�, \fBwait\fP wait czeka na zako�czenie
wszelkich obecnych zada� (je�li istnieja takowe) i ko�czy si�
statusem zerowym.
Je�li kontrola zada� zosta�a w��czona, to zostaje wy�wietlony
status zako�czeniowy zada�
(to nie ma miejsca, je�li zadania zosta�y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka�dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je�li podano opcj� \fB\-p\fP, to zostaje odszykany trop
dla \fInazw\fP, b�d�cych zarezerwowanymi z�owami, aliasmi, \fIitp.\fP
Bez opcji \fB\-v\fP \fBwhence\fP dzia�a podobnie do \fBcommand \-v\fP,
poza tym, �e \fBwhence\fP odszukuje zarezerwowane s�owa i nie wypisuje
alias�w jako komendy alias;
z opcj� \fB\-v\fP, \fBwhence\fP to tosamo co \fBcommand \-V\fP.
Prosz� zwr�ci� uwag�, �e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp�ywu
na przeszukiwany trop, tak jak dla \fBcommand\fP.
Je�li typ jednej lub wi�cej sposr�d nazw niem�g� zosta� ustalony 
do status zako�czenia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola Zada�"
Kontrola zada� oznacza zdolno�� otoczki to monitorowania i kontrolowania
wykonywanych \fBzada�\fP,
kt�re s� procesami lub grupami proces�w tworzonych przez komendy lub 
ruroci�gi.
Otoczka przynajmniej �ledzi status obecnych zada� w tle
(\fItzn.\fP, asynchronicznych); t� informacj� mo�na otrzyma�
wykonyj�� komend� \fBjobs\fP.
Je�li zosta�a uaktywnioa pe�na kontrola zada�
(stosuj�c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w otoczkach interakcjynych,
to procesy pewnego zadania zostaj� umieszczane we w�asnej grupie
proces�w, pierwszoplanowe zadnia mog� zosta� zatrzymane przy pomocy
klawisza wstrzymania z termialu (zwykle ^Z),
zadania mog� zosta� ponownie podj�te albo na pierwszym planie albo
w tle, stosujac odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nast�pnie odtworzony, je�li
zatanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Prosz� zwr�ci� uwga�, �e tylko komendy tworz�ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podotoczek, i niewbudowane komendy
nie b�d�ce funkcjami) mog� zosta� wstrzymane; takie komendy
jak \fBread\fP nie mog� tego.
.sp
Gdy zostaje stworzone zadnie, to przyporzadkowywuje mu si� numer zadania.
Dla interakcyjnych otoczek, numer ten zostaje wy�wietlone w \fB[\fP..\fB]\fP,
i w nast�pstwie identyfikatory proces�w w zadaniu, je�li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo�emy odnosi� si� w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i 
\fBwait\fP albo poprzez id ostatniego procesu w ruroci�gu komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj�c
numer zadania znakiem procentu (\fB%\fP).
R�wnie� nast�puj�ce sekwencj� z procentem mog� by� stosowane do
odnoszenia si� do zada�:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie, lub, gdy brak zatrzymanych zada�, najstarsze 
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, kt�re wy�oby pod \fB%+\fP gdyby nie zosta�o zako�czone.
T}
%\fIn\fP	T{
Zadanie z numeram zadania \fIn\fP.
T}
%?\fIci�g\fP	T{
Zadanie zawieracjace ci�g \fIci�g\fP (wyst�puje b��d, gdy odpowiada mu 
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
otoczka wy�wietla nast�puj�ce informacje o statusie:
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
Wskazuje opbecny stan danego zadania
i mo�e to by�
.RS
.IP "\fBRunning\fP"
Zadania nie jest ani wstrzymane ani zako�czone (prosz� zwr�ci� uwag�, i�
przebieg nie koniecznie musi oznacza� spotrzebowywanie
czasu CPU \(em proces mo�e by� zablokowany, czekaj�c na pewne zaj�cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zako�czone. \fInumer\fP to status zako�czeniowy danego zadania,
kt�ry zostaje pominiety, je�li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna�\fP\fB)\fP]"
zadanie zosta�o wstrzymane danym sygna�em \fIsygna�\fP (gdy brak sygna�u,
to zadnie zosta�o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna�u\fP [\fB(core dumped)\fP]"
zadanie zosta�o zabite sygna�em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opis�w sygna��w).
Wiadomos� \fB(core\ dumped)\fP wskazuje, �e proces stworzy� plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, kt�ra stworzy�a dany proces.
Je�li dane zadania zwiera kilka proces�w, to k�dy proces zostanie wy�wietlony
w osobnym wierszy pokazujacym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je�li jest on odmienny od statusu poprzedniego procesu.
.PP
Je�li pr�buje si� zako�czy� otoczk�, podczas gdy istniej� zadania w
stanie zatrzymania, to otoczka ostrzega u�ytkownika, �e s� zadania w stanie
zatrzymania i nie zaka�cza si�.
Gdy tu� potem zostanie podj�ta ponowna pr�ba zako�czenia otoczki, to
zatrzymane zadania otrzymuj� sygna� \fBHUP\fP i otoczka ko�czy prac�.
podobnie, je�li nie zosta�a nastawiona opcja \fBnohup\fP,
i s� zadania w pracy, gdy zostanie podjeta pr�ba zako�czenia otoczki
zameldowania, otoczka ostrzega u�ytkownika i nie ko�czy pracy.
Gdy tu� potem zotanie ponownie podjeta pr�ba zako�czenia pracy otoczki,
to bierz�ce procesy otrzymuj� sygna� \fBHUP\fP i otoczka ko�czy prac�.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna Edycja Wiersza Wprowadze� w Trybie Emacs"
Je�li zosta�a nastawiona opcja \fBemacs\fP,jest w��czona interakcyjna
edycja wiersza wprowadze�.  \fBOstrze�enie\fP: Ten tryb zachowuje si�
nieco inaczej ni� tryb emacs-a w orginalnej otoczce Korn-a
i 8-smy bit zostaje wykasowany w trybie emacs-a.
W trybie tym r�ne komendy edycji (zazwyczaj pod��czone pod jeden lub wiecej
znak�w kontrolnych) powoduj� natychmiastowe akcje bez odczekiwania
nast�pnego prze�amania wiersza.  Wiele komend edycji jest zwi�zywana z 
pewnymi znakami kontrolnymi podczas odpalania otoczki; te zwi�zki mog� zosta�
zmienione przy pomocy nast�puj�cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi�zki zostaj� wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci�g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi�zana pod dany \fBci�g\fP, kt�ry
powinnien sk�ada� si� ze znaku kontrolnego (zapisanego przy pomocy
strza�ki w g�r� \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dw�ch znak�w przedsionkownych.  Wprowadzenie danego
\fIci�gu\fP b�dzie w�wczas powodowa�o bezpo�rednie wywo�anie danej
komendy edycji.  Prosz� zwr�ci� uwag�, �e cho� tylko
dwa znaki przedsionkowe mog� (zwykle ESC i ^X) s� wspomagane, to
r�wnie� niekt�re ci�gi wieloznakowe r�wnie� mog� zosta� podane.  
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
dane \fIpodstawienie\fP kt�re mo�e zawiera� komendy edycji.
.\"}}}
.PP
Nast�puje lista dost�pnych komend edycji.
Ka�dy z poszczeg�lnych opis�w zaczyna si� nazw� komendy,
liter� \fIn\fP, je�li komenda mo�e zosta� poprzedzona licznikiem,
i wszelkimi klawiszami do kt�rych dana komenda jest pod�aczona
domy�lnie (w zapisie sotsujacym notacj� strza�kow�, \fItzn.\fP, 
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj�cy komend� wprowadzamy stosuj�c ci�g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci�g sk�adaj�cy si� z jednej
lub wi�cej cyfr;
chyba, �e podano inaczej licznik, je�li zosta� pomini�ty, wynosi 
domy�lnie 1.
Prosz� zwr�ci� uwag�, �e nazwy komend edycji stosowane s� jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy�lne podwi�zania zosta�y wybrane
tak, aby by�y zgodne z odpowiednimi podwi�zaniami EMACS-a.  
Znaki u�ytkownika tty (\fIw szczeg�lno�ci\fP, ERASE) zosta�y
pod��czenia do stosownych podstawnie� i przekasowywuj� domy�lne
pod��czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania-histori\fP 
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
Przesuwa na pocz�tek histori.
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
Je�li bierz�cy wiersz nie zaczyna si� od znaku komentarza, zostaje on
dodany na pocz�tku wiersza i wiesz zostaje wprowadzony (tak jakby
naci�ni�to prze�amanie wiersza), w przeciwnym razie istniej�ce znaki
komentarza zostaj� usuni�te i kursor zostaje umieszczony na pocz�tku 
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope�nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj�cej kursor.  Je�li ca�a pozosta�a cz��
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy�wietlona
po wype�nieniy, chyba �e jest to nazwa katalogu, w kt�rym to razie zostaje
do��czone \fB/\fP.  Je�li nie ma komendy lub nazwy pliku zaczynajacej
si� od takiej cz�sci s�owa, to zostaje wyprowadzony znak dzwonka 
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
Automatycznie dope�nia tyle ile jest jednoznaczne z nazwy plikyu
zawieraj�cego cz�ciowe s�owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy�ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymie� mo�liwe dope�nienia bierz�cego s�owa.
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
Kasuje znaki po koursorze, a� do ko�ca \fIn\fP s��w.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historji w prz�d \fIn\fP wierszy (p�niej).  
Ka�dy wiersz wprowadzenia zaczyna si� orginalnie tu� po ostatnim
miejscu w buforze historji, tak wi�c
\fBdown-history\fP nie jest przydaten dopuki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Przemie� na ma�e litery nast�pnych \fIn\fP s��w.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porousza do ko�ca historji.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na konie� wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia�a jako koniec-pliku; Jest to przydatne, albowiem tryb edycji
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
Umie�� kursor na znaczniku i nastaw znacznik na miejsce w kt�rym by�
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bierz�cego s�owa i zast�puje dane s�owo wynikiem
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
Przemieszcza do historji numer \fIn\fP.
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
w przeciwnym razie kasuje znaki pomi�dzu cursorem a
\fIn\fP-t� kolumn�.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend lub nazw plik�w
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
Do nazw katalog�w zostaje do��czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw komend
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy�wietla sortowan�, skolumnowan� list� nazw plik�w
(je�li s� takowe) kt�re mog�yby dope�ni� cz�ciowe s�owo zawieraj�ce kursr.
Specyfikatory rodzaju plik�w zostaj� do��czone tak jak powy�ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bierz�cego wiersza wprowadze� przez otoczk�.
Kursor mo�e znajdowa� si� aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bierz�cego wiersza wprowadze� przez otoczk�,
po czym nast�pny wiersz z histori staje si� wierszem bierz�cym.
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
Nast�puj�cy znak zostaje wzi�ty dos�ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zach�cacz i bierz�cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty� w bierz�cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w prz�d w bierz�cym wierszu \fIn\fP-tego wyst�pienia
nast�pnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd� w krocz�cy tryb szukania.  Wewn�trzna lista historji zostaje
przeszukiwana wstecz za komendami odpowiadaj�cymi wprowadzeniu.  
pocz�tkowe \fB^\fP w szukanym ci�gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan� wykonywane po opuszczeniu trybu szukania.  
Ponowne komendy \fBsearch-history\fP kontynuuj� szukanie wstecz
do nast�pnego poprzedniego wyst�pienia wzorca.  Bufor historji
zawiera tylko sko�czon� ilo�� wierszy; dla potrzeby najstarsze zostaj�
wy�ucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bierz�cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj�cymi, wypycha pod��czony znak spowrotem
do wej�cia terminala, dzie mo�e on zosta� specjalnie przetworzony przez
terminal.  Jest to przydatne n.p. dla opcji BRL \fB^T\fP mini-systat'a.
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
poprzedni i birz�cy znak, po czym przesuwa cursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historji \fIn\fP wierszy wstecz (wcze�niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nast�pnych \fIn\fP s��w w du�e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisuj� wersj� ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci�ni�ty jakikolwiek klawisz 
(po czym ten klawisz zostaje przetworzony, chyba �e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad� ostatnio skasowny ci�g tekstu na bierz�c� pozycj� kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo�rednio po \fByank\fP, zamienia wprowadzony tekst na
nast�pny poprzednio skasowany ci�g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny Tryb Edycji Wiersza Wprowadze� Vi"
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
komenda \fB_\fP dzia�a odmiennie (w ksh jst to komenda ostatniego argumentu,
a w vi przechodzenie do pocz�tku bierz�cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fPporuszaj� si� w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
i brak jest komend, kt�re nie maj� znaczenia w edytorze obs�ugujacym jeden 
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
W trybie wprowadzania, wi�kszo�� znakow zostaje po prostu umieszczona
w buforze na bierz�cym miejscu kursora w kolejno�ci ich wpisywania, 
chocia� niekt�re znaki zostaj� traktowane specjalnie.
W szczeg�lno�ci nast�puj�ce znaki odpowiadaj� obecnym ustawieniom tty'a
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
bazpo�renio nast�pny: nast�pny naci�ni�ty znak nie zostaje traktowany 
specjalnie (mo�na tego u�y� do wprowadzenia opisywanych tu znak�w)
T}
^J ^M	T{
kiniec wiersza: bierz�cy wiersz zostaje wczytany, rozpoznany i wykonany
przez otoczk�
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni�ej)
T}
^E	T{
wyliczanie komend i nazw plik�w (patrz poni�ej)
T}
^F	T{
dope�nianie nazw plik�w (patrz poni�ej).
Je�li zostanie u�yte dwukrotnie, zo w�wczas wy�wietla list� mo�liwych
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
w ostatniej kolumnie, wskazujacy odpowiednio na wi�cej znak�w po, przed i po, oraz 
przed obecn� pozycj�.
Wiersz jest przwijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka�dy znak zostaje interpretowany jako komenda.
Znaki kt�rym nie odpowiada �adna komenda, kt�re s� niedopuszczaln� 
komend� lub s� komendami niedowykonania, wszystkie wyzwalaj� dzwonek.
W nast�puj�cych opisach komend, \fIn\fP wskazuje �e komed� mo�na
poprzedzi� numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znak�w); gdy brak przedsionka numerowego, to zak�ada si�, �e \fIn\fP 
jest r�wne 1, chyba �e powiemy inaczej.
Zwrot `bierz�ca pozycja' odnosi si� do pozycji pomi�dzy cursorem
a znakiem przed nim.
`S�owo' to ci�g liter, cyfr lub podkre�le�
albo ci�g nie nie-liter, nie-cyfr, nie-podkre�le�, niebia�ych-znak�w
(\fItak wi�c\fP, ab2*&^ zawiera dwa s�owa), oraz `du�e s�owo' jest ci�giem
niebia�ych znak�w.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nast�puj�cych komend brak, lub s� one odmienne od tych w normalnym
edytorze plik�w vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad� przerw� z nast�pstwem \fIn\fP-tego du�ego s�owa
z ostatniej komendy w historji na bierz�cej pozycji w wejd� z tryp
wprowadzania; je�li nie podano \fIn\fP to domy�lnie zostaje wprowadzone
ostatnie s�owo.
.IP "\fB#\fP"
wprowad� znak komenta�a (\fB#\fP) na pocz�tku bierz�cego wiersza
i przeka� ten wiersz do otoczki (taksoamo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z wyj�tkiem, �e je�li nie podano \fIn\fP 
to dotyczy to ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj�c edytor vi; 
je�li nie podano \fIn\fP, to edytuje bierz�cy wiersz.
W�a�ciw� wykonywan� komend� jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope�nianie komendy lub nazwy pliku zostaje zastosowane do
 obecnego du�ego s�owa
(po dodaniu *, je�li to s�owo nie zawiera �adnych znak�w dope�niania nazw
plik�w) - du�e s�owo zostaje zast�pione s�owami wynikowymi.
Je�li bierz�ce du�e s�owo jest pierwszym w wierszu (lub wyst�puke po
jednym z nast�puj�cych znak�w: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera pochy�ka (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wyknoane rozwijanie nazwy plik�w.
Rozwijanie komend podpasowuje du�e s�owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i r�wnie� wszelkie wykonywalne pliki odnajdywane
przeszukuj�c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plik�w dopasowywuje du�e s�owo do nazw plik�w w bierz�cym
katalogu.
Po rozwini�ciu, kursor zostaje umieszczony tu� po
ostatnim s�owie na ko�cu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope�nianie nazw komend/plik�w: 
zast�puje bierz�ce du�e s�owo najd�uzszym, jednoznacznym
dopasowaniem otrzymanym przez rozwini�cie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je�li zosta�a w��czona opcja 
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je�li zosta�a w��czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je�li podano \fIn\fP to zostaje u�yte \fIn\fP-te mo�liwe 
dope�nienie (z tych zwracanych przez komen� wyliczania dope�nie� nazw
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
przsu� si� do kolumny 0.
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
odnajd� wz�r: edytor szuka do przodu najbli�szego nawiasu okr�g�ego
prostok�tnego lub zawi�ego i nast�pnie przesuwa si� od odpowiadaj�cego mu
nawiasu okr�g�ego prostok�tne lub zawi�ego.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesu� si� w prz�d do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesu� si� w ty� do \fIn\fP-tego wyst�pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesu� si� w przod tu� przed \fIn\fP-te wyst�pienie znaku \fIc\fP.
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
przejd� do \fIn\fP-tego nast�pnego wiersza w historji.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd� do \fIn\fP-tego poprzedniego wiersza w historji.
.IP "\fIn\fP\fBG\fP"
przejd� do wiersza \fIn\fP w historji; je�li brak \fIn\fP, to przenosi
si� do pierwszego zapamietanego wiersza w historji.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, �e je�li nie podan \fIn\fP to idzie do
ostatnio zapami�tanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci�g\fP"
szukaj wstecz w historji \fIn\fP-tego wiersza zawieraj�cego
\fIci�g\fP; je�li \fIci�g\fP zaczyna si� od \fB^\fP, to reszta ci�gu
musi wyst�powa� na samym pocz�tku wiersza historji aby pasowa�a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, �e szuka do przodu w histori.
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
bierz�cej pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t� r�nic� �e dodaje do ko�ca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bierz�cej
pozycji.
Dodanie zostaje jedynie wykonane, je�li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je�li <esc> zostanie u�yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t� r�nic� �e dodaje do tu� przed pierwszym niebia�ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamie� nast�pnych \fIn\fP znak�w (\fItzn.\fP, skasuj te znaki i przejd�
do trybu wprowadzania).
.IP "\fBS\fP"
zast�p ca�y wiersz: wszystkie znaki od pierwszego niebia�ego znaku
do ko�ca wiersza zostaj� skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd� z bierz�cej pozycji do pozycji wynikajacej z \fIn\fP
\fIkomend-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wej� w tryb
wprowadzania);
je�li \fIkomend�-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia�ego znaku pocz�wszy.
.IP "\fBC\fP"
zmie� od obecnej pozycji op koniec wiersza (\fItzn.\fP, skasuj do ko�ca wiersza
i przejd� do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nast�pnych \fIn\fP znak�w.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znak�w.
.IP "\fBD\fP"
skasuj do ko�ca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikajacej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo�e by� komend� przemieszczania (patrz powy�ej) lub \fBd\fP,
co powoduje skasowanie bierz�cego wiersza.
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
ca�y wierz zostaje wyci�ty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do ko�ca wiesza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto�� bufora wycinania tu� po bierz�cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko �e bufor zostaje wklejony na bierz�cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "R�ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bierz�cy wiersz zostaje wczytany, rozpoznany i wykonany przez otoczk�.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bierz�cy wiersz.
.IP "\fIn\fP\fB.\fP"
wyknoaj ponownie ostatni� komend� edycji \fIn\fP razy.
.IP "\fBu\fP"
odwr�� ostatni� komend� edycji.
.IP "\fBU\fP"
odwr�� wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zako�czenia powoduj� skasowania bierz�cego
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
Wszelkie b��dy w pdksh nale�y zg�asza� pod adres pdksh@cs.mun.ca.  
Prosz� poda� wersj� pdksh (echo $KSH_VERSION pokazuje j�), maszyn�,
system operacyjny i stosowany kompilator oraz opis jak powt�rzy� dany b��d
(najlepiej ma�y skrypt otoczki demonstruj�cy dany b��d).  
Nast�puj�ce mo�e by� r�wnie� pomocne, je�li ma znaczenie 
(je�li nie jeste� pewny to podaj to r�wnie�): 
stosowane opcje (zar�wno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo�na otrzyma� z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta otoczka powsta�a z publicznego klona 7-mego wydania otoczki
Bourne-a wykonwnego przez Charlesa Forsytha i z cz�ci otoczki
BRL autorstwa Doug A.\& Gwyn, Doug Kingston,
Ron Natalie, Arnold Robbins, Lou Salkind i innych.  Pierwsze wydanie
pdksh stworzy� Eric Gisin, a nast�pnie troszczyli si� ni� kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji �r�de� zawiera bardziej kompletn�
list� ludzi i ich wk�adu do rozwoju tej otoczki.
.PP
T�umaczenie tego podr�cznika na j�zyk Polski wykona� Marcin Dalecki 
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "PATRZ R�WNIE�"
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
.\"}}}
