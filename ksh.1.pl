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
.TH KSH 1 "22 Lutego, 1999" "" "Komendy u¿ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja otoczki Korn-a
.\"}}}
.\"{{{  Synopsis
.SH WYWO£ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP] [ [ \fB\-c\fP \fIci±g-komenda\fP [\fInazwa-komendy\fP] | \fB\-s\fP | \fIplik\fP ] [\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP, to interpretator komend nadaj±cy siê, zarówno jako otoczka
do interakcyjnej pracy z systemem, jak i do wykonywania skryptów.
Jêzyk komend przezeñ rozumiany to nadzbiór jêzyka otoczki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Odpalanie Otoczki"
Nastêpuj±ce opcje mog± zostaæ zastosowane w wierszu komendy:
.IP "\fB\-c\fP \fIci±g-komenda\fP"
otoczka wykonuje rozkaz(y) zawarte w \fIci±g-komenda\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni¿ej
.IP \fB\-l\fP
otoczka zameldowania \(em patrz poni¿ej
interakcyjny tryb \(em patrz poni¿ej
.IP \fB\-s\fP
otoczka wczytuje komendy ze standardowego wej¶cia; wszelkie argumenty
nie bêd±ce opcjami, s± argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni¿ej
.PP
Ponad to wszelkie opcje, opisane w zwi±zku z wmontowan±
komend± \fBset\fP, mog± równie¿ zostaæ u¿yte w wierszu komendy.
.PP
Je¶li ani opcja \fB\-c\fP, ani opcja \fB\-s\fP, nie zosta³y
podane, wówczas pierwszy argument nie bêd±cy opcj±, okre¶la
plik z którego zostan± wczytywane komendy. Je¶li brak jest argumentów
nie bêd±cych opcjami, to otoczka wczytuje komendy ze standardowego
wej¶cia.
Nazwa otoczki (\fItzn.\fP, zawarto¶æ parametru \fB$0\fP)
jest ustalana jak nastêpuje: je¶li u¿yto opcji \fB\-c\fP i zosta³
podany nieopcyjny argument, to jest on nazw±; 
je¶li komendy s± wczytywane z pliku, wówczas nazwa danego pliku zostaje
u¿yta jako nasza nazwa; w kazdym innym przypadku zostaje u¿yta
nazwa, pod jak± dana otoczka zosta³a wywo³ana 
(\fItzn.\fP, warto¶æ argv[0]).
.PP
Otoczka jest \fBinterakcyjna\fP, je¶li u¿yto opcji \fB\-i\fP 
lub je¶li zarówno standardowe wej¶cie, jak i standardowe wyj¶cie,
s± skojarzone z jakim¶ terminalem.
W interakcyjnej otoczce kontrola zadañ (je¶li takowa jest dostêpna
w danym systemie) jest w³±czona i ignoruje nastêpuj±ce sygna³y:
INT, QUIT oraz TERM. Ponadto wy¶wietla ona zachêcacze przed
wczytywaniem wprowadzeñ (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych otoczek, uaktywnia siê domy¶lnie opcja \fBtrackall\fP
(patrz poni¿ej: komenda \fBset\fP).
.PP
Otoczka jest \fBograniczona\fP je¶li zastosowano opcjê \fB\-r\fP lub
gdy, albo podstawa nazwy pod jak± wywo³ano otoczkê, albo parametr
\fBSHELL\fP, pasuj± pod wzorzec *r*sh (\fIw szczególno¶ci\fP, 
rsh, rksh, rpdksh, \fIitp.\fP).
Nastêpuj±ce ograniczenia zachodz± wówczas po przetworzeniu przez
otoczkê wrzelkich plików profilowych i plików z \fB$ENV\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
komenda \fBcd\fP jest wy³±czona
.IP \ \ \(bu
parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP, nie mog± byæ modyfikowane
.IP \ \ \(bu
nazwy komend nie mog± byæ podane przy pomocy absolutnych lub
wzglêdnych tropów
.IP \ \ \(bu
opcja \fB\-p\fP wbudowanej komendy \fBcommand\fP jest niedostêpna
.IP \ \ \(bu
przekierowania, które stwarzaj± pliki, nie mog± zostaæ zastosowane
(\fIw szczególno¶ci\fP, \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Otoczka jest \fBuprzywilejowana\fP, je¶li zastosowano opcjê \fB\-p\fP,
lub, je¶li rzeczywisty id u¿ytkownika lub jego grupy
nie jest zgodny z efektywnym id u¿ytkownika czy grupy
(patrz \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana otoczka nie przetwarza ani $HOME/.profile, ani parametru
\fBENV\fP (patrz poni¿ej), w zamian zostaje przetworzony plik
/etc/suid_profile.
Wykasowanie opcji uprzywilejowania powoduje, ¿e otoczka ustawia swój
efektywny id u¿ytkownika i grupy na warto¶ci faktycznego id u¿ytkownika
(user-id) i jego grupy (group-id).
.PP
Je¶li podstawa nazwy pod jak± dana otoczka zosta³a wywo³ana 
(\fItzn.\fP, argv[0])
zaczyna siê od \fB\-\fP, lub je¶li podano opcjê \fB\-l\fP,
to zak³ada siê, ¿e otoczka ma byæ otoczk± zameldowania i wczytuje
zawarto¶æ plików \fB/etc/profile\fP i \fB$HOME/.profile\fP,
je¶li takowe istniej± i s± odczytywalne.
.PP
Je¶li podczas odpalania otoczki zosta³ ustawiony parametr \fBENV\fP
(albo, w wypadku otoczek zameldowania, po przetworzeniu
wszelkich plików profilowych), to jego zawarto¶æ zostaje
poddana podstawieniom komend, arytmetycznym oraz szlaczka, a nastêpnie
wynikaj±ca z tej operacji nazwa (je¶li takowa istnieje), zostaje
zinterpretowana jako nazwa pliku, podlegaj±cego nastêpnemu
wczytaniu i wykonaniu.
Je¶li parametr \fBENV\fP jest pusty (i niezerowy), oraz pdksh zosta³
skompilowany ze zdefiniowanym makro \fBDEFAULT_ENV\fP, 
to (po wykonaniu wszelkich ju¿ wy¿ej wymienionych podstawieñ)
plik przezeñ okre¶lany zostaje wczytany.
.PP
Status zakoñczenia otoczki wynosi 127, je¶li plik komend
podany we wierszu wywo³ania nie móg³ zostaæ otwarty,
albo jest niezerowy, je¶li wyst±pi³ fatalny b³±d w sk³adni
podczas wykonywania tego¿ skryptu.
W wypadku braku wszelkich b³êdów, status jest równy statusowi ostaniej
wykonanej komendy lub, je¶li nie wykonano ¿adnej komendy, zeru.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk³adnia Komend"
.\"{{{  words and tokens
Otoczka rozpoczyna analizê sk³adni swych wprowadzeñ od podzia³u
na poszczególne s³owa \fIword\fPs.
S³owa, stanowi±ce ci±gi znaków, rozgranicza siê niewycytowanymi
znakami \fIbia³ymi\fP (spacja, tabulator i przerwanie wiersza) 
lub \fImeta-znakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza rozgraniczeniami s³ów przerwy i tabulatory s± ignorowane.
Natomiast przerwania wierszy zwykle rozgraniczaj± komendy.
meta-znaki stosowane s± do tworzenia nastêpuj±cych kawa³ków:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIetc.\fP,
które s³u¿± do specyfikacji przekierowañ (patrz: przekierowywanie
wej¶cia/wyj¶cia poni¿ej);
\fB|\fP s³u¿y do tworzenia ruroci±gów;
\fB|&\fP s³u¿y do tworzenia koprocesów (patrz: Koprocesy poni¿ej);
\fB;\fP s³u¿y do oddzielania komend;
\fB&\fP s³u¿y do tworzenia asynchronicznych ruroci±gów;
\fB&&\fP i \fB||\fP s³u¿± do specyfikacji warkunkowego wykonania;
\fB;;\fP jest u¿ywany w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s± u¿ywane w wyra¿eniach arytmetycznych;
i na zakoñczenie,
\fB(\fP .. \fB)\fP s³u¿± do tworzenia podotoczek.
.PP
Bia³e przerwy lub meta-znaki mo¿na wycytowywaæ indywidualnie
przy u¿yciu wstecznika (\fB\e\fP), lub grupami poprzez
podwójne (\fB"\fP) lub pojedyñcze (\fB'\fP)
cudzys³owy.
Porszê zwróciæ uwagê, i¿ nastêpuj±ce znaki podlegaj± równie¿ 
specjalnej interpretacji przez otoczkê i musz± zostaæ wycytowane
je¶li maj± reprezentowaæ samych siebie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to powy¿ej wspomniane symbole wycytowywania
(patrz wycytowywanie poni¿ej);
\fB#\fP, na pocz±tu s³owa rozpoczyna komentarz \(em wszysko do
\fB#\fP, po zakoñczenie bierz±cego wiersza, zostaje zignorowane;
\fB$\fP s³u¿y do wprowadzenia podstawienia  parametru, komendy lub arytmetycznego
wyra¿enia (patrz Podstawienia poni¿ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz Podstawienia poni¿ej);
\fB~\fP rozpoczyna rozwiniêcie katalogu (patrz Rozwijanie Szlaczka poni¿ej);
\fB{\fP i \fB}\fP obejmuj± alternacje w stylu \fIcsh\fP(1)
(patrz Rozwijanie Nawiasów poni¿ej);
i, na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s± stosowane
w generacji nazw plików (patrz Wzorce Nazw Plików poni¿ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s³ów i kawa³ków, otoczka tworzy komendy, z których
wyró¿nia siê dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z³o¿one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, konstrukty grupujace i definicje funkcji.
.PP
Prosta komenda sk³ada siê z kombinacji przyporz±dkowañ warto¶ci 
parametrom (patrz Parametry ponizej), przekierowañ wej¶cia/wyj¶cia
(patrz Przekierowania Wej¶cia/Wyj¶cia poni¿ej), i s³ów komend;
Jedynym ograniczeniem jest to, ¿e wszelkie przyporz±dkowania warto¶ci
parametrom musz± poprzedzaæ s³owa komendy.
S³owa komendy, je¶li zosta³y takowe podane, okre¶laj± komendê, któr±
nale¿y wykonaæ, wraz z jej argumentami.
Komenda mo¿e byæ wbudowan± komend± otoczki, funkcj± lub
\fIzewnêtrzn± komend±\fP, \fItzn.\fP, oddzielnym
plikiem wykonywalnym, który zostaje zlokalizowany przy u¿yciu
warto¶ci parametru \fBPATH\fP (patrz Wykonywanie Kommend poni¿ej).
Proszê zwróciæ uwagê i¿ wszelkie konstrukty komendowe posiadaj± 
\fIstatus zakoñczenia\fP: dla zewnêtrznych komend, jest on
powi±zany ze statusem zwracanym przez \fIwait\fP(2) (je¶li
komenda nie zosta³a odnaleziona, wówczas status wynosi 127, 
natomiast je¶li nie mo¿na by³o jej wykonaæ, to status wynosi 126);
statusy zwracane przez inne konstrukty komendowe (komendy wbudowane,
funkcje, ruroci±gi, listy, \fIitp.\fP) s± precyzyjnie okre¶lone
i opisano je w zwi±zku z opisem danego konstruktu.
Status zakoñczenia komendy zawieraj±cej jedynie przyporz±dkowania
warto¶ci parametrom, odopwiada statusowi ostaniego wykonanego podczas tego
przyporz±dkowywnia podstawienia lub zeru, je¶li ¿adne podstawienia nie mia³y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Komendy mog± zostaæ powi±zane przy pomocy oznacznika \fB|\fP w
\fIruroci±gi\fP, w których standardowe wyj¶cie
wszyskich komend poza ostatni±, zostaje pod³±czone
(patrz \fIpipe\fP(2)) do standardowego wej¶cia nastêpnej z szeregu
komend.
Status zakoñczeniowy ruroci±gu, odpowiada statusowi ostatniej komendy
w nim.
Ruroci±g mo¿e zostaæ poprzedzony zarezerwowanym s³owem \fB!\fP,
dziêki czemu status ruroci±gu zostanie zamieniony na jego
logiczny komplement. Tzn. je¶li pierwotnie status wynosi³
0, to bêdzie on mia³ warto¶æ 1, natomiast je¶li pierwotn± warto¶ci±
nie by³o 0, to komplementarnym statusem jest 0.
.\"}}}
.\"{{{  lists
.PP
\fIListê\fP komend tworzymy rozdzielaj±c ruroci±gi
poprzez jeden z nastêpuj±cych oznaczników:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj± warunkowe wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko, je¶li status zakoñczenia \fIcmd1\fP by³ zerowy.
Natomiast \fB||\fP zachowuje siê dok³adnie przeciwstawnie. \(em \fIcmd2\fP 
zostaje wykonane jedynie, je¶li status zakoñczeniowy \fIcmd1\fP by³
ró¿ny od zera.
\fB&&\fP i \fB||\fP wi±¿± równowa¿nie, a zarazem mocniej ni¿
\fB&\fP, \fB|&\fP i \fB;\fP, które równie¿ posiadaj± t± sam± si³ê wi±zania.
Oznacznik \fB&\fP powoduje, ¿e poprzedzaj±ca go komenda zostanie wykonana
asynchronicznie, tzn., otoczka odpala dan± komendê, jednak nie czeka na jej
zakoñczenie (otoczka ¶ledzi dok³adnie wszystkie asynchronicznye
komendy \(em patrz Kontroloa Zadañ poni¿ej).
Ja¶li asynchroniczna komenda zostaje zastartowana z wy³±czony±
kontrol± zadañ (\fInp.\fP, w wiêkszo¶ci skryptów), 
wówczas komenda zostaje odpalona z wy³±czonymi sygna³ami INT
i QUIT, oraz przekierowanym wej¶ciem na /dev/null
(aczkolwiek przekierowania, ustalone w samej asynchronicznej komendzie
maj± tu pierwszeñstwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi±cy specjalnego
rodzaju asynchroniczn± komendê (patrz Koprocesy poni¿ej).
Proszê zwróciæ uwagê, i¿ po operatorach \fB&&\fP i \fB||\fP 
musi wystêpowaæ komenda, podczas gdy niekoniecznie
po \fB&\fP, \fB|&\fP i \fB;\fP.
Statusem zakoñczenia listy komend jest status ostatniej wykonanej w niej
komendy z wyj±tkiem asynchronicznych list, dla których status wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Z³o¿none komendy tworzymy przy pomocy nastêpuj±cych zarezerwowanych s³ów
\(em s³owa te zostaj± jedynie rozpoznane, gdy nie s± wycytowane i
wystepuj± jako pierwsze wyrazy w komendzie (\fIdok³aniej\fP, nie s± poprzedzane
¿adnymi przyporz±dkowywaniami warto¶ci parametrom
lub przekierowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niektóre otoczki (lecz nie nasza) wykonuj± rozkazy kontrolne, 
je¶li jeden lub wiêcej z ich deskryptorów plików zosta³y przekierowane, 
w podotoczce tak wiêc wszekiego rodzaju zmiany otoczenia w nich mog±
nie dzia³aæ.
Aby zachowaæ portabilijno¶æ nale¿y stosowaæ rozkaz \fBexec\fP,
zamiast przekierowañ deskryptorów plików przed rozkazem kontrolnym.
.PP
W nastêpuj±cym opisie z³o¿onych komend, listy komend (zanaczone przez 
\fIlista\fP) koñcz±ce siê zarezerwowanym s³owem
musz± koñczyæ siê ¶rednikiem lub prze³amaniem wiersza lub (poprawnym
gramatycznie) zarezerwowanym s³owem.
Przyk³adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s± poprawne, naotmiast
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlistê\fP w podotoczce.  Nie ma bezpo¶redniej mo¿liwo¶ci
przekazania warto¶ci parametrów podotoczki zpowrotem do jej
otoczki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Z³o¿ony konstrukt; \fIlista\fP zostaje wykonana, lecz nie w podotoczce.
Prosze zauwa¿yæ, i¿ \fB{\fP i \fB}\fP, to zarezerwowane s³owa, a nie
meta-znaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs³owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra¿enie \fBcase\fP stara siê podpasowaæ \fIs³owo\fP pod jeden
z danych \fIwzorców\fP; \fIlista\fP, powi±zana z pierwszym
poprawnie podpasowanym wzorcem, zostaje wykonana.  
Wzorce stosowane w wyra¿eniach \fBcase\fP odpowiadaj± wzorcom
stosowanymi do specyfikacji wzorców nazw plików z wyj±tkeim tego, ¿e
ograniczenia zwi±zane z \fB\&.\fP i \fB/\fP nie zachodz±.  
Proszê zwróciæ uwagê na to, ¿e wszelkie niewycytowane bia³e
przerwy przed i po wzorcu zostaj± usuniête; wszelkie przerwy we wzorcu
musz± byæ wycytowane.  Zarówno s³owa jak i wzorce podlegaj± podstawieniom
parametrów, rozwiniêciom arytmetycznym jak te¿ i podstawieniu szlaczka.
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykaj±cy zamiast \fBin\fP i \fBesac\fP 
(\fIw szczegóno¶ci wiêc\fP, \fBcase $foo { *) echo bar; }\fP).
Statusem wykonania wyra¿enia \fBcase\fP jest status wykonanej
\fIlisty\fP; je¶li nie zosta³a wykanana ¿adna \fIlista\fP, 
wówczas status wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest, albo przerwaniem wiersza, albo \fB;\fP.
Dla ka¿dego \fIs³owa\fP w podanej li¶cie s³ów, parameter \fInazwa\fP zostaje
ustawiony na to s³owo i \fIlista\fP wykonana. Je¶li nie u¿yjemy \fBin\fP 
do specyfikacji listy s³ów, wówczas zostaj± u¿yte parametry pozycyjne
(\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP) wzamian.
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP 
(\fIw szczególno¶ci\fP, \fBfor i; { echo $i; }\fP).
Statusem wykonania wyra¿enia \fBfor\fP jest ostatni status
wykonania danej \fIlisty\fP; je¶li \fIlista\fP nie zosta³a w ogóle
wykonana, wówczas status wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je¶li status wykonania pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je¶li mamy takow±,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami.  Je¶li wszystkie listy po \fBif\fP
i \fBelif\fPs wyka¿± b³±d (\fItzn.\fP, zwróc± niezerowy status), to
\fIlista\fP po \fBelse\fP zostanie wykonana.
Statusem wyra¿enia \fBif\fP jest status wykonanej \fIlisty\fP,
nieokre¶laj±cej warunek; Je¶li ¿adna nieokre¶laj±ca warunek
\fIlista\fP niezostanie wykonana, wówczas status wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest, albo prze³amaniem wiersza albo \fB;\fP.
Wyra¿enie \fBselect\fP umo¿liwia automatyczn± prezentacjê u¿ytkownikowi
menu, wraz z mo¿liwo¶ci± wyboru z niego.
Przeliczona lista wykazanych \fIs³ów\fP zostaje wypisana na
standardowym wyj¶ciu b³êdów, poczym zostaje
wy¶wietlony zachêcacz (\fBPS3\fP, czyli domy¶lnie `\fB#? \fP').
Nastêpnie zostaje wczytana liczba odpowiadaj±ca danemu punktowi
menu ze standardowego wej¶cia, poczym \fInazwie\fP 
zostaje przyporz±dkowane w ten sposób wybrane s³owo (lub warto¶æ
pusta, je¶li dane wybór by³ niew³a¶ciwy), \fBREPLY\fP
zostaje przyporz±dkowane to co zosta³o wczytane
(po usuniêciu pocz±tkowych i koñcowych bia³ych przerw),
i \fIlista\fP zostaje wykonan.
Je¶li wprowadzono pusty wiersz (\fIdok³adniej\fP, zero lub wiêcej
znaczków \fBIFS\fP) wówczas menu zostaje podownie wy¶wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zakoñczone, 
wówczas przeliczona lista wyborów zostaje wy¶wietlona ponownie, je¶li
\fBREPLY\fP jest zerowe, zachêcacz zostaje ponownie podany i tak dalej.
Proces ten powtarza siê, a¿ do wczytania znaku zakoñczenia pliku,
otrzymania sygna³u przerwania, lub wykonania wyra¿enia przerwania
w ¶rodku wstêgi.
Je¶li opuszczono \fBin\fP \fIs³owo\fP \fB\&...\fP, wówczas
u¿yte zostaj± parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP, 
\fIitp.\fP).
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczególno¶ci\fP, 
\fBselect i; { echo $i; }\fP).
Statusem zakoñczenia wyra¿enia \fBselect\fP jest zero, je¶li
uzyta wyra¿enia przerwania do wyjscia ze wstêgi, albo
nie-zero w wypadku przeciwnym.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia³a dok³adnie jak \fBwhile\fP, z wyj±tkiem tego, ¿e zawarto¶æ
wstêgi zostaje wykonana jedynie gdy status pierwszej 
\fIlisty\fP jest nie-zerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra¿enie \fBwhile\fP okre¶la wstêgê o przedbiegowym warunku jej
wykonania.  Zawarto¶æ wstêgi zostaje wykonywana dopuki,
doputy status wykonania pierwszej \fIlisty\fP jest zerowy.
Statusem zakoñczeniowym wyra¿enia \fBwhile\fP jest ostatni 
status zakoñczenia \fIlisty\fP w zawarto¶ci tej wstêgi; 
gdy zawarto¶æ nie zostanie wogóle wykonana wówczas status wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcjê o nazwie \fInazwa\fP.
Patrz Funkcje poni¿ej.
Proszê zwróciæ uwagê, ¿e przekierowania tu¿ po definicji
funkcji zostaj± zastosowane podczas wykonywania jej zawarto¶ci, 
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fIname\fP \fB()\fP \fIcommand\fP"
Niemal dok³adnie to samo co w \fBfunction\fP.
Patrz Funkcje poni¿ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra¿enie\fP \fB))\fP"
Warto¶æ wyra¿enia arytmetycznego \fIwyra¿enie\fP zostaje przeliczona;
równowa¿ne do \fBlet "\fP\fIwyra¿enie\fP\fB"\fP.
patrz Wyra¿enia Arytmetyczne i komenda \fBlet\fP poni¿ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (które opisyjemy 
pó¿niej), z nastêpuj±cymi ró¿nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie pól i generacja nazw plików nies± wykonywana na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub), zostaj± zast±pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok³adniej.\fP, \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP) 
musz± byæ wycytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczególno¶ci\fP, porównanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP
które zwracaj± prawdê, gdy pierwszy ci±gowy operand jest mniejszy lub 
odpowiednio wiêkszy do drugiego operanda ci±gowego.
.IP \ \ \(bu
Jednoargumentowa postaæ operacji \fBtest\fP,
w której sprawdza siê czy jedyny operand jest d³ugo¶ci zeroweji, jest 
niedozwolona
- operatory zawsze muszê byæ wykazywane jawnie, \fIw szczególno¶ci\fP, 
zamiast
.ce
\fB[\fP \fIci±g\fP \fB]\fP
nale¿y u¿yæ
.ce
\fB[[ \-n \fP\fIci±g\fP\fB ]]\fP
.IP \ \ \(bu
Podstawienia parametrów, komend i arytmetyczne zostaj± wykonane
w trakcie wyliczania wyra¿enia. Do operatorów
\fB&&\fP i \fB||\fP zostaje zastosowana metoda ogródkowego wyliczania
ich warto¶ci.
To znaczy, ¿e w wyra¿eniu
.ce
\fB[[ -r foo && $(< foo) = b*r ]]\fP
warto¶æ \fB$(< foo)\fP zostaje wyliczona wtedy i tylko wtedy, gdy
plik o nazwie \fBfoo\fP istnieje i jest czytelny.
.nr PD \n(P2
.RE
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Quoting
.SS Wycytowywanie
Wycytowywanie stosuje siê to zapobiegania, aby otoczka trakotwa³a
znaki lub s³owa w specjalny sosób.
Istniej± trzy metody wycytowywania: Po pierwsze, \fB\e\fP wycytowywuje
nastêpny znak, gdy tylko nie mie¶ci siê on na koñcu wiersza, gdzie
zarówna \fB\e\fP jak i przeniesienie wiersza zostaj± usuniête.
po drugie pojedyñczy cydzys³ow (\fB'\fP) wycytowywuje wszystko,
a¿ po nastêpny pojedyñczy cudzys³ów (wraz z prze³amaniami wierszy w³±cznie).
Po trzecie, podwójny cudzys³ów (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a¿ po nastêpny niewycytowany podwójny 
cudzys³ów.
\fB$\fP i \fB`\fP wewnatrz podwójnych cudzys³owów zachowuj± zwyk³e 
znacznie (\fItzn.\fP,
znaczaj± podstawienie warto¶ci parametru, komendy lub wyra¿enia arytmetycznego),
je¶li tylko niezostanie wykonany jakikolwiek podzia³ pól na
wyniku podwójnymi cudzys³owami wycytowanych podstawieñ.
Je¶li po \fB\e\fP, wewnatrz podwójnymi cudzys³owami wycytowanego
ci±gu znaków, nastêpuje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zastêpiony drugim z tych znaków;
je¶li nastêpne jest prze³amanie wierszu, wówczas zarówno \fB\e\fP 
jak i prze³amanie wirszu zostaj± usuniête;
w przeciwnym razie zarówno znak \fB\e\fP jak i nastêpuj±cy po nim znak
nie podlegaj± ¿adnej zamianie.
.PP
Uwaga: patrz Tryb POSIX poni¿ej pod wzglêdem szczególnych regó³
obowi±zuj±cych sekwencje znaków postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej± dwa rodzaje aliasów: normalne aliasy komend i
¶ledzone aliasy.  Aliasy komend stosowane s± zwykle jako
skróty dla d³ugich a czêsto stosowanych komend. 
Otoczka rozwija aliasy komend (\fItzn.\fP,
odstawia pod nazwê aliasu jest zawarto¶æ), gdy wczytuje
pierwsze s³owo komendy. 
Roziwniêty alias zostaje ponownie przetworzony, aby uwzglêdniæ
ewentualne wystêpowanie dlaszych aliasów.  
Je¶li alias komendy koñczy siê przerw± lub tabulatorem, to wówczas
nastêpne s³owo zostaje równie¿ sprawdzone pod wzglêdem rozwiniêcia
aliasów. Proces rozwijania aliasów koñczy siê przy napotkaniu
s³owa, które nie jest aliasen, gdy napotknie siê na wycytowane s³owo,
lub gdy napotka siê na alias, który jest w³a¶nie wyeksportowywany.
.PP
Nastêpuj±ce aliasy s± definiowane domy¶lnie przez otoczkê:
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
¦ledzone aliasy pozwalaj± otoczce na zapamiêtanie, gdzie
odnalaz³a ona konkretn± komendê.
Gdy otoczka po raz pierwszy odszukuje komendy po tropie, która
zosta³a naznaczona ¶ledzonym aliasem, wowczas zapamiêtywuje ona
sobie pe³ny trop do tej komendy.
Gdy otoczka nastêpnie wykonuje danê komendê poraz drugi,
wówczas sprawdza ona czy ten trop wci±¿ jest nadal aktualny i je¶li
tak nie przegl±da ju¿ wiêcej pe³nego tropu w poszukiwaniu
danej komendy.
¦ledzone aliasy mo¿na wy¶wietliæ lub stworzyæ stosuj±c \fBalias
\-t\fP.  Proszê zauwa¿yæ, ¿e zmieniajac warto¶æ parametru \fBPATH\fP 
równie¿ wyczyszczamy tropy dla wszelkich ¶ledzoenych aliasów.
Je¶li zosta³a w³±czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP), 
wówczas otoczka ¶ledzi wszelkie komendy. 
Ta opcja zostaje w³±czona domy¶lnie dla wszelkich
nieinterakcyjnych otoczek.
Dla otoczek interakcyjnych, jedynie nastêpuj±ce komendy, s± 
¶ledzone domy¶lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki otoczka wykonyje, podczas wykonywania
prostej komendy, jest przeprowadzenia podstawieñ na s³owach tej¿e
komendy.
Istniej± trzy rodzaje podstawieñ: parameterów, komend i arytmetyczne.
Podstawienia parametrów, które dok³adniej opiszemy w nastêpnej sekcji,
maj± postaæ \fB$name\fP lub \fB${\fP...\fB}\fP; 
podstawienia komend maj± postaæ \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je¶li podstawienie wystêpuje poza podwójnymi cudzys³owami, wówczas 
wynik tego podstawienia podlega zwykle podzia³owi s³ów lub pól, w zale¿no¶ci
od bierz±cej warto¶ci parametru \fBIFS\fP.
Parametr \fBIFS\fP specyfikuje listê znaczków, które
s³u¿± jako rozgraniczniki w podziale ci±gów znaków na pojedyñcze 
wyrazy;
wszelkie znaki wymienione w tym zbiorze oraz tabulator, przerywacz i 
prze³amanie wiersza w³±cznie, nazywane s± \fIIFS bia³ymi przerywaczami\fP.
Ci±gi jednego lub wielu bia³ych przerywaczy z IFS w powi±zaniu
z zerem oraz jednym lub wiêcej bia³ych przerywaczy nie wymienionych w IFS,
rozgraniczaj± pola.
Jako wyj±tek poprzedajace i koñcowe bia³e przerywacze z IFS zostaj± usuniête
(\fItzn.\fP, nie powstaj± przezeñ ¿adne prowadz±ce lub zakañczaj±ce
puste pola); natomiast prowadz±ce lub koñcz±ce bia³e przerwy nie z IFS
definiuj± okre¶laj± puste pola.
Przyk³adowo: je¶li \fBIFS\fP zawiera `<spacja>:', to ci±g
znaków `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Proszê zauwa¿yæ, ¿e je¶li parametr \fBIFS\fP 
jest ustawiony na pusty ci±g znaków, to wówczas ¿aden podzia³ pól
nie ma miejsca; gdy paramter ten nie jest ustawiony w ogóle,
wówczas stosuje siê domy¶lnie jako rozgraniczniki
przerwy, tabulatora i przerwania wiersza.
.PP
Je¶li nie podajemy inaczej, to wynik podstwaienia
podlega równie¿ rozwijaniu nawiasów i nazw plików (patrz odpowiednie
akapity poni¿ej).
.PP
Podstawienie komendy zostaje zast±pione wyj¶ciem, wygenerowanym
podczas wykonania danej komendy przez podotoczkê.
Dla podstawienia \fB$(\fP\fIkomeda\fP\fB)\fP zachodz± normalne
regó³y wycytowywania, podczas analizy \fIkomendy\fP,
choæ jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu¿ po nim, zostaje usuniêty
(znak \fB\e\fP z nastêpstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyjatkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczajaca podstawienie zawarto¶ci pliku \fIplik\fP 
($(< foo) ma wiêc ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony ¿aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra¿enia \fB$(\fP\fIkomendacommand\fP\fB)\fP s± analizowane
obecnie poprzez odnajdywanie zaleg³ego nawiasu, niezale¿nie od
wycytowañ.  Miejmy nadziejê, ¿e to zostanie jak najszybciej
skorygowane.
.PP
Podstwaienia arytmetyczne zostaja zast±pione warto¶ci± wyniku
danego wyra¿enia.
Przyk³adowo wiêc, komenda \fBecho $((2+3*4))\fP wy¶wietla 14.
Patrz Wyra¿enia Arytmetyczne aby odnale¼æ opis \fIwyra¿eñ\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w otoczce; mo¿na im przyporz±dkowywaæ 
warto¶ci, oraz wyczytywaæ je poprzez podstwaienia parametrowe.
Nazwa parametru jest albo jednym ze znaków 
intperpunkyjnych o specjalnym znaczeniu lub cyfr±, jakie opisujemy 
poni¿ej, lub liter± z nastêpstwem jednej lub wiêcej liter albo cyfr
(`_' zalicza siê to liter).
Podstawienia parametrów posiadaj± postaæ \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdziee \fInazwa\fP jest nazw±
danego parametru.
Gdy podstawienia zostanie wykonane na parametrzy, który nie zosta³
ustalony, wówczas zerowy ci±g znaków jest jego wynikiem, chyba ¿e
zosta³a w³aczona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP) co oznacza, ¿e wystêpuje wówczas b³±d.
.PP
.\"{{{  parameter assignment
Warto¶ci mo¿na przyporz±dkowywaæ parametrom na wiele ró¿nych sposobów.
Po pierwsze, otoczka domy¶lnie ustala pewne parametry takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny sposób w jaki parametry zwi±zana 
ze specjalnymi jednoznakami s± ustawiane.  Po drugie, parametry zostaj± 
importowane z otocznia otoczki podczas jej odpalania.  Po przecie,
parametrom mo¿na przyporz±dkowaæ warto¶ci we wierszu komendy, tak jak np.,
`\fBFOO=bar\fP' przyporz±dkowywuje parametrowi FOO warto¶æ bar;
wielokrotne przyporz±dkowania warto¶ci s± mo¿liwe w jednym wierszu komendy
i mo¿e po nich wystêpowaæ prosta komenda, co powoduje, ¿e
przyporz±dkowania te s± wówczas jedynie aktualne podczas
wykonywywania danej komendy (tego rodzaju przyporz±dkowywania
zostaj± równie¿ wyekstportowane, patrz poni¿ej co do tego konsekwencji).
Proszê zwróciæ uwagê, i¿, aby otoczka rozpozna³a je jako
przyporz±dkowanie warto¶ci parametrowi, zarówno nazwa parametru jak i \fB=\fP
nie mog± byæ wycytowane.
Czwartym sposobem ustawiania parametrów jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale Wykonywanie Komend.
Po czwarte wstêgi \fBfor\fP i \fBselect\fP ustawiaj± parametry,
tak jak i równie¿ komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zakoñczenie, paramerom mo¿na przyporz±dkowywaæ warto¶ci stosuj±c
operatory nadania warto¶ci wewn±trz wyra¿eñ arytmetycznych
(patrz Wyra¿enia Arytmetyczne poni¿ej) lub
stosujac postaæ \fB${\fP\fInazwa\fP\fB=\fP\fIwarto¶æ\fP\fB}\fP
podstawienia parametru (patrz poni¿ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem exportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP,albo poprzez przyporz±dkowywanie warto¶ci
parametru z nastêpuj±c± prost± komend±) 
zostaj± umieszczone w otoczeniu (patrz \fIenviron\fP(5)) komend
wykonywanych przez otoczke jako pary \fInazwa\fP\fB=\fP\fIwarto¶æ\fP.
Kolejno¶æ w jakiej parametry wystêpuj± w otoczeniu komendy jest 
nieustalona bli¿ej.
Podczas odpalania otoczka pozyskuje parametry ze swojego
otoczenia,
i automatycznie ustawia na tych¿e parametrach atrybut exportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo¿na stosowaæ modyfikatory do postaciu \fB${\fP\fInazwa\fP\fB}\fP 
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna
warto¶æ, w przeciwnym razie zostaje podstawione \fIs³owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje podstawione 
\fIs³owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastwaiony i niezerowy, wówczas zostaje podstawiony 
on sam, w przeciwnym razie zostaje my przyporz±dkowana warto¶æ
\fIs³owo\fP i warto¶æ wynikaj±ca ze \fIs³owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna warto¶æ, w przeciwnym razie \fIs³owo\fP
zostaje wy¶wietlone na standardowym wyj¶ciu b³êdów (tu¿ po \fInazwa\fP:)
i zachodzi b³±d
(powoduj±cy normalnie zakoñczenie ca³ego skryptu otoczki, funkcji lub \&.-scryptyu).
Je¶li s³owo zosta³o pominiête, wówczas zostaje u¿yty ci±g 
`parameter null or not set' w zamian.
.PP
W powy¿szych modyfikatorach mo¿emy omin±æ \fB:\fP, czego skutkiem
bêdzie, ¿e warunki bêd± jedynie wymagaæ aby
\fInazwa\fP by³ nastawiony lub nie (a nie ¿eby by³ ustawiony i niezerowy).
Je¶li potrzebna jest warto¶æ \fIs³owo\fP, wówczas zostaj± nañ wykonane
podstawienia parametrów, komend, arytmetyczne i szlaczka;
natomiast, je¶li \fIs³owo\fP oka¿e siê byæ niepotrzebne, wówczas jego
warto¶æ nie zostanie obliczona.
.\"}}}
.PP
Mo¿na stosowaæ, równie¿ podstawienia parametrów o nastêpuj±cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Ilo¶æ parametrów pozycyjnych, je¶li \fInazw±\fP jest \fB*\fP, \fB@\fP lub
niczego nie podano, lub d³ugo¶æ ci±gu bêd±cego wasto¶ci± parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Ilo¶æ elemntów w ci±gu \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak³ada siê na pocz±tek warto¶ci parametru \fInazwa\fP,
wówczas pasuj±cy teks zostaje pominiêty w wynikajacym z tego podstawieniu. 
Pojedyñczy \fB#\fP oznacza najkrótsze mo¿liwe podpasowanie pod wzorzec, a daw \fB#\fP
oznaczaj± jak najd³u¿sze podpasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko ¿e dotyczy
koñca warto¶ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nastêpuj±ce specjalne parametry zostaja ustawione domy¶nie przez otoczkê
i nie mo¿na przyporz±dkowywaæ jawnie warto¶ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego zastartowanego w tle procesu. Je¶li nie ma
aktualnie procesów zastartowanych w tle, wówczas parametr ten jest 
nienastawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Ilo¶æ parametrów pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj±cego danej otoczce lub PID pierwotnej otoczki,
je¶li mamy do czynienia z  podotoczk±.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenecja bierz±cych opcji jednoliterkowych
(patrz komenda \fBset\fP poni¿ej, aby poznaæ dostêpne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Status wynikowy ostatniej wykonanej  nieasynchronicznej komendy.
Je¶li ostatnia komenda zosta³a zabita sygna³em, wówczas, \fB$?\fP 
przyjmuje warto¶æ 128 plus numer danego sygna³u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa pod jak± dana otoczka zosta³a wywo³ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP je¶li zosta³a ona wywo³ana przy urzyciu opcji \fB\-c\fP 
i \fBnazwa komendy\fP zosta³a podana, lub argument \fIplik\fP,
je¶li takowy zosta³ podany.
Je¶li opcja \fBposix\fP nie jest nastawiona, to \fB$0\fP zawiera
nazwê bie¿±cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewiêc parametrów pozycyjnych podanych otoczce, czy
funkcji lub \fB.\fP-skriptowi.
Dostêp do dlaszych parametrów pozycyjnych odbywa siê przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj±tkiem parametru 0), 
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u¿yte poza podwójnymi cudzys³owami, wówczas parametry zostaj±
rozgraniczone w pojedyñcze s³owa
(podlegaj±ce rozgraniczaniu s³ów); je¶li u¿yte pomiêdzy 
podwójnymi cudzys³owami, wowczas parametry zostaj± rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci±gami znaków, je¶li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj±tkiem zastosowania w podwójnych cudzys³owach,
gdzie oddzielne s³owo zostaje wygenerowane dla ka¿dego parametru
pozycyjnego z osobna \- je¶li brak parametrów pozycyjnych,
wówczas nie generowane jest ¿adne s³owo
("$@" mo¿e byæ uzyte aby otrzymaæ dostê bezpo¶redni do argumentów
bez utraty argumentów zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nastêpuj±ce parametry zostaj± nastawione przez otoczkê:
.\"{{{  _
.IP "\fB_\fP \fI(podkre¶lenie)\fP"
Gdy jaka¶ komenda zostaje wykonywana prze otoczkê, ten parametrt przyjmuje
w otoczeniu odpowiedniego nowego procesu warto¶æ tropu prowadz±cego
do tej¿e komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierowtej otoczce
ponadto warto¶æ ostatniego s³owo poprzedniej komendy
Podczas warto¶ciowania wiadomosci typu \fBMAILPATH\fP,
parametr ten zawiera wiêc nazwê pliku który siê zmieni³
(patrz parametr \fBMAILPATH\fP poni¿ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
Trop do przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia³a tak samo jak
\fBPATH\fP dla katalogów nierozpoczynajacych siê od \fB/\fP 
w komendach \fBcd\fP.
Proszê zwróciæ uwagê, i¿ je¶li CDPATH jest nastawiony i nie zwaiera ani
\fB.\fP ani pustego tropu, to wówczas katalog bie¿±cy nie zostaje przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Ilo¶æ kolumn terminala lub okienka.
Obecnie nastawiany warto¶ci± \fBcols\fP zwracan± przez komendê
\fIstty\fP(1), je¶li ta warto¶æ nie wynosi zera.
Parametr ten ma znaczenia w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w³a¶ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je¶li nie zosta³ nastawiony parametr \fBVISUAL\fP, wówczas kontroluje on
tryb edycj wiersza komendy w otoczkach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni¿ej, aby dowiedzieæ siê jak to dzia³a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je¶li parametr ten oka¿e siê byæ nastawionym po przetworzeniu
wszelkich plików profilowych, wówczas jego rozwinieta warto¶æ zostaje
wyko¿ystana jako nazwa pliku zawieraj±cego dalsze komendy inicjalizacyjne
otoczki.  Zwykle zwiera on definicje funkcji i aliasów.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca³kowita warto¶æ odpowiadaj±ca zmiennej errno otoczki 
\(em wskazuje przyczynê wyst±pienia b³êdu, gdy ostatnie wywoa³nie
systemowe nie powiod³o siê.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezimplementowe.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je¶li nastawiono, to wówczas zawiera otoczkê, jakiej nale¿y u¿yæ
do wykonywania komend których niezdo³a³ wykonaæ \fIexecve\fP(2) 
i które nie zaczynaja siê od ci±gu `\fB#!\fP \fIotoczka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u¿ywany przez komendê \fBfc\fP (patrz poni¿ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je¶li otoczka natrafi na niezdefiniowan± 
funkcjê podczas pracy, stosowane do lokalizacji pliku zawieraj±cego definicjê
tej funkcji.
Równie¿ przeszukiwane, gdy komenda nie zosta³a odnaleziona przy
u¿yciu \fBPATH\fP.
Patrz Funkcje poni¿ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u¿ywanego do zapisu histori komend.
Je¶li warto¶æ zosta³a ustalona, wówczas historia zostaje za³adowana
z danego pliku.
Podobnie wielokrotne wcielenia otoczki bêd± ko¿ysta³y z jednej
historii, je¶li dla nich warto¶ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je¶li HISTFILE nie zosta³o ustawione, wówczas ¿aden plik histori
nie zostaje u¿yty.  W originalnej wersji otoczki
Korna natomiast, przyjmuje siê domy¶lnie \fB$HOME/.sh_history\fP;
w przysz³o¶ci mo¿e pdksh, bêdzie równie¿ sotoswa³ domy¶lny
plik histori.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Ilo¶æ komend zapamiêtywana w histori, domy¶lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy¶lna warto¶æ dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz Rozwijanie Szlaczka poni¿ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewnêtrzny separator pól, sotoswany podczas podstawieñ
i wykonywania komendy \fBread\fP, do rozdzielania
warto¶ci na oddzielne argumenty; domy¶nie przerwa, tabulator i 
prze³amanie wiersza. Szczególy zosta³y opisane w punkcie Podstawienia
powy¿ej.
.br
\fBUwaga:\fP ten parametr nie zostaje importowany z otoczenia, 
podczas odpalania otoczki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja i data kompilacji otoczki (tylko do otczytu).
Patrz równie¿ na komedy wersji w Emacsowej Interakcyjnej Edycji Wiersza 
Komendy i Edycji Wiersza Vi poni¿ej.
.\"}}}
.\"{{{  SH_VERSION
.\"}}}
.\"{{{  LINENO
.IP \fBLINENO\fP
Numer wiersza w funkcji lub aktualnie wykonywanym skrypcie.
.\"}}}
.\"{{{  LINES
.IP \fBLINES\fP
Ilo¶æ wierszy terminala lub okienka pracy.
.\"Currently set to the \fBrows\fP value as reported by \fIstty\fP(1) if that
.\"value is non-zero.
.\" todo: LINES variable
.sp
Jeszcze nie zimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je¶li nastawiony, to u¿ytkownik jest informaowany
o nadej¶ciu nowej poczty do ustawionego tam pliku docelowego.
Ten parametr jest ignorowany, je¶li
zosta³ nastawiony parametr \fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak czêsto otoczka ma sprawdzaæ, czy pojawi³a siê
w plikach podanych poprzez \fBMAIL\fP lub \fBMAILPATH\fP nowa poczta. 
Je¶li 0, to otoczka sprawdza przed ka¿d± now± zachêt±.  
Warto¶ci± domy¶ln± jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
Lista plików sprawdzanych o now± pocztê.  Lista ta jest rozdzielana
dwukropkami, ponadto po nazwie ka¿dego z plików mo¿na podaæ
\fB?\fP i wiadomo¶æ która ma byæ wy¶wietlona, je¶li nadesz³a nowa poczta.  
Podstawienia komend parametrów i arytmetyczne zostaj± wykonane na
danej wiadomo¶ci. Podczas postawieñ parametr \fB$_\fP
zawiera nazwê tego¿ pliku.
Domy¶lnym zawiadomieniem jest \fByou have mail in $_\fP 
(\fBmasz pocztê w $_\fP).
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nieustalony, je¶li \fBcd\fP nie zmieni³o z powodzeniem
katalogu od czasu odpalenie otoczki lub je¶li otoczka nie wie gdzie
siê aktualnie obraca.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
Podczas u¿ywania \fBgetopts\fP, zawiera argument dla aktulanie
rozpoznawanej opcji, je¶li jest on oczekiwany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostoaniego przetworzonego argumentu podczas u¿ywania \fBgetopts\fP.
Przyporz±dkowanie 1 temu parametrowi powoduje, ¿e \fBgetopts\fP
przetwarza arugmenty od pocz±tku, gdy zostanie wywo³ane ponownie.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem od siebie katalogów, które s± przeszukiwane
podczas odnajdywania jakiej¶ komendy lub plików typu \fB.\fP.
Pusty ci±g wynikaj±cy z poprzedzaj±cego lub nastêpuj±cego dwukropka,
albo dwuch s±siednich dwukropków, jest trakowany jako `.',
czyli katalog bierz±cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Nstawienie tego parametru powoduje w³±czenie opcji \fBposix\fP.
Patrz Tryp POSIX-owy poni¿ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzicielskiego otoczki (tylko odczyt).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP zachêcacz pierwszego rzêdu dla otoczek interakcyjnych.
Podlega podstawieniom parametrów, komend i arytmetycznym, poand to
\fB!\fP zostaje zast±pione numerem kolejnym aktualnej komendy
(patrz komenda \fBfc\fP
poni¿ej).  Sam znak ! mo¿e zostaæ umieszczony w zachêcaczu stosuj±c 
!! w PS1.
Zauwa¿, ¿e poniewa¿ edytory wiersza komendy staraj± siê obliczyæ,
jak d³ugi jest zachêcacz, (aby móc ustaliæ, ile miejsca pozostaje
wolnego do  parwego brzegu ekranu), sekwencje wyj¶ciowe w zachêcaczu 
zwykle wprowadzaj± pewien ba³agan.
Istnije mo¿liwo¶æ podpowiedzenia otoczce, ¿eby nie uwzglêdnia³a
pewnych ci±gów znaków (takich jak kody wyj¶cia) poprzez podanie
predsionka na pocz±tku zachêcacza bêd±cego niewy¶wietlalnym znakiem
(takim jak np. control-A) z nastêpstwem prze³amania wiersza,
oraz odgraniczaj±c nastêpnie kody wyj¶cia przy pomocy tego 
niewy¶wietlalnego znaku.
Gdy brak niewy¶wietlalnych znaków, to nie ma ¿adnej rady...
Nawiasem mówi±c nie ja jestem odpowiedzialny za ten hack. To pochodzi
z orginalnego ksh.
Domy¶ln± warto¶ci± jest `\fB$\ \fP' dla nieuprzywilejownych
u¿ytkowników, a `\fB#\ \fP' dla root-a..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Durugorzêdny zachêcacz, o domy¶lnej warto¶ci `\fB>\fP ', który
jest stosowany, gdy wymagane s± dalsze wprowadzenia w celu
skompletowania komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zachêcacz stosowany przez wyra¿enie
\fBselect\fP podczas wczytywania wyboru z menu.
Domy¶lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, które zostaj± wy¶wietlone podczas
¶ledzenia toku pracy
(patrz komenda \fBset \-x\fP poni¿ej).
Domy¶lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo¿e byæ nienastawiony lub zerowy, je¶li
otoczka nie wie gdzie siê znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb pseudo przypadkowych. Za ka¿dym razem, gdy
odnosimy siê do \fBRANDOM\fP jego warto¶ci zostaje przyporz±dkowana
nastêpna liczba z przypadkowego ci±gu liczb.
Miejsce w danym ci±gu mo¿e zostaæ ustawione nadaj±c
warto¶æ \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy¶lny parametr dla komendy
\fBread\fP, je¶li nie pozostan± podane jej ¿adne nazwy.
Stosowany równie¿ we wstêgach \fBselect\fP do zapisu warto¶ci
wczytywanej ze standardowego wej¶cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Sekundy, które up³ynê³y od czasu odpalenia otoczki, lub je¶li
parametrowi zosta³a nadana warto¶æ ca³kowita, ilo¶æ sekund od czasu
nadania tej warto¶ci plus ta warto¶æ.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy nastawiony na pozytywn± warto¶æ ca³kowit±, wiêksz± od zera,
wówczas ustala w interkacyjnej otoczce czas w sekundach, przez jaki
bêdzie ona czeka³a na wprowadzenie po wy¶wietleniu pierwszorzêdnego
zachêcacza (\fBPS1\fP).  Po przekroczeniu tego czasu otoczka zostaje 
opuszczona.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog w którym tymczasowe pliki otoczki zostaj± umieszczone.
Je¶li dany parametr nie zosta³ nastawiony, lub gdy nie zawiera 
pe³nego tropu zapisywalnego katalogy, wówczas domy¶lnie tymczasowe
pliki mieszcz± siê w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je¶li zosta³ nastawiony, ustala tryb edycji wiersza komend w otoczkach
interakcyjnych. Je¶li sotatni cz³onek tropu podanego w danym
parametrze zawierz ci±g znaków \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odopiwednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie Szlaczków"
Roziwaje szlaczków, które ma miejsce równolegle do podstawieñ parametrów,
zostaje wykonane na s³owach rozpoczynaj±cych siê niewycytowanym
\fB~\fP.  Znaki po szlaczku do pierwszego
\fB/\fP, je¶li wystêpuje takowy, s± domy¶lnie traktowane jako
nazwa u¿ytkownika.  Je¶li nazwa u¿ytkownia jest pusta, to \fB+\fP lub \fB\-\fP,
warto¶æ parametrów \fBHOME\fP, \fBPWD\fP, lub \fBOLDPWD\fP zostaje
odpowiednio podstawiona.  W przeciwnym razie zostaje 
przeszukany plik kodów dostêpu w celu odnalezienia danej nazwy
u¿ytkownika, i w miejsce rozwiniêcia szlaczka zostaje
podstawiony katalog domowy danego u¿ytkownika
Je¶li nazwa u¿ytkownika nie zostaje odnalezione w pliku hase³,
lub gdy jakiekolwiek wycytowanie albo podstawienie parametru
wystêpuje  w nazwie u¿ytkownika, wówczas nie zostaje wykonane ¿adne 
podstawienie.
.PP
W nastawieniach parametrów
(tych poprzedzaj±cych proste komendy lub tych wystêpuj±cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie szlaczków zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP), i nazwy u¿ytkowników zostaj± ujête
w dwukropki.
.PP
Katalogi domowe poprzednio rozwinietych nazw u¿ytkowników zostaj±
umieszczone w pamiêci podrêcznej i w ponownym u¿yciu zostaj± stamt±d
pobierane.  Komenda \fBalias \-d\fP mo¿e byæ u¿yta do wylistowania, 
zmiany i dodawnia do tej pamiêci podrêcznej
(\fIw szczególno¶ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie Nawiasów (przemiany)"
Rozwiniêcia nawiasów przyjmuj±ce postaæ
.RS
\fIprefiks\fP\fB{\fP\fIci±g\fP1\fB,\fP...\fB,\fP\fIci±g\fPN\fB}\fP\fIsuffiks\fP
.RE
zostaj± rozwiniête w N wyrazów, z których ka¿dy zawiera konkatenacjê
\fIprefiks\fP, \fIci±g\fPi i  \fIsuffiks\fP
(\fIw szczegóno¶ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwiniête do czterech wyrazów:
ace, abXe, abYe, and ade).
Jak ju¿ wy¿ej wspomniano, rozwiniêci nawiasów mog± byæ nak³adane na siebie
i wynikaj±ce s³owa nie s± sortowane.
Wyra¿enia nawiasowe musz± zawieraæ niewycytowany przecinek
(\fB,\fP) aby nastêpi³o rozwijanie
(\fItak wiêc\fP, \fB{}\fP i \fB{foo}\fP nie zostaj± rozwiniête).
Rozwiniêcie nawiasów nastêpuje po podstawnieniach parametrów i przed
generacj± nazw plików
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce Nazw Plików"
.PP
Wzorcem nazwy pliku jest s³owo zwieraj±ce jeden lub wiêcej z 
niewycytownych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.  
Po wykoaniu rozwiniêci± nawiasów, otoczka zamienia wzorce nazw plików
na uporz±dkowane nazwy plików które pod nadym wzorzec pasuj±
(je¶li ¿adne pliki nie pasuj±, wówczas dane s³owo zostaje pozostawione
bez zmian).  Elemety wzorców posiadaj±nastêpuj±ce znaczenia:
.IP \fB?\fP
obejmuje dowolny pojedyñczy znak.
.IP \fB*\fP
obejmuje dowoln± sekwencjê znaczków.
.IP \fB[\fP..\fB]\fP
obejmuje ka¿dy ze znaczków pomiêczy klamrami.  Zakresy znaczków mog±
zostaæ podane rozczielajac dwa znaczki poprzez \fB\-\fP, \fItzn.\fP,
\fB[a0\-9]\fP objemuje literê \fBa\fP lub dowoln± cyfrê.
Aby przedstawiæ sam znak
\fB\-\fP nale¿y go albo wycytowaæ albo musi byæ to pierwszy lub ostatni znak
w li¶cie znaków.  Podobnie \fB]\fP musi byæ wycytowywane albo pierwszym
lub ostatnim znakiem w li¶cie je¶li ma oznaczaæ samego siebie a nie zakoñczenie
listy.  Równie¿ \fB!\fP wystêpuj±cy na pocz±tmu listy posiada specjalne
znaczenie (patrz poni¿ej), tak wiêc aby reprezentowa³ samego siebie
musi zostaæ wycytowny lub wystêpowaæ dalej w li¶cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko, ¿e obejmuje dowolny znak
nie wystêpuj±cy pomiêdzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka¿dy ci±g zawierajacy zero lub wiêcej wyst±pieñ podanych wzorców.
Przyk³adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci±gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka¿dy ci±g znaków obejumj±cy jedno lub wiêcej wyst±pieñ danych
wzorców.
Przyk³adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci±gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci±g pusty lub ci±g obejmuj±cy jeden z danych wzorców.
Przyk³adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci±gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci±g obejmuj±cy jeden z podanych wzorców.
Przyk³adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy³±cznie ci±gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ciag nie obejmujacy ¿adnego z danych wzorców.
Przyk³adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci±gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje ¿adnego ci±gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci±gi (proszê siê nad tym zastanowiæ).
.PP
Proszê zauwa¿yæ, ¿e wzorce w pdksh obecnie nigdy nie obejmuj± \fB.\fP i
\fB..\fP, w przeciwieñstwie do roginalnej otoczki
ksh, Bourn-a sh i bash-a, tak wiêc to bêdziemusia³o siê ewentualnie 
zmieniæ (na z³e).
.PP
Proszê zauwa¿yæ, ¿e powy¿sze elementy wzorców nigdy nie obejmuj± propki
(\fB.\fP) na pocz±tku nazwy pliku ani pochy³ka (\fB/\fP), 
nawet gdy zosta³y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s± obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je¶li zosta³a nastawiona opcja \fBmarkdirs\fP, wówczas, 
wszelkie katalogi wynikaj±ce z generacji nazw plików
zostaj± oznaczone zakoñczeniowym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znaków (\fItzn.\fP,
\fB[:\fP\fInazwa-klasy\fP\fB:]\fP wewn±trz wyra¿enia typu \fB[\fP..\fB]\fP)
jak narazie nie zosta³y zimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierunkowywanie Wej¶cia/Wyj¶cia"
Podczas wykonywania komendy, jej standardowe wej¶cie, standardowe wyj¶cie
i standardowe wyj¶cie b³êdów (odpowienio deskryptory plików 0, 1 i 2),
zostaj± zwykle dziedziczone po otoczce.
Trzema wyj±taki do tej regó³y s±, komendy w rurociagach, dla których
standardowe lub standardowe wuj¶cie odpowieadaj± tym stalonym przez
rurociag,  komendy asychroniczne stwarzane je¶li kontrola prac zosta³a
wy³aczona, dla których standardowe wej¶cie zostaje ustawnioe na
\fB/dev/null\fP, oraz komendy dla których jedno lub wiele z nastêpuj±cych
przekierunkowañ zosta³o nastawione:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj¶cie zostaje przekierowane do \fIplik\fP-u.  
Je¶li \fIplik\fP nie istnieje, wówczas zostaje stworzony; 
je¶li istnieje i jest to regularny plik oraz zosta³a nastawiona
opcja \fBnoclobber\fP, wówczas wystêpuje b³±d, w przeciwnym razie
dany plik zostaje odciêty do pocz±tku.
Proszê zwróciæ uwagê i¿ oznacza to, ¿e komenda \fIjaka¶ < foo > foo\fP 
otworzy plik \fIfoo\fP do odczytu a naztêpnie
stasuje jego zawarto¶æ gdy otworzy go do zapisu,
zanim \fIjaka¶\fP otrzyma szansê wyczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e zawarto¶æ pliku zostaje skasowana
niezale¿nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e je¶li dany plik ju¿ istnieje
zostaje on rozszerzany zamiast kasowania poprzedniej jego zawaro¶ci.  
Ponad to plik ten zostaje otwarty w trybie rozszerzania, tak wiêc
wszelkiego rodzaju operacje zapisu na nim dotycz± jego aktualnego koñca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej¶cie zostaje przekierunkowane na \fIplik\fP, 
który zostaje otorzony do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko ¿e plik zostaje otworzony w trybie
wpisu i czytanie.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj±cego tego rodzaju przekierunkowanie
(zwane tu-dokumentem), otoczka kopiuje wiersze z komendy
do tymczasowego pliku a¿ po natrafienie na wiersz
odpowiadaj±cy \fIznacznik\fPowi.
podczas wykonywania komendy standardowe wej¶cie zostaje przekierunkowane
na dany plik tymczasowy.
Je¶li \fIznacznik\fP nie zawiera wycytowanych znaków, zawarto¶æ danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera³a siê w 
podwujnych cudzys³owach za, ka¿dym razem gdy dana komenda zostaje wykonana.
Tak wiêc zostaj± na nim wykonane podstawienia parametrów,
komend i arytmetyczne wraz z interpretacj± wstecznego pochylnika 
(\fB\e\fP) i znaków wyj¶æ dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enewline\fP.
Je¶li wiele tu-dokumentów zostaje zastosowanych w jednym i tymsamym
wierszy komendy, wówczas zostaj± one zachowane w podanej kolejno¶ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko ¿e pocz±tkowe tabulatory
zostaj± usuniête w tu-dokumencie.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej¶cie zostaje powielone  z deskryptora pliku \fIfd\fP.
\fIfd\fP mo¿e byæ pojedyñcz± cyfr±, wskazuj±c± na number
istniej±cego deskryptora pliku, literk±  \fBp\fP, wskazujac± na plik
powi±zany w wyj¶ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj±cym, ¿e standardowe wej¶cie powinno zostaæ
zamkniête.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko ¿e operacja dotyczy standardowego wyj¶cia.
.PP
W ka¿dym z powy¿szych przekierunkowañ, mo¿e zostaæ podany jawnie deskryptor
pliku, którego ma ono dotyczyæ, (\fItzn.\fP, standardowego wej¶cia
lub standard wyj¶cia) poprzez poprzedzaj±c± odpowiedni± pojedyñcz± cyfrê.
podstawienia paramertór komend, arytmetyczne, szlaczków tak jak i
(gdy otoczka jest interakcyjna) generacje nazw plików wszystkie 
zostaj± wykonane na argumentach przekierowañ \fIplik\fP, \fInacznik\fP 
i \fIfd\fP.
Proszê jednak zwróciæ uwagê, i¿ wyniki wszelkiego rodzaju przekierunkowañ 
plików zostaj± jedynie u¿yte je¶li zawieraj± jedynie nazwê jednego pliku;
je¶li natomiast obejmuj± one wiele plików, wówczas zostaje zastosowane
dane s³owo bez rozwiniêc wynikaj±cych z generacji nazw plików.
proszê zwróciæ uwagê, i¿ w otoczkach ograniczonych, 
przekierunkowania tworz±ce nowe pliki nie mog± byæ stosowane.
.PP
Dla prostych komend, przekierunkowania mog± wystêpowaæ w dowolnym miejscu
komendy, w komendach z³o¿onych (wyra¿eniach \fBif\fP, \fIitp.\fP), 
wszelkie przekierunkowani musz± znajdowaæ siê na koñcu.
Przekierunkowania s± przetwarzane po tworzeniu ruroci±gów i w kolejno¶ci
w której zosta³y podane, tak wiêc
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy¶wietli b³±d z numerem lini wiersza poprzedzaj±cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra¿enia Arytmetyczne"
Ca³kowite wyra¿enia arytmetyczne mog± byæ stosowane przy pomocy
komendy \fBlet\fP, wewn±trz wyra¿eñ \fB$((\fP..\fB))\fP,
wewn±trz dereferencji ³añcuchów (\fIw szczególno¶ci\fP, 
\fInzwa\fP\fB[\fP\fIwyra¿enie\fP\fB]\fP),
jako numerbyczne argumenty komendy \fBtest\fP,
i jako warto¶ci w przyporz±dkowywaniach do ca³kowitych parametrów.
.PP
Wyra¿enia mog± zawieraæ alfa-numeryczne identyfikatory parametrów,
dereferencje ³añcuchów i ca³kowite sta³e. Mog± zostaæ równie¿
po³±czone nastêpuj±cymi operatorami jêzyka C:
(wymienione i ugrupowane z kolejno¶ci odpowiadaj±cej zwiêkszonej
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
\fB?:\fP (precedencja jest bezpo¶redino wy¿sza od przyporz±dkowania)
.TP
Operatory grupuj±ce:
\fB( )\fP
.PP
Sta³e ca³kowite mog± zostaæ podane w dowolnej bazie, stosuj±c notacjê
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesiêtn± liczb±
ca³kowit± specyfikuj±c± bazê, a \fIliczba\fP jest liczb±
zapisan± w danej bazie.
.LP
Operatory zostaj± wyliczane w nastepuj±cy sposób:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy³±cznie dla pe³no¶ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je¶li argument jest zerowy, a 0 je¶li nie.
.IP "\fB~\fP"
arithmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi byæ zastosowanym do parametru (a nie litera³u lub
innego wyra¿enia) - parametr zostaje powiêkszony o 1.
Je¶li zosta³ zastosowany jako operator prefiksowy, wówczas wynikiem jest 
inkrementowana warto¶æ parametru, a je¶li zosta³ zastosowany jako
operator postfiksowy, to wynikiem jest pierwotna warto¶æ parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko, ¿e wynikiem jest dekrement parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra¿enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nastêpnie prawa strona. Wynikiem jest warto¶æ
wyra¿enia po prawej stronie.
.IP "\fB=\fP"
przyporz±dkowanie; zmiennej po lewej zostaje nadana warto¶æ po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatoray przyporz±dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP 
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je¶il przynajmniej jeden 
z argumentów jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je¶li obydwa argumenty s± niezerowe, 
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewey jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkacja (bit-w-bit).
.IP "\fB==\fP"
równo¶æ; wynikiem jest 1, je¶li obydwa argumenty s± sobie równe, 0 gdy nie.
.IP "\fB!=\fP"
nierówno¶c; wynikiem jest 0, je¶li obydwa arguemnty s± sobie równe, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je¶li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub równe, wieksze lub równe, wiêksze od.  Patrz <.
.IP "\fB<< >>\fP"
przesuñ w lewo (prawo); wynikiem jst lewy argument z bitami przesuniêtymi
na lewo (prawo) o ilo¶æ pól podan± w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, ró¿nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego arguemntu prze prawy.  
Znak wyniku jest nieustalony, je¶li jeden z argumentów jest negatywny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je¶li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to ruroci±g stworzony poprzez operator \fB|&\fP,
który jest asynchronicznym proecsem do którego otoczka mo¿e 
zrówno pisaæ (u¿ywaj±c \fBprint \-p\fP) i czytaæ (u¿ywaj±c \fBread \-p\fP).
Wej¶cie i wyj¶cie koprocesu mog± byæ ponadto manipulowane
przy pomocy przekietowañ \fB>&p\fP i odpowiednio \fB<&p\fP.
Po odpaleniu koprocesu, nastêpne nie mog± byæ odpalane zanim
dany koproces zakoñczy pracê, lub zanim wej¶cie kopocesu
nie zosta³o przekierowane poprzez \fBexec \fP\fIn\fP\fB>&p\fP.
Je¶li wej¶cie koprocesu zostaje przekierowane w ten sposób,
wówczas nastêpny w kolejce do odpalenia koproces bêdzie
wspóldzieli³ wyj¶cie z pierwszym koprocesem, chyba ¿e wyj¶cie pierwszego
koprocesu zosta³o przekierowane przy pomocy
\fBexec \fP\fIn\fP\fB<&p\fP.
.PP
Pewne uwagi dotycz±ce koprocesów:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
jedyn± mo¿liwo¶ci± zamkniêcia wej¶cia koprocesu
(tak aby koproces wczyta³ zakoñczenie pliku) jest przekierowanie
wej¶cia na numerowany deskryptor pliku, a nastêpnie zamkniêcie tego
deskryptora (\fIw szczególno¶ci\fP, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby kopreocesy móg³y wspó³dzieliæ jedno wyj¶cie, otoczka musi
zachowaæ otwart± czê¶ci wpisow± danego ruroci±gu wyj¶ciowego.
Oznacza to, ¿e zakoñczenie pliku nie zostanie wykryte do czasu a¿
wszystkie koprocesy wspó³dziel±ce wyj¶cie koprocesów zostan± zakoñczone
(gdy zostan± one zakoñczone, wówczas  otoczka zamyka swoj± kopiê
ruroci±gu).
Mo¿na temu zapobiec przekierunkowuj±ca wyj¶cie na numerowany
deskryptor pliku
(poniewa¿ powoduje to równie¿ zamkniêcie przez otoczkê swojej kopi).
Proszê zwróciæ uwagê i¿ to zachowaniê siê jest nieco odmienne od orginalnej
otoczki Korn-a, która zamyka swoj± cz±¶æ zapisow± swojej kopi wyj¶cia
koprocesu, gdy ostatnio odpalony koproces 
(zamiast gdy wszystkie wspó³dziel±ce koprocesy) zostanie zakoñczony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna³u SIGPIPE poczas zapisu, je¶li
dany sygna³ nie zosta³ od³apany lub zignorowany; nie zachodzi to jednak
, gdy wej¶cie koprocesu zosta³o powielone na inny deskryptor pliku
i sotsowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje siê albo przy pomocy syntaktyki otoczki
Korn-a \fBfunction\fP \fIname\fP,
albo syntaktyki otoczki Bourn-a/POSIX-owej \fIname\fP\fB()\fP
(patrz poni¿ej co do ró¿nic zachodz±cych pomiêdzy tymi dwoma formami).
Funkcje, tak jak i \fB.\fP-skrypty, zostaj± wykonywane w bierz±cym
otoczeniu, aczkolwiek, w przeciwieñstwie do \fB.\fP-skryptów,
argumenty otoczki
(\fItzn.\fP, argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) niegdy nie s±
widoczne wewn±trz nich.
Podczas ustalania lokacji komendy funkcje s± przeszukiwane po przeszukani
specjalnych wbydowanych komend i przed regularnymi oraz nieregularnymi
komendami wbudowanymi, a zanim \fBPATH\fP zostanie przeszukany.
.PP
Istniej±ca funkcja mo¿e zostaæ usuniêta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
Listê funkcji mo¿na otrzymaæ poprzez \fBtypeset +f\fP, a definicje
funkcji mo¿na otrzymaæ poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo¿e zostaæ
u¿yte do tworzenia niezdefiniowanych funkcji;
je¶li ma byæ wykonana niezdefiniowana funkcja, wówczas otoczka
przeszukuje trop podany w parametrze \fBFPATH\fP za plikiem o nazwie
identycznej do nazwy danej funkcji, który, gdy zostanie odnaleziony 
takowy, zostaje wczytany i wykonany.
Je¶li po wykonaniu tego pliku dana funkcja bêdzie zdefiniowany, wówczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk³e
odnajdywanie komend
(\fItzn.\fP, otoczka przeszukuje tablicê zwyk³ych komend wbudowanych
i \fBPATH\fP).
Proszê zwróciæ uwagê, ¿e je¶li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, wówczas zostaje podjêta próba odnalezienia
funkcji poprzez \fBFPATH\fP (jest to niezdokumentowanym zachowaniem
siê orginalnej otoczki Korn-a).
.PP
Funkcje mog± mieæ dwa atrybuty ¶ledzenia i eksportowania, które
mog± byæ ustwaieane przez \fBtypeset \-ft\fP i odpowiednio 
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji ¶ledzonej, opcja \fBxtrace\fP otoczki
zostaje w³±czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy³±czona.
Atrybut exportowania nie jest obecnie u¿ywany.  W orginalnej
otoczce Korn-a, wyexportowane funkcje s± widoczne dla skrytów otoczki,
gdy s± one wykonywane.
.PP
Poniewa¿ funckje zostaj± wykonywane w obecnym konketscie otoczki,
przyporz±dkowania parametrów wykonane wewn±trz funkcji pozostaj±
widoczne po zakoñczeniu danej funkcji.
Je¶li jest to nieporz±dane, wówczas komenda \fBtypeset\fP mo¿e
byæ zastosowana wewn±trz funkcji do tworzenia lokalnych parametrów.
Proszê zwrócic uwagê i¿ specjale parametry
(\fItzn.\fP, \fB$$\fP, \fB$!\fP) nie mog± zostaæ ograniczone w 
ich widoczno¶ci w ten sposób.
.PP
Statusem zakoñczeniownym kuncji jest status ostatniej
wykonanej w niej komendy.
Funkcjê mo¿na przerwaæ bezpo¶redino przy pomocy komendy \fBreturn\fP;
mo¿na to równie¿ zastosowaæ do jawnej specyfikacji statusu zakoñczenia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s³owa \fBfunction\fP, s±
traktowane odmiennie w nastêpuj±cych punktach od funkcji zdefiniowanych
poprzez notacjê \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje nastawiony na nazwê funkcji
(funkcje w stylu Bourne-a nie tykaj± \fB$0\fP).
.IP \ \ \(bu
przyporz±dkowania warto¶ci parametrom poprzedzaj±ce wywo³anie
funkcji nie zostaj± zaczowane w bierz±cym kontekscie otoczki
(wykonywanie funkcji w stylu Bourne-a functions zachowuje te
przyporz±dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostake zachowany i skasowany 
na pocz±tku oraz nastêpnie odtworzony na zakoñczenie funkcji, tak wiêc
\fBgetopts\fP mo¿e byæ poprawnie stosowane zarówno wewn±trz jak i poza
funkcjami
(funkcje w stylu Bourne-a nie tykaj± \fBOPTIND\fP, tak wiêc
stosowanie \fBgetopts\fP wewn±trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.nr PD \n(P2
W przysz³o¶ci nastêpuj±ce ró¿nice zostan± równie¿ dodane:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Oddzielny kontekst ¶ledznia/sygna³ów bêdzie stosowany podczas sykonywania
funkcji.
Tak wiêc ¶ledzenia nastawione wewn±trz funkcji nie bêd± mia³y wp³ywu 
na ¶ledzenia i sygna³y otoczki nie ignorowane przez ni± (które mog±
byæ przechwytywane) bêd± mia³y domy¶lne ich znaczenie wewn±trz funkcji.
.IP \ \ \(bu
¦ledzenie EXIT-a, je¶li zostanie nastawione wewn±trz funkcji, 
zostanie wykonane, po zakoñczeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana otoczka ma byæ w zasadzie zgodna ze standardem POSIX, 
aczkolwiej jednak, w niektórych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem orginalnej
otocznik Korn-a albo wygod± u¿ytkownika.
Jak otoczka zachowuje siê w takich wypadkach jest ustalane poprzez
status opcji posix (\fBset \-o posix\fP) \(em je¶li jest ona
w³±czona wówczas zachowuje siê zgodnie z POSIX-em, a w przeciwnym 
razie nie.
Opcja \fBposix\fP zostaje automatycznie nastawiona je¶li otoczka startuje
w otoczeniu zawieraj±cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Otoczkê mo¿na równie¿ skompilowaæ tak aby zachowanie zgodne z
POSIX-em by³o domy¶lnie ustawione, aczkolwiek jest to zwykle 
nieporz±dane).
.PP
A oto lista wp³ywów ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn±trz wycytowanych podwójnymi cuczys³owami \fB`\fP..\fB`\fP 
podstwieñ komend:
w trybie posix-owym, the \fB\e"\fP zostaje zinterpretowane podczas interpretacji
komendy;
w trybie nie posix-ownym, pochy³ek w lewo zostaje usuniety przed
interpretacj± podstawienia komendy. 
Przyk³adowo \fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie posix-owym, `hi' a w trybie nie-posix-owym.  
W celu unikniêcia problemów proszê stosowaæ postaæ \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
\fBkill \-l\fP wyj¶cie: w trybie posix-owym, nazwy sygna³ow
zostaj± wymieniane wiersz po wierszu;
w nie-posix-owym trybie, numery sygna³ów ich nazwy i opis zostaj± wymienione
w kolumnach.
W przysz³o¶ci nowa opcja zostanie dodana (pewnie \fB\-v\fP) w celu
rozró¿nienia tych dwóch zachowañ.
.IP \ \ \(bu
\fBfg\fP status zakoñczenia: w trybie posix-owym, status zakoñczenia wynosi
0, je¶li nie wyst±pi³y ¿adne b³êdy;
w trybie nie-posix-owym, status zakoñczeniowy odpowiada statusowi
ostatniego zadania wykonywanego w pierwszym planie.
.IP \ \ \(bu
\fBgetopts\fP: w trybie posix-owym, optcje musz± zaczynaæ siê od \fB\-\fP;
w trybie nie-posix-owym, opcje mog± siê zaczynaæ od albo \fB\-\fP albo \fB+\fP.
.IP \ \ \(bu
rozwijanie nawiasów (zwane równie¿ przemian±): w trybie posix opwym, 
rozwijanie nawiasów jest wy³±czoen; w trybie nie-posix-owym, 
rozwijanie nawiasów jest w³±czone.
Proszê zauwa¿yæ, ¿e \fBset \-o posix\fP (lub nastawienie 
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy³±cza opcjê \fBbraceexpand\fP, mo¿e ona byæ jednak jawnie
w³±czona pu¼niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie posix-owym, nie wy³±cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-posix-owym, wy³±cza.
.IP \ \ \(bu
\fBset\fP status zakoñczenia: w trybie posix-owym, 
status zakoñczenia wynosi 0, je¶li nie wyst±pi³y ¿adne b³êdy; 
w trybie nie-posix-owym, status zakoñczeniowy odpowiada statusie
wszelkich podstawieb komend wykonywanych podczas
generacji komendy set.
Przyk³adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie posix,
a 1 w tybie nie-posix.  Ten konstrukt jest stosowany w wiêkszo¶ci
skrytpów otoczji stosujacych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argumentów dla komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP, i
\fBtypeset\fP: w trybie posix-owym, nastêpuje normalme rozwijanie argumentów;
w trybie nie-posix-owym, rozdzielanie pól, rozszerzanie plików, 
rozwijanie nawiasów i (zwyk³e) rozwijanie szlaczków s± wy³±czone, oraz
rozwijanie szlaczków w przyporz±dkowania pozostaje w³±czone.
.IP \ \ \(bu
specyfikacja sygna³ów: w trybie posix-owym, signa³y mog± byæ
podawane jedynie cyframi, je¶li numery sygna³ów s± one zgodne z 
warto¶ciami z POSIX-a (\fItzn.\fP, HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14, and TERM=15); w trybie nie-posix-owym, 
sygna³u mog± zawsze cyframi.
.IP \ \ \(bu
rozwijanie aliasów: w trybie posix-owym, rozwijanie aliasów
zostaje jedynie wykonywane, podczas wczytywania s³ów komend; w trybie 
nie-posix-owym, rozwijanie aliasów zostaje wykonane równie¿ na
ka¿dym s³owie po jakim¶ aliasie, które koñczy siê bia³± przerw±.
Przyk³adowo w nastêpuj±ca wstêga for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u¿ywa parameteru \fBi\fP w tybie posix-owym, natomiast \fBj\fP w
trybie nie-posix-owym.
.IP \ \ \(bu
test: w trybie posix-owym, wyra¿enia "\fB-t\fP" (poprzedzone pewn±
ilo¶ci± argumentów "\fB!\fP") zawsze jest prawdziwe, gdy¿ jest
ci±giem o d³ugo¶ci niezerowej; w nie-posix-owym trybie, sprawdza czy
descryptor pliku 1 jest jakim¶ tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo¿e zostaæ pominiêty i jest
domy¶lnie równy 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie Komend"
Po wyliczeniu argumentów wiersza komnedy, wykonaniu przekierunkowañ
i przyporz±dkowañ parametrów, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku który nale¿y wykonaæ przy pomocy parametru
\fBPATH\fP.
Testy te zostaj± wykonane w wy¿ej podanym porz±dku.
Specjalne wbudowane komendy ró¿ni± siê tym od innych komend, 
¿e pramert \fBPATH\fP nie jest u¿ywany do ich odnalezienie, b³±d
podczas ich wykonywania mo¿e spowodowaæ zakoñczenie nieinterakcyjnej
otocz i przyporz±dkowania wartosci parametrów poprzedzaj±ce
komendê zostaj± zachowane po jej wykonaniu.
Aby tylko wprowadziæ zamieszanie, je¶li opcja
posix zosta³a w³±czona (patrz komenda \fBset\fP
poni¿ej) pewne specjale komendy staj± siê bardzo specjalne, gdy¿
nie wykonywane s± rozdzielanie pól, rozwijanie nazw plików,
rozwijanie nawiasów ani rozwijanie szlaczków na argumentach, 
które wygl±daj± jak przyporz±dkowania.
Zwyk³e wbudowane komendy wyró¿niaj±siê jedynie tym,¿e
parametr \fBPATH\fP nie jest stosowany do ich odnalezienia.
.PP
Orignalny ksh i POSIX ró¿ni± siê nieco w tym jakie
komendy s± traktowane jako specjalne a jakie jako zwyk³e:
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
W przysz³o¶ci dodatkowe specjalne komendy ksh oraz regularne komendy
mog± byæ traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz±dkowania warto¶ci parametrów
zostaj± wykonane i wyeksportowane na czas trwania komendy.
.PP
W nastêpuj±cym opisujemy specjalne i regularne komendy wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wyknoaj komendy w \fIplik\fP w bierz±dym otoczeniu.
Plik zostaje odszukiwany przy u¿yciu katalogów z \fBPATH\fP.
Je¶li zosta³y podane argumenty, wówczas parametry pozycyjne mog± byæ
u¿ywane do dostêpu do nich podczas wykonywania \fIplik\fP-u.
Je¶li nie zosta³y podane ¿adne argumenty, wówczas argumenty pozycyjne
odpowiadaja tym z bierz±cego otoczenia, w którym dana komenda zosta³a
u¿yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Statusem zakoñczenia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto¶æ1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
bez argumentów, \fBalias\fP wylicza wszystkie obecne aliasy.
Dla ka¿dej nazwy bez podanej warto¶ci zostaje wliczony istniej±cy
odpowiedni alias.
Ka¿da nazwa z podan± warto¶ci± definiuje alias (patrz aliasy Aliases powy¿ej).
.sp
podczas wyliczania aliasów mo¿na u¿yæ jednego z dwuch formatów: 
zwykle aliasy s± wyliczane jako \fInazwa\fP\fB=\fP\fIwarto¶æ\fP, przy czym
\fIwarto¶æ\fP jest wycytowana; je¶li opcje mia³y przedsionek \fB+\fP 
lub same \fB+\fP zosta³o podane we wierszu komendy, tyko \fInazwa\fP
zostaje wy¶wietlona.
Ponad to, je¶li zosta³a zstosowana opcja \fB\-p\fP, ka¿dy wiersz zostaje
zaczêty dodtakowo od ci±gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP nastawia, (a \fB+x\fP kasuje) atrybut eksportu dla aliasa,
lub, je¶li nie podano ¿adnych nazw, wylicza aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma posiada ¿adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, ¿e ¶ledzone aliasy maj± byæ wyliczone ustawione
(warto¶ci podane we wierszu komendy zostaj± zignorowane dla ¶ledzonych
aliasów).
Opcja \fB\-r\fP wskazuje, ¿e wszystkie ¶ledzone aliasy
maj± zostaæ usuniête.
.sp
Opcja \fB\-d\fP nakazuje wyliczenie lub ustawienie aliasów katalogów, 
które s± stosowane w rozwiniêcziach szlaczków
(patrz Rozwiniêcia Szlaczków powy¿ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je¶li nie podana ¿adnego zadaniam wówczas przyjmuje siê domy¶lnie \fB%+\fP.
Ta komenda jest jeynie dostêpna na systemach wspomagaj±cych kontrolê zadañ.
Patrz Kontrola Zadañ poni¿ej co do dalszych informacji.
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Nastawienie lub wyliczenie obecnych przyporz±dkowañ klwaiszy/mark w 
emacs-owym trybie edycji komend.
Patrz Emacs-owa Interakcyjna Edycja Wiersza Komendy w celu pe³nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fPth zagnie¿d¿enia we wstêgach
for, select, until, lub while.
\fIpoziom\fP wynosi domy¶lnie 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan± komendê \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.  
Je¶li zosta³ nastawiony parameter \fBCDPATH\fP, to wypisuje
listê katalogów, w których nale¿y szukaæ pod-\fIkatalog\fP.
Pusta zawarto¶æ w \fBCDPATH\fP oznacza katalog bie¿±cy.
Je¶li niepusty katalog z \fBCDPATH\fP zostanie zastosowany,
wówczas zostanie wy¶wietlony pe³ny wynikaj±cy trop na standardowym
wyj¶ciu.
Je¶li nie podano \fIkatalog\fP, wówczas
zostaje u¿yty katalog domowy \fB$HOME\fP.  Je¶li \fIkatalog\fP-iem jest
\fB\-\fP, to porzedni katalog roboczy zostaje zastosowany (patrz
parametr OLDPWD).
Je¶li u¿yto opcji \fB\-L\fP (logiczny trop) lub je¶li opcja \fBphysical\fP
nie zosta³a nastawiona
(patrz komenda \fBset\fP poni¿ej), wówczas odniesienia do \fB..\fP w 
\fIkatalogu\fP s± wzglêdnymi wobec tropu zastosowanego do doj¶ci± do danego
katalogu.
Je¶li podano opcjê \fB\-P\fP (fizyczny trop) lub gdy zosta³a nastawiona
opcja \fBphysical\fP, wówczas \fB..\fP jest wzglêdne wobec drzewa katalogów 
systemu plików.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj± uaktualnione taki, aby odpowiednio
zawiera³y bie¿±cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci±g \fInowy\fP zostaje podstawiony wzamian za \fIstary\fP w bie¿±cym
katalogu, i otoczka próbuje przej¶æ do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je¶li nie zosta³a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, wówczas
\fIkomenda\fP
zostaje wykonana dok³adnie tak jakby nie podano \fBcommand\fP,
z dwoma wyj±takami: po pierwsze, \fIkomenda\fP nie mo¿e byæ funkcj± w otoczce,
oraz po drugie, specjalne wbudowane komendy trac± swoj± specjalno¶æ (\fItzn.\fP,
przekierowania i b³êdy w u¿yciu nie powoduj±, ¿e otoczka zostaje zakoñczona, a
przyporz±dkowania parametrów nie zostaj± wykonane).
Je¶li podano opcjê \fB\-p\fP, zostaje stosowany pewien domy¶lny trop
zamiast obecnej warto¶ci \fBPATH\fP (warto¶æ domy¶lna tropu jest zale¿na
od systemy w jakim pracujemy: w systemach POSIX-owatych, jest to
warto¶æ zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je¶li podano opcjê \fB\-v\fP, wówczas zamiast wykonania \fIkomenda\fP, 
zostaje podana informacja co by zosta³o wykonane (i to same dotyczny 
równia¿ \fIarg1\fP ...):
dla specjalnych i zwyklych wbudowanych komend i funkcji,
zostaj± po prostu wy¶wietlone ich nazwy,
dla aliasów, zostaje wy¶wietlona komenda definiuj±ca dany alias,
oraz dla komend odnajdownych poprzez przeszukiwanie zawarto¶ci
parametru \fBPATH\fP, zostaje wy¶wietlony pe³ny trop danej komendy.
Je¶li komenda nie zostanie odnaleziona, (\fItzn.\fP, przeszukiwanie tropu
nie powiedzie siê), nic nie zostaje wy¶wietlone i \fBcommand\fP zostaje
zakoñczone z niezerowym statusem.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko ¿e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP stacze na pocz±tek \fIpoziom\fP-u z najg³êbiej
zagnie¿d¿onej wstêgi for,
select, until, lub while.
\fIlevel\fP domy¶lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy¶wietla na standardowym wyj¶ciu swoje argumenty (rozdzielone przerwami)
zakoñczone prze³amaniem wiersza.
Prze³amanie wiersza nie nastêpuje je¶li którykolwiek z parametrów
zawiera sekwencjê pochy³ka wstecznego \fB\ec\fP.
Patrz komenda \fBprint\fP poni¿ej, co do listy innych rozpoznawanych
sekwencji pochy³ków wstecznych.
.sp
Nastêpuj±ce opcje zosta³y dodane dla zachowania zgodno¶ci ze
skryptami z systemów BSD:
\fB\-n\fP wy³±cza koñcowe prze³amanie wiersza, \fB\-e\fP w³±cza
interpretacjê pochy³ków wstecznych (operacja zerowa, albowiem ma to
domy¶lnie miejsce), oraz \fB\-E\fP wy³±czaj±ce interpretacjê
pochy³ków wstecznych.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Zrgumenty zostaj± powi±zane (z przerwami pomiêdzy nimi) do jednego
ci±gu, który nastêpnie otoczka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez forkowania, zastêpuj±c proces otoczki.
.sp
Je¶li nie podano ¿adnych argumentów wszelkie przekierowania wej¶cia/wyj¶cia
s± dozwolone i otocznia nie zostaje zast±piona.
Wszelkie deskryptory plików wiêksze ni¿ 2 otwarte lub z\fIdup\fP(2)-owane
w ten sopsób nie s± dostêpne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbydownych w otoczkê).
Proszê zwróciæ uwagê i¿ otoczka Bourne-a ró¿ni siê w tym: 
przekazuje bowiem deskryptory plików.
.\"}}}
.\"{{{  exit [status]
.IP "\fBexit\fP [\fIstatus\fP]"
Otoczka zostaje zakoñczona z podanym statusem.
Je¶li \fIstatus\fP nie zosta³ podany, wówczas status zakoñczenia
przyjmuje bie¿±c± warto¶æ parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Nastawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj± przekazywane w otoczeniu do wykonywanych
komend.
Je¶il podano warto¶ci wówczas zostaj± one równia¿ przyporz±dkowany
danym parametrom.
.sp
Je¶li nie podano ¿adnych parametró, wówczas nazwy wszystkich parametrów
z atrybutem eksportu zostaj± wy¶wietlone wiersz po wierszu, chyba ¿e u¿yto
opcji \fB\-p\fP, w którym to wypadu zostaj± wy¶wietlone komendy
\fBexport\fP definiuj±ce wszystkie eksportowane parametry wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda koñcz±ca siê z niezerowym statusem.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj± komendy z histori.
Komendy mo¿emy wybieraæ przy pomocy ich numeru w historji
lub podaj±c ci±g znaków okre¶laj±cy ostatnio u¿yt± komendê rozpoczynaj±c±
siê od tego¿ ci±gu.
Opcja \fB\-l\fP wy¶wietla dan± komendê na stdout,
a \fB\-n\fP wy³±cza domy¶lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno¶æ koemnd w li¶cie historji.  Bez \fB\-l\fP, wybrane
komendy podlegaj± edycji przez edytor podany poprzez opcjê
\fB\-e\fP, albo je¶lki nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je¶li nie zosta³ nastawiony ten
parametr, wówczas sotsuje siê \fB/bin/ed\fP),
i nastêpnie wykonana przez otoczkê.
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran± konendê (domy¶lnie poprzedni± komendê) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je¶li
podano \fB\-g\fP, wówczas wszelkie wysotmpienia \fIstare\fP zostaj±
zastêpione przez \fInowe\fP.  Z tej komendy ko¿ysta siê zwykle
przy pomocy zdefiniowanego domy¶lnie aliasa \fBr='fc \-e \-'\fP.
.\"}}}
.\"{{{  fg [job ...]
.IP "\fBfg\fP [\fIzadanie\fP ...]"
Przywróæ na pierwszy plan zadanie(-nia).
Je¶li nie podano jawnie ¿adnego zadania, wówczas odnosi siê to
domy¶lnie do \fB%+\fP.
Ta komenda jest jedynie dostêpna na systemach wspomagaj±cych
kontrolê zadañ.
Patrz Kontrola Zadañ dla dalszych informacji.
.\"}}}
.\"{{{  getopts optstring name [arg ...]
.IP "\fBgetopts\fP \fIci±gopt\fP \fInazwa\fP [\fIarg\fP ...]"
\fBgetopts\fP jest stosowany przez procedury otoczki
do rozeznawania podanych argumentów
(lub parametrów pozycyjnychi, je¶li nie podano ¿adnych argumentów)
i do sprawdzenia zasadno¶ci opcji.
\fIci±gopt\fP zawiera litery opcji, które 
\fBgetopts\fP ma rozpoznawaæ.  Je¶li po literze wystêpuje przecinek,
wówczas oczekuje siê, ¿e opcja posiada argument.
Opcje nieposiadaj±ce argumentów mog± byæ grupowane w jeden argument.
Je¶li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w którym siê znajduje, wówczas reszta argumentu 
zsotaje potraktowana jako argument danej opcji. W przeciwnym razie
nastêpny argument jest argumentem opcji.
.sp
Za ka¿dym razem, gdy zostaje wywo³ane \fBgetopts\fP, 
umieszcza siê nastêpn± opcjê w parametrze otoczki
\fInazwa\fP i indeks nastêpnego argumentu pod obróbkê
w parmaetrze otoczki \fBOPTIND\fP.
Je¶li opcja zosta³a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z prefiksem \fB+\fP.
Je¶li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze otoczki \fBOPTARG\fP.
Je¶li natrafi siê na niedopuszczaln± opcjê lub brakuje
argumentu opcji, wówczas znak zapytania albo dwukropek zostaje
umieszczony w \fInazwa\fP
(wskazuj±c na nielegaln± opcjê, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje nastawiony na znak który by³ przyczyn± tego problemu.
Ponadto zostaje wówczas wy¶wietlony komunikat o b³êdzie na standardowym
wyj¶ciu b³êdów, je¶li \fIci±gopt\fP nie zaczyna siê od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa pracê
niezerowym statusem zakoñczenia.
Opcje koñcz± siê na pierwszym (nie podlegaj±cym opcji) argumencie,
który nie rozpoczyna siê od \-, albo je¶li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawania opcji mo¿e zostaæ ponowione ustawiaj±c \fBOPTIND\fP na 1
(co nastêpuje automatycznie za ka¿dym razem, gdy otoczka lub 
funkcja w otoczce zostaje wywo³ana).
.sp
Ostrze¿enie: Zmiana warto¶ci parametru otoczki \fBOPTIND\fP na
warto¶æ wiêksz± ni¿ 1, lub rozpoznawanie odmiennych zestawów
parametrów bez ponowienia \fBOPTIND\fP mo¿e doprowadziæ do nieoczekiwanych
wyników.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je¶li brak argumentów, wówczas wszelkie tropy wykonywalnych komend z
kluczem zostaj± wymienione.
Opcja \fB\-r\fP nakazuje wy¿ucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka¿da \fInazwa\fP zostaje odszukiwana tak jak by to by³a nazwa komedy
i dodna do tablicy kluczy je¶li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy¶wietlij informacje o danych zadaniach; gdy nie podano ¿adnych
zadañ wszystkie zadania zostaj± wy¶wietlone.
Je¶li podano opcjê \fB\-n\fP, wówczas informacje zostaj± wy¶wietlone
jedynie o zadaniach których stan zmieni³ siê od czasu ostaniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka¿dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, ¿e zostaje wy¶wietlona jedynie
jedynie grupa procesowa kadego zadania.
patrz Kontrola Zadañ dla informacji o formie parametru
\fIzdanie\fP i formacie w którym zostaj± wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy¶lij dany sygna³ do doanych zadañ, procesów z danym id-em, lub grup
procesów.
Je¶li nie podano jawnie ¿adnego sygna³u, wówczas domy¶lnie zostaje wys³any
sygna³ TERM.
Je¶li podano zadanie, wówczas sygna³ zostaje wys³any do grupy 
procesów danego zadnia.
Patrz poni¿ej Kontrola Zadab dla informacji o formacie \fIzadania\fP.
.\"}}}
.\"{{{  kill -l [exit-status ...]
.IP "\fBkill \-l\fP [\fIstatus-zakoñczenia\fP ...]"
Wypisz nazwê sygna³u, który zabi³ procesy, które zakoñczy³y siê
danym \fIstatusem-zakoñczenia\fP.
Je¶li brak argumentów, wówczas zostaje wy¶wietlona lista
wszelkich sygna³ów i ich numerów, wraz z krótkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra¿enie\fP ...]"
Ka¿de wyra¿enie zostaje wyliczone, patrz Wyra¿enie Arytmetyczne powy¿ej.
Je¶li wszelkie wyra¿enia zosta³y poprawnie wyliczone,statusem zakoñczenia
jest 0 (1), je¶li warto¶ci± ostatniego wyra¿enia
 nie by³o zero (zero).
Je¶li wyst±pi b³±d podczas rozpoznawania lub wyliczania wyra¿enia,
status zakoñczenia jest wiêkszy od 1.
Poniewa¿ m¿e zaj¶æ konieczno¶æ wycytowania wyra¿eñ, wiêc
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s³odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy¶wietla swe argumenty na standardowym wyj¶ciu, rozdzielone
przerwami i zakoñczone prze³amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy¶lnemu prze³amaniu wiersza. 
Domy¶lnie pewne wyprowadzenia z C zostaj± odpowiednio przet³umaczone.
Wsród nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0### 
(# oznacza cyfrê w systemie ósemkowym, tzn. od 0 po 3).
\ec jest równowa¿ne z zastosowaniem opcji \fB\-n\fP.  \e wyra¿eniom
mo¿na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pilku historji zamiast
standardowego wyj¶cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wyno¶i domy¶lnie 1 przy pominiêciu), 
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy¿ej).
.sp
Opcja \fB\-R\fP jest stowoana do emulacji, w pewnym stopniu, komendy 
echo w wydaniu BSD, która nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy¿ej opcja \fB\-n\fP zapobiega zakonieczeniowemu prze³amaniu
wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bierz±cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta³a nastawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni¿ej), zostaje wy¶wietlony trop
logiczny (\fItzn.\fP, trop knieczny aby wykonaæ \fBcd\fP 
do bierz±cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (fizyczny trop) lub gdy
opcja \fBphysical\fP zosta³a nastawiona, zostaje wy¶wietlony trop
ustalone przez wystem plików (¶ledz±c katalogi \fB..\fP
a¿ po katalog pniowy).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej¶cia, rozdziela ten
wiersz na pola przy uwzglêdnieniu parametru \fBIFS\fP (
patrz Podstawienia powy¿ej), i przyporz±dkowywuje pola odpowienio danym 
parametrom.
Je¶li mamy wiêcej parametrów ni¿ pul, wówczas dodatkowe parametry zostaj±
ustawione na zero, a natomiast je¶li jest wiêcej pól ni¿ paramtrów to
ostatni parametr otrzymuje jako warto¶æ wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj±cymi przerwami).
Je¶li nie podano ¿adnych parametrów, wówczas zostaje zastosowany
parametr \fBREPLY\fP.
Je¶li wiersz wprowadzenie koñczy siê na pochy³ku wstecznym
i nie podano opcji \fB\-r\fP, to pochy³ek wsteczny i prze³amanie
wiersza zostaj± usuniête i wiêcej wprowadznia zostaje wczytane.
Gdy nie zostanie wczytane ¿adne wprowadznie, \fBread\fP zakañcza siê
niezerowym statusem.
.sp
Pierwszy parametro mo¿e mieæ do³±czony znak zapytania i ci±g, co oznacza, ¿e
dany ci±g zostania zastosowany jako zachêta do wprowadzenia 
(wy¶wietlana na standardowym wyj¶ciu b³edów zanim
zostanie wczytane jakiekolwiek wprowadzenie) je¶li wej¶cie jest tty-em
(\fIe.g.\fP, \fBread nco¶?'ile co¶ków: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj± ¿e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bierz±cego ko-procesu 
(patrz komenta¿e na ten temat w Ko-procesy powy¿ej).
Je¶li zastosowano opcjê \fB\-s\fP, wówczas wprowadznie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Patrz parametr wy³±cznego odczytu nazwanych parametrów.
Je¶li zosta³y podane warto¶ci wówczas zostaj± one nadane parametrom przed
ustawieniem danego strybutu.
Po nadaniu cechy wy³±cznego odczytu parametrowi, nie ma wiêcej mo¿liwo¶ci
wykasowania go lub zmiany jego warto¶ci.
.sp
Je¶li nie podano ¿adnych parametrów, wówczas zostaj± wypisane nazwy
wszystkich parametrów w cech± wy³±cznego odczytu wiersz po wierszu, chyba
¿e zastosowano opcjê \fB\-p\fP, co powoduje wypisanie pe³nych komend
\fBreadonly\fP definiuj±cych parametry wy³±czneg odczytu wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  return [status]
.IP "\fBreturn\fP [\fIstatus\fP]"
Powrót z funkcji lub \fB.\fP scryptu, ze statusem zakoñczenia \fIstatus\fP.
Je¶li nie podano warto¶ci \fIstatus\fP, wówczas zostaje domy¶lnie
zastosowany status ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcji lub \fB.\fP scryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Proszê zwróciæ uwagê i¿ pdksh traktuje zarówno profile jak i pliki z 
\fB$ENV\fP jako \fB.\fP scrypty, podczas gdy
orginalny Korn shell jedynie profile traktuje jako \fB.\fP scrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s³u¿y do nastawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opkcji otoczki, nastawiania prarmetrów pozycyjnych, lub
nastawiania parametru ci±gowego.
Opcje mog± byæ zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe³n± nazw± pewnej opcji, lub stosuj±c postaæ
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow±
nazwê danej opcji (niewszystkie opcje posiadaj± jednoliterow± nazê).
Nastêpuj±ca tablica wylicza zarówno litery opcji (gdy mamy takowe), jak i
pe³ne ich nazwy wraz z opisem wp³ywów danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci±gowego \fInazwa\fP na \fIarg\fP ...;
Je¶li zastosowano \fB\-A\fP, ci±g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je¶li zastosowano \fB+A\fP, zastaj± nastawione pierwsze N elementów (gdzie N
jest ilo¶ci± \fIarg\fPsów), reszta pozostaje niezmienioa.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj± tworzone z cecha eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu¿ przed zachêt±.
Ma tylko znaczenia je¶li zosta³a w³±czona kontrola zadañ (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej±cych ju¿ plików poprzez przekierunkowania
\fB>\fP (\fB>|\fP musi zostaæ zastosowane do wymuszenia przepisania).
T}
\-e	errexit	T{
Wyjd¼ (po wykoaniu komendy pu³apki \fBERR\fP) tu¿ po wyst±pieniu
b³êdu lub niepomy¶lnym wykoaniu jakiej¶ komendy
(\fItzn.\fP, je¶li zosta³a ona zakoñczona niezerowym statusem).
Niedotyczy to komend których status zakoñczenia zostaje jawnie przetestowny
konstruktem otoczki takim jak wyra¿enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorców nazw plików.
T}
\-h	trackall	T{
Twó¿ ¶ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy¿ej).
Domy¶lnie w³±czone dla nieinterakcyjnych otoczek.
T}
\-i	interactive	T{
W³±cz tryb interakcyjny \- mo¿e zostaæ 
w³±czone/wy³±czone jedynie podczas odpalania otoczki.
T}
\-k	keyword	T{
Przyporz±dkowania warto¶ci parametrom zostaj± rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Otoczka ma byæ otoczk± zameldowania \- mo¿e zostaæ 
w³±czone/wy³±czone jedynie podczas odpalania otoczki
(patrz Odpalania Otoczki powy¿ej).
T}
\-m	monitor	T{
W³±cz kontrloê zadabñ (domy¶lne dla otoczek interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skryptów (ignorowane dla interakcyjnych otoczek).
T}
\-p	privileged	T{
Nastawiane automatycznie, je¶li gdy otoczka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Otoczki powy¿ej dla opisu co to znaczy.
T}
-r	restricted	T{
Nastaw tryb ograniczony \(em ta opcja mo¿e zostaæ jedynie
zastosowan podczas odpalania otoczki.  Patrz Odpalania Otoczki
dla opisy co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania otoczki, wówczas komendy
zostaj± wczytywane ze standardowego wej¶cia.
Nastawione automatycznie, je¶li otoczka zosta³a odpalona bez jakichkolwiek
argumentów.
.sp
Je¶li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, wówczas
podane argumenty zostaj± uporz±dkowane zanim zostan± one przyczielone
parametrom pozycyjnym
(lub ci±gowi \fInazwa\fP, je¶li \fB\-A\fP zosta³o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nienastawionego parametru zostaje traktowane jako b³±d,
chyba ¿e jeden z modyfikatorów \fB\-\fP, \fB+\fP lub \fB=\fP 
zosta³ zastosowany.
T}
\-v	verbose	T{
Wypisuj wprowadzenia otoczki na standardowym wyj¶ciu b³êdów podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz±dkowania parametrów podczas ich wykonywania
poprzedzone warto¶ci± \fBPS4\fP.
T}
\-X	markdirs	T{
Naznaczaj katalogi nastêpuj±cym \fB/\fP podczas generacji nazw
plików.
T}
	bgnice	T{
Zadania w tle zostaj± wykonywane z ni¿szym priorytetem.
T}
	braceexpand	T{
W³±cz rozwijanie nawiasów (aka, alternacja).
T}
	emacs	T{
W³±cz edycjê wiersza komendy  w stylu BRL emacs-a (dotyczy wy³±cznie
otoczek interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W³±cz edycjê wiersza koemndy w stylo gmacs-like (Gosling emacs) 
(dotyczy wy³±cznie otoczek interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj±tkiem tego, ¿e przemiana (^T) 
zachowuje siê nieco inaczej.
T}
	ignoreeof	T{
Otoczka nie zostanie zakoñczona je¶li zostanie wczytany znak zakoñczenia
pliku. Nale¿y u¿yæ jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie¿±cych zadañ sygna³em \fBHUP\fP gdy otoczka zameldowania
zostaje zakoñczona.
Obecnie nastawione domy¶lnie, co siê jednak zmieni w przysz³o¶ci w celu
poprawienia kompatybilijnosæ z orginalnym Korn shell (który nie posiada
tej opcji, aczkolwiek wysy³a sygna³ \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w originalej otoczce Korn. Zapobiega sortowaniu definicji
funkcji w pliku histori.
T}
	physical	T{
Powoduje, ¿e komendy \fBcd\fP oraz \fBpwd\fP stosuj± `fizyczne'
(\fItzn.\fP, pochodz±ce od systemu plików) \fB..\fP katalogi zamiast `logicznych'
katalogów (\fItzn.\fP,  ¿e otoczka interpretuje \fB..\fP, co pozwala
u¿ytkownikowi nietroszczyæ siê o pod³±czenia symboliczne do katalogów).
Domy¶lnie wykasowane.  Proszê zwróciæ uwagê i¿ nastawianie tej opcji
nie wp³ywa na bie¿±c± warto¶æ parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy¿ej dla dalszych szczegu³ów.
T}
	posix	T{
W³±cz try posix-owy.  Patrz Tryb POSIX-owy powy¿ej.
T}
	vi	T{
W³±cz edycjê wiersza komendy  w stylu vi (dotyczy tylko otoczek 
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w orginalnej otoczce Korn-a, dopuki nie zosta³o 
nastawione viraw, tryb wiersza komendy vi
pozostawia³ pracê napêdowi tty a¿ do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plików
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Prefiksuj znaki z nastawionym ósmym bitem poprzez `M-'.
Je¶li nie zostanie nastawiona ta opcja, wówczas, znaki z zakresu
128-160 zostaj± wypisane bez zmian co mo¿e byæ przyczyn± problemów.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonyj rozwiania koemnd/ plików
je¶li tab (^I) zostanie wrowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo¿na urzyæ równie¿ podczas odpalania otoczki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje siê w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy¶wietla
wszystki opcja i informacjê o ich nastawieniu lub nie;
\fBset +o\fP wypisuje pe³ne nazwy opcji obecnie w³±czonych.
.sp
Pozosta³e argumenty, je¶li podano takowe, s± traktowane jako parametry
pozycyjne i zostaj± przyporz±dkowane, przy zachowaniu kolejno¶ci,
parametrom pozycyjnym (\fItzn.\fP, \fB1\fP, \fB2\fP, \fIitd.\fP).
Je¶li opcje koñcz± siê \fB\-\-\fP i brak dalszych argumentów,
wówczas wszystkie parametry pozycyjne zostaj± wyczyszczone.
Je¶li nie podano ¿adnych opcji lub argumentów, wówczas zostaj± wy¶wietlone
warto¶ci wszystkich nazw.
Z nieznanych historycznych powodów, samotna opcja \fB\-\fP 
zostaje traktowana specjalnie:
kasuje zaróno opcjê \fB\-x\fP, jak i \fB\-v\fP.
.\"}}}
.\"{{{  shift [number]
.IP "\fBshift\fP [\fIliczba\fP]"
Parametry pozycyjne \fIliczba\fP+1, \fIliczba\fP+2 \fIitd.\fP\& zostaj±
przeniesione pod \fB1\fP, \fB2\fP, \fIitd.\fP
\fIliczba\fP wynosi domy¶lnie 1.
.\"}}}
.\"{{{  test expression, [ expression ]
.IP "\fBtest\fP \fIwyra¿enie\fP"
.IP "\fB[\fP \fIwyra¿enie\fP \fB]\fP"
\fBtest\fP wylicza \fIwyra¿enia\fP i zwraca status zero je¶li
prawda, i status 1 jeden je¶li fa³sz, awiêcej ni¿ 1 je¶li wyst±pi³ b³±d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra¿eñ \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nastêpuj±ce podstawowe wyra¿enia:
.sp
.TS
afB ltw(2.8i).
\fIci±g\fP	T{
\fIci±g\fP ma niezerow± d³ugo¶æ.  Proszê zwróciæ uwagê i¿ mog± wyst±piæ
tródno¶ci je¶li \fIci±g\fP oka¿e siê byæ operatorem 
(\fIdok³adniej\fP, \fB-r\fP) - ogólnie lepiej jest stosowaæ
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
wzamian (podwójne wycytowania zostaj± zastosowaneje¶li
\fIci±g\fP zawiera przerwy lub znaki rozwijania plików).
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
\fIplik\fP jest zwyk³ym plikiem
T}
\-d \fIplik\fP	T{
\fIplik\fP jest katalogiem
T}
\-c \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem napêdu ci±gowego
T}
\-b \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem napêdu blokowego
T}
\-p \fIplik\fP	T{
\fIplik\fP jest nazwanym ruroci±giem
T}
\-u \fIplik\fP	T{
\fIplik\fP o ustawionym bicie setuid
T}
\-g \fIplik\fP	T{
\fIplik\fP' o ustawionym bicie setgid
T}
\-k \fIplik\fP	T{
\fIplik\fP o ustawionym bicie lepko¶ci
T}
\-s \fIplik\fP	T{
\fIplik\fP nie jest pusty
T}
\-O \fIplik\fP	T{
w³a¶ciciel \fIpliku\fP zgadza siê z efektywnym user-ID otoczki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza siê z efektywn± group-ID otoczki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod³±czeniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale¿nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod³±czeniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP otoczki jest nastawiona (patrz komenda \fBset\fP powy¿ej
dla listy mo¿liwych opcji).
Jako niestandardowe rozszerzenie, je¶li opcja zaczyna siê od
\fB!\fP, to wynik testu zostaje negowany; test wypada zawsze negatywnie
gdy dana opcja nie istnieje (tak wiêc
.RS
\fB[ -o \fP\fIco¶\fP \fB-o -o !\fP\fIco¶\fP \fB]\fP
.RE
zwraca prawdê tylko i tylko wtedy, gdy opcja \fIco¶\fP istnieje).
T}
\fIplik\fP \-nt \fIplik\fP	T{
pierwszy \fIplik\fP jest nowszy od nastêpnego \fIpliku\fP
T}
\fIplik\fP \-ot \fIplik\fP	T{
pierwszy \fIplik\fP jest starszy od nastêpnego \fIpliku\fP
T}
\fIplik\fP \-ef \fIplik\fP	T{
pierwszy \fIplik\fP jest torzsamy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przy¿±dem tty.
Je¶li nie zosta³a nastawiona opcja posix-a (\fBset \-o posix\fP, 
patrz Tryb POSIX powy¿ej), wówczas \fIfd\fP mo¿e zostaæ pominiêty, 
co oznacza przyjêcie domu¶lnej warto¶ci 1
(zachowanie siê jest wówczas odmienne z powodu specjalnych regó³
POSIX-a opisywanych powy¿ej).
T}
\fIci±g\fP	T{
\fIci±g\fP jest niepusty
T}
\-z\ \fIci±g\fP	T{
\fIci±g\fP jest pusty
T}
\-n\ \fIci±g\fP	T{
\fIci±g\fP jest niepusty
T}
\fIci±g\fP\ =\ \fIci±g\fP	T{
ci±gi s± sobie równe
T}
\fIci±g\fP\ ==\ \fIci±g\fP	T{
ci±gi s± sobie równe
T}
\fIci±g\fP\ !=\ \fIci±g\fP	T{
ci±gi siê ró¿ni±
T}
\fIliczba\fP\ \-eq\ \fIliczba\fP	T{
liczby s± równe
T}
\fIliczba\fP\ \-ne\ \fIliczba\fP	T{
liczby ró¿ni± siê
T}
\fIliczba\fP\ \-ge\ \fIliczba\fP	T{
liczba jest wiêksza lub równa od drugiej
T}
\fIliczba\fP\ \-gt\ \fIliczba\fP	T{
liczba jest wiêksza od drugiej
T}
\fIliczba\fP\ \-le\ \fIliczba\fP	T{
liczba jest mniejsza lub równa od drugiej
T}
\fIliczba\fP\ \-lt\ \fIliczba\fP	T{
liczba jest mniejsza od drugiej
T}
.TE
.sp
Powy¿sze podstawowe wyra¿enie, w których unarne operatory maj±
pierwszeñstwo przed operatorami binarnymi, mog± byæ stosowane w po³±czeniu
z nastêpuj±cymi operatorami
(wymienionymi w kolejno¶ci odpowiadaj±cej ich pierwszeñstwu):
.sp
.TS
afB l.
\fIwyra¿enie\fP \-o \fIwyra¿enie\fP	logiczne lub
\fIwyra¿enie\fP \-a \fIwyra¿enie\fP	logiczne i
! \fIwyra¿enie\fP	logiczna negacja
( \fIwyra¿enie\fP )	grupowanie
.TE
.sp
W systemie operacyjny niewspomagaj±cy napêdów \fB/dev/fd/\fP\fIn\fP
(gdzie \fIn\fP jest numerem deskryptora pliku),
komenda \fBtest\fP stara siê je emulowaæ dla wszystkich testów
operuj±cych na plikach (z wyj±tkiem testu \fB-e\fP).
W.sz., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dostêpny zapis na
deskryptor pliku 2.
.sp
Proszê zwróciæ uwagê ¿e zachodz± specjalne regó³y
(zawdziêczane POSIX-owi), je¶li liczba argumentów
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od piêciu: 
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête tak ¿e pozostaje tylko
jeden argument, wówczas zostaje przeprowadzony test d³ugosci ci±gu
(ponownie, nawet je¶li dany argument jest unarnym operatorem);
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête tak, ¿e pozostaj± trzy
argumenty i drugi argument jest operatorem binarnym, wówczas zostaje
wykonana dana binarna operacja (nawet je¶li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuniêtym \fB!\fP).
.sp
\fBUwaga:\fP Czêstym b³êdem jest stosowanie \fBif [ $co¶ = tam ]\fP co
daje wynik negatywny je¶li parametr \fBco¶\fP jest zerowy lub
nienastawiony, zwiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest unarnym operatorem, takim jak
\fB!\fP lub \fB\-n\fP.  Proszê stosowaæ testy typu 
\fBif [ "X$co¶" = Xtam ]\fP wzamian.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy¶wietla zgromadzony czas w przestrzeniu u¿ytkownika oraz systemu,
który spotrzebowa³a otoczka i w niej wystartowane 
procesy które w siê zakoñczy³y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna³ ...\fP]"
Nastawia obrabiacz, który nale¿y wykonaæ w razie odebrania danego sygna³u.
\fBObrabiacz\fP mo¿e byæ albo zerowym ci±giem, wskazujacym na zamiar
ignorowania sygna³ów danego typu, minusem (\fB\-\fP), 
wskazuj±cym, ¿e ma zostaæ podjêta akcja domy¶lna dla danego sygna³u
(patrz signal(2 or 3)), lub ci±giem zawierajacym komendy otoczki
które maj± zostaæ wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zakoñczeniu bierz±cej komendy, lub przed
wypisaniem nastêpnego zachêcacza \fBPS1\fP) po odebraniu
jednego z danych sygna³ów.
\fBSigna³\fP jest nazw± danego wygna³u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy¿ej).
Istnieja dwa specjalne sygna³y: \fBEXIT\fP (równie¿ znany jako \fB0\fP),
który zostaje wykonany tu¿ przed zakoñczeniem otoczki, i
\fBERR\fP który zostaje wykonany po wyst±pieniu b³edu
(b³êdem jest co¶ co powodowa³oby zakonczenie otoczki
je¶li zosta³y nastawioe opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP opwy¿ej).
Obrabiacze \fBEXIT\fP zostaj± wykonane w otoczeniu
ostatniej wykonywanej komendy.
Proszê zwróciæ uwage, ¿e dla otoczek nieinterakcyjnych obrabiacz wykroczeñ
nie mo¿e zostaæ zmieniony dla sygna³ów które by³y ignorowane podczas
startu danej otoczki.
.sp
Bez argumentów, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykroczeñ, które zosta³y nastawione od czasu staru otoczki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna³ów \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i orginalnej otoczki Korn'a w funkcjach nie zosta³o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda zakoñczaj±ca siê zerow± warto¶ci± statusu.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto¶æ\fP] ...]"
Wy¶wietlaj lub nastawiaj warto¶ci atrybutów parametrów.
Bez argumentów \fInazwa\fP, zostaj± wy¶wietlone atrybuty parametrów: 
je¶li brak argumentów opcyjnych, zostaja wy¶wietlone atrybuty
wszystkich parametór jako komendy typeset; je¶li podano opcjê
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto¶ci posiadaj±ce dany atrybut zostaj± 
wy¶wietlone;
je¶li opcje zaczynaj± siê od \fB+\fP, to nie zostaj± wy¶wietlone warto¶ci
oparametrów.
.sp
Je¶li podano argumenty If \fInazwa\fP, zostaj± nastawione atrybuty
danych parametrów (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto¶ci parametrów mog± zostaæ ewentualnie podane.
Je¶li typeset zostanie zastosowane wewn±trz funkcji, 
wszystkie nowotworzone parametry pozostaj± lokalne dla danej funkcji.
.sp
Je¶li zastosowano \fB\-f\fP, wówczas typeset operuje na atrybutach funkcji.
Tak jak dla parametrów, je¶li brak \fInazw\fPs, zostaj± wymienione funkcje
wraz z ich warto¶ciami (\fItzn.\fP, definicjami) chyba, ¿e opdano
opcje zaczynaj±ce siê od \fB+\fP, w którym wypadku
zostaj± wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyrównania do lewego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bierz±ca szeroko¶æ parametru 
(lub szeroko¶æ pierwszej przyporz±dkowywanej warto¶ci).
Prowadz±ce bia³e przerwy (tak jak i zera, je¶li
nastawiono opcjê \fB\-Z\fP) zostaj± wykasowane.
Je¶li trzeba, warto¶ci zostaj± albo obciête lub dodane przerwy
do osi±gniêcia wymaganej szeroko¶ci.
T}
\-R\fIn\fP	T{
Atrybut przyrównania do prawego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bierz±ca szeroko¶æ parametru
(lub szeroko¶æ pierwszej przyporz±dkowywanej warto¶ci).
Bia³e przerwy na koñcu zostaj± usuniête.
Je¶li trzeba, warto¶ci zostaj± albo pozbawione prowadz±cych znaków
albo przerwy zostaj± dodane do osi±gniêcia wymaganej szeroko¶ci.
T}
\-Z\fIn\fP	T{
Atrybut wype³niania zerami: je¶li nie skombinowany z \fB\-L\fP, to oznacza to
samo co \fB\-R\fP, tylko, ¿e do rozszerzania zostaje zastosowane zero
zamiast przerw.
T}
\-i\fIn\fP	T{
Atrybut ca³kowito¶ci:
\fIn\fP podaje bazê do zastosowania podczas
wypisywania danej warto¶ci ca³kowitej
(je¶li nie podano, to baza zostaje zaczerpniêta z 
bazy zastosowanej w pierwszym przyporz±dkowaniu warto¶ci).
Parametrom z tym atrybutem mog± byæ przyporz±dkowywane warto¶ci
zawierajace wyra¿enia arytmetyczne.
T}
\-U	T{
Atrybut dodatniej ca³kowito¶ci: liczby ca³kowite zostaj± wy¶wietlone
jako warto¶ci bez znaku
(stosowne jedynie w powi±zaniu z opcj± \fB\-i\fP).
Tej opcji brak w orginalnej otoczce Korn'a.
T}
\-f	T{
Tryb funkcji: wy¶wietlaj lub nastawiaj funkcje i ich atrybuty, zamiast
parametrów.
T}
\-l	T{
Atrybut ma³ej litery: wszystkie znaki z du¿ej litery zostaj± 
w wartosci zamienione na ma³e litery.
(W orignalnej otoczce Korn'a, parametr ten oznacza³ `d³ugi ca³kowity' 
gdy by³ stosowany w po³±czeniu z opcj± \fB\-i\fP).
T}
\-p	T{
Wypisuj pe³ne komendy typeset, które mo¿na nastêpnie zastosowaæ do
odtworzenia danych atrybutów (lecz nie warto¶ci) parametrów.
To jest wynikiem domy¶lnym (opcja ta istnieje w celu zachowania
kompatybilijno¶ci z ksh93).
T}
\-r	T{
Atrybut wy³acznego odczytu: parametry z danym atrybutem
nie przyjmuj± nowych warto¶ci i nie mog± zostaæ wykasowane.
Po nastawieniu tego atrybutu nie mo¿na go ju¿ wiêcej odaktywniæ.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla otoczki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut ¶ledzenia.
Je¶li zostaj± wykonywane funkcje z atrybutem ¶ledzenia, to
opcja otoczki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w³aczona.
T}
\-u	T{
Atrybut du¿ej litery: wszystkie znaki z ma³ej litery w warto¶ciach zostaj±
przestawione na du¿e litery.
(W orginalnej otoczce Korn'a, ten parametr oznacza³ `ca³kowity bez znaku' je¶li
zosta³ zastosowany w po³±czeniu z opcj± \fB\-i\fP, oznacza³o to, ¿e
nie mo¿na by³o sotsowaæ du¿ych liter dla baz wiêkszych ni¿ 10.  
patrz opcja \fB\-U\fP).
.sp
Dla funkcji, \fB\-u\fP to atrybut niezdefiniowania.  Patrz Funkcje powy¿ej
dla implikacji tego.
T}
\-x	T{
Atrybut eksportowania: parametry (lub funkcje) zostaj± umieszczone
w otoczenia wszelkich wykonywanych komend.  
Eksportowanie funkcji nie zosta³o jeszcze do tej pory zrealizowane.
T}
.TE
.\"}}}
.\"{{{  ulimit [-acdfHlmnpsStvw] [value]
.IP "\fBulimit\fP [\fB\-acdfHlmnpsStvw\fP] [\fIwarto¶æ\fP]"
Wy¶wietlij lub nastaw ograniczenia dla procesów.
Je¶li brak opcji, to ograniczenie ilo¶ci plików (\fB\-f\fP) zostaje
przyjête jako domy¶le.
\fBwarto¶æ\fP, je¶li podana, mo¿e byæ albo wyra¿eniem arytmetycznym
lub s³owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz± otoczki i wszelkich procesów przez ni± tworzonych
po nadaniu ograniczenia.
Proszê zwróciæ uwagê, i¿ niektóre systemy mog± zabraniaæ podnoszenia
warto¶ci ograniczeñ po ich nadaniu.
Ponadto proszê zwróciæ uwagê, ¿e rodzaje dostêpnych ograniczeñ zale¿± od
danego systemu \- niektóre systemy posiadaj± jedynie mo¿liwo¶æ
ograniczania \fB\-f\fP.
.RS
.IP \fB\-a\fP
Wy¶wietla wszystkie ograniczenia; je¶li nie podano \fB\-H\fP,
to zostaj± wy¶wietlone ograniczenia miêkkie.
.IP \fB\-H\fP
Nastaw jedynie ograniczenie twarde (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-S\fP
Nastaw jedynie ograniczenie miêkkie (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-c\fP
Ogranicz wielko¶ci plików zrzutów core do \fIn\fP blków.
.IP \fB\-d\fP
Ogranicz wielko¶æ area³u danych do \fIn\fP kbytów.
.IP \fB\-f\fP
Ogranicz wielkosæ plików zapisywanych przez otoczkê i jej programy pochodne
do \fIn\fP plików (pliki dowolnej wielko¶ci mog± byæ wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kbytów ilo¶æ podkluczonej (podpiêtej) fizycznej pamiêci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kbytów ilo¶æ uzywanej fizycznej pamiêci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie otwartych deskryptorów plików.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie wykonywanych procesów danego
u¿ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kbytów rozmiar area³u stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu¿ywany przez pojedyñcze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kbytów ilo¶æ u¿ywanej wirtualnej pamiêci;
pod niektórymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kbajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kbytów ilo¶æ stosowanego obszaru odk³adania.
.PP
Dla \fBulimit\fP blok to zawsze512 bajtów.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy¶wietl lub nastaw maskê zezwoleñ w tworzeniu plików, lub umask 
(patrz \fIumask\fP(2)).
Je¶li zastosowano opcjê \fB\-S\fP, maska jest wy¶wietlana lub podawana
symbolicznie, natomias jako liczba oktalna w przeciwnym razie.
.sp
Symboliczne maski s± podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znaków jest czê¶ci± \fIkto\fP, a druga grupa czêsci±
\fIop\fP, i ostatnio grupa czê¶ci± \fIperm\fP.
Czê¶æ \fIkto\fP okre¶la która czê¶æ umaski ma zostaæ zmodyfikowana.
Litery oznaczaj±:
.RS
.IP \fBu\fP
prawa u¿ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta³ych (nie-u¿ytkownika, nie-groupy)
.IP \fBa\fP
wszelkie prawa naraz (u¿ytkownika, grupy i pozosta³ych)
.RE
.sp
Czê¶æ \fIop\fP wskazujê jak prawa \fIkto\fP majê byæ zmienioe:
.RS
.IP \fB=\fP
nadaj
.IP \fB+\fP
dodaj do
.IP \fB\-\fP
usuñ z
.RE
.sp
Czê¶æ \fIperm\fP wskazuje które prawa maj± zostaæ nadane, dodane lub usuniête:
.RS
.IP \fBr\fP
prawo czytania
.IP \fBw\fP
prawo zapisu
.IP \fBx\fP
prawo wykonywania
.RE
.sp
Gdy stosuje siê symboliczne maski, do opisuj± one które prawa mog± zostaæ
udostêpnioe (w przeciwieñstwie do masek oktalnych, w których nastawienie
bita oznacze, ¿e ma on zostaæ wykasowany).
przyk³ad: `ug=rwx,o=' nastawia maskê tak, ¿e pliki nie bêd± odczytywalne,
zapisywalne i wykonywalne przez `innych', i jest ekwiwalnetne
(w wiêkszo¶ci systemów) do oktalnej maski `07'.
.RE
.\"}}}
.\"{{{  unalias [-adt] name ...
.IP "\fBunalias\fP [\fB\-adt\fP] [\fInazwa1\fP ...]"
Aliasy dla danej nazwy zostaj± usuniête.
Gdy zastosowano opcjê \fB\-a\fP, to wszelkie aliasy zostaj± usuniête.
Gdy zastosowano opcjê \fB\-t\fP lub \fB\-d\fP, to wymienione operacje
zostaj± wykonane jedynie na ¶ledzonych lub odpowiednio
aliasach katalogów.
.\"}}}
.\"{{{  unset [-fv] parameter ...
.IP "\fBunset\fP [\fB\-fv\fP] \fIparametr\fP ..."
Kasuj wymienione parametry (\fB\-v\fP, oznacza domy¶lne) lub funkcje
(\fB\-f\fP).
Statusem zakoñczenia jest nie-zerowy je¶li który¶ z danych parametrów by³
ju¿ wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zakoñczenie danego zadania/zadañ.
Statusem zakoñczenia wait jest status ostaniego podanego zadania:
je¶li dane zadanie zosta³o zabite sygna³em, status zakoñczenia wynosi
128 + number danego sygna³u (patrz \fBkill \-l\fP \fIstatus-zakoñczenia\fP
powy¿ej); je¶li ostatnie dane zadanie nie mo¿e zostaæ odnalezione
(bo nigdy nie istnia³o, lub ju¿ zosta³o zakoñczone), to status
zakoñczenia wait wynosi 127.
Patrz Kontrola Zadañ poni¿ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zakoñczone je¶li zajdzie sygna³ na który zosta³
nastawiony obrabiacz, lub gdy zostanie odebrany sygna³ HUP, INT lub
QUIT.
.sp
Je¶li nie podano zadañ, \fBwait\fP wait czeka na zakoñczenie
wszelkich obecnych zadañ (je¶li istnieja takowe) i koñczy siê
statusem zerowym.
Je¶li kontrola zadañ zosta³a w³±czona, to zostaje wy¶wietlony
status zakoñczeniowy zadañ
(to nie ma miejsca, je¶li zadania zosta³y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka¿dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je¶li podano opcjê \fB\-p\fP, to zostaje odszykany trop
dla \fInazw\fP, bêd±cych zarezerwowanymi z³owami, aliasmi, \fIitp.\fP
Bez opcji \fB\-v\fP \fBwhence\fP dzia³a podobnie do \fBcommand \-v\fP,
poza tym, ¿e \fBwhence\fP odszukuje zarezerwowane s³owa i nie wypisuje
aliasów jako komendy alias;
z opcj± \fB\-v\fP, \fBwhence\fP to tosamo co \fBcommand \-V\fP.
Proszê zwróciæ uwagê, ¿e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp³ywu
na przeszukiwany trop, tak jak dla \fBcommand\fP.
Je¶li typ jednej lub wiêcej sposród nazw niemóg³ zostaæ ustalony 
do status zakoñczenia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola Zadañ"
Kontrola zadañ oznacza zdolno¶æ otoczki to monitorowania i kontrolowania
wykonywanych \fBzadañ\fP,
które s± procesami lub grupami procesów tworzonych przez komendy lub 
ruroci±gi.
Otoczka przynajmniej ¶ledzi status obecnych zadañ w tle
(\fItzn.\fP, asynchronicznych); t± informacjê mo¿na otrzymaæ
wykonyj±æ komendê \fBjobs\fP.
Je¶li zosta³a uaktywnioa pe³na kontrola zadañ
(stosuj±c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w otoczkach interakcjynych,
to procesy pewnego zadania zostaj± umieszczane we w³asnej grupie
procesów, pierwszoplanowe zadnia mog± zostaæ zatrzymane przy pomocy
klawisza wstrzymania z termialu (zwykle ^Z),
zadania mog± zostaæ ponownie podjête albo na pierwszym planie albo
w tle, stosujac odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nastêpnie odtworzony, je¶li
zatanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Proszê zwróciæ uwgaê, ¿e tylko komendy tworz±ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podotoczek, i niewbudowane komendy
nie bêd±ce funkcjami) mog± zostaæ wstrzymane; takie komendy
jak \fBread\fP nie mog± tego.
.sp
Gdy zostaje stworzone zadnie, to przyporzadkowywuje mu siê numer zadania.
Dla interakcyjnych otoczek, numer ten zostaje wy¶wietlone w \fB[\fP..\fB]\fP,
i w nastêpstwie identyfikatory procesów w zadaniu, je¶li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo¿emy odnosiæ siê w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i 
\fBwait\fP albo poprzez id ostatniego procesu w ruroci±gu komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj±c
numer zadania znakiem procentu (\fB%\fP).
Równie¿ nastêpuj±ce sekwencjê z procentem mog± byæ stosowane do
odnoszenia siê do zadañ:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie, lub, gdy brak zatrzymanych zadañ, najstarsze 
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, które wy³oby pod \fB%+\fP gdyby nie zosta³o zakoñczone.
T}
%\fIn\fP	T{
Zadanie z numeram zadania \fIn\fP.
T}
%?\fIci±g\fP	T{
Zadanie zawieracjace ci±g \fIci±g\fP (wystêpuje b³±d, gdy odpowiada mu 
kilka zadañ).
T}
%\fIci±g\fP	T{
Zadanie zaczynaj±ce siê ci±giem \fIci±g\fP (wystêpuje b³±d, gdy odpowiada 
mu kilka zadañ).
T}
.TE
.sp
Je¶li zadanie zmienia status (\fItzn.\fP, gdy zadanie w tle
zostaje zakoñczone lub zadanie na pierwszym planie zostaje wstrzymane), 
otoczka wy¶wietla nastêpuj±ce informacje o statusie:
.RS
\fB[\fP\fInumer\fP\fB]\fP \fIflaga status komenda\fP
.RE
gdzie
.IP "\ \fInumer\fP"
to numer danego zadania.
.IP "\ \fIflaga\fP"
jest \fB+\fP lub \fB-\fP je¶li zadaniem jest odpowiednio zadanie z 
\fB%+\fP lub \fB%-\fP, lub przerwa je¶li nie jest ani jednym ani drugim.
.IP "\ \fIstatus\fP"
Wskazuje opbecny stan danego zadania
i mo¿e to byæ
.RS
.IP "\fBRunning\fP"
Zadania nie jest ani wstrzymane ani zakoñczone (proszê zwróciæ uwagê, i¿
przebieg nie koniecznie musi oznaczaæ spotrzebowywanie
czasu CPU \(em proces mo¿e byæ zablokowany, czekaj±c na pewne zaj¶cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zakoñczone. \fInumer\fP to status zakoñczeniowy danego zadania,
który zostaje pominiety, je¶li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna³\fP\fB)\fP]"
zadanie zosta³o wstrzymane danym sygna³em \fIsygna³\fP (gdy brak sygna³u,
to zadnie zosta³o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna³u\fP [\fB(core dumped)\fP]"
zadanie zosta³o zabite sygna³em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opisów sygna³ów).
Wiadomosæ \fB(core\ dumped)\fP wskazuje, ¿e proces stworzy³ plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, która stworzy³a dany proces.
Je¶li dane zadania zwiera kilka procesów, to k±dy proces zostanie wy¶wietlony
w osobnym wierszy pokazujacym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je¶li jest on odmienny od statusu poprzedniego procesu.
.PP
Je¶li próbuje siê zakoñczyæ otoczkê, podczas gdy istniej± zadania w
stanie zatrzymania, to otoczka ostrzega u¿ytkownika, ¿e s± zadania w stanie
zatrzymania i nie zakañcza siê.
Gdy tu¿ potem zostanie podjêta ponowna próba zakoñczenia otoczki, to
zatrzymane zadania otrzymuj± sygna³ \fBHUP\fP i otoczka koñczy pracê.
podobnie, je¶li nie zosta³a nastawiona opcja \fBnohup\fP,
i s± zadania w pracy, gdy zostanie podjeta próba zakoñczenia otoczki
zameldowania, otoczka ostrzega u¿ytkownika i nie koñczy pracy.
Gdy tu¿ potem zotanie ponownie podjeta próba zakoñczenia pracy otoczki,
to bierz±ce procesy otrzymuj± sygna³ \fBHUP\fP i otoczka koñczy pracê.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna Edycja Wiersza Wprowadzeñ w Trybie Emacs"
Je¶li zosta³a nastawiona opcja \fBemacs\fP,jest w³±czona interakcyjna
edycja wiersza wprowadzeñ.  \fBOstrze¿enie\fP: Ten tryb zachowuje siê
nieco inaczej ni¿ tryb emacs-a w orginalnej otoczce Korn-a
i 8-smy bit zostaje wykasowany w trybie emacs-a.
W trybie tym ró¿ne komendy edycji (zazwyczaj pod³±czone pod jeden lub wiecej
znaków kontrolnych) powoduj± natychmiastowe akcje bez odczekiwania
nastêpnego prze³amania wiersza.  Wiele komend edycji jest zwi±zywana z 
pewnymi znakami kontrolnymi podczas odpalania otoczki; te zwi±zki mog± zostaæ
zmienione przy pomocy nastêpuj±cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi±zki zostaj± wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci±g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi±zana pod dany \fBci±g\fP, który
powinnien sk³adaæ siê ze znaku kontrolnego (zapisanego przy pomocy
strza³ki w górê \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dwóch znaków przedsionkownych.  Wprowadzenie danego
\fIci±gu\fP bêdzie wówczas powodowa³o bezpo¶rednie wywo³anie danej
komendy edycji.  Proszê zwróciæ uwagê, ¿e choæ tylko
dwa znaki przedsionkowe mog± (zwykle ESC i ^X) s± wspomagane, to
równie¿ niektóre ci±gi wieloznakowe równie¿ mog± zostaæ podane.  
Nastêpuj±ce pod³±cza klawisze terminala ANSI lub xterm
(które s± w domy¶lnych podwi±zaniach).  Oczywi¶cie niektóre
sekwencje wyprowadzenia nie chc± dzia³aæ tak g³adko:
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
Wymieñ nazwy funkcji do których mo¿na pod³aczyæ klawisze.
.\"}}}
.\"{{{  bind -m string=[substitute]
.IP "\fBbind \-m\fP \fIci±g\fP\fB=\fP[\fIpodstawienie\fP]"
Dany ci±g wprowadzenia \fIci±g\fP zostanie zamieniony bezpo¶rednio na
dane \fIpodstawienie\fP które mo¿e zawieraæ komendy edycji.
.\"}}}
.PP
Nastêpuje lista dostêpnych komend edycji.
Ka¿dy z poszczególnych opisów zaczyna siê nazw± komendy,
liter± \fIn\fP, je¶li komenda mo¿e zostaæ poprzedzona licznikiem,
i wszelkimi klawiszami do których dana komenda jest pod³aczona
domy¶lnie (w zapisie sotsujacym notacjê strza³kow±, \fItzn.\fP, 
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj±cy komendê wprowadzamy stosuj±c ci±g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci±g sk³adaj±cy siê z jednej
lub wiêcej cyfr;
chyba, ¿e podano inaczej licznik, je¶li zosta³ pominiêty, wynosi 
domy¶lnie 1.
Proszê zwróciæ uwagê, ¿e nazwy komend edycji stosowane s± jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy¶lne podwi±zania zosta³y wybrane
tak, aby by³y zgodne z odpowiednimi podwi±zaniami EMACS-a.  
Znaki u¿ytkownika tty (\fIw szczególno¶ci\fP, ERASE) zosta³y
pod³±czenia do stosownych podstawnieñ i przekasowywuj± domy¶lne
pod³±czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania-histori\fP 
do przerwania tego szukania.
.\"}}}
.\"{{{  auto-insert n
.IP "\fBauto-insert\fP \fIn\fP"
Powoduje po prostu wy¶wietlenie znaku jako bezpo¶rednie wprowadzenie. 
Wiêkszo¶æ zwyk³ych znaków jest pod to pod³±czona.
.\"}}}
.\"{{{  backward-char	n ^B
.IP "\fBbackward-char\fP  \fIn\fP \fB^B\fP"
Przesuwa kursor \fIn\fP znaków wstecz.
.\"}}}
.\"{{{  backward-word  n ^[B
.IP "\fBbackward-word\fP  \fIn\fP \fB^[B\fP"
Przesuwa kursor wstecz na pocz±tek s³owa; s³owa sk³adaj± siê ze
znaków alfanumerycznych, podkre¶lenia (_) i dolara ($).
.\"}}}
.\"{{{  beginning-of-history ^[<
.IP "\fBbeginning-of-history ^[<\fP"
Przesuwa na pocz±tek histori.
.\"}}}
.\"{{{  beginning-of-line ^A
.IP "\fBbeginning-of-line ^A\fP"
Przesuwa kursor na pocz±tek edytowanego wiersza wprowadzenia.
.\"}}}
.\"{{{  capitalize-word n ^[c, ^[C
.IP "\fBcapitalize-word\fP \fIn\fP \fB^[c\fP, \fB^[C\fP"
Przemienia pierwszy znak w nastêpnych \fIn\fP s³owach na du¿± literê,
pozostawiaj±c kursor za koñcem ostatniego s³owa.
.\"}}}
.\"{{{  comment ^[#
Je¶li bierz±cy wiersz nie zaczyna siê od znaku komentarza, zostaje on
dodany na pocz±tku wiersza i wiesz zostaje wprowadzony (tak jakby
naci¶niêto prze³amanie wiersza), w przeciwnym razie istniej±ce znaki
komentarza zostaj± usuniête i kursor zostaje umieszczony na pocz±tku 
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj±cej kursor.  Je¶li ca³a pozosta³a czê¶æ
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy¶wietlona
po wype³nieniy, chyba ¿e jest to nazwa katalogu, w którym to razie zostaje
do³±czone \fB/\fP.  Je¶li nie ma komendy lub nazwy pliku zaczynajacej
siê od takiej czêsci s³owa, to zostaje wyprowadzony znak dzwonka 
(zwykle powodujacy s³yszalne zabuczenie).
.\"}}}
.\"{{{  complete-command ^X^[
.IP "\fBcomplete-command ^X^[\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne z nazwy komendy
zawieraj±cej czê¶ciowe s³owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy¿ej.
.\"}}}
.\"{{{  complete-file ^[^X
.IP "\fBcomplete-file ^[^X\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne z nazwy plikyu
zawieraj±cego czê¶ciowe s³owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy¿ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymieñ mo¿liwe dope³nienia bierz±cego s³owa.
.\"}}}
.\"{{{  delete-char-backward n ERASE, ^?, ^H
.IP "\fBdelete-char-backward\fP \fIn\fP \fBERASE\fP, \fB^?\fP, \fB^H\fP"
Skasuj \fIn\fP znaków przed kursorem.
.\"}}}
.\"{{{  delete-char-forward n
.IP "\fBdelete-char-forward\fP \fIn\fP"
Skasuj \fIn\fP znaków po kursorze.
.\"}}}
.\"{{{  delete-word-backward n ^[ERASE, ^[^?, ^[^H, ^[h
.IP "\fBdelete-word-backward\fP \fIn\fP \fB^[ERASE\fP, \fB^[^?\fP, \fB^[^H\fP, \fB^[h\fP"
Skasuj \fIn\fP s³ów przed kursorem.
.\"}}}
.\"{{{  delete-word-forward n ^[d
.IP "\fBdelete-word-forward\fP \fIn\fP \fB^[d\fP"
Kasuje znaki po koursorze, a¿ do koñca \fIn\fP s³ów.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historji w przód \fIn\fP wierszy (pó¼niej).  
Ka¿dy wiersz wprowadzenia zaczyna siê orginalnie tu¿ po ostatnim
miejscu w buforze historji, tak wiêc
\fBdown-history\fP nie jest przydaten dopuki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Przemieñ na ma³e litery nastêpnych \fIn\fP s³ów.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porousza do koñca historji.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na konieæ wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia³a jako koniec-pliku; Jest to przydatne, albowiem tryb edycji
wprowadzenia wy³±cza normaln± regularyzacjê wprowadzenia terminala.
.\"}}}
.\"{{{  eot-or-delete n ^D
.IP "\fBeot-or-delete\fP \fIn\fP \fB^D\fP"
Dzia³a jako eot je¶li jest samotne na wierszu; w przeciwnym razie
dzia³a jako delete-char-forward.
.\"}}}
.\"{{{  error
.IP "\fBerror\fP"
Error (ring the bell).
.\"}}}
.\"{{{  exchange-point-and-mark ^X^X
.IP "\fBexchange-point-and-mark ^X^X\fP"
Umie¶æ kursor na znaczniku i nastaw znacznik na miejsce w którym by³
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bierz±cego s³owa i zastêpuje dane s³owo wynikiem
rozwiniêcia nazwy pliku na danym s³owie.
Gdy nie pasuj± ¿adne pliki, zadzwoñ.
.\"}}}
.\"{{{  forward-char n ^F
.IP "\fBforward-char\fP \fIn\fP \fB^F\fP"
Przesuwa kursor naprzód o \fIn\fP znaków.
.\"}}}
.\"{{{  forward-word n ^[f
.IP "\fBforward-word\fP \fIn\fP \fB^[f\fP"
Przesuwa kursor naprzód na zakoñczenie \fIn\fP-tego s³owa.
.\"}}}
.\"{{{  goto-history n ^[g
.IP "\fBgoto-history\fP \fIn\fP \fB^[g\fP"
Przemieszcza do historji numer \fIn\fP.
.\"}}}
.\"{{{  kill-line KILL
.IP "\fBkill-line KILL\fP"
Kasuje ca³y wiersz wprowadzenia.
.\"}}}
.\"{{{  kill-region ^W
.IP "\fBkill-region ^W\fP"
Kasuje wprowadzenie pomiêdzy kursorem a znacznikiem.
.\"}}}
.\"{{{  kill-to-eol n ^K
.IP "\fBkill-to-eol\fP \fIn\fP \fB^K\fP"
Je¶li ominiêto \fIn\fP, to kasuje wprowadzenia od kursora do koñca wiersza,
w przeciwnym razie kasuje znaki pomiêdzu cursorem a
\fIn\fP-t± kolumn±.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend lub nazw plików
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
Do nazw katalogów zostaje do³±czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw plików
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
Specyfikatory rodzaju plików zostaj± do³±czone tak jak powy¿ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bierz±cego wiersza wprowadzeñ przez otoczkê.
Kursor mo¿e znajdowaæ siê aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bierz±cego wiersza wprowadzeñ przez otoczkê,
po czym nastêpny wiersz z histori staje siê wierszem bierz±cym.
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
Ostatnie (\fIn\fP-te) s³owo poprzedniej komendy zostaje wprowadzone
na miejscu kursora.
.\"}}}
.\"{{{  quote ^^
.IP "\fBquote ^^\fP"
Nastêpuj±cy znak zostaje wziêty dos³ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zachêcacz i bierz±cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty³ w bierz±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w przód w bierz±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd¼ w krocz±cy tryb szukania.  Wewnêtrzna lista historji zostaje
przeszukiwana wstecz za komendami odpowiadaj±cymi wprowadzeniu.  
pocz±tkowe \fB^\fP w szukanym ci±gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan± wykonywane po opuszczeniu trybu szukania.  
Ponowne komendy \fBsearch-history\fP kontynuuj± szukanie wstecz
do nastêpnego poprzedniego wyst±pienia wzorca.  Bufor historji
zawiera tylko skoñczon± ilo¶æ wierszy; dla potrzeby najstarsze zostaj±
wy¿ucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bierz±cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj±cymi, wypycha pod³±czony znak spowrotem
do wej¶cia terminala, dzie mo¿e on zostaæ specjalnie przetworzony przez
terminal.  Jest to przydatne n.p. dla opcji BRL \fB^T\fP mini-systat'a.
.\"}}}
.\"{{{  stuff-reset
.IP "\fBstuff-reset\fP"
Dzia³a tak jak \fBstuff\fP, a potem przerywa wprowadzenie tak jak
przerwanie.
.\"}}}
.\"{{{  transport-chars ^T
.IP "\fBtranspose-chars ^T\fP"
Na koñcu wiersza lub je¶li w³±czono opcjê \fBgmacs\fP, 
zamienia dwa poprzedzaj±ce znaki; w przeciwnym razie zamienia
poprzedni i birz±cy znak, po czym przesuwa cursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historji \fIn\fP wierszy wstecz (wcze¶niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nastêpnych \fIn\fP s³ów w du¿e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisujê wersjê ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci¶niêty jakikolwiek klawisz 
(po czym ten klawisz zostaje przetworzony, chyba ¿e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad¼ ostatnio skasowny ci±g tekstu na bierz±c± pozycjê kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo¶rednio po \fByank\fP, zamienia wprowadzony tekst na
nastêpny poprzednio skasowany ci±g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny Tryb Edycji Wiersza Wprowadzeñ Vi"
Edytor vi wiersza komendy w ksh obs³uguje w zasadzie te same komendy co
edytor vi (patrz \fIvi\fP(1)), poza nastêpuj±cymi wyj±tkami:
.nr P2 \n(PD
.IP \ \ \(bu
zaczyna w trybie wprowadzania,
.IP \ \ \(bu
ma komendy uzupe³niania nazw plików i komend
(\fB=\fP, \fB\e\fP, \fB*\fP, \fB^X\fP, \fB^E\fP, \fB^F\fP i,
opcjonalnie, \fB<tab>\fP),
.IP \ \ \(bu
komenda \fB_\fP dzia³a odmiennie (w ksh jst to komenda ostatniego argumentu,
a w vi przechodzenie do pocz±tku bierz±cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fPporuszaj± siê w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
i brak jest komend, które nie maj± znaczenia w edytorze obs³ugujacym jeden 
wiersz (\fIw szczególno¶ci\fP, przewijanie ekranu, komendy ex \fB:\fP, 
\fIitp.\fP).
.nr PD \n(P2
.LP
Proszê zwróciæ uwagê, ¿e \fB^X\fP oznacza control-X; oraz \fB<esc>\fP,
\fB<space>\fP i \fB<tab>\fP stosowane s± za escape, space i tab, 
odpowiednio (bez ¿artów).
.\"}}}
.\"{{{  modes
.PP
Tak jak w vi, s± dwa tryby: tryb wprowadzania i tryb komend.
W trybie wprowadzania, wiêkszo¶æ znakow zostaje po prostu umieszczona
w buforze na bierz±cym miejscu kursora w kolejno¶ci ich wpisywania, 
chocia¿ niektóre znaki zostaj± traktowane specjalnie.
W szczególno¶ci nastêpuj±ce znaki odpowiadaj± obecnym ustawieniom tty'a
(patrz \fIstty\fP(1)) i zachowuj± ich normalne znaczenia
(normalne warto¶ci s± podane w nawiasach):
skasuj (\fB^U\fP), wyma¿ (\fB^?\fP), wyma¿ s³owo (\fB^W\fP), eof (\fB^D\fP),
przerwij (\fB^C\fP) i zakoñcz (\fB^\e\fP).
Poza powy¿szymi dodatkowo równie¿ nastêpuj±ce znaki zostaj± traktowane
specjalnie w trybie wprowadzania:
.TS
expand;
afB lw(4.5i).
^H	T{
kasuje poprzedni znak
T}
^V	T{
bazpo¶renio nastêpny: nastêpny naci¶niêty znak nie zostaje traktowany 
specjalnie (mo¿na tego u¿yæ do wprowadzenia opisywanych tu znaków)
T}
^J ^M	T{
kiniec wiersza: bierz±cy wiersz zostaje wczytany, rozpoznany i wykonany
przez otoczkê
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni¿ej)
T}
^E	T{
wyliczanie komend i nazw plików (patrz poni¿ej)
T}
^F	T{
dope³nianie nazw plików (patrz poni¿ej).
Je¶li zostanie u¿yte dwukrotnie, zo wówczas wy¶wietla listê mo¿liwych
dope³nieñ;
je¶li zostanie u¿yte trzykrotnie, to kasuje dope³nienie.
T}
^X	T{
rozwijanie nazw komend i plików (patrz poni¿ej)
T}
<tab>	T{
opcjonalnie dope³nianie nazw plików i komend (patrz \fB^F\fP powy¿ej), 
w³±czane przez \fBset \-o vi-tabcomplete\fP
T}
.TE
.\"}}}
.\"{{{  display
.PP
Je¶li jaki¶ wiersz jest d³u¿szy od szeroko¶ci ekranu
(patrz parametr \fBCOLUMNS\fP),
to zostaje wy¶wietlony znak \fB>\fP, \fB+\fP lub \fB<\fP 
w ostatniej kolumnie, wskazujacy odpowiednio na wiêcej znaków po, przed i po, oraz 
przed obecn± pozycj±.
Wiersz jest przwijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka¿dy znak zostaje interpretowany jako komenda.
Znaki którym nie odpowiada ¿adna komenda, które s± niedopuszczaln± 
komend± lub s± komendami niedowykonania, wszystkie wyzwalaj± dzwonek.
W nastêpuj±cych opisach komend, \fIn\fP wskazuje ¿e komedê mo¿na
poprzedziæ numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znaków); gdy brak przedsionka numerowego, to zak³ada siê, ¿e \fIn\fP 
jest równe 1, chyba ¿e powiemy inaczej.
Zwrot `bierz±ca pozycja' odnosi siê do pozycji pomiêdzy cursorem
a znakiem przed nim.
`S³owo' to ci±g liter, cyfr lub podkre¶leñ
albo ci±g nie nie-liter, nie-cyfr, nie-podkre¶leñ, niebia³ych-znaków
(\fItak wiêc\fP, ab2*&^ zawiera dwa s³owa), oraz `du¿e s³owo' jest ci±giem
niebia³ych znaków.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nastêpuj±cych komend brak, lub s± one odmienne od tych w normalnym
edytorze plików vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad¼ przerwê z nastêpstwem \fIn\fP-tego du¿ego s³owa
z ostatniej komendy w historji na bierz±cej pozycji w wejd¼ z tryp
wprowadzania; je¶li nie podano \fIn\fP to domy¶lnie zostaje wprowadzone
ostatnie s³owo.
.IP "\fB#\fP"
wprowad¼ znak komenta¿a (\fB#\fP) na pocz±tku bierz±cego wiersza
i przeka¿ ten wiersz do otoczki (taksoamo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z wyj±tkiem, ¿e je¶li nie podano \fIn\fP 
to dotyczy to ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj±c edytor vi; 
je¶li nie podano \fIn\fP, to edytuje bierz±cy wiersz.
W³a¶ciw± wykonywan± komend± jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope³nianie komendy lub nazwy pliku zostaje zastosowane do
 obecnego du¿ego s³owa
(po dodaniu *, je¶li to s³owo nie zawiera ¿adnych znaków dope³niania nazw
plików) - du¿e s³owo zostaje zast±pione s³owami wynikowymi.
Je¶li bierz±ce du¿e s³owo jest pierwszym w wierszu (lub wystêpuke po
jednym z nastêpuj±cych znaków: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera pochy³ka (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wyknoane rozwijanie nazwy plików.
Rozwijanie komend podpasowuje du¿e s³owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i równie¿ wszelkie wykonywalne pliki odnajdywane
przeszukuj±c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plików dopasowywuje du¿e s³owo do nazw plików w bierz±cym
katalogu.
Po rozwiniêciu, kursor zostaje umieszczony tu¿ po
ostatnim s³owie na koñcu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope³nianie nazw komend/plików: 
zastêpuje bierz±ce du¿e s³owo najd³uzszym, jednoznacznym
dopasowaniem otrzymanym przez rozwiniêcie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je¶li zosta³a w³±czona opcja 
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je¶li zosta³a w³±czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je¶li podano \fIn\fP to zostaje u¿yte \fIn\fP-te mo¿liwe 
dope³nienie (z tych zwracanych przez komenê wyliczania dope³nieñ nazw
komend/plików).
.IP "\fB=\fP and \fB^E\fP"
wyliczanie nazw komend/plików: wymieñ wszystkie komendy lub pliki
pasujêce pod obecne du¿e s³owo.
.IP "\fB^V\fP"
wy¶wietl wersjê pdksh; jest ona wy¶wietlana do nastêpnego naci¶niêcia
klawisza (ten klawisz zostaje zignorowany).
.IP "\fB@\fP\fIc\fP"
rozwiniêcie makro: wykonaj komendy znajduj±ce siê w aliasie _\fIc\fP.
.RE
.\"}}}
.\"{{{  Intra-line movement commands
.IP "Komendy przemieszczania w wierszu"
.RS
.IP "\fIn\fP\fBh\fP and \fIn\fP\fB^H\fP"
przesuñ siê na lewo \fIn\fP znaków.
.IP "\fIn\fP\fBl\fP and \fIn\fP\fB<space>\fP"
przesuñ siê w prawo \fIn\fP znaków.
.IP "\fB0\fP"
przsuñ siê do kolumny 0.
.IP "\fB^\fP"
przesuñ siê do pierwszego niebia³ego znaku.
.IP "\fIn\fP\fB|\fP"
przesuñ siê do kolumny \fIn\fP.
.IP "\fB$\fP"
przesuñ siê do ostatniego znaku.
.IP "\fIn\fP\fBb\fP"
przesuñ siê wstecz \fIn\fP s³ów.
.IP "\fIn\fP\fBB\fP"
przesuñ siê wstecz \fIn\fP du¿ych s³ów.
.IP "\fIn\fP\fBe\fP"
przesuñ siê na przód do koñca s³owo \fIn\fP razy.
.IP "\fIn\fP\fBE\fP"
przesuñ siê na przód do koñca du¿ego s³owa \fIn\fP razy.
.IP "\fIn\fP\fBw\fP"
przesuñ siê na przód o \fIn\fP s³ów.
.IP "\fIn\fP\fBW\fP"
przesuñ siê na przód o \fIn\fP du¿ych s³ów.
.IP "\fB%\fP"
odnajd¼ wzór: edytor szuka do przodu najbli¿szego nawiasu okr±g³ego
prostok±tnego lub zawi³ego i nastêpnie przesuwa siê od odpowiadaj±cego mu
nawiasu okr±g³ego prostokêtne lub zawi³ego.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesuñ siê w przód do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesuñ siê w ty³ do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesuñ siê w przod tu¿ przed \fIn\fP-te wyst±pienie znaku \fIc\fP.
.IP "\fIn\fP\fBT\fP\fIc\fP"
przesuñ siê w ty³ tu¿ przed \fIn\fP-te wyst±pienie znaku \fIc\fP.
.IP "\fIn\fP\fB;\fP"
powtarza ostatni± komendê \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP.
.IP "\fIn\fP\fB,\fP"
powtarza ostatni± komendê \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP, 
lecz porusza siê w przeciwnym kierunku.
.RE
.\"}}}
.\"{{{  Inter-line movement commands
.IP "Komendy przemieszczania miêdzy wierszami"
.RS
.IP "\fIn\fP\fBj\fP i \fIn\fP\fB+\fP i \fIn\fP\fB^N\fP"
przejd¼ do \fIn\fP-tego nastêpnego wiersza w historji.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd¼ do \fIn\fP-tego poprzedniego wiersza w historji.
.IP "\fIn\fP\fBG\fP"
przejd¼ do wiersza \fIn\fP w historji; je¶li brak \fIn\fP, to przenosi
siê do pierwszego zapamietanego wiersza w historji.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, ¿e je¶li nie podan \fIn\fP to idzie do
ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci±g\fP"
szukaj wstecz w historji \fIn\fP-tego wiersza zawieraj±cego
\fIci±g\fP; je¶li \fIci±g\fP zaczyna siê od \fB^\fP, to reszta ci±gu
musi wystêpowaæ na samym pocz±tku wiersza historji aby pasowa³a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, ¿e szuka do przodu w histori.
.IP "\fIn\fP\fBn\fP"
szukaj \fIn\fP-tego wyst±pienia ostatnio szukanego ci±gu; kierunek jest
ten sam co kierunek ostatniego szukania.
.IP "\fIn\fP\fBN\fP"
szukaj \fIn\fP-tego wyst±pienia ostatnio szukanego ci±gu; kierunek jest
przeciwny do kierunku ostatniego szukania.
.RE
.\"}}}
.\"{{{  Edit commands
.IP "Komendy edycji"
.RS
.IP "\fIn\fP\fBa\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania tu¿ po
bierz±cej pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t± ró¿nic± ¿e dodaje do koñca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bierz±cej
pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t± ró¿nic± ¿e dodaje do tu¿ przed pierwszym niebia³ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamieñ nastêpnych \fIn\fP znaków (\fItzn.\fP, skasuj te znaki i przejd¼
do trybu wprowadzania).
.IP "\fBS\fP"
zast±p ca³y wiersz: wszystkie znaki od pierwszego niebia³ego znaku
do koñca wiersza zostaj± skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd¼ z bierz±cej pozycji do pozycji wynikajacej z \fIn\fP
\fIkomend-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wej¼ w tryb
wprowadzania);
je¶li \fIkomend±-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia³ego znaku pocz±wszy.
.IP "\fBC\fP"
zmieñ od obecnej pozycji op koniec wiersza (\fItzn.\fP, skasuj do koñca wiersza
i przejd¼ do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nastêpnych \fIn\fP znaków.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znaków.
.IP "\fBD\fP"
skasuj do koñca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikajacej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo¿e byæ komend± przemieszczania (patrz powy¿ej) lub \fBd\fP,
co powoduje skasowanie bierz±cego wiersza.
.IP "\fIn\fP\fBr\fP\fIc\fP"
zamieñ nastêpnych \fIn\fP znaków na znak \fIc\fP.
.IP "\fIn\fP\fBR\fP"
zamieñ: wejd¼ w tryb wprowadzania lecz przepisuj istniejace znaki
zamiast wprowadzania przed istniej±cymi znakami.  Zamiana zostaje wykonana
\fIn\fP krotnie.
.IP "\fIn\fP\fB~\fP"
zmieñ wielko¶æ nastêpnych \fIn\fP znaków.
.IP "\fIn\fP\fBy\fP\fImove-cmd\fP"
wytnij od obecnej pozycji po pozycjê wynikaj±c± z \fIn\fP krotnego
\fImove-cmd\fP do bufora wycinania; je¶li \fImove-cmd\fP jest \fBy\fP, to
ca³y wierz zostaje wyciêty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do koñca wiesza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto¶æ bufora wycinania tu¿ po bierz±cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko ¿e bufor zostaje wklejony na bierz±cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "Ró¿ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bierz±cy wiersz zostaje wczytany, rozpoznany i wykonany przez otoczkê.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bierz±cy wiersz.
.IP "\fIn\fP\fB.\fP"
wyknoaj ponownie ostatni± komendê edycji \fIn\fP razy.
.IP "\fBu\fP"
odwróæ ostatni± komendê edycji.
.IP "\fBU\fP"
odwróæ wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zakoñczenia powoduj± skasowania bierz±cego
wiersza i wy¶wietlenie nowej zachêty.
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
.SH B£ÊDY
Wszelkie b³êdy w pdksh nale¿y zg³aszaæ pod adres pdksh@cs.mun.ca.  
Proszê podaæ wersjê pdksh (echo $KSH_VERSION pokazuje j±), maszynê,
system operacyjny i stosowany kompilator oraz opis jak powtórzyæ dany b³±d
(najlepiej ma³y skrypt otoczki demonstruj±cy dany b³±d).  
Nastêpuj±ce mo¿e byæ równie¿ pomocne, je¶li ma znaczenie 
(je¶li nie jeste¶ pewny to podaj to równie¿): 
stosowane opcje (zarówno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo¿na otrzymaæ z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta otoczka powsta³a z publicznego klona 7-mego wydania otoczki
Bourne-a wykonwnego przez Charlesa Forsytha i z czê¶ci otoczki
BRL autorstwa Doug A.\& Gwyn, Doug Kingston,
Ron Natalie, Arnold Robbins, Lou Salkind i innych.  Pierwsze wydanie
pdksh stworzy³ Eric Gisin, a nastêpnie troszczyli siê ni± kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji ¼róde³ zawiera bardziej kompletn±
listê ludzi i ich wk³adu do rozwoju tej otoczki.
.PP
T³umaczenie tego podrêcznika na jêzyk Polski wykona³ Marcin Dalecki 
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "PATRZ RÓWNIE¯"
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
.TH KSH 1 "22 Lutego, 1999" "" "Komendy u¿ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja otoczki Korn-a
.\"}}}
.\"{{{  Synopsis
.SH WYWO£ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP] [ [ \fB\-c\fP \fIci±g-komenda\fP [\fInazwa-komendy\fP] | \fB\-s\fP | \fIplik\fP ] [\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP, to interpretator komend nadaj±cy siê, zarówno jako otoczka
do interakcyjnej pracy z systemem, jak i do wykonywania skryptów.
Jêzyk komend przezeñ rozumiany to nadzbiór jêzyka otoczki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Odpalanie Otoczki"
Nastêpuj±ce opcje mog± zostaæ zastosowane w wierszu komendy:
.IP "\fB\-c\fP \fIci±g-komenda\fP"
otoczka wykonuje rozkaz(y) zawarte w \fIci±g-komenda\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni¿ej
.IP \fB\-l\fP
otoczka zameldowania \(em patrz poni¿ej
interakcyjny tryb \(em patrz poni¿ej
.IP \fB\-s\fP
otoczka wczytuje komendy ze standardowego wej¶cia; wszelkie argumenty
nie bêd±ce opcjami, s± argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni¿ej
.PP
Ponad to wszelkie opcje, opisane w zwi±zku z wmontowan±
komend± \fBset\fP, mog± równie¿ zostaæ u¿yte w wierszu komendy.
.PP
Je¶li ani opcja \fB\-c\fP, ani opcja \fB\-s\fP, nie zosta³y
podane, wówczas pierwszy argument nie bêd±cy opcj±, okre¶la
plik z którego zostan± wczytywane komendy. Je¶li brak jest argumentów
nie bêd±cych opcjami, to otoczka wczytuje komendy ze standardowego
wej¶cia.
Nazwa otoczki (\fItzn.\fP, zawarto¶æ parametru \fB$0\fP)
jest ustalana jak nastêpuje: je¶li u¿yto opcji \fB\-c\fP i zosta³
podany nieopcyjny argument, to jest on nazw±; 
je¶li komendy s± wczytywane z pliku, wówczas nazwa danego pliku zostaje
u¿yta jako nasza nazwa; w kazdym innym przypadku zostaje u¿yta
nazwa, pod jak± dana otoczka zosta³a wywo³ana 
(\fItzn.\fP, warto¶æ argv[0]).
.PP
Otoczka jest \fBinterakcyjna\fP, je¶li u¿yto opcji \fB\-i\fP 
lub je¶li zarówno standardowe wej¶cie, jak i standardowe wyj¶cie,
s± skojarzone z jakim¶ terminalem.
W interakcyjnej otoczce kontrola zadañ (je¶li takowa jest dostêpna
w danym systemie) jest w³±czona i ignoruje nastêpuj±ce sygna³y:
INT, QUIT oraz TERM. Ponadto wy¶wietla ona zachêcacze przed
wczytywaniem wprowadzeñ (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych otoczek, uaktywnia siê domy¶lnie opcja \fBtrackall\fP
(patrz poni¿ej: komenda \fBset\fP).
.PP
Otoczka jest \fBograniczona\fP je¶li zastosowano opcjê \fB\-r\fP lub
gdy, albo podstawa nazwy pod jak± wywo³ano otoczkê, albo parametr
\fBSHELL\fP, pasuj± pod wzorzec *r*sh (\fIw szczególno¶ci\fP, 
rsh, rksh, rpdksh, \fIitp.\fP).
Nastêpuj±ce ograniczenia zachodz± wówczas po przetworzeniu przez
otoczkê wrzelkich plików profilowych i plików z \fB$ENV\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
komenda \fBcd\fP jest wy³±czona
.IP \ \ \(bu
parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP, nie mog± byæ modyfikowane
.IP \ \ \(bu
nazwy komend nie mog± byæ podane przy pomocy absolutnych lub
wzglêdnych tropów
.IP \ \ \(bu
opcja \fB\-p\fP wbudowanej komendy \fBcommand\fP jest niedostêpna
.IP \ \ \(bu
przekierowania, które stwarzaj± pliki, nie mog± zostaæ zastosowane
(\fIw szczególno¶ci\fP, \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Otoczka jest \fBuprzywilejowana\fP, je¶li zastosowano opcjê \fB\-p\fP,
lub, je¶li rzeczywiste id u¿ytkownika lub jego grupy
nie jest zgodne z efektywnym id u¿ytkownika czy grupy
(patrz \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana otoczka nie przetwarza ani $HOME/.profile, ani parametru
\fBENV\fP (patrz poni¿ej), w zamian zostaje przetworzony plik
/etc/suid_profile.
Wykasowanie opcji uprzywilejowania powoduje, ¿e otoczka ustawia swoje
efektywne id u¿ytkownika i grupy na warto¶ci faktycznych id u¿ytkownika
(user-id) i jego grupy (group-id).
.PP
Je¶li podstawa nazwy pod jak± dana otoczka zosta³a wywo³ana 
(\fItzn.\fP, argv[0])
zaczyna siê od \fB\-\fP, lub je¶li podano opcjê \fB\-l\fP,
to zak³ada siê, ¿e otoczka ma byæ otoczk± zameldowania i wczytuje
zawarto¶æ plików \fB/etc/profile\fP i \fB$HOME/.profile\fP,
je¶li takowe istniej± i s± czytelne.
.PP
Je¶li podczas odpalania otoczki zosta³ ustawiony parametr \fBENV\fP
(albo, w wypadku otoczek zameldowania, po przetworzeniu
wszelkich plików profilowych), to jego zawarto¶æ zostaje
poddana podstawieniom komend, arytmetycznym i szlaczka, a nastêpnie
wynikaj±ca z tej operacji nazwa (je¶li takowa istnieje), zostaje
zinterpretowana jako nazwa pliku, podlegaj±cego nastêpnemu
wczytaniu i wykonaniu.
Je¶li parametr \fBENV\fP jest pusty (i niezerowy), oraz pdksh zosta³
skompilowany ze zdefiniowanym makro \fBDEFAULT_ENV\fP, 
to (po wykonaniu wszelkich ju¿ wy¿ej wymienionych podstawieñ)
plik przezeñ okre¶lany zostaje wczytany.
.PP
Status zakoñczenia otoczki wynosi 127, je¶li plik komend
podany we wierszu wywo³ania nie móg³ zostaæ otwarty,
lub jest niezerowy, je¶li wyst±pi³ fatalny b³±d w sk³adni
podczas wykonywania tego¿ skryptu.
W wypadku braku wszelkich b³êdów status jest równy statusowi ostaniej
wykonanej komendy lub zero, je¶li nie wykonano ¿adnej komendy.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk³adnia Komend"
.\"{{{  words and tokens
Otoczka rozpoczyna analizê sk³adni swych wprowadzeñ od podzia³u
na poszczególne s³owa \fIword\fPs.
S³owa, stanowi±ce ci±gi znaków, rozgranicza siê niewycytowanymi
znakami \fIbia³ymi\fP (spacja, tabulator i przerwanie wierszu) 
lub \fImeta-znakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza rozgraniczeniami s³ów spacje i tabulatory s± ignorowane,
podczas gdy, przerwania wierszy zwykle rozgraniczaj± komendy.
meta-znaki stosowane s± to tworzenia nastêpuj±cych kawa³ków:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIetc.\fP,
które s³u¿± do specyfikacji przekierowañ (patrz: przekierowywanie
wej¶cia/wyj¶cia poni¿ej);
\fB|\fP s³u¿y do tworzenia ruroci±gów;
\fB|&\fP s³u¿y do tworzenia co-procesów (patrz Co-Procesy poni¿ej);
\fB;\fP s³u¿y do rozgraniczania komend;
\fB&\fP s³u¿y do tworzenia asynchronicznych ruroci±gów;
\fB&&\fP i \fB||\fP s³u¿± do specyfikacji warkunkowego wykonania;
\fB;;\fP jest u¿ywania w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s± u¿ywane w wyra¿eniach arytmetycznych;
i na zakoñczenie,
\fB(\fP .. \fB)\fP s³u¿± do tworzenia podotoczek.
.PP
Bia³e przerwy lub meta-znaki mo¿na wycytowywaæ indywidualnie
przy u¿yciu wstecznika (\fB\e\fP), lub grupami poprzez
podwójne (\fB"\fP) lub pojedyñcze (\fB'\fP)
cudzys³owy.
Porszê zwróciæ uwagê, i¿ nastêpuj±ce znaki podlegaj± równie¿ 
specjalnej interpretacji przez otoczkê i musz± zostaæ wycytowane
je¶li maj± reprezentowaæ same siebie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to powy¿ej wspomniane symbole wycytowywania
(patrz wycytowywanie poni¿ej);
\fB#\fP, na pocz±tu s³owa rozpoczyna komentarz \(em wszysko do
\fB#\fP, po zakoñczenie bierz±cego wiersza, zostaje zignorowane;
\fB$\fP s³u¿y do wprowadzenia podstawienia  parametru, komendy lub arytmetycznego
wyra¿enia (patrz Podstawienia poni¿ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz Podstawienia poni¿ej);
\fB~\fP rozpoczyna rozwiniêcie katalugo (patrz Rozwijanie Szlaczka poni¿ej);
\fB{\fP i \fB}\fP obejmuj± alternacje w stylu \fIcsh\fP(1)
(patrz Rozwijanie Nawiasów poni¿ej);
i, na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s± stosowane
w generacji nazw plików (patrz Wzorce Nazw Plików poni¿ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s³ów i kawa³ków, otoczka tworzy komendy, z których
wyró¿nia siê dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z³o¿one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, konstrukty grupujace i definicje funkcji.
.PP
Prosta komenda sk³ada siê z kombinacji przyporz±dkowañ warto¶ci 
parametrom (patrz Parametry ponizej), przekierowañ wej¶cia/wyj¶cia
(patrz Przekierowania Wej¶cia/Wyj¶cia poni¿ej), i s³ów komend;
Jedynym ograniczeniem jest to, ¿e wszelkie przyporz±dkowania warto¶ci
parametrom musz± wyprzedzaæ s³owa komendy.
S³owa komendy, je¶li zosta³y takowe podane, okre¶laj± komendê, któr±
nale¿y wykonaæ, wraz z jej argumentami.
Komenda mo¿e byæ wbudowan± komend± otoczki, funkcj± lub
\fIzewnêtrzn± komend±\fP, \fItzn.\fP, oddzielnym
plikiem wykonywalnym, który zostaje zlokalizowany przy u¿yciu
warto¶ci parametru \fBPATH\fP (patrz Wykonywanie Kommend poni¿ej).
Proszê zwróciæ uwagê i¿ wszelkie konstrukty komendowe posiadaj± 
\fIstatus zakoñczenia\fP: dla zewnêtrznych komend, jest to
powi±zane ze statusem zwracanym przez \fIwait\fP(2) (je¶li
komenda niezosta³a odnaleziona, wówczas status wynosi 127, 
natomiast je¶li nie mo¿na by³o jej wykonaæ, wowczas status wynosi 126);
statusy zwracane przez inne konstrukcje komendowe (komendy wbudowane,
funkcje, rurociagi, listy, \fIitp.\fP) s± dok³adnie okre¶lone
i  opisano je w kontekscie opisu danej konstrukcji.
Status zakoñczenia komendy zawieraj±cej jedynie przyporz±dkowania
warto¶ci parametrom, odopwiada statusowi ostaniej wykonanej podczas tego
przyporz±dkowywnia substytucji lub zeru, je¶li ¿adne podstawienia nie mia³y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Komendy mog± zostaæ powi±zane przy pomocy oznacznika \fB|\fP w
\fIruroci±gi\fP, w których standardowe wyj¶cie
wszyskich komend poza ostatni±, zostaje pod³±czone
(patrz \fIpipe\fP(2)) do standardowego wej¶cia nastêpnej w szeregu
komend.
Status zakoñczeniowy ruroci±gu, odpowiada statusowi ostatniej komendy
w nim.
Ruroci±g mo¿e zostaæ poprzedzony zarezerwowanym s³owem \fB!\fP,
dziêki czemu status ruroci±gu zostanie zamieniony na jego
logiczny komplement. Tzn. je¶li pierwotnie status wynosi³
0 wówczas bêdzie on mia³ warto¶æ 1, natomiast je¶li pierwotn± warto¶ci±
nie by³o 0, wówczas komplementarny status wynosi 0.
.\"}}}
.\"{{{  lists
.PP
\fIListê\fP komend tworzymy rozdzielaj±c ruroci±gi
poprzez jeden z nastêpuj±cych oznaczników:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj± uwarunkowane wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko, je¶li status zakoñczenia \fIcmd1\fP by³ zerowy.
Natomiast \fB||\fP zachowuje siê dok³adnie przeciwstawnie. \(em \fIcmd2\fP 
zostaje wykonane jedynie, je¶li status zakoñczeniowy \fIcmd1\fP by³
ró¿ny od zera.
\fB&&\fP i \fB||\fP wi±¿± równowa¿nie, a zarazem mocniej ni¿
\fB&\fP, \fB|&\fP i \fB;\fP, które równie¿ posiadaj± t± sam± si³ê wi±zania.
Oznacznik \fB&\fP powoduje, ¿e poprzedzaj±ca go komenda zostanie wykonana
asynchronicznie, tzn., otoczka odpala dan± komendê, jednak nie czeka na jej
zakoñczenie (otoczka ¶ledzi dok³adnie wszystkie asynchronicznye
komendy \(em patrz Kontroloa Zadañ poni¿ej).
Ja¶li asynchroniczna komenda zostaje zastartowana z wy³±czony±
kontrol± zadañ (\fInp.\fP, w wiêkszo¶ci skryptów), 
wówczas komenda zostaje odpalona z wy³±czonymi sygna³ami INT
i QUIT, oraz przekierowanym wej¶ciem na /dev/null
(aczkolwiek przekierowania, ustalone w samej asynchronicznej komendzie
maj± tu pierwszeñstwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi±cy specjalnego
rodzaju asynchroniczn± komendê (patrz Koprocesy poni¿ej).
Proszê zwróciæ uwagê, i¿ po operatorach \fB&&\fP i \fB||\fP 
musi wystêpowaæ komenda, podczas gdy niekoniecznie
po \fB&\fP, \fB|&\fP i \fB;\fP.
Statusem zakoñczenia listy komend jest status ostatniej wykonanej w niej
komendy z wyj±tkiem asynchronicznych list, dla których status wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Z³o¿none komendy tworzymy przy pomocy nastêpuj±cych zarezerwowanych s³ów
\(em s³owa te zostaj± wy³acznie rozpoznane, je¶li nie s± wycytowane i
wystepuj± jako pierwsze wyrazy w komendzie (\fIdok³aniej\fP, nie s± poprzedzane
¿adnymi przyporz±dkowywaniami warto¶ci parametrom
lub przekierunkowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niektóre otoczki (lecz nie nasza) wykonuj± rozkazy kontrolne
w podotoczce, je¶li jeden lub wiêcej z ich deskryptorów plików zosta³y
przekierowane, tak wiêc wszekiego rodzaju zmiany otoczenia w nich mog±
nie dzia³aæ.
Aby zachowaæ portabilijno¶æ nale¿y stosowaæ rozkaz \fBexec\fP,
zamiast przekierowañ deskryptorów plików przed rozkazem kontrolnym.
.PP
W nastêpuj±cym opisie z³o¿onych komend, listy komend (zanaczone przez 
\fIlista\fP) koñcz±ce siê zarezerwowanym s³owem
musz± koñczyæ siê ¶rednikiem lub prze³amaniem wiersza lub (poprawnym
gramatycznie) zarezerwowanym s³owem.
Przyk³adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s± poprawne, lecz
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlistê\fP w podotoczce.  Nie ma bezpo¶redniej mo¿liwo¶ci
przekazania warto¶ci parametrów podotoczki z powrotem do jej
otoczki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Z³o¿ony konstrukt; \fIlista\fP zostaje wykonana, lecz nie w podotoczce.
Prosze zauwa¿uæ, i¿ \fB{\fP i \fB}\fP, to zarezerwowane s³owa, a nie
meta-znaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs³owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra¿enie \fBcase\fP stara siê podpasowaæ \fIs³owo\fP pod jeden
z danych \fIwzorców\fP; \fIlista\fP, powi±zana z pierwszym
poprawnie podpasowanym wzorcem, zostaje wykonana.  
Wzorce stosowane w wyra¿eniach \fBcase\fP odpowiadaj± wzorcom
stosowanymi do specyfikacji wzorców nazw plików z wyj±tkeim tego, ¿e
ograniczenia zwi±zane z \fB\&.\fP i \fB/\fP niezachodz±.  
Proszê zwróciæ uwagê na to, ¿e wszelkie niewycytowane bia³e
przerwy przed i po wzorcu zostaj± usuniête; wszelkie przerwy we wzorcu
musz± byæ wycytowane.  Zarówno s³owa jak i wzorce podlegaj± podstawieniom
parametrów, rozwiniêciom arytmetycznym jak i podstawieniu szlaczka.
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykaj±cy zamiast \fBin\fP i \fBesac\fP 
(\fIw szczegóno¶ci wiêc\fP, \fBcase $foo { *) echo bar; }\fP).
Statusem wykonania wyra¿enia \fBcase\fP jest status wykonanej
\fIlisty\fP; je¶li niezosta³a wykanana ¿adna \fIlista\fP, 
wówczas status wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest, albo przerwaniem wiersza, albo \fB;\fP.
Dla ka¿dego \fIs³owa\fP w podanej li¶cie s³ów, parameter \fInazwa\fP zostaje
ustawiony na to s³owo i \fIlista\fP wykonana. Je¶li nie u¿yjemy \fBin\fP 
do specyfikacji listy s³ów, wówczas zostaj± u¿yte parametry pozycyjne
(\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP) wzamian.
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP 
(\fIw szczególno¶ci\fP, \fBfor i; { echo $i; }\fP).
Statusem wykonania wyra¿enia \fBfor\fP jest ostatni status
wykonania danej \fIlisty\fP; je¶li \fIlista\fP nie zosta³a w ogóle
wykonana, wówczas status wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je¶li status wykonania pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je¶li mamy takow±,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami.  Je¶li wszystkie listy po \fBif\fP
i \fBelif\fPs wyka¿± b³±d (\fItzn.\fP, zwróc± niezerowy status), to
\fIlista\fP po \fBelse\fP zostanie wykonana.
Statusem wyra¿enia \fBif\fP jest status wykonanej \fIlisty\fP,
nieokre¶laj±cej warunek; Je¶li ¿adna nieokre¶laj±ca warunek
\fIlista\fP niezostanie wykonana, wówczas status wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest, albo prze³amaniem wiersza albo \fB;\fP.
Wyra¿enie \fBselect\fP umo¿liwia automatyczn± prezentacjê u¿ytkownikowi
menu, wraz z mo¿liwo¶ci± wyboru z niego.
Przeliczona lista wykazanych \fIs³ów\fP zostaje wypisana na
standardowym wyj¶ciu b³êdów, poczym zostaje
wy¶wietlony zachêcacz (\fBPS3\fP, czyli domy¶lnie `\fB#? \fP').
Nastêpnie zostaje wczytana liczba odpowiadaj±ca danemu punktowi
menu ze standardowego wej¶cia, poczym \fInazwie\fP 
zostaje przyporz±dkowane w ten sposób wybrane s³owo (lub warto¶æ
pusta, je¶li dane wybór by³ niew³a¶ciwy), \fBREPLY\fP
zostaje przyporz±dkowane to co zosta³o wczytane
(po usuniêciu pocz±tkowych i koñcowych bia³ych przerw),
i \fIlista\fP zostaje wykonan.
Je¶li wprowadzono pusty wiersz (\fIdok³adniej\fP, zero lub wiêcej
znaczków \fBIFS\fP) wówczas menu zostaje podownie wy¶wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zakoñczone, 
wówczas przeliczona lista wyborów zostaje wy¶wietlona ponownie, je¶li
\fBREPLY\fP jest zerowe, zachêcacz zostaje ponownie podany i tak dalej.
Proces ten powtarza siê, a¿ do wczytania znaku zakoñczenia pliku,
otrzymania sygna³u przerwania, lub wykonania wyra¿enia przerwania
w ¶rodku wstêgi.
Je¶li opuszczono \fBin\fP \fIs³owo\fP \fB\&...\fP, wówczas
u¿yte zostaj± parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP, 
\fIitp.\fP).
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i 
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczególno¶ci\fP, 
\fBselect i; { echo $i; }\fP).
Statusem zakoñczenia wyra¿enia \fBselect\fP jest zero, je¶li
uzyta wyra¿enia przerwania do wyjscia ze wstêgi, albo
nie-zero w wypadku przeciwnym.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia³a dok³adnie jak \fBwhile\fP, z wyj±tkiem tego, ¿e zawarto¶æ
wstêgi zostaje wykonana jedynie gdy status pierwszej 
\fIlisty\fP jest nie-zerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra¿enie \fBwhile\fP okre¶la wstêgê o przedbiegowym warunku jej
wykonania.  Zawarto¶æ wstêgi zostaje wykonywana dopuki,
doputy status wykonania pierwszej \fIlisty\fP jest zerowy.
Statusem zakoñczeniowym wyra¿enia \fBwhile\fP jest ostatni 
status zakoñczenia \fIlisty\fP w zawarto¶ci tej wstêgi; 
gdy zawarto¶æ nie zostanie wogóle wykonana wówczas status wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcjê o nazwie \fInazwa\fP.
Patrz Funkcje poni¿ej.
Proszê zwróciæ uwagê, ¿e przekierowania tu¿ po definicji
funkcji zostaj± zastosowane podczas wykonywania jej zawarto¶ci, 
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fIname\fP \fB()\fP \fIcommand\fP"
Niemal dok³adnie to samo co w \fBfunction\fP.
Patrz Funkcje poni¿ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra¿enie\fP \fB))\fP"
Warto¶æ wyra¿enia arytmetycznego \fIwyra¿enie\fP zostaje przeliczona;
równowa¿ne do \fBlet "\fP\fIwyra¿enie\fP\fB"\fP.
patrz Wyra¿enia Arytmetyczne i komenda \fBlet\fP poni¿ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (które opisyjemy 
pó¿niej), z nastêpuj±cymi ró¿nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie pól i generacja nazw plików nies± wykonywana na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub), zostaj± zast±pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok³adniej.\fP, \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP) 
musz± byæ wycytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczególno¶ci\fP, porównanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP
które zwracaj± prawdê, gdy pierwszy ci±gowy operand jest mniejszy lub 
odpowiednio wiêkszy do drugiego operanda ci±gowego.
.IP \ \ \(bu
Jednoargumentowa postaæ operacji \fBtest\fP,
w której sprawdza siê czy jedyny operand jest d³ugo¶ci zeroweji, jest 
niedozwolona
- operatory zawsze muszê byæ wykazywane jawnie, \fIw szczególno¶ci\fP, 
zamiast
.ce
\fB[\fP \fIci±g\fP \fB]\fP
nale¿y u¿yæ
.ce
\fB[[ \-n \fP\fIci±g\fP\fB ]]\fP
.IP \ \ \(bu
Podstawienia parametrów, komend i arytmetyczne zostaj± wykonane
w trakcie wyliczania wyra¿enia. Do operatorów
\fB&&\fP i \fB||\fP zostaje zastosowana metoda ogródkowego wyliczania
ich warto¶ci.
To znaczy, ¿e w wyra¿eniu
.ce
\fB[[ -r foo && $(< foo) = b*r ]]\fP
warto¶æ \fB$(< foo)\fP zostaje wyliczona wtedy i tylko wtedy, gdy
plik o nazwie \fBfoo\fP istnieje i jest czytelny.
.nr PD \n(P2
.RE
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Quoting
.SS Wycytowywanie
Wycytowywanie stosuje siê to zapobiegania, aby otoczka trakotwa³a
znaki lub s³owa w specjalny sosób.
Istniej± trzy metody wycytowywania: Po pierwsze, \fB\e\fP wycytowywuje
nastêpny znak, gdy tylko nie mie¶ci siê on na koñcu wiersza, gdzie
zarówna \fB\e\fP jak i przeniesienie wiersza zostaj± usuniête.
po drugie pojedyñczy cydzys³ow (\fB'\fP) wycytowywuje wszystko,
a¿ po nastêpny pojedyñczy cudzys³ów (wraz z prze³amaniami wierszy w³±cznie).
Po trzecie, podwójny cudzys³ów (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a¿ po nastêpny niewycytowany podwójny 
cudzys³ów.
\fB$\fP i \fB`\fP wewnatrz podwójnych cudzys³owów zachowuj± zwyk³e 
znacznie (\fItzn.\fP,
znaczaj± podstawienie warto¶ci parametru, komendy lub wyra¿enia arytmetycznego),
je¶li tylko niezostanie wykonany jakikolwiek podzia³ pól na
wyniku podwójnymi cudzys³owami wycytowanych podstawieñ.
Je¶li po \fB\e\fP, wewnatrz podwójnymi cudzys³owami wycytowanego
ci±gu znaków, nastêpuje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zastêpiony drugim z tych znaków;
je¶li nastêpne jest prze³amanie wierszu, wówczas zarówno \fB\e\fP 
jak i prze³amanie wirszu zostaj± usuniête;
w przeciwnym razie zarówno znak \fB\e\fP jak i nastêpuj±cy po nim znak
nie podlegaj± ¿adnej zamianie.
.PP
Uwaga: patrz Tryb POSIX poni¿ej pod wzglêdem szczególnych regó³
obowi±zuj±cych sekwencje znaków postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej± dwa rodzaje aliasów: normalne aliasy komend i
¶ledzone aliasy.  Aliasy komend stosowane s± zwykle jako
skróty dla d³ugich a czêsto stosowanych komend. 
Otoczka rozwija aliasy komend (\fItzn.\fP,
odstawia pod nazwê aliasu jest zawarto¶æ), gdy wczytuje
pierwsze s³owo komendy. 
Roziwniêty alias zostaje ponownie przetworzony, aby uwzglêdniæ
ewentualne wystêpowanie dlaszych aliasów.  
Je¶li alias komendy koñczy siê przerw± lub tabulatorem, to wówczas
nastêpne s³owo zostaje równie¿ sprawdzone pod wzglêdem rozwiniêcia
aliasów. Proces rozwijania aliasów koñczy siê przy napotkaniu
s³owa, które nie jest aliasen, gdy napotknie siê na wycytowane s³owo,
lub gdy napotka siê na alias, który jest w³a¶nie wyeksportowywany.
.PP
Nastêpuj±ce aliasy s± definiowane domy¶lnie przez otoczkê:
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
¦ledzone aliasy pozwalaj± otoczce na zapamiêtanie, gdzie
odnalaz³a ona konkretn± komendê.
Gdy otoczka po raz pierwszy odszukuje komendy po tropie, która
zosta³a naznaczona ¶ledzonym aliasem, wowczas zapamiêtywuje ona
sobie pe³ny trop do tej komendy.
Gdy otoczka nastêpnie wykonuje danê komendê poraz drugi,
wówczas sprawdza ona czy ten trop wci±¿ jest nadal aktualny i je¶li
tak nie przegl±da ju¿ wiêcej pe³nego tropu w poszukiwaniu
danej komendy.
¦ledzone aliasy mo¿na wy¶wietliæ lub stworzyæ stosuj±c \fBalias
\-t\fP.  Proszê zauwa¿yæ, ¿e zmieniajac warto¶æ parametru \fBPATH\fP 
równie¿ wyczyszczamy tropy dla wszelkich ¶ledzoenych aliasów.
Je¶li zosta³a w³±czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP), 
wówczas otoczka ¶ledzi wszelkie komendy. 
Ta opcja zostaje w³±czona domy¶lnie dla wszelkich
nieinterakcyjnych otoczek.
Dla otoczek interakcyjnych, jedynie nastêpuj±ce komendy, s± 
¶ledzone domy¶lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki otoczka wykonyje, podczas wykonywania
prostej komendy, jest przeprowadzenia podstawieñ na s³owach tej¿e
komendy.
Istniej± trzy rodzaje podstawieñ: parameterów, komend i arytmetyczne.
Podstawienia parametrów, które dok³adniej opiszemy w nastêpnej sekcji,
maj± postaæ \fB$name\fP lub \fB${\fP...\fB}\fP; 
podstawienia komend maj± postaæ \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je¶li podstawienie wystêpuje poza podwójnymi cudzys³owami, wówczas 
wynik tego podstawienia podlega zwykle podzia³owi s³ów lub pól, w zale¿no¶ci
od bierz±cej warto¶ci parametru \fBIFS\fP.
Parametr \fBIFS\fP specyfikuje listê znaczków, które
s³u¿± jako rozgraniczniki w podziale ci±gów znaków na pojedyñcze 
wyrazy;
wszelkie znaki wymienione w tym zbiorze oraz tabulator, przerywacz i 
prze³amanie wiersza w³±cznie, nazywane s± \fIIFS bia³ymi przerywaczami\fP.
Ci±gi jednego lub wielu bia³ych przerywaczy z IFS w powi±zaniu
z zerem oraz jednym lub wiêcej bia³ych przerywaczy nie wymienionych w IFS,
rozgraniczaj± pola.
Jako wyj±tek poprzedajace i koñcowe bia³e przerywacze z IFS zostaj± usuniête
(\fItzn.\fP, nie powstaj± przezeñ ¿adne prowadz±ce lub zakañczaj±ce
puste pola); natomiast prowadz±ce lub koñcz±ce bia³e przerwy nie z IFS
definiuj± okre¶laj± puste pola.
Przyk³adowo: je¶li \fBIFS\fP zawiera `<spacja>:', to ci±g
znaków `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Proszê zauwa¿yæ, ¿e je¶li parametr \fBIFS\fP 
jest ustawiony na pusty ci±g znaków, to wówczas ¿aden podzia³ pól
nie ma miejsca; gdy paramter ten nie jest ustawiony w ogóle,
wówczas stosuje siê domy¶lnie jako rozgraniczniki
przerwy, tabulatora i przerwania wiersza.
.PP
Je¶li nie podajemy inaczej, to wynik podstwaienia
podlega równie¿ rozwijaniu nawiasów i nazw plików (patrz odpowiednie
akapity poni¿ej).
.PP
Podstawienie komendy zostaje zast±pione wyj¶ciem, wygenerowanym
podczas wykonania danej komendy przez podotoczkê.
Dla podstawienia \fB$(\fP\fIkomeda\fP\fB)\fP zachodz± normalne
regó³y wycytowywania, podczas analizy \fIkomendy\fP,
choæ jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu¿ po nim, zostaje usuniêty
(znak \fB\e\fP z nastêpstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyjatkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczajaca podstawienie zawarto¶ci pliku \fIplik\fP 
($(< foo) ma wiêc ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony ¿aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra¿enia \fB$(\fP\fIkomendacommand\fP\fB)\fP s± analizowane
obecnie poprzez odnajdywanie zaleg³ego nawiasu, niezale¿nie od
wycytowañ.  Miejmy nadziejê, ¿e to zostanie jak najszybciej
skorygowane.
.PP
Podstwaienia arytmetyczne zostaja zast±pione warto¶ci± wyniku
danego wyra¿enia.
Przyk³adowo wiêc, komenda \fBecho $((2+3*4))\fP wy¶wietla 14.
Patrz Wyra¿enia Arytmetyczne aby odnale¼æ opis \fIwyra¿eñ\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w otoczce; mo¿na im przyporz±dkowywaæ 
warto¶ci, oraz wyczytywaæ je poprzez podstwaienia parametrowe.
Nazwa parametru jest albo jednym ze znaków 
intperpunkyjnych o specjalnym znaczeniu lub cyfr±, jakie opisujemy 
poni¿ej, lub liter± z nastêpstwem jednej lub wiêcej liter albo cyfr
(`_' zalicza siê to liter).
Podstawienia parametrów posiadaj± postaæ \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdziee \fInazwa\fP jest nazw±
danego parametru.
Gdy podstawienia zostanie wykonane na parametrzy, który nie zosta³
ustalony, wówczas zerowy ci±g znaków jest jego wynikiem, chyba ¿e
zosta³a w³aczona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP) co oznacza, ¿e wystêpuje wówczas b³±d.
.PP
.\"{{{  parameter assignment
Warto¶ci mo¿na przyporz±dkowywaæ parametrom na wiele ró¿nych sposobów.
Po pierwsze, otoczka domy¶lnie ustala pewne parametry takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny sposób w jaki parametry zwi±zana 
ze specjalnymi jednoznakami s± ustawiane.  Po drugie, parametry zostaj± 
importowane z otocznia otoczki podczas jej odpalania.  Po przecie,
parametrom mo¿na przyporz±dkowaæ warto¶ci we wierszu komendy, tak jak np.,
`\fBFOO=bar\fP' przyporz±dkowywuje parametrowi FOO warto¶æ bar;
wielokrotne przyporz±dkowania warto¶ci s± mo¿liwe w jednym wierszu komendy
i mo¿e po nich wystêpowaæ prosta komenda, co powoduje, ¿e
przyporz±dkowania te s± wówczas jedynie aktualne podczas
wykonywywania danej komendy (tego rodzaju przyporz±dkowywania
zostaj± równie¿ wyekstportowane, patrz poni¿ej co do tego konsekwencji).
Proszê zwróciæ uwagê, i¿, aby otoczka rozpozna³a je jako
przyporz±dkowanie warto¶ci parametrowi, zarówno nazwa parametru jak i \fB=\fP
nie mog± byæ wycytowane.
Czwartym sposobem ustawiania parametrów jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale Wykonywanie Komend.
Po czwarte wstêgi \fBfor\fP i \fBselect\fP ustawiaj± parametry,
tak jak i równie¿ komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zakoñczenie, paramerom mo¿na przyporz±dkowywaæ warto¶ci stosuj±c
operatory nadania warto¶ci wewn±trz wyra¿eñ arytmetycznych
(patrz Wyra¿enia Arytmetyczne poni¿ej) lub
stosujac postaæ \fB${\fP\fInazwa\fP\fB=\fP\fIwarto¶æ\fP\fB}\fP
podstawienia parametru (patrz poni¿ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem exportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP,albo poprzez przyporz±dkowywanie warto¶ci
parametru z nastêpuj±c± prost± komend±) 
zostaj± umieszczone w otoczeniu (patrz \fIenviron\fP(5)) komend
wykonywanych przez otoczke jako pary \fInazwa\fP\fB=\fP\fIwarto¶æ\fP.
Kolejno¶æ w jakiej parametry wystêpuj± w otoczeniu komendy jest 
nieustalona bli¿ej.
Podczas odpalania otoczka pozyskuje parametry ze swojego
otoczenia,
i automatycznie ustawia na tych¿e parametrach atrybut exportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo¿na stosowaæ modyfikatory do postaciu \fB${\fP\fInazwa\fP\fB}\fP 
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna
warto¶æ, w przeciwnym razie zostaje podstawione \fIs³owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje podstawione 
\fIs³owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastwaiony i niezerowy, wówczas zostaje podstawiony 
on sam, w przeciwnym razie zostaje my przyporz±dkowana warto¶æ
\fIs³owo\fP i warto¶æ wynikaj±ca ze \fIs³owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs³owo\fP\fB}\fP
je¶li \fInazwa\fP jest nastawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna warto¶æ, w przeciwnym razie \fIs³owo\fP
zostaje wy¶wietlone na standardowym wyj¶ciu b³êdów (tu¿ po \fInazwa\fP:)
i zachodzi b³±d
(powoduj±cy normalnie zakoñczenie ca³ego skryptu otoczki, funkcji lub \&.-scryptyu).
Je¶li s³owo zosta³o pominiête, wówczas zostaje u¿yty ci±g 
`parameter null or not set' w zamian.
.PP
W powy¿szych modyfikatorach mo¿emy omin±æ \fB:\fP, czego skutkiem
bêdzie, ¿e warunki bêd± jedynie wymagaæ aby
\fInazwa\fP by³ nastawiony lub nie (a nie ¿eby by³ ustawiony i niezerowy).
Je¶li potrzebna jest warto¶æ \fIs³owo\fP, wówczas zostaj± nañ wykonane
podstawienia parametrów, komend, arytmetyczne i szlaczka;
natomiast, je¶li \fIs³owo\fP oka¿e siê byæ niepotrzebne, wówczas jego
warto¶æ nie zostanie obliczona.
.\"}}}
.PP
Mo¿na stosowaæ, równie¿ podstawienia parametrów o nastêpuj±cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Ilo¶æ parametrów pozycyjnych, je¶li \fInazw±\fP jest \fB*\fP, \fB@\fP lub
niczego nie podano, lub d³ugo¶æ ci±gu bêd±cego wasto¶ci± parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Ilo¶æ elemntów w ci±gu \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak³ada siê na pocz±tek warto¶ci parametru \fInazwa\fP,
wówczas pasuj±cy teks zostaje pominiêty w wynikajacym z tego podstawieniu. 
Pojedyñczy \fB#\fP oznacza najkrótsze mo¿liwe podpasowanie pod wzorzec, a daw \fB#\fP
oznaczaj± jak najd³u¿sze podpasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko ¿e dotyczy
koñca warto¶ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nastêpuj±ce specjalne parametry zostaja ustawione domy¶nie przez otoczkê
i nie mo¿na przyporz±dkowywaæ jawnie warto¶ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego zastartowanego w tle procesu. Je¶li nie ma
aktualnie procesów zastartowanych w tle, wówczas parametr ten jest 
nienastawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Ilo¶æ parametrów pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj±cego danej otoczce lub PID pierwotnej otoczki,
je¶li mamy do czynienia z  podotoczk±.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenecja bierz±cych opcji jednoliterkowych
(patrz komenda \fBset\fP poni¿ej, aby poznaæ dostêpne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Status wynikowy ostatniej wykonanej  nieasynchronicznej komendy.
Je¶li ostatnia komenda zosta³a zabita sygna³em, wówczas, \fB$?\fP 
przyjmuje warto¶æ 128 plus numer danego sygna³u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa pod jak± dana otoczka zosta³a wywo³ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP je¶li zosta³a ona wywo³ana przy urzyciu opcji \fB\-c\fP 
i \fBnazwa komendy\fP zosta³a podana, lub argument \fIplik\fP,
je¶li takowy zosta³ podany.
Je¶li opcja \fBposix\fP nie jest nastawiona, to \fB$0\fP zawiera
nazwê bie¿±cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewiêc parametrów pozycyjnych podanych otoczce, czy
funkcji lub \fB.\fP-skriptowi.
Dostêp do dlaszych parametrów pozycyjnych odbywa siê przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj±tkiem parametru 0), 
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u¿yte poza podwójnymi cudzys³owami, wówczas parametry zostaj±
rozgraniczone w pojedyñcze s³owa
(podlegaj±ce rozgraniczaniu s³ów); je¶li u¿yte pomiêdzy 
podwójnymi cudzys³owami, wowczas parametry zostaj± rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci±gami znaków, je¶li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj±tkiem zastosowania w podwójnych cudzys³owach,
gdzie oddzielne s³owo zostaje wygenerowane dla ka¿dego parametru
pozycyjnego z osobna \- je¶li brak parametrów pozycyjnych,
wówczas nie generowane jest ¿adne s³owo
("$@" mo¿e byæ uzyte aby otrzymaæ dostê bezpo¶redni do argumentów
bez utraty argumentów zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nastêpuj±ce parametry zostaj± nastawione przez otoczkê:
.\"{{{  _
.IP "\fB_\fP \fI(podkre¶lenie)\fP"
Gdy jaka¶ komenda zostaje wykonywana prze otoczkê, ten parametrt przyjmuje
w otoczeniu odpowiedniego nowego procesu warto¶æ tropu prowadz±cego
do tej¿e komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierowtej otoczce
ponadto warto¶æ ostatniego s³owo poprzedniej komendy
Podczas warto¶ciowania wiadomosci typu \fBMAILPATH\fP,
parametr ten zawiera wiêc nazwê pliku który siê zmieni³
(patrz parametr \fBMAILPATH\fP poni¿ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
Trop do przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia³a tak samo jak
\fBPATH\fP dla katalogów nierozpoczynajacych siê od \fB/\fP 
w komendach \fBcd\fP.
Proszê zwróciæ uwagê, i¿ je¶li CDPATH jest nastawiony i nie zwaiera ani
\fB.\fP ani pustego tropu, to wówczas katalog bie¿±cy nie zostaje przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Ilo¶æ kolumn terminala lub okienka.
Obecnie nastawiany warto¶ci± \fBcols\fP zwracan± przez komendê
\fIstty\fP(1), je¶li ta warto¶æ nie wynosi zera.
Parametr ten ma znaczenia w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w³a¶ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je¶li nie zosta³ nastawiony parametr \fBVISUAL\fP, wówczas kontroluje on
tryb edycj wiersza komendy w otoczkach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni¿ej, aby dowiedzieæ siê jak to dzia³a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je¶li parametr ten oka¿e siê byæ nastawionym po przetworzeniu
wszelkich plików profilowych, wówczas jego rozwinieta warto¶æ zostaje
wyko¿ystana jako nazwa pliku zawieraj±cego dalsze komendy inicjalizacyjne
otoczki.  Zwykle zwiera on definicje funkcji i aliasów.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca³kowita warto¶æ odpowiadaj±ca zmiennej errno otoczki 
\(em wskazuje przyczynê wyst±pienia b³êdu, gdy ostatnie wywoa³nie
systemowe nie powiod³o siê.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezimplementowe.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je¶li nastawiono, to wówczas zawiera otoczkê, jakiej nale¿y u¿yæ
do wykonywania komend których niezdo³a³ wykonaæ \fIexecve\fP(2) 
i które nie zaczynaja siê od ci±gu `\fB#!\fP \fIotoczka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u¿ywany przez komendê \fBfc\fP (patrz poni¿ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je¶li otoczka natrafi na niezdefiniowan± 
funkcjê podczas pracy, stosowane do lokalizacji pliku zawieraj±cego definicjê
tej funkcji.
Równie¿ przeszukiwane, gdy komenda nie zosta³a odnaleziona przy
u¿yciu \fBPATH\fP.
Patrz Funkcje poni¿ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u¿ywanego do zapisu histori komend.
Je¶li warto¶æ zosta³a ustalona, wówczas historia zostaje za³adowana
z danego pliku.
Podobnie wielokrotne wcielenia otoczki bêd± ko¿ysta³y z jednej
historii, je¶li dla nich warto¶ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je¶li HISTFILE nie zosta³o ustawione, wówczas ¿aden plik histori
nie zostaje u¿yty.  W originalnej wersji otoczki
Korna natomiast, przyjmuje siê domy¶lnie \fB$HOME/.sh_history\fP;
w przysz³o¶ci mo¿e pdksh, bêdzie równie¿ sotoswa³ domy¶lny
plik histori.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Ilo¶æ komend zapamiêtywana w histori, domy¶lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy¶lna warto¶æ dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz Rozwijanie Szlaczka poni¿ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewnêtrzny rodzielacz pól, sotoswany podczas podstawieñ
i wykonywania komendy \fBread\fP, do rozgraniczania
warto¶ci w oddzielne argumenty; domy¶nie ustawiony na przerwê, tabulator i 
prze³amanie wiersza. Szczególy zosta³y opisane w punkcie Podstawienia
powy¿ej.
.br
\fBUwaga:\fP ten parametr nie zostaje importowany z otoczenia, 
podczas odpalania otoczki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja otoczki i data jest stworzenia (tylko otczyt mo¿liwy).
Patrz równie¿ komedy wersji w Emacsowej Interakcyjnej Edycji Wiersza 
Komendy i Vi Edycji Wiersza poni¿ej.
.\"}}}
.\"{{{  SH_VERSION
.\"}}}
.\"{{{  LINENO
.IP \fBLINENO\fP
Numer wiersza w funkcji lub aktualnie wykonywanym skrypcie.
.\"}}}
.\"{{{  LINES
.IP \fBLINES\fP
Ilo¶æ wierszy na terminalu lub w okienku.
.\"Currently set to the \fBrows\fP value as reported by \fIstty\fP(1) if that
.\"value is non-zero.
.\" todo: LINES variable
.sp
Jeszcze nie zimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je¶li nastawione, wówczas u¿ytkownik zostanie poinformaowany
o nadej¶ciu poczty w ustawionym tam pliku.
Ten parametr zostaje zignorowany, je¶li
zosta³ nastawiony parametr \fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak czêsto otoczka ma sprawdzaæ, czy nadesz³a nowa poczta
w plikach podanych poprzez \fBMAIL\fP lub \fBMAILPATH\fP. 
Je¶li 0, wówczas otoczka sprawdza przed ka¿d± zachêt±.  
Warto¶ci± domy¶ln± jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
lista plików sprawdzanych o pocztê.  Lista ta jest rozdzielana
dwukropkami, ponadto po nazwie ka¿dego z plików mo¿na podaæ
\fB?\fP i wiwdomo¶æ jaka powinna zostaæ wy¶wietlona,
je¶li nadesz³a nowa poczta.  
podstawienia komend parametrów i arytmetyczne zostaj± wykonane na
danej wiadomo¶ci, i podczas postawiania parametr \fB$_\fP
zawiera nazwê tego¿ pliku.
Domy¶lnym zawiadomieniem jest \fByou have mail in $_\fP.
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nienastawiony, je¶li \fBcd\fP nie zmieni³ z powodzeniem
katalogu od czasu odpalenie otoczki, lub je¶li otoczka nie wie gdzie
siê aktualnie obraca.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
podczas u¿ywania \fBgetopts\fP, zawiera argument dla aktulanie
rozpoznawanej opcji, je¶li takowy jest wymagany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostoaniego przetwo¿onego argumentu podczas u¿ywania \fBgetopts\fP.
Przyporz±dkowanie 1 temu parametrowi powoduje, ¿e \fBgetopts\fP
przetwarza arugmenty od pocz±tku, gdy zostanie odpalone nastêpny raz.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem od siebie katalogów, które s± przeszukiwane
podczas odnajdywania jakiej¶ komendy lub plików \fB.\fP.
Puszty ci±g wynikaj±cy z poprzedzaj±cego lub nastêpuj±cego dwukropka,
albo dwuch s±siednich dwukropków jest trakowany jako `.',
czyli katalod bierz±cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Gdy parametr ten zostanie nastawiony, wówczas zostaje w³±czona opcja
\fBposix\fP.
Patrz Tryp POSIX Mode poni¿ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzimego otoczki (tylko wyczyt).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP zachêcacz pierwszego rzêdu dla otoczek interakcyjnych.
Podlega substytucji parametrów, komend i arytmetycznym, oraz
\fB!\fP zostaje zast±pioen numerem kolejnym aktualnej komendy
(patrz komenda \fBfc\fP
poni¿ej).  Sam znak ! mo¿e zostaæ umieszczony w zachêcaczu umieszczajaæ 
!! w PS1.
Zauwa¿, ¿e poniewa¿ edytory wiersza komendy staraj± siê obliczyæ,
jak d³ugi jest zachêcacz, (aby móc ustaliæi, ile miejsca pozostaje do 
parwego brzegu ekranu), sekwencje wyj¶ciowe w zachêcaczu zwykle wprowadzaj± 
ba³agan.
Istnije mo¿liwo¶æ podpowiedzenia otoczce, aby nie uwzglêdnia³a
pewnych ci±gów znaków (takich jak kody wyj¶cia) poprzez podanie
prefiksu na pocz±tku zachêcacza bêd±cego niewy¶wietlywalnym znakiem
(takim jak no control-A) z nastêpstwem prze³amania wiersza, oraz rozgraniczaj±c
nastêpnie kody wyj¶cia przy pomocy tego niewy¶wietlalnego znaku.
Gdy brak niewy¶wietlalnych znaków, wówczas nie ma ¿adnej rady...
Nawiasê mówi±c nie ja jestem odpowiedzialny za ten hack. To pochodzi
z orginalnego ksh.
Domy¶ln± warto¶ci± jest `\fB$\ \fP' dla nieuprzywilejownych
u¿ytkowników, a `\fB#\ \fP' dla root-a..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Durugorzêdny zachêcacz, o domy¶lnej warto¶ci `\fB>\fP ', który
jest stosowany, gdy wymagane s± dalsze wprowadzenia w celu
skompletowania komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zachêcacz stosowany przez wyra¿enie
\fBselect\fP podczas wczytywania wybory z menu.
Domy¶lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, które zostaj± wy¶wietlane podczas
¶ledzenia pracy
(patrz komenda \fBset \-x\fP poni¿ej).
Domy¶lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo¿e byæ nienastawione lub zerowe je¶li
otoczka nie wie gdzie siê znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb przypadkowych. Za ka¿dym razem, gdy
odnosimy siê do \fBRANDOM\fP zostaje jego warto¶ci przyporz±dkowana
nastêpna liczba z przypadkowego ci±gu liczb.
Miejsce w danym ci±gu mo¿e zostaæ ustawione nadaj±c
warto¶æ \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy¶lny parametr dla komendy
\fBread\fP, je¶li nie pozostan± podane jej ¿adne nazwy.
Sotsowany równie¿ we wstêgach \fBselect\fP do zapisu warto¶ci
wczytywanej ze standardowego wej¶cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Sekundy, które up³ynê³y od czasu odpalenia otoczki, lub je¶li
parametrowi zosta³a nadana warto¶æ ca³kowita, ilo¶æ sekund od czasu
nadania tej warto¶ci plus dana warto¶æ.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy nastawiony na pozytywn± warto¶æ ca³kowit±, wiêksz± od zera,
wówczas ustala w interkacyjnej otoczce czas w sekundach, przez jaki
bêdzie ona czeka³a na wprowadzenie po wy¶wietleniu pierwszorzêdnego
zachêcacza (\fBPS1\fP).  Po przekroczeniu tego czasu otoczka zostaje 
opuszczona.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog w którym tymczasowe pliki otoczki zostaj± umieszczone.
Je¶li dany parametr nie zosta³ nastawiony, lub gdy nie zawiera 
pe³nego tropu zapisywalnego katalogy, wówczas domy¶lnie tymczasowe
pliki mieszcz± siê w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je¶li zosta³ nastawiony, ustala tryb edycji wiersza komend w otoczkach
interakcyjnych. Je¶li sotatni cz³onek tropu podanego w danym
parametrze zawierz ci±g znaków \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odopiwednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie Szlaczków"
Roziwaje szlaczków, które ma miejsce równolegle do podstawieñ parametrów,
zostaje wykonane na s³owach rozpoczynaj±cych siê niewycytowanym
\fB~\fP.  Znaki po szlaczku do pierwszego
\fB/\fP, je¶li wystêpuje takowy, s± domy¶lnie traktowane jako
nazwa u¿ytkownika.  Je¶li nazwa u¿ytkownia jest pusta, to \fB+\fP lub \fB\-\fP,
warto¶æ parametrów \fBHOME\fP, \fBPWD\fP, lub \fBOLDPWD\fP zostaje
odpowiednio podstawiona.  W przeciwnym razie zostaje 
przeszukany plik kodów dostêpu w celu odnalezienia danej nazwy
u¿ytkownika, i w miejsce rozwiniêcia szlaczka zostaje
podstawiony katalog domowy danego u¿ytkownika
Je¶li nazwa u¿ytkownika nie zostaje odnalezione w pliku hase³,
lub gdy jakiekolwiek wycytowanie albo podstawienie parametru
wystêpuje  w nazwie u¿ytkownika, wówczas nie zostaje wykonane ¿adne 
podstawienie.
.PP
W nastawieniach parametrów
(tych poprzedzaj±cych proste komendy lub tych wystêpuj±cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie szlaczków zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP), i nazwy u¿ytkowników zostaj± ujête
w dwukropki.
.PP
Katalogi domowe poprzednio rozwinietych nazw u¿ytkowników zostaj±
umieszczone w pamiêci podrêcznej i w ponownym u¿yciu zostaj± stamt±d
pobierane.  Komenda \fBalias \-d\fP mo¿e byæ u¿yta do wylistowania, 
zmiany i dodawnia do tej pamiêci podrêcznej
(\fIw szczególno¶ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie Nawiasów (przemiany)"
Rozwiniêcia nawiasów przyjmuj±ce postaæ
.RS
\fIprefiks\fP\fB{\fP\fIci±g\fP1\fB,\fP...\fB,\fP\fIci±g\fPN\fB}\fP\fIsuffiks\fP
.RE
zostaj± rozwiniête w N wyrazów, z których ka¿dy zawiera konkatenacjê
\fIprefiks\fP, \fIci±g\fPi i  \fIsuffiks\fP
(\fIw szczegóno¶ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwiniête do czterech wyrazów:
ace, abXe, abYe, and ade).
Jak ju¿ wy¿ej wspomniano, rozwiniêci nawiasów mog± byæ nak³adane na siebie
i wynikaj±ce s³owa nie s± sortowane.
Wyra¿enia nawiasowe musz± zawieraæ niewycytowany przecinek
(\fB,\fP) aby nastêpi³o rozwijanie
(\fItak wiêc\fP, \fB{}\fP i \fB{foo}\fP nie zostaj± rozwiniête).
Rozwiniêcie nawiasów nastêpuje po podstawnieniach parametrów i przed
generacj± nazw plików
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce Nazw Plików"
.PP
Wzorcem nazwy pliku jest s³owo zwieraj±ce jeden lub wiêcej z 
niewycytownych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.  
Po wykoaniu rozwiniêci± nawiasów, otoczka zamienia wzorce nazw plików
na uporz±dkowane nazwy plików które pod nadym wzorzec pasuj±
(je¶li ¿adne pliki nie pasuj±, wówczas dane s³owo zostaje pozostawione
bez zmian).  Elemety wzorców posiadaj±nastêpuj±ce znaczenia:
.IP \fB?\fP
obejmuje dowolny pojedyñczy znak.
.IP \fB*\fP
obejmuje dowoln± sekwencjê znaczków.
.IP \fB[\fP..\fB]\fP
obejmuje ka¿dy ze znaczków pomiêczy klamrami.  Zakresy znaczków mog±
zostaæ podane rozczielajac dwa znaczki poprzez \fB\-\fP, \fItzn.\fP,
\fB[a0\-9]\fP objemuje literê \fBa\fP lub dowoln± cyfrê.
Aby przedstawiæ sam znak
\fB\-\fP nale¿y go albo wycytowaæ albo musi byæ to pierwszy lub ostatni znak
w li¶cie znaków.  Podobnie \fB]\fP musi byæ wycytowywane albo pierwszym
lub ostatnim znakiem w li¶cie je¶li ma oznaczaæ samego siebie a nie zakoñczenie
listy.  Równie¿ \fB!\fP wystêpuj±cy na pocz±tmu listy posiada specjalne
znaczenie (patrz poni¿ej), tak wiêc aby reprezentowa³ samego siebie
musi zostaæ wycytowny lub wystêpowaæ dalej w li¶cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko, ¿e obejmuje dowolny znak
nie wystêpuj±cy pomiêdzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka¿dy ci±g zawierajacy zero lub wiêcej wyst±pieñ podanych wzorców.
Przyk³adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci±gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka¿dy ci±g znaków obejumj±cy jedno lub wiêcej wyst±pieñ danych
wzorców.
Przyk³adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci±gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci±g pusty lub ci±g obejmuj±cy jeden z danych wzorców.
Przyk³adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci±gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci±g obejmuj±cy jeden z podanych wzorców.
Przyk³adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy³±cznie ci±gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ciag nie obejmujacy ¿adnego z danych wzorców.
Przyk³adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci±gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje ¿adnego ci±gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci±gi (proszê siê nad tym zastanowiæ).
.PP
Proszê zauwa¿yæ, ¿e wzorce w pdksh obecnie nigdy nie obejmuj± \fB.\fP i
\fB..\fP, w przeciwieñstwie do roginalnej otoczki
ksh, Bourn-a sh i bash-a, tak wiêc to bêdziemusia³o siê ewentualnie 
zmieniæ (na z³e).
.PP
Proszê zauwa¿yæ, ¿e powy¿sze elementy wzorców nigdy nie obejmuj± propki
(\fB.\fP) na pocz±tku nazwy pliku ani pochy³ka (\fB/\fP), 
nawet gdy zosta³y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s± obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je¶li zosta³a nastawiona opcja \fBmarkdirs\fP, wówczas, 
wszelkie katalogi wynikaj±ce z generacji nazw plików
zostaj± oznaczone zakoñczeniowym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znaków (\fItzn.\fP,
\fB[:\fP\fInazwa-klasy\fP\fB:]\fP wewn±trz wyra¿enia typu \fB[\fP..\fB]\fP)
jak narazie nie zosta³y zimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierunkowywanie Wej¶cia/Wyj¶cia"
Podczas wykonywania komendy, jej standardowe wej¶cie, standardowe wyj¶cie
i standardowe wyj¶cie b³êdów (odpowienio deskryptory plików 0, 1 i 2),
zostaj± zwykle dziedziczone po otoczce.
Trzema wyj±taki do tej regó³y s±, komendy w rurociagach, dla których
standardowe lub standardowe wuj¶cie odpowieadaj± tym stalonym przez
rurociag,  komendy asychroniczne stwarzane je¶li kontrola prac zosta³a
wy³aczona, dla których standardowe wej¶cie zostaje ustawnioe na
\fB/dev/null\fP, oraz komendy dla których jedno lub wiele z nastêpuj±cych
przekierunkowañ zosta³o nastawione:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj¶cie zostaje przekierowane do \fIplik\fP-u.  
Je¶li \fIplik\fP nie istnieje, wówczas zostaje stworzony; 
je¶li istnieje i jest to regularny plik oraz zosta³a nastawiona
opcja \fBnoclobber\fP, wówczas wystêpuje b³±d, w przeciwnym razie
dany plik zostaje odciêty do pocz±tku.
Proszê zwróciæ uwagê i¿ oznacza to, ¿e komenda \fIjaka¶ < foo > foo\fP 
otworzy plik \fIfoo\fP do odczytu a naztêpnie
stasuje jego zawarto¶æ gdy otworzy go do zapisu,
zanim \fIjaka¶\fP otrzyma szansê wyczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e zawarto¶æ pliku zostaje skasowana
niezale¿nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e je¶li dany plik ju¿ istnieje
zostaje on rozszerzany zamiast kasowania poprzedniej jego zawaro¶ci.  
Ponad to plik ten zostaje otwarty w trybie rozszerzania, tak wiêc
wszelkiego rodzaju operacje zapisu na nim dotycz± jego aktualnego koñca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej¶cie zostaje przekierunkowane na \fIplik\fP, 
który zostaje otorzony do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko ¿e plik zostaje otworzony w trybie
wpisu i czytanie.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj±cego tego rodzaju przekierunkowanie
(zwane tu-dokumentem), otoczka kopiuje wiersze z komendy
do tymczasowego pliku a¿ po natrafienie na wiersz
odpowiadaj±cy \fIznacznik\fPowi.
podczas wykonywania komendy standardowe wej¶cie zostaje przekierunkowane
na dany plik tymczasowy.
Je¶li \fIznacznik\fP nie zawiera wycytowanych znaków, zawarto¶æ danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera³a siê w 
podwujnych cudzys³owach za, ka¿dym razem gdy dana komenda zostaje wykonana.
Tak wiêc zostaj± na nim wykonane podstawienia parametrów,
komend i arytmetyczne wraz z interpretacj± wstecznego pochylnika 
(\fB\e\fP) i znaków wyj¶æ dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enewline\fP.
Je¶li wiele tu-dokumentów zostaje zastosowanych w jednym i tymsamym
wierszy komendy, wówczas zostaj± one zachowane w podanej kolejno¶ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko ¿e pocz±tkowe tabulatory
zostaj± usuniête w tu-dokumencie.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej¶cie zostaje powielone  z deskryptora pliku \fIfd\fP.
\fIfd\fP mo¿e byæ pojedyñcz± cyfr±, wskazuj±c± na number
istniej±cego deskryptora pliku, literk±  \fBp\fP, wskazujac± na plik
powi±zany w wyj¶ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj±cym, ¿e standardowe wej¶cie powinno zostaæ
zamkniête.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko ¿e operacja dotyczy standardowego wyj¶cia.
.PP
W ka¿dym z powy¿szych przekierunkowañ, mo¿e zostaæ podany jawnie deskryptor
pliku, którego ma ono dotyczyæ, (\fItzn.\fP, standardowego wej¶cia
lub standard wyj¶cia) poprzez poprzedzaj±c± odpowiedni± pojedyñcz± cyfrê.
podstawienia paramertór komend, arytmetyczne, szlaczków tak jak i
(gdy otoczka jest interakcyjna) generacje nazw plików wszystkie 
zostaj± wykonane na argumentach przekierowañ \fIplik\fP, \fInacznik\fP 
i \fIfd\fP.
Proszê jednak zwróciæ uwagê, i¿ wyniki wszelkiego rodzaju przekierunkowañ 
plików zostaj± jedynie u¿yte je¶li zawieraj± jedynie nazwê jednego pliku;
je¶li natomiast obejmuj± one wiele plików, wówczas zostaje zastosowane
dane s³owo bez rozwiniêc wynikaj±cych z generacji nazw plików.
proszê zwróciæ uwagê, i¿ w otoczkach ograniczonych, 
przekierunkowania tworz±ce nowe pliki nie mog± byæ stosowane.
.PP
Dla prostych komend, przekierunkowania mog± wystêpowaæ w dowolnym miejscu
komendy, w komendach z³o¿onych (wyra¿eniach \fBif\fP, \fIitp.\fP), 
wszelkie przekierunkowani musz± znajdowaæ siê na koñcu.
Przekierunkowania s± przetwarzane po tworzeniu ruroci±gów i w kolejno¶ci
w której zosta³y podane, tak wiêc
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy¶wietli b³±d z numerem lini wiersza poprzedzaj±cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra¿enia Arytmetyczne"
Ca³kowite wyra¿enia arytmetyczne mog± byæ stosowane przy pomocy
komendy \fBlet\fP, wewn±trz wyra¿eñ \fB$((\fP..\fB))\fP,
wewn±trz dereferencji ³añcuchów (\fIw szczególno¶ci\fP, 
\fInzwa\fP\fB[\fP\fIwyra¿enie\fP\fB]\fP),
jako numerbyczne argumenty komendy \fBtest\fP,
i jako warto¶ci w przyporz±dkowywaniach do ca³kowitych parametrów.
.PP
Wyra¿enia mog± zawieraæ alfa-numeryczne identyfikatory parametrów,
dereferencje ³añcuchów i ca³kowite sta³e. Mog± zostaæ równie¿
po³±czone nastêpuj±cymi operatorami jêzyka C:
(wymienione i ugrupowane z kolejno¶ci odpowiadaj±cej zwiêkszonej
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
\fB?:\fP (precedencja jest bezpo¶redino wy¿sza od przyporz±dkowania)
.TP
Operatory grupuj±ce:
\fB( )\fP
.PP
Sta³e ca³kowite mog± zostaæ podane w dowolnej bazie, stosuj±c notacjê
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesiêtn± liczb±
ca³kowit± specyfikuj±c± bazê, a \fIliczba\fP jest liczb±
zapisan± w danej bazie.
.LP
Operatory zostaj± wyliczane w nastepuj±cy sposób:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy³±cznie dla pe³no¶ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je¶li argument jest zerowy, a 0 je¶li nie.
.IP "\fB~\fP"
arithmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi byæ zastosowanym do parametru (a nie litera³u lub
innego wyra¿enia) - parametr zostaje powiêkszony o 1.
Je¶li zosta³ zastosowany jako operator prefiksowy, wówczas wynikiem jest 
inkrementowana warto¶æ parametru, a je¶li zosta³ zastosowany jako
operator postfiksowy, to wynikiem jest pierwotna warto¶æ parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko, ¿e wynikiem jest dekrement parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra¿enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nastêpnie prawa strona. Wynikiem jest warto¶æ
wyra¿enia po prawej stronie.
.IP "\fB=\fP"
przyporz±dkowanie; zmiennej po lewej zostaje nadana warto¶æ po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatoray przyporz±dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP 
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je¶il przynajmniej jeden 
z argumentów jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je¶li obydwa argumenty s± niezerowe, 
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewey jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkacja (bit-w-bit).
.IP "\fB==\fP"
równo¶æ; wynikiem jest 1, je¶li obydwa argumenty s± sobie równe, 0 gdy nie.
.IP "\fB!=\fP"
nierówno¶c; wynikiem jest 0, je¶li obydwa arguemnty s± sobie równe, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je¶li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub równe, wieksze lub równe, wiêksze od.  Patrz <.
.IP "\fB<< >>\fP"
przesuñ w lewo (prawo); wynikiem jst lewy argument z bitami przesuniêtymi
na lewo (prawo) o ilo¶æ pól podan± w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, ró¿nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego arguemntu prze prawy.  
Znak wyniku jest nieustalony, je¶li jeden z argumentów jest negatywny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je¶li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to ruroci±g stworzony poprzez operator \fB|&\fP,
który jest asynchronicznym proecsem do którego otoczka mo¿e 
zrówno pisaæ (u¿ywaj±c \fBprint \-p\fP) i czytaæ (u¿ywaj±c \fBread \-p\fP).
Wej¶cie i wyj¶cie koprocesu mog± byæ ponadto manipulowane
przy pomocy przekietowañ \fB>&p\fP i odpowiednio \fB<&p\fP.
Po odpaleniu koprocesu, nastêpne nie mog± byæ odpalane zanim
dany koproces zakoñczy pracê, lub zanim wej¶cie kopocesu
nie zosta³o przekierowane poprzez \fBexec \fP\fIn\fP\fB>&p\fP.
Je¶li wej¶cie koprocesu zostaje przekierowane w ten sposób,
wówczas nastêpny w kolejce do odpalenia koproces bêdzie
wspóldzieli³ wyj¶cie z pierwszym koprocesem, chyba ¿e wyj¶cie pierwszego
koprocesu zosta³o przekierowane przy pomocy
\fBexec \fP\fIn\fP\fB<&p\fP.
.PP
Pewne uwagi dotycz±ce koprocesów:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
jedyn± mo¿liwo¶ci± zamkniêcia wej¶cia koprocesu
(tak aby koproces wczyta³ zakoñczenie pliku) jest przekierowanie
wej¶cia na numerowany deskryptor pliku, a nastêpnie zamkniêcie tego
deskryptora (\fIw szczególno¶ci\fP, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby kopreocesy móg³y wspó³dzieliæ jedno wyj¶cie, otoczka musi
zachowaæ otwart± czê¶ci wpisow± danego ruroci±gu wyj¶ciowego.
Oznacza to, ¿e zakoñczenie pliku nie zostanie wykryte do czasu a¿
wszystkie koprocesy wspó³dziel±ce wyj¶cie koprocesów zostan± zakoñczone
(gdy zostan± one zakoñczone, wówczas  otoczka zamyka swoj± kopiê
ruroci±gu).
Mo¿na temu zapobiec przekierunkowuj±ca wyj¶cie na numerowany
deskryptor pliku
(poniewa¿ powoduje to równie¿ zamkniêcie przez otoczkê swojej kopi).
Proszê zwróciæ uwagê i¿ to zachowaniê siê jest nieco odmienne od orginalnej
otoczki Korn-a, która zamyka swoj± cz±¶æ zapisow± swojej kopi wyj¶cia
koprocesu, gdy ostatnio odpalony koproces 
(zamiast gdy wszystkie wspó³dziel±ce koprocesy) zostanie zakoñczony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna³u SIGPIPE poczas zapisu, je¶li
dany sygna³ nie zosta³ od³apany lub zignorowany; nie zachodzi to jednak
, gdy wej¶cie koprocesu zosta³o powielone na inny deskryptor pliku
i sotsowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje siê albo przy pomocy syntaktyki otoczki
Korn-a \fBfunction\fP \fIname\fP,
albo syntaktyki otoczki Bourn-a/POSIX-owej \fIname\fP\fB()\fP
(patrz poni¿ej co do ró¿nic zachodz±cych pomiêdzy tymi dwoma formami).
Funkcje, tak jak i \fB.\fP-skrypty, zostaj± wykonywane w bierz±cym
otoczeniu, aczkolwiek, w przeciwieñstwie do \fB.\fP-skryptów,
argumenty otoczki
(\fItzn.\fP, argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) niegdy nie s±
widoczne wewn±trz nich.
Podczas ustalania lokacji komendy funkcje s± przeszukiwane po przeszukani
specjalnych wbydowanych komend i przed regularnymi oraz nieregularnymi
komendami wbudowanymi, a zanim \fBPATH\fP zostanie przeszukany.
.PP
Istniej±ca funkcja mo¿e zostaæ usuniêta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
Listê funkcji mo¿na otrzymaæ poprzez \fBtypeset +f\fP, a definicje
funkcji mo¿na otrzymaæ poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo¿e zostaæ
u¿yte do tworzenia niezdefiniowanych funkcji;
je¶li ma byæ wykonana niezdefiniowana funkcja, wówczas otoczka
przeszukuje trop podany w parametrze \fBFPATH\fP za plikiem o nazwie
identycznej do nazwy danej funkcji, który, gdy zostanie odnaleziony 
takowy, zostaje wczytany i wykonany.
Je¶li po wykonaniu tego pliku dana funkcja bêdzie zdefiniowany, wówczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk³e
odnajdywanie komend
(\fItzn.\fP, otoczka przeszukuje tablicê zwyk³ych komend wbudowanych
i \fBPATH\fP).
Proszê zwróciæ uwagê, ¿e je¶li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, wówczas zostaje podjêta próba odnalezienia
funkcji poprzez \fBFPATH\fP (jest to niezdokumentowanym zachowaniem
siê orginalnej otoczki Korn-a).
.PP
Funkcje mog± mieæ dwa atrybuty ¶ledzenia i eksportowania, które
mog± byæ ustwaieane przez \fBtypeset \-ft\fP i odpowiednio 
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji ¶ledzonej, opcja \fBxtrace\fP otoczki
zostaje w³±czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy³±czona.
Atrybut exportowania nie jest obecnie u¿ywany.  W orginalnej
otoczce Korn-a, wyexportowane funkcje s± widoczne dla skrytów otoczki,
gdy s± one wykonywane.
.PP
Poniewa¿ funckje zostaj± wykonywane w obecnym konketscie otoczki,
przyporz±dkowania parametrów wykonane wewn±trz funkcji pozostaj±
widoczne po zakoñczeniu danej funkcji.
Je¶li jest to nieporz±dane, wówczas komenda \fBtypeset\fP mo¿e
byæ zastosowana wewn±trz funkcji do tworzenia lokalnych parametrów.
Proszê zwrócic uwagê i¿ specjale parametry
(\fItzn.\fP, \fB$$\fP, \fB$!\fP) nie mog± zostaæ ograniczone w 
ich widoczno¶ci w ten sposób.
.PP
Statusem zakoñczeniownym kuncji jest status ostatniej
wykonanej w niej komendy.
Funkcjê mo¿na przerwaæ bezpo¶redino przy pomocy komendy \fBreturn\fP;
mo¿na to równie¿ zastosowaæ do jawnej specyfikacji statusu zakoñczenia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s³owa \fBfunction\fP, s±
traktowane odmiennie w nastêpuj±cych punktach od funkcji zdefiniowanych
poprzez notacjê \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje nastawiony na nazwê funkcji
(funkcje w stylu Bourne-a nie tykaj± \fB$0\fP).
.IP \ \ \(bu
przyporz±dkowania warto¶ci parametrom poprzedzaj±ce wywo³anie
funkcji nie zostaj± zaczowane w bierz±cym kontekscie otoczki
(wykonywanie funkcji w stylu Bourne-a functions zachowuje te
przyporz±dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostake zachowany i skasowany 
na pocz±tku oraz nastêpnie odtworzony na zakoñczenie funkcji, tak wiêc
\fBgetopts\fP mo¿e byæ poprawnie stosowane zarówno wewn±trz jak i poza
funkcjami
(funkcje w stylu Bourne-a nie tykaj± \fBOPTIND\fP, tak wiêc
stosowanie \fBgetopts\fP wewn±trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.nr PD \n(P2
W przysz³o¶ci nastêpuj±ce ró¿nice zostan± równie¿ dodane:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Oddzielny kontekst ¶ledznia/sygna³ów bêdzie stosowany podczas sykonywania
funkcji.
Tak wiêc ¶ledzenia nastawione wewn±trz funkcji nie bêd± mia³y wp³ywu 
na ¶ledzenia i sygna³y otoczki nie ignorowane przez ni± (które mog±
byæ przechwytywane) bêd± mia³y domy¶lne ich znaczenie wewn±trz funkcji.
.IP \ \ \(bu
¦ledzenie EXIT-a, je¶li zostanie nastawione wewn±trz funkcji, 
zostanie wykonane, po zakoñczeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana otoczka ma byæ w zasadzie zgodna ze standardem POSIX, 
aczkolwiej jednak, w niektórych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem orginalnej
otocznik Korn-a albo wygod± u¿ytkownika.
Jak otoczka zachowuje siê w takich wypadkach jest ustalane poprzez
status opcji posix (\fBset \-o posix\fP) \(em je¶li jest ona
w³±czona wówczas zachowuje siê zgodnie z POSIX-em, a w przeciwnym 
razie nie.
Opcja \fBposix\fP zostaje automatycznie nastawiona je¶li otoczka startuje
w otoczeniu zawieraj±cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Otoczkê mo¿na równie¿ skompilowaæ tak aby zachowanie zgodne z
POSIX-em by³o domy¶lnie ustawione, aczkolwiek jest to zwykle 
nieporz±dane).
.PP
A oto lista wp³ywów ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn±trz wycytowanych podwójnymi cuczys³owami \fB`\fP..\fB`\fP 
podstwieñ komend:
w trybie posix-owym, the \fB\e"\fP zostaje zinterpretowane podczas interpretacji
komendy;
w trybie nie posix-ownym, pochy³ek w lewo zostaje usuniety przed
interpretacj± podstawienia komendy. 
Przyk³adowo \fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie posix-owym, `hi' a w trybie nie-posix-owym.  
W celu unikniêcia problemów proszê stosowaæ postaæ \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
\fBkill \-l\fP wyj¶cie: w trybie posix-owym, nazwy sygna³ow
zostaj± wymieniane wiersz po wierszu;
w nie-posix-owym trybie, numery sygna³ów ich nazwy i opis zostaj± wymienione
w kolumnach.
W przysz³o¶ci nowa opcja zostanie dodana (pewnie \fB\-v\fP) w celu
rozró¿nienia tych dwóch zachowañ.
.IP \ \ \(bu
\fBfg\fP status zakoñczenia: w trybie posix-owym, status zakoñczenia wynosi
0, je¶li nie wyst±pi³y ¿adne b³êdy;
w trybie nie-posix-owym, status zakoñczeniowy odpowiada statusowi
ostatniego zadania wykonywanego w pierwszym planie.
.IP \ \ \(bu
\fBgetopts\fP: w trybie posix-owym, optcje musz± zaczynaæ siê od \fB\-\fP;
w trybie nie-posix-owym, opcje mog± siê zaczynaæ od albo \fB\-\fP albo \fB+\fP.
.IP \ \ \(bu
rozwijanie nawiasów (zwane równie¿ przemian±): w trybie posix opwym, 
rozwijanie nawiasów jest wy³±czoen; w trybie nie-posix-owym, 
rozwijanie nawiasów jest w³±czone.
Proszê zauwa¿yæ, ¿e \fBset \-o posix\fP (lub nastawienie 
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy³±cza opcjê \fBbraceexpand\fP, mo¿e ona byæ jednak jawnie
w³±czona pu¼niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie posix-owym, nie wy³±cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-posix-owym, wy³±cza.
.IP \ \ \(bu
\fBset\fP status zakoñczenia: w trybie posix-owym, 
status zakoñczenia wynosi 0, je¶li nie wyst±pi³y ¿adne b³êdy; 
w trybie nie-posix-owym, status zakoñczeniowy odpowiada statusie
wszelkich podstawieb komend wykonywanych podczas
generacji komendy set.
Przyk³adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie posix,
a 1 w tybie nie-posix.  Ten konstrukt jest stosowany w wiêkszo¶ci
skrytpów otoczji stosujacych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argumentów dla komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP, i
\fBtypeset\fP: w trybie posix-owym, nastêpuje normalme rozwijanie argumentów;
w trybie nie-posix-owym, rozdzielanie pól, rozszerzanie plików, 
rozwijanie nawiasów i (zwyk³e) rozwijanie szlaczków s± wy³±czone, oraz
rozwijanie szlaczków w przyporz±dkowania pozostaje w³±czone.
.IP \ \ \(bu
specyfikacja sygna³ów: w trybie posix-owym, signa³y mog± byæ
podawane jedynie cyframi, je¶li numery sygna³ów s± one zgodne z 
warto¶ciami z POSIX-a (\fItzn.\fP, HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14, and TERM=15); w trybie nie-posix-owym, 
sygna³u mog± zawsze cyframi.
.IP \ \ \(bu
rozwijanie aliasów: w trybie posix-owym, rozwijanie aliasów
zostaje jedynie wykonywane, podczas wczytywania s³ów komend; w trybie 
nie-posix-owym, rozwijanie aliasów zostaje wykonane równie¿ na
ka¿dym s³owie po jakim¶ aliasie, które koñczy siê bia³± przerw±.
Przyk³adowo w nastêpuj±ca wstêga for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u¿ywa parameteru \fBi\fP w tybie posix-owym, natomiast \fBj\fP w
trybie nie-posix-owym.
.IP \ \ \(bu
test: w trybie posix-owym, wyra¿enia "\fB-t\fP" (poprzedzone pewn±
ilo¶ci± argumentów "\fB!\fP") zawsze jest prawdziwe, gdy¿ jest
ci±giem o d³ugo¶ci niezerowej; w nie-posix-owym trybie, sprawdza czy
descryptor pliku 1 jest jakim¶ tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo¿e zostaæ pominiêty i jest
domy¶lnie równy 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie Komend"
Po wyliczeniu argumentów wiersza komnedy, wykonaniu przekierunkowañ
i przyporz±dkowañ parametrów, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku który nale¿y wykonaæ przy pomocy parametru
\fBPATH\fP.
Testy te zostaj± wykonane w wy¿ej podanym porz±dku.
Specjalne wbudowane komendy ró¿ni± siê tym od innych komend, 
¿e pramert \fBPATH\fP nie jest u¿ywany do ich odnalezienie, b³±d
podczas ich wykonywania mo¿e spowodowaæ zakoñczenie nieinterakcyjnej
otocz i przyporz±dkowania wartosci parametrów poprzedzaj±ce
komendê zostaj± zachowane po jej wykonaniu.
Aby tylko wprowadziæ zamieszanie, je¶li opcja
posix zosta³a w³±czona (patrz komenda \fBset\fP
poni¿ej) pewne specjale komendy staj± siê bardzo specjalne, gdy¿
nie wykonywane s± rozdzielanie pól, rozwijanie nazw plików,
rozwijanie nawiasów ani rozwijanie szlaczków na argumentach, 
które wygl±daj± jak przyporz±dkowania.
Zwyk³e wbudowane komendy wyró¿niaj±siê jedynie tym,¿e
parametr \fBPATH\fP nie jest stosowany do ich odnalezienia.
.PP
Orignalny ksh i POSIX ró¿ni± siê nieco w tym jakie
komendy s± traktowane jako specjalne a jakie jako zwyk³e:
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
W przysz³o¶ci dodatkowe specjalne komendy ksh oraz regularne komendy
mog± byæ traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz±dkowania warto¶ci parametrów
zostaj± wykonane i wyeksportowane na czas trwania komendy.
.PP
W nastêpuj±cym opisujemy specjalne i regularne komendy wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wyknoaj komendy w \fIplik\fP w bierz±dym otoczeniu.
Plik zostaje odszukiwany przy u¿yciu katalogów z \fBPATH\fP.
Je¶li zosta³y podane argumenty, wówczas parametry pozycyjne mog± byæ
u¿ywane do dostêpu do nich podczas wykonywania \fIplik\fP-u.
Je¶li nie zosta³y podane ¿adne argumenty, wówczas argumenty pozycyjne
odpowiadaja tym z bierz±cego otoczenia, w którym dana komenda zosta³a
u¿yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Statusem zakoñczenia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto¶æ1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
bez argumentów, \fBalias\fP wylicza wszystkie obecne aliasy.
Dla ka¿dej nazwy bez podanej warto¶ci zostaje wliczony istniej±cy
odpowiedni alias.
Ka¿da nazwa z podan± warto¶ci± definiuje alias (patrz aliasy Aliases powy¿ej).
.sp
podczas wyliczania aliasów mo¿na u¿yæ jednego z dwuch formatów: 
zwykle aliasy s± wyliczane jako \fInazwa\fP\fB=\fP\fIwarto¶æ\fP, przy czym
\fIwarto¶æ\fP jest wycytowana; je¶li opcje mia³y przedsionek \fB+\fP 
lub same \fB+\fP zosta³o podane we wierszu komendy, tyko \fInazwa\fP
zostaje wy¶wietlona.
Ponad to, je¶li zosta³a zstosowana opcja \fB\-p\fP, ka¿dy wiersz zostaje
zaczêty dodtakowo od ci±gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP nastawia, (a \fB+x\fP kasuje) atrybut eksportu dla aliasa,
lub, je¶li nie podano ¿adnych nazw, wylicza aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma posiada ¿adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, ¿e ¶ledzone aliasy maj± byæ wyliczone ustawione
(warto¶ci podane we wierszu komendy zostaj± zignorowane dla ¶ledzonych
aliasów).
Opcja \fB\-r\fP wskazuje, ¿e wszystkie ¶ledzone aliasy
maj± zostaæ usuniête.
.sp
Opcja \fB\-d\fP nakazuje wyliczenie lub ustawienie aliasów katalogów, 
które s± stosowane w rozwiniêcziach szlaczków
(patrz Rozwiniêcia Szlaczków powy¿ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je¶li nie podana ¿adnego zadaniam wówczas przyjmuje siê domy¶lnie \fB%+\fP.
Ta komenda jest jeynie dostêpna na systemach wspomagaj±cych kontrolê zadañ.
Patrz Kontrola Zadañ poni¿ej co do dalszych informacji.
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Nastawienie lub wyliczenie obecnych przyporz±dkowañ klwaiszy/mark w 
emacs-owym trybie edycji komend.
Patrz Emacs-owa Interakcyjna Edycja Wiersza Komendy w celu pe³nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fPth zagnie¿d¿enia we wstêgach
for, select, until, lub while.
\fIpoziom\fP wynosi domy¶lnie 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan± komendê \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.  
Je¶li zosta³ nastawiony parameter \fBCDPATH\fP, to wypisuje
listê katalogów, w których nale¿y szukaæ pod-\fIkatalog\fP.
Pusta zawarto¶æ w \fBCDPATH\fP oznacza katalog bie¿±cy.
Je¶li niepusty katalog z \fBCDPATH\fP zostanie zastosowany,
wówczas zostanie wy¶wietlony pe³ny wynikaj±cy trop na standardowym
wyj¶ciu.
Je¶li nie podano \fIkatalog\fP, wówczas
zostaje u¿yty katalog domowy \fB$HOME\fP.  Je¶li \fIkatalog\fP-iem jest
\fB\-\fP, to porzedni katalog roboczy zostaje zastosowany (patrz
parametr OLDPWD).
Je¶li u¿yto opcji \fB\-L\fP (logiczny trop) lub je¶li opcja \fBphysical\fP
nie zosta³a nastawiona
(patrz komenda \fBset\fP poni¿ej), wówczas odniesienia do \fB..\fP w 
\fIkatalogu\fP s± wzglêdnymi wobec tropu zastosowanego do doj¶ci± do danego
katalogu.
Je¶li podano opcjê \fB\-P\fP (fizyczny trop) lub gdy zosta³a nastawiona
opcja \fBphysical\fP, wówczas \fB..\fP jest wzglêdne wobec drzewa katalogów 
systemu plików.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj± uaktualnione taki, aby odpowiednio
zawiera³y bie¿±cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci±g \fInowy\fP zostaje podstawiony wzamian za \fIstary\fP w bie¿±cym
katalogu, i otoczka próbuje przej¶æ do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je¶li nie zosta³a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, wówczas
\fIkomenda\fP
zostaje wykonana dok³adnie tak jakby nie podano \fBcommand\fP,
z dwoma wyj±takami: po pierwsze, \fIkomenda\fP nie mo¿e byæ funkcj± w otoczce,
oraz po drugie, specjalne wbudowane komendy trac± swoj± specjalno¶æ (\fItzn.\fP,
przekierowania i b³êdy w u¿yciu nie powoduj±, ¿e otoczka zostaje zakoñczona, a
przyporz±dkowania parametrów nie zostaj± wykonane).
Je¶li podano opcjê \fB\-p\fP, zostaje stosowany pewien domy¶lny trop
zamiast obecnej warto¶ci \fBPATH\fP (warto¶æ domy¶lna tropu jest zale¿na
od systemy w jakim pracujemy: w systemach POSIX-owatych, jest to
warto¶æ zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je¶li podano opcjê \fB\-v\fP, wówczas zamiast wykonania \fIkomenda\fP, 
zostaje podana informacja co by zosta³o wykonane (i to same dotyczny 
równia¿ \fIarg1\fP ...):
dla specjalnych i zwyklych wbudowanych komend i funkcji,
zostaj± po prostu wy¶wietlone ich nazwy,
dla aliasów, zostaje wy¶wietlona komenda definiuj±ca dany alias,
oraz dla komend odnajdownych poprzez przeszukiwanie zawarto¶ci
parametru \fBPATH\fP, zostaje wy¶wietlony pe³ny trop danej komendy.
Je¶li komenda nie zostanie odnaleziona, (\fItzn.\fP, przeszukiwanie tropu
nie powiedzie siê), nic nie zostaje wy¶wietlone i \fBcommand\fP zostaje
zakoñczone z niezerowym statusem.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko ¿e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP stacze na pocz±tek \fIpoziom\fP-u z najg³êbiej
zagnie¿d¿onej wstêgi for,
select, until, lub while.
\fIlevel\fP domy¶lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy¶wietla na standardowym wyj¶ciu swoje argumenty (rozdzielone przerwami)
zakoñczone prze³amaniem wiersza.
Prze³amanie wiersza nie nastêpuje je¶li którykolwiek z parametrów
zawiera sekwencjê pochy³ka wstecznego \fB\ec\fP.
Patrz komenda \fBprint\fP poni¿ej, co do listy innych rozpoznawanych
sekwencji pochy³ków wstecznych.
.sp
Nastêpuj±ce opcje zosta³y dodane dla zachowania zgodno¶ci ze
skryptami z systemów BSD:
\fB\-n\fP wy³±cza koñcowe prze³amanie wiersza, \fB\-e\fP w³±cza
interpretacjê pochy³ków wstecznych (operacja zerowa, albowiem ma to
domy¶lnie miejsce), oraz \fB\-E\fP wy³±czaj±ce interpretacjê
pochy³ków wstecznych.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Zrgumenty zostaj± powi±zane (z przerwami pomiêdzy nimi) do jednego
ci±gu, który nastêpnie otoczka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez forkowania, zastêpuj±c proces otoczki.
.sp
Je¶li nie podano ¿adnych argumentów wszelkie przekierowania wej¶cia/wyj¶cia
s± dozwolone i otocznia nie zostaje zast±piona.
Wszelkie deskryptory plików wiêksze ni¿ 2 otwarte lub z\fIdup\fP(2)-owane
w ten sopsób nie s± dostêpne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbydownych w otoczkê).
Proszê zwróciæ uwagê i¿ otoczka Bourne-a ró¿ni siê w tym: 
przekazuje bowiem deskryptory plików.
.\"}}}
.\"{{{  exit [status]
.IP "\fBexit\fP [\fIstatus\fP]"
Otoczka zostaje zakoñczona z podanym statusem.
Je¶li \fIstatus\fP nie zosta³ podany, wówczas status zakoñczenia
przyjmuje bie¿±c± warto¶æ parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Nastawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj± przekazywane w otoczeniu do wykonywanych
komend.
Je¶il podano warto¶ci wówczas zostaj± one równia¿ przyporz±dkowany
danym parametrom.
.sp
Je¶li nie podano ¿adnych parametró, wówczas nazwy wszystkich parametrów
z atrybutem eksportu zostaj± wy¶wietlone wiersz po wierszu, chyba ¿e u¿yto
opcji \fB\-p\fP, w którym to wypadu zostaj± wy¶wietlone komendy
\fBexport\fP definiuj±ce wszystkie eksportowane parametry wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda koñcz±ca siê z niezerowym statusem.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj± komendy z histori.
Komendy mo¿emy wybieraæ przy pomocy ich numeru w historji
lub podaj±c ci±g znaków okre¶laj±cy ostatnio u¿yt± komendê rozpoczynaj±c±
siê od tego¿ ci±gu.
Opcja \fB\-l\fP wy¶wietla dan± komendê na stdout,
a \fB\-n\fP wy³±cza domy¶lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno¶æ koemnd w li¶cie historji.  Bez \fB\-l\fP, wybrane
komendy podlegaj± edycji przez edytor podany poprzez opcjê
\fB\-e\fP, albo je¶lki nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je¶li nie zosta³ nastawiony ten
parametr, wówczas sotsuje siê \fB/bin/ed\fP),
i nastêpnie wykonana przez otoczkê.
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran± konendê (domy¶lnie poprzedni± komendê) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je¶li
podano \fB\-g\fP, wówczas wszelkie wysotmpienia \fIstare\fP zostaj±
zastêpione przez \fInowe\fP.  Z tej komendy ko¿ysta siê zwykle
przy pomocy zdefiniowanego domy¶lnie aliasa \fBr='fc \-e \-'\fP.
.\"}}}
.\"{{{  fg [job ...]
.IP "\fBfg\fP [\fIzadanie\fP ...]"
Przywróæ na pierwszy plan zadanie(-nia).
Je¶li nie podano jawnie ¿adnego zadania, wówczas odnosi siê to
domy¶lnie do \fB%+\fP.
Ta komenda jest jedynie dostêpna na systemach wspomagaj±cych
kontrolê zadañ.
Patrz Kontrola Zadañ dla dalszych informacji.
.\"}}}
.\"{{{  getopts optstring name [arg ...]
.IP "\fBgetopts\fP \fIci±gopt\fP \fInazwa\fP [\fIarg\fP ...]"
\fBgetopts\fP jest stosowany przez procedury otoczki
do rozeznawania podanych argumentów
(lub parametrów pozycyjnychi, je¶li nie podano ¿adnych argumentów)
i do sprawdzenia zasadno¶ci opcji.
\fIci±gopt\fP zawiera litery opcji, które 
\fBgetopts\fP ma rozpoznawaæ.  Je¶li po literze wystêpuje przecinek,
wówczas oczekuje siê, ¿e opcja posiada argument.
Opcje nieposiadaj±ce argumentów mog± byæ grupowane w jeden argument.
Je¶li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w którym siê znajduje, wówczas reszta argumentu 
zsotaje potraktowana jako argument danej opcji. W przeciwnym razie
nastêpny argument jest argumentem opcji.
.sp
Za ka¿dym razem, gdy zostaje wywo³ane \fBgetopts\fP, 
umieszcza siê nastêpn± opcjê w parametrze otoczki
\fInazwa\fP i indeks nastêpnego argumentu pod obróbkê
w parmaetrze otoczki \fBOPTIND\fP.
Je¶li opcja zosta³a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z prefiksem \fB+\fP.
Je¶li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze otoczki \fBOPTARG\fP.
Je¶li natrafi siê na niedopuszczaln± opcjê lub brakuje
argumentu opcji, wówczas znak zapytania albo dwukropek zostaje
umieszczony w \fInazwa\fP
(wskazuj±c na nielegaln± opcjê, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje nastawiony na znak który by³ przyczyn± tego problemu.
Ponadto zostaje wówczas wy¶wietlony komunikat o b³êdzie na standardowym
wyj¶ciu b³êdów, je¶li \fIci±gopt\fP nie zaczyna siê od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa pracê
niezerowym statusem zakoñczenia.
Opcje koñcz± siê na pierwszym (nie podlegaj±cym opcji) argumencie,
który nie rozpoczyna siê od \-, albo je¶li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawania opcji mo¿e zostaæ ponowione ustawiaj±c \fBOPTIND\fP na 1
(co nastêpuje automatycznie za ka¿dym razem, gdy otoczka lub 
funkcja w otoczce zostaje wywo³ana).
.sp
Ostrze¿enie: Zmiana warto¶ci parametru otoczki \fBOPTIND\fP na
warto¶æ wiêksz± ni¿ 1, lub rozpoznawanie odmiennych zestawów
parametrów bez ponowienia \fBOPTIND\fP mo¿e doprowadziæ do nieoczekiwanych
wyników.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je¶li brak argumentów, wówczas wszelkie tropy wykonywalnych komend z
kluczem zostaj± wymienione.
Opcja \fB\-r\fP nakazuje wy¿ucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka¿da \fInazwa\fP zostaje odszukiwana tak jak by to by³a nazwa komedy
i dodna do tablicy kluczy je¶li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy¶wietlij informacje o danych zadaniach; gdy nie podano ¿adnych
zadañ wszystkie zadania zostaj± wy¶wietlone.
Je¶li podano opcjê \fB\-n\fP, wówczas informacje zostaj± wy¶wietlone
jedynie o zadaniach których stan zmieni³ siê od czasu ostaniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka¿dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, ¿e zostaje wy¶wietlona jedynie
jedynie grupa procesowa kadego zadania.
patrz Kontrola Zadañ dla informacji o formie parametru
\fIzdanie\fP i formacie w którym zostaj± wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy¶lij dany sygna³ do doanych zadañ, procesów z danym id-em, lub grup
procesów.
Je¶li nie podano jawnie ¿adnego sygna³u, wówczas domy¶lnie zostaje wys³any
sygna³ TERM.
Je¶li podano zadanie, wówczas sygna³ zostaje wys³any do grupy 
procesów danego zadnia.
Patrz poni¿ej Kontrola Zadab dla informacji o formacie \fIzadania\fP.
.\"}}}
.\"{{{  kill -l [exit-status ...]
.IP "\fBkill \-l\fP [\fIstatus-zakoñczenia\fP ...]"
Wypisz nazwê sygna³u, który zabi³ procesy, które zakoñczy³y siê
danym \fIstatusem-zakoñczenia\fP.
Je¶li brak argumentów, wówczas zostaje wy¶wietlona lista
wszelkich sygna³ów i ich numerów, wraz z krótkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra¿enie\fP ...]"
Ka¿de wyra¿enie zostaje wyliczone, patrz Wyra¿enie Arytmetyczne powy¿ej.
Je¶li wszelkie wyra¿enia zosta³y poprawnie wyliczone,statusem zakoñczenia
jest 0 (1), je¶li warto¶ci± ostatniego wyra¿enia
 nie by³o zero (zero).
Je¶li wyst±pi b³±d podczas rozpoznawania lub wyliczania wyra¿enia,
status zakoñczenia jest wiêkszy od 1.
Poniewa¿ m¿e zaj¶æ konieczno¶æ wycytowania wyra¿eñ, wiêc
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s³odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy¶wietla swe argumenty na standardowym wyj¶ciu, rozdzielone
przerwami i zakoñczone prze³amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy¶lnemu prze³amaniu wiersza. 
Domy¶lnie pewne wyprowadzenia z C zostaj± odpowiednio przet³umaczone.
Wsród nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0### 
(# oznacza cyfrê w systemie ósemkowym, tzn. od 0 po 3).
\ec jest równowa¿ne z zastosowaniem opcji \fB\-n\fP.  \e wyra¿eniom
mo¿na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pilku historji zamiast
standardowego wyj¶cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wyno¶i domy¶lnie 1 przy pominiêciu), 
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy¿ej).
.sp
Opcja \fB\-R\fP jest stowoana do emulacji, w pewnym stopniu, komendy 
echo w wydaniu BSD, która nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy¿ej opcja \fB\-n\fP zapobiega zakonieczeniowemu prze³amaniu
wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bierz±cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta³a nastawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni¿ej), zostaje wy¶wietlony trop
logiczny (\fItzn.\fP, trop knieczny aby wykonaæ \fBcd\fP 
do bierz±cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (fizyczny trop) lub gdy
opcja \fBphysical\fP zosta³a nastawiona, zostaje wy¶wietlony trop
ustalone przez wystem plików (¶ledz±c katalogi \fB..\fP
a¿ po katalog pniowy).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej¶cia, rozdziela ten
wiersz na pola przy uwzglêdnieniu parametru \fBIFS\fP (
patrz Podstawienia powy¿ej), i przyporz±dkowywuje pola odpowienio danym 
parametrom.
Je¶li mamy wiêcej parametrów ni¿ pul, wówczas dodatkowe parametry zostaj±
ustawione na zero, a natomiast je¶li jest wiêcej pól ni¿ paramtrów to
ostatni parametr otrzymuje jako warto¶æ wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj±cymi przerwami).
Je¶li nie podano ¿adnych parametrów, wówczas zostaje zastosowany
parametr \fBREPLY\fP.
Je¶li wiersz wprowadzenie koñczy siê na pochy³ku wstecznym
i nie podano opcji \fB\-r\fP, to pochy³ek wsteczny i prze³amanie
wiersza zostaj± usuniête i wiêcej wprowadznia zostaje wczytane.
Gdy nie zostanie wczytane ¿adne wprowadznie, \fBread\fP zakañcza siê
niezerowym statusem.
.sp
Pierwszy parametro mo¿e mieæ do³±czony znak zapytania i ci±g, co oznacza, ¿e
dany ci±g zostania zastosowany jako zachêta do wprowadzenia 
(wy¶wietlana na standardowym wyj¶ciu b³edów zanim
zostanie wczytane jakiekolwiek wprowadzenie) je¶li wej¶cie jest tty-em
(\fIe.g.\fP, \fBread nco¶?'ile co¶ków: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj± ¿e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bierz±cego ko-procesu 
(patrz komenta¿e na ten temat w Ko-procesy powy¿ej).
Je¶li zastosowano opcjê \fB\-s\fP, wówczas wprowadznie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Patrz parametr wy³±cznego odczytu nazwanych parametrów.
Je¶li zosta³y podane warto¶ci wówczas zostaj± one nadane parametrom przed
ustawieniem danego strybutu.
Po nadaniu cechy wy³±cznego odczytu parametrowi, nie ma wiêcej mo¿liwo¶ci
wykasowania go lub zmiany jego warto¶ci.
.sp
Je¶li nie podano ¿adnych parametrów, wówczas zostaj± wypisane nazwy
wszystkich parametrów w cech± wy³±cznego odczytu wiersz po wierszu, chyba
¿e zastosowano opcjê \fB\-p\fP, co powoduje wypisanie pe³nych komend
\fBreadonly\fP definiuj±cych parametry wy³±czneg odczytu wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  return [status]
.IP "\fBreturn\fP [\fIstatus\fP]"
Powrót z funkcji lub \fB.\fP scryptu, ze statusem zakoñczenia \fIstatus\fP.
Je¶li nie podano warto¶ci \fIstatus\fP, wówczas zostaje domy¶lnie
zastosowany status ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcji lub \fB.\fP scryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Proszê zwróciæ uwagê i¿ pdksh traktuje zarówno profile jak i pliki z 
\fB$ENV\fP jako \fB.\fP scrypty, podczas gdy
orginalny Korn shell jedynie profile traktuje jako \fB.\fP scrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s³u¿y do nastawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opkcji otoczki, nastawiania prarmetrów pozycyjnych, lub
nastawiania parametru ci±gowego.
Opcje mog± byæ zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe³n± nazw± pewnej opcji, lub stosuj±c postaæ
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow±
nazwê danej opcji (niewszystkie opcje posiadaj± jednoliterow± nazê).
Nastêpuj±ca tablica wylicza zarówno litery opcji (gdy mamy takowe), jak i
pe³ne ich nazwy wraz z opisem wp³ywów danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci±gowego \fInazwa\fP na \fIarg\fP ...;
Je¶li zastosowano \fB\-A\fP, ci±g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je¶li zastosowano \fB+A\fP, zastaj± nastawione pierwsze N elementów (gdzie N
jest ilo¶ci± \fIarg\fPsów), reszta pozostaje niezmienioa.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj± tworzone z cecha eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu¿ przed zachêt±.
Ma tylko znaczenia je¶li zosta³a w³±czona kontrola zadañ (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej±cych ju¿ plików poprzez przekierunkowania
\fB>\fP (\fB>|\fP musi zostaæ zastosowane do wymuszenia przepisania).
T}
\-e	errexit	T{
Wyjd¼ (po wykoaniu komendy pu³apki \fBERR\fP) tu¿ po wyst±pieniu
b³êdu lub niepomy¶lnym wykoaniu jakiej¶ komendy
(\fItzn.\fP, je¶li zosta³a ona zakoñczona niezerowym statusem).
Niedotyczy to komend których status zakoñczenia zostaje jawnie przetestowny
konstruktem otoczki takim jak wyra¿enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorców nazw plików.
T}
\-h	trackall	T{
Twó¿ ¶ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy¿ej).
Domy¶lnie w³±czone dla nieinterakcyjnych otoczek.
T}
\-i	interactive	T{
W³±cz tryb interakcyjny \- mo¿e zostaæ 
w³±czone/wy³±czone jedynie podczas odpalania otoczki.
T}
\-k	keyword	T{
Przyporz±dkowania warto¶ci parametrom zostaj± rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Otoczka ma byæ otoczk± zameldowania \- mo¿e zostaæ 
w³±czone/wy³±czone jedynie podczas odpalania otoczki
(patrz Odpalania Otoczki powy¿ej).
T}
\-m	monitor	T{
W³±cz kontrloê zadabñ (domy¶lne dla otoczek interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skryptów (ignorowane dla interakcyjnych otoczek).
T}
\-p	privileged	T{
Nastawiane automatycznie, je¶li gdy otoczka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Otoczki powy¿ej dla opisu co to znaczy.
T}
-r	restricted	T{
Nastaw tryb ograniczony \(em ta opcja mo¿e zostaæ jedynie
zastosowan podczas odpalania otoczki.  Patrz Odpalania Otoczki
dla opisy co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania otoczki, wówczas komendy
zostaj± wczytywane ze standardowego wej¶cia.
Nastawione automatycznie, je¶li otoczka zosta³a odpalona bez jakichkolwiek
argumentów.
.sp
Je¶li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, wówczas
podane argumenty zostaj± uporz±dkowane zanim zostan± one przyczielone
parametrom pozycyjnym
(lub ci±gowi \fInazwa\fP, je¶li \fB\-A\fP zosta³o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nienastawionego parametru zostaje traktowane jako b³±d,
chyba ¿e jeden z modyfikatorów \fB\-\fP, \fB+\fP lub \fB=\fP 
zosta³ zastosowany.
T}
\-v	verbose	T{
Wypisuj wprowadzenia otoczki na standardowym wyj¶ciu b³êdów podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz±dkowania parametrów podczas ich wykonywania
poprzedzone warto¶ci± \fBPS4\fP.
T}
\-X	markdirs	T{
Naznaczaj katalogi nastêpuj±cym \fB/\fP podczas generacji nazw
plików.
T}
	bgnice	T{
Zadania w tle zostaj± wykonywane z ni¿szym priorytetem.
T}
	braceexpand	T{
W³±cz rozwijanie nawiasów (aka, alternacja).
T}
	emacs	T{
W³±cz edycjê wiersza komendy  w stylu BRL emacs-a (dotyczy wy³±cznie
otoczek interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W³±cz edycjê wiersza koemndy w stylo gmacs-like (Gosling emacs) 
(dotyczy wy³±cznie otoczek interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj±tkiem tego, ¿e przemiana (^T) 
zachowuje siê nieco inaczej.
T}
	ignoreeof	T{
Otoczka nie zostanie zakoñczona je¶li zostanie wczytany znak zakoñczenia
pliku. Nale¿y u¿yæ jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie¿±cych zadañ sygna³em \fBHUP\fP gdy otoczka zameldowania
zostaje zakoñczona.
Obecnie nastawione domy¶lnie, co siê jednak zmieni w przysz³o¶ci w celu
poprawienia kompatybilijnosæ z orginalnym Korn shell (który nie posiada
tej opcji, aczkolwiek wysy³a sygna³ \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w originalej otoczce Korn. Zapobiega sortowaniu definicji
funkcji w pliku histori.
T}
	physical	T{
Powoduje, ¿e komendy \fBcd\fP oraz \fBpwd\fP stosuj± `fizyczne'
(\fItzn.\fP, pochodz±ce od systemu plików) \fB..\fP katalogi zamiast `logicznych'
katalogów (\fItzn.\fP,  ¿e otoczka interpretuje \fB..\fP, co pozwala
u¿ytkownikowi nietroszczyæ siê o pod³±czenia symboliczne do katalogów).
Domy¶lnie wykasowane.  Proszê zwróciæ uwagê i¿ nastawianie tej opcji
nie wp³ywa na bie¿±c± warto¶æ parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy¿ej dla dalszych szczegu³ów.
T}
	posix	T{
W³±cz try posix-owy.  Patrz Tryb POSIX-owy powy¿ej.
T}
	vi	T{
W³±cz edycjê wiersza komendy  w stylu vi (dotyczy tylko otoczek 
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w orginalnej otoczce Korn-a, dopuki nie zosta³o 
nastawione viraw, tryb wiersza komendy vi
pozostawia³ pracê napêdowi tty a¿ do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plików
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Prefiksuj znaki z nastawionym ósmym bitem poprzez `M-'.
Je¶li nie zostanie nastawiona ta opcja, wówczas, znaki z zakresu
128-160 zostaj± wypisane bez zmian co mo¿e byæ przyczyn± problemów.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonyj rozwiania koemnd/ plików
je¶li tab (^I) zostanie wrowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo¿na urzyæ równie¿ podczas odpalania otoczki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje siê w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy¶wietla
wszystki opcja i informacjê o ich nastawieniu lub nie;
\fBset +o\fP wypisuje pe³ne nazwy opcji obecnie w³±czonych.
.sp
Pozosta³e argumenty, je¶li podano takowe, s± traktowane jako parametry
pozycyjne i zostaj± przyporz±dkowane, przy zachowaniu kolejno¶ci,
parametrom pozycyjnym (\fItzn.\fP, \fB1\fP, \fB2\fP, \fIitd.\fP).
Je¶li opcje koñcz± siê \fB\-\-\fP i brak dalszych argumentów,
wówczas wszystkie parametry pozycyjne zostaj± wyczyszczone.
Je¶li nie podano ¿adnych opcji lub argumentów, wówczas zostaj± wy¶wietlone
warto¶ci wszystkich nazw.
Z nieznanych historycznych powodów, samotna opcja \fB\-\fP 
zostaje traktowana specjalnie:
kasuje zaróno opcjê \fB\-x\fP, jak i \fB\-v\fP.
.\"}}}
.\"{{{  shift [number]
.IP "\fBshift\fP [\fIliczba\fP]"
Parametry pozycyjne \fIliczba\fP+1, \fIliczba\fP+2 \fIitd.\fP\& zostaj±
przeniesione pod \fB1\fP, \fB2\fP, \fIitd.\fP
\fIliczba\fP wynosi domy¶lnie 1.
.\"}}}
.\"{{{  test expression, [ expression ]
.IP "\fBtest\fP \fIwyra¿enie\fP"
.IP "\fB[\fP \fIwyra¿enie\fP \fB]\fP"
\fBtest\fP wylicza \fIwyra¿enia\fP i zwraca status zero je¶li
prawda, i status 1 jeden je¶li fa³sz, awiêcej ni¿ 1 je¶li wyst±pi³ b³±d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra¿eñ \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nastêpuj±ce podstawowe wyra¿enia:
.sp
.TS
afB ltw(2.8i).
\fIci±g\fP	T{
\fIci±g\fP ma niezerow± d³ugo¶æ.  Proszê zwróciæ uwagê i¿ mog± wyst±piæ
tródno¶ci je¶li \fIci±g\fP oka¿e siê byæ operatorem 
(\fIdok³adniej\fP, \fB-r\fP) - ogólnie lepiej jest stosowaæ
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
wzamian (podwójne wycytowania zostaj± zastosowaneje¶li
\fIci±g\fP zawiera przerwy lub znaki rozwijania plików).
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
\fIplik\fP jest zwyk³ym plikiem
T}
\-d \fIplik\fP	T{
\fIplik\fP jest katalogiem
T}
\-c \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem napêdu ci±gowego
T}
\-b \fIplik\fP	T{
\fIplik\fP jest specjalnym plikiem napêdu blokowego
T}
\-p \fIplik\fP	T{
\fIplik\fP jest nazwanym ruroci±giem
T}
\-u \fIplik\fP	T{
\fIplik\fP o ustawionym bicie setuid
T}
\-g \fIplik\fP	T{
\fIplik\fP' o ustawionym bicie setgid
T}
\-k \fIplik\fP	T{
\fIplik\fP o ustawionym bicie lepko¶ci
T}
\-s \fIplik\fP	T{
\fIplik\fP nie jest pusty
T}
\-O \fIplik\fP	T{
w³a¶ciciel \fIpliku\fP zgadza siê z efektywnym user-ID otoczki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza siê z efektywn± group-ID otoczki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod³±czeniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale¿nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym pod³±czeniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP otoczki jest nastawiona (patrz komenda \fBset\fP powy¿ej
dla listy mo¿liwych opcji).
Jako niestandardowe rozszerzenie, je¶li opcja zaczyna siê od
\fB!\fP, to wynik testu zostaje negowany; test wypada zawsze negatywnie
gdy dana opcja nie istnieje (tak wiêc
.RS
\fB[ -o \fP\fIco¶\fP \fB-o -o !\fP\fIco¶\fP \fB]\fP
.RE
zwraca prawdê tylko i tylko wtedy, gdy opcja \fIco¶\fP istnieje).
T}
\fIplik\fP \-nt \fIplik\fP	T{
pierwszy \fIplik\fP jest nowszy od nastêpnego \fIpliku\fP
T}
\fIplik\fP \-ot \fIplik\fP	T{
pierwszy \fIplik\fP jest starszy od nastêpnego \fIpliku\fP
T}
\fIplik\fP \-ef \fIplik\fP	T{
pierwszy \fIplik\fP jest torzsamy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przy¿±dem tty.
Je¶li nie zosta³a nastawiona opcja posix-a (\fBset \-o posix\fP, 
patrz Tryb POSIX powy¿ej), wówczas \fIfd\fP mo¿e zostaæ pominiêty, 
co oznacza przyjêcie domu¶lnej warto¶ci 1
(zachowanie siê jest wówczas odmienne z powodu specjalnych regó³
POSIX-a opisywanych powy¿ej).
T}
\fIci±g\fP	T{
\fIci±g\fP jest niepusty
T}
\-z\ \fIci±g\fP	T{
\fIci±g\fP jest pusty
T}
\-n\ \fIci±g\fP	T{
\fIci±g\fP jest niepusty
T}
\fIci±g\fP\ =\ \fIci±g\fP	T{
ci±gi s± sobie równe
T}
\fIci±g\fP\ ==\ \fIci±g\fP	T{
ci±gi s± sobie równe
T}
\fIci±g\fP\ !=\ \fIci±g\fP	T{
ci±gi siê ró¿ni±
T}
\fIliczba\fP\ \-eq\ \fIliczba\fP	T{
liczby s± równe
T}
\fIliczba\fP\ \-ne\ \fIliczba\fP	T{
liczby ró¿ni± siê
T}
\fIliczba\fP\ \-ge\ \fIliczba\fP	T{
liczba jest wiêksza lub równa od drugiej
T}
\fIliczba\fP\ \-gt\ \fIliczba\fP	T{
liczba jest wiêksza od drugiej
T}
\fIliczba\fP\ \-le\ \fIliczba\fP	T{
liczba jest mniejsza lub równa od drugiej
T}
\fIliczba\fP\ \-lt\ \fIliczba\fP	T{
liczba jest mniejsza od drugiej
T}
.TE
.sp
Powy¿sze podstawowe wyra¿enie, w których unarne operatory maj±
pierwszeñstwo przed operatorami binarnymi, mog± byæ stosowane w po³±czeniu
z nastêpuj±cymi operatorami
(wymienionymi w kolejno¶ci odpowiadaj±cej ich pierwszeñstwu):
.sp
.TS
afB l.
\fIwyra¿enie\fP \-o \fIwyra¿enie\fP	logiczne lub
\fIwyra¿enie\fP \-a \fIwyra¿enie\fP	logiczne i
! \fIwyra¿enie\fP	logiczna negacja
( \fIwyra¿enie\fP )	grupowanie
.TE
.sp
W systemie operacyjny niewspomagaj±cy napêdów \fB/dev/fd/\fP\fIn\fP
(gdzie \fIn\fP jest numerem deskryptora pliku),
komenda \fBtest\fP stara siê je emulowaæ dla wszystkich testów
operuj±cych na plikach (z wyj±tkiem testu \fB-e\fP).
W.sz., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dostêpny zapis na
deskryptor pliku 2.
.sp
Proszê zwróciæ uwagê ¿e zachodz± specjalne regó³y
(zawdziêczane POSIX-owi), je¶li liczba argumentów
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od piêciu: 
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête tak ¿e pozostaje tylko
jeden argument, wówczas zostaje przeprowadzony test d³ugosci ci±gu
(ponownie, nawet je¶li dany argument jest unarnym operatorem);
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête tak, ¿e pozostaj± trzy
argumenty i drugi argument jest operatorem binarnym, wówczas zostaje
wykonana dana binarna operacja (nawet je¶li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuniêtym \fB!\fP).
.sp
\fBUwaga:\fP Czêstym b³êdem jest stosowanie \fBif [ $co¶ = tam ]\fP co
daje wynik negatywny je¶li parametr \fBco¶\fP jest zerowy lub
nienastawiony, zwiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest unarnym operatorem, takim jak
\fB!\fP lub \fB\-n\fP.  Proszê stosowaæ testy typu 
\fBif [ "X$co¶" = Xtam ]\fP wzamian.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy¶wietla zgromadzony czas w przestrzeniu u¿ytkownika oraz systemu,
który spotrzebowa³a otoczka i w niej wystartowane 
procesy które w siê zakoñczy³y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna³ ...\fP]"
Nastawia obrabiacz, który nale¿y wykonaæ w razie odebrania danego sygna³u.
\fBObrabiacz\fP mo¿e byæ albo zerowym ci±giem, wskazujacym na zamiar
ignorowania sygna³ów danego typu, minusem (\fB\-\fP), 
wskazuj±cym, ¿e ma zostaæ podjêta akcja domy¶lna dla danego sygna³u
(patrz signal(2 or 3)), lub ci±giem zawierajacym komendy otoczki
które maj± zostaæ wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zakoñczeniu bierz±cej komendy, lub przed
wypisaniem nastêpnego zachêcacza \fBPS1\fP) po odebraniu
jednego z danych sygna³ów.
\fBSigna³\fP jest nazw± danego wygna³u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy¿ej).
Istnieja dwa specjalne sygna³y: \fBEXIT\fP (równie¿ znany jako \fB0\fP),
który zostaje wykonany tu¿ przed zakoñczeniem otoczki, i
\fBERR\fP który zostaje wykonany po wyst±pieniu b³edu
(b³êdem jest co¶ co powodowa³oby zakonczenie otoczki
je¶li zosta³y nastawioe opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP opwy¿ej).
Obrabiacze \fBEXIT\fP zostaj± wykonane w otoczeniu
ostatniej wykonywanej komendy.
Proszê zwróciæ uwage, ¿e dla otoczek nieinterakcyjnych obrabiacz wykroczeñ
nie mo¿e zostaæ zmieniony dla sygna³ów które by³y ignorowane podczas
startu danej otoczki.
.sp
Bez argumentów, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykroczeñ, które zosta³y nastawione od czasu staru otoczki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna³ów \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i orginalnej otoczki Korn'a w funkcjach nie zosta³o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda zakoñczaj±ca siê zerow± warto¶ci± statusu.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto¶æ\fP] ...]"
Wy¶wietlaj lub nastawiaj warto¶ci atrybutów parametrów.
Bez argumentów \fInazwa\fP, zostaj± wy¶wietlone atrybuty parametrów: 
je¶li brak argumentów opcyjnych, zostaja wy¶wietlone atrybuty
wszystkich parametór jako komendy typeset; je¶li podano opcjê
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto¶ci posiadaj±ce dany atrybut zostaj± 
wy¶wietlone;
je¶li opcje zaczynaj± siê od \fB+\fP, to nie zostaj± wy¶wietlone warto¶ci
oparametrów.
.sp
Je¶li podano argumenty If \fInazwa\fP, zostaj± nastawione atrybuty
danych parametrów (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto¶ci parametrów mog± zostaæ ewentualnie podane.
Je¶li typeset zostanie zastosowane wewn±trz funkcji, 
wszystkie nowotworzone parametry pozostaj± lokalne dla danej funkcji.
.sp
Je¶li zastosowano \fB\-f\fP, wówczas typeset operuje na atrybutach funkcji.
Tak jak dla parametrów, je¶li brak \fInazw\fPs, zostaj± wymienione funkcje
wraz z ich warto¶ciami (\fItzn.\fP, definicjami) chyba, ¿e opdano
opcje zaczynaj±ce siê od \fB+\fP, w którym wypadku
zostaj± wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyrównania do lewego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bierz±ca szeroko¶æ parametru 
(lub szeroko¶æ pierwszej przyporz±dkowywanej warto¶ci).
Prowadz±ce bia³e przerwy (tak jak i zera, je¶li
nastawiono opcjê \fB\-Z\fP) zostaj± wykasowane.
Je¶li trzeba, warto¶ci zostaj± albo obciête lub dodane przerwy
do osi±gniêcia wymaganej szeroko¶ci.
T}
\-R\fIn\fP	T{
Atrybut przyrównania do prawego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bierz±ca szeroko¶æ parametru
(lub szeroko¶æ pierwszej przyporz±dkowywanej warto¶ci).
Bia³e przerwy na koñcu zostaj± usuniête.
Je¶li trzeba, warto¶ci zostaj± albo pozbawione prowadz±cych znaków
albo przerwy zostaj± dodane do osi±gniêcia wymaganej szeroko¶ci.
T}
\-Z\fIn\fP	T{
Atrybut wype³niania zerami: je¶li nie skombinowany z \fB\-L\fP, to oznacza to
samo co \fB\-R\fP, tylko, ¿e do rozszerzania zostaje zastosowane zero
zamiast przerw.
T}
\-i\fIn\fP	T{
Atrybut ca³kowito¶ci:
\fIn\fP podaje bazê do zastosowania podczas
wypisywania danej warto¶ci ca³kowitej
(je¶li nie podano, to baza zostaje zaczerpniêta z 
bazy zastosowanej w pierwszym przyporz±dkowaniu warto¶ci).
Parametrom z tym atrybutem mog± byæ przyporz±dkowywane warto¶ci
zawierajace wyra¿enia arytmetyczne.
T}
\-U	T{
Atrybut dodatniej ca³kowito¶ci: liczby ca³kowite zostaj± wy¶wietlone
jako warto¶ci bez znaku
(stosowne jedynie w powi±zaniu z opcj± \fB\-i\fP).
Tej opcji brak w orginalnej otoczce Korn'a.
T}
\-f	T{
Tryb funkcji: wy¶wietlaj lub nastawiaj funkcje i ich atrybuty, zamiast
parametrów.
T}
\-l	T{
Atrybut ma³ej litery: wszystkie znaki z du¿ej litery zostaj± 
w wartosci zamienione na ma³e litery.
(W orignalnej otoczce Korn'a, parametr ten oznacza³ `d³ugi ca³kowity' 
gdy by³ stosowany w po³±czeniu z opcj± \fB\-i\fP).
T}
\-p	T{
Wypisuj pe³ne komendy typeset, które mo¿na nastêpnie zastosowaæ do
odtworzenia danych atrybutów (lecz nie warto¶ci) parametrów.
To jest wynikiem domy¶lnym (opcja ta istnieje w celu zachowania
kompatybilijno¶ci z ksh93).
T}
\-r	T{
Atrybut wy³acznego odczytu: parametry z danym atrybutem
nie przyjmuj± nowych warto¶ci i nie mog± zostaæ wykasowane.
Po nastawieniu tego atrybutu nie mo¿na go ju¿ wiêcej odaktywniæ.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla otoczki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut ¶ledzenia.
Je¶li zostaj± wykonywane funkcje z atrybutem ¶ledzenia, to
opcja otoczki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w³aczona.
T}
\-u	T{
Atrybut du¿ej litery: wszystkie znaki z ma³ej litery w warto¶ciach zostaj±
przestawione na du¿e litery.
(W orginalnej otoczce Korn'a, ten parametr oznacza³ `ca³kowity bez znaku' je¶li
zosta³ zastosowany w po³±czeniu z opcj± \fB\-i\fP, oznacza³o to, ¿e
nie mo¿na by³o sotsowaæ du¿ych liter dla baz wiêkszych ni¿ 10.  
patrz opcja \fB\-U\fP).
.sp
Dla funkcji, \fB\-u\fP to atrybut niezdefiniowania.  Patrz Funkcje powy¿ej
dla implikacji tego.
T}
\-x	T{
Atrybut eksportowania: parametry (lub funkcje) zostaj± umieszczone
w otoczenia wszelkich wykonywanych komend.  
Eksportowanie funkcji nie zosta³o jeszcze do tej pory zrealizowane.
T}
.TE
.\"}}}
.\"{{{  ulimit [-acdfHlmnpsStvw] [value]
.IP "\fBulimit\fP [\fB\-acdfHlmnpsStvw\fP] [\fIwarto¶æ\fP]"
Wy¶wietlij lub nastaw ograniczenia dla procesów.
Je¶li brak opcji, to ograniczenie ilo¶ci plików (\fB\-f\fP) zostaje
przyjête jako domy¶le.
\fBwarto¶æ\fP, je¶li podana, mo¿e byæ albo wyra¿eniem arytmetycznym
lub s³owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz± otoczki i wszelkich procesów przez ni± tworzonych
po nadaniu ograniczenia.
Proszê zwróciæ uwagê, i¿ niektóre systemy mog± zabraniaæ podnoszenia
warto¶ci ograniczeñ po ich nadaniu.
Ponadto proszê zwróciæ uwagê, ¿e rodzaje dostêpnych ograniczeñ zale¿± od
danego systemu \- niektóre systemy posiadaj± jedynie mo¿liwo¶æ
ograniczania \fB\-f\fP.
.RS
.IP \fB\-a\fP
Wy¶wietla wszystkie ograniczenia; je¶li nie podano \fB\-H\fP,
to zostaj± wy¶wietlone ograniczenia miêkkie.
.IP \fB\-H\fP
Nastaw jedynie ograniczenie twarde (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-S\fP
Nastaw jedynie ograniczenie miêkkie (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-c\fP
Ogranicz wielko¶ci plików zrzutów core do \fIn\fP blków.
.IP \fB\-d\fP
Ogranicz wielko¶æ area³u danych do \fIn\fP kbytów.
.IP \fB\-f\fP
Ogranicz wielkosæ plików zapisywanych przez otoczkê i jej programy pochodne
do \fIn\fP plików (pliki dowolnej wielko¶ci mog± byæ wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kbytów ilo¶æ podkluczonej (podpiêtej) fizycznej pamiêci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kbytów ilo¶æ uzywanej fizycznej pamiêci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie otwartych deskryptorów plików.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie wykonywanych procesów danego
u¿ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kbytów rozmiar area³u stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu¿ywany przez pojedyñcze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kbytów ilo¶æ u¿ywanej wirtualnej pamiêci;
pod niektórymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kbajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kbytów ilo¶æ stosowanego obszaru odk³adania.
.PP
Dla \fBulimit\fP blok to zawsze512 bajtów.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy¶wietl lub nastaw maskê zezwoleñ w tworzeniu plików, lub umask 
(patrz \fIumask\fP(2)).
Je¶li zastosowano opcjê \fB\-S\fP, maska jest wy¶wietlana lub podawana
symbolicznie, natomias jako liczba oktalna w przeciwnym razie.
.sp
Symboliczne maski s± podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znaków jest czê¶ci± \fIkto\fP, a druga grupa czêsci±
\fIop\fP, i ostatnio grupa czê¶ci± \fIperm\fP.
Czê¶æ \fIkto\fP okre¶la która czê¶æ umaski ma zostaæ zmodyfikowana.
Litery oznaczaj±:
.RS
.IP \fBu\fP
prawa u¿ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta³ych (nie-u¿ytkownika, nie-groupy)
.IP \fBa\fP
wszelkie prawa naraz (u¿ytkownika, grupy i pozosta³ych)
.RE
.sp
Czê¶æ \fIop\fP wskazujê jak prawa \fIkto\fP majê byæ zmienioe:
.RS
.IP \fB=\fP
nadaj
.IP \fB+\fP
dodaj do
.IP \fB\-\fP
usuñ z
.RE
.sp
Czê¶æ \fIperm\fP wskazuje które prawa maj± zostaæ nadane, dodane lub usuniête:
.RS
.IP \fBr\fP
prawo czytania
.IP \fBw\fP
prawo zapisu
.IP \fBx\fP
prawo wykonywania
.RE
.sp
Gdy stosuje siê symboliczne maski, do opisuj± one które prawa mog± zostaæ
udostêpnioe (w przeciwieñstwie do masek oktalnych, w których nastawienie
bita oznacze, ¿e ma on zostaæ wykasowany).
przyk³ad: `ug=rwx,o=' nastawia maskê tak, ¿e pliki nie bêd± odczytywalne,
zapisywalne i wykonywalne przez `innych', i jest ekwiwalnetne
(w wiêkszo¶ci systemów) do oktalnej maski `07'.
.RE
.\"}}}
.\"{{{  unalias [-adt] name ...
.IP "\fBunalias\fP [\fB\-adt\fP] [\fInazwa1\fP ...]"
Aliasy dla danej nazwy zostaj± usuniête.
Gdy zastosowano opcjê \fB\-a\fP, to wszelkie aliasy zostaj± usuniête.
Gdy zastosowano opcjê \fB\-t\fP lub \fB\-d\fP, to wymienione operacje
zostaj± wykonane jedynie na ¶ledzonych lub odpowiednio
aliasach katalogów.
.\"}}}
.\"{{{  unset [-fv] parameter ...
.IP "\fBunset\fP [\fB\-fv\fP] \fIparametr\fP ..."
Kasuj wymienione parametry (\fB\-v\fP, oznacza domy¶lne) lub funkcje
(\fB\-f\fP).
Statusem zakoñczenia jest nie-zerowy je¶li który¶ z danych parametrów by³
ju¿ wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zakoñczenie danego zadania/zadañ.
Statusem zakoñczenia wait jest status ostaniego podanego zadania:
je¶li dane zadanie zosta³o zabite sygna³em, status zakoñczenia wynosi
128 + number danego sygna³u (patrz \fBkill \-l\fP \fIstatus-zakoñczenia\fP
powy¿ej); je¶li ostatnie dane zadanie nie mo¿e zostaæ odnalezione
(bo nigdy nie istnia³o, lub ju¿ zosta³o zakoñczone), to status
zakoñczenia wait wynosi 127.
Patrz Kontrola Zadañ poni¿ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zakoñczone je¶li zajdzie sygna³ na który zosta³
nastawiony obrabiacz, lub gdy zostanie odebrany sygna³ HUP, INT lub
QUIT.
.sp
Je¶li nie podano zadañ, \fBwait\fP wait czeka na zakoñczenie
wszelkich obecnych zadañ (je¶li istnieja takowe) i koñczy siê
statusem zerowym.
Je¶li kontrola zadañ zosta³a w³±czona, to zostaje wy¶wietlony
status zakoñczeniowy zadañ
(to nie ma miejsca, je¶li zadania zosta³y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka¿dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je¶li podano opcjê \fB\-p\fP, to zostaje odszykany trop
dla \fInazw\fP, bêd±cych zarezerwowanymi z³owami, aliasmi, \fIitp.\fP
Bez opcji \fB\-v\fP \fBwhence\fP dzia³a podobnie do \fBcommand \-v\fP,
poza tym, ¿e \fBwhence\fP odszukuje zarezerwowane s³owa i nie wypisuje
aliasów jako komendy alias;
z opcj± \fB\-v\fP, \fBwhence\fP to tosamo co \fBcommand \-V\fP.
Proszê zwróciæ uwagê, ¿e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp³ywu
na przeszukiwany trop, tak jak dla \fBcommand\fP.
Je¶li typ jednej lub wiêcej sposród nazw niemóg³ zostaæ ustalony 
do status zakoñczenia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola Zadañ"
Kontrola zadañ oznacza zdolno¶æ otoczki to monitorowania i kontrolowania
wykonywanych \fBzadañ\fP,
które s± procesami lub grupami procesów tworzonych przez komendy lub 
ruroci±gi.
Otoczka przynajmniej ¶ledzi status obecnych zadañ w tle
(\fItzn.\fP, asynchronicznych); t± informacjê mo¿na otrzymaæ
wykonyj±æ komendê \fBjobs\fP.
Je¶li zosta³a uaktywnioa pe³na kontrola zadañ
(stosuj±c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w otoczkach interakcjynych,
to procesy pewnego zadania zostaj± umieszczane we w³asnej grupie
procesów, pierwszoplanowe zadnia mog± zostaæ zatrzymane przy pomocy
klawisza wstrzymania z termialu (zwykle ^Z),
zadania mog± zostaæ ponownie podjête albo na pierwszym planie albo
w tle, stosujac odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nastêpnie odtworzony, je¶li
zatanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Proszê zwróciæ uwgaê, ¿e tylko komendy tworz±ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podotoczek, i niewbudowane komendy
nie bêd±ce funkcjami) mog± zostaæ wstrzymane; takie komendy
jak \fBread\fP nie mog± tego.
.sp
Gdy zostaje stworzone zadnie, to przyporzadkowywuje mu siê numer zadania.
Dla interakcyjnych otoczek, numer ten zostaje wy¶wietlone w \fB[\fP..\fB]\fP,
i w nastêpstwie identyfikatory procesów w zadaniu, je¶li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo¿emy odnosiæ siê w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i 
\fBwait\fP albo poprzez id ostatniego procesu w ruroci±gu komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj±c
numer zadania znakiem procentu (\fB%\fP).
Równie¿ nastêpuj±ce sekwencjê z procentem mog± byæ stosowane do
odnoszenia siê do zadañ:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie, lub, gdy brak zatrzymanych zadañ, najstarsze 
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, które wy³oby pod \fB%+\fP gdyby nie zosta³o zakoñczone.
T}
%\fIn\fP	T{
Zadanie z numeram zadania \fIn\fP.
T}
%?\fIci±g\fP	T{
Zadanie zawieracjace ci±g \fIci±g\fP (wystêpuje b³±d, gdy odpowiada mu 
kilka zadañ).
T}
%\fIci±g\fP	T{
Zadanie zaczynaj±ce siê ci±giem \fIci±g\fP (wystêpuje b³±d, gdy odpowiada 
mu kilka zadañ).
T}
.TE
.sp
Je¶li zadanie zmienia status (\fItzn.\fP, gdy zadanie w tle
zostaje zakoñczone lub zadanie na pierwszym planie zostaje wstrzymane), 
otoczka wy¶wietla nastêpuj±ce informacje o statusie:
.RS
\fB[\fP\fInumer\fP\fB]\fP \fIflaga status komenda\fP
.RE
gdzie
.IP "\ \fInumer\fP"
to numer danego zadania.
.IP "\ \fIflaga\fP"
jest \fB+\fP lub \fB-\fP je¶li zadaniem jest odpowiednio zadanie z 
\fB%+\fP lub \fB%-\fP, lub przerwa je¶li nie jest ani jednym ani drugim.
.IP "\ \fIstatus\fP"
Wskazuje opbecny stan danego zadania
i mo¿e to byæ
.RS
.IP "\fBRunning\fP"
Zadania nie jest ani wstrzymane ani zakoñczone (proszê zwróciæ uwagê, i¿
przebieg nie koniecznie musi oznaczaæ spotrzebowywanie
czasu CPU \(em proces mo¿e byæ zablokowany, czekaj±c na pewne zaj¶cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zakoñczone. \fInumer\fP to status zakoñczeniowy danego zadania,
który zostaje pominiety, je¶li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna³\fP\fB)\fP]"
zadanie zosta³o wstrzymane danym sygna³em \fIsygna³\fP (gdy brak sygna³u,
to zadnie zosta³o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna³u\fP [\fB(core dumped)\fP]"
zadanie zosta³o zabite sygna³em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opisów sygna³ów).
Wiadomosæ \fB(core\ dumped)\fP wskazuje, ¿e proces stworzy³ plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, która stworzy³a dany proces.
Je¶li dane zadania zwiera kilka procesów, to k±dy proces zostanie wy¶wietlony
w osobnym wierszy pokazujacym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je¶li jest on odmienny od statusu poprzedniego procesu.
.PP
Je¶li próbuje siê zakoñczyæ otoczkê, podczas gdy istniej± zadania w
stanie zatrzymania, to otoczka ostrzega u¿ytkownika, ¿e s± zadania w stanie
zatrzymania i nie zakañcza siê.
Gdy tu¿ potem zostanie podjêta ponowna próba zakoñczenia otoczki, to
zatrzymane zadania otrzymuj± sygna³ \fBHUP\fP i otoczka koñczy pracê.
podobnie, je¶li nie zosta³a nastawiona opcja \fBnohup\fP,
i s± zadania w pracy, gdy zostanie podjeta próba zakoñczenia otoczki
zameldowania, otoczka ostrzega u¿ytkownika i nie koñczy pracy.
Gdy tu¿ potem zotanie ponownie podjeta próba zakoñczenia pracy otoczki,
to bierz±ce procesy otrzymuj± sygna³ \fBHUP\fP i otoczka koñczy pracê.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna Edycja Wiersza Wprowadzeñ w Trybie Emacs"
Je¶li zosta³a nastawiona opcja \fBemacs\fP,jest w³±czona interakcyjna
edycja wiersza wprowadzeñ.  \fBOstrze¿enie\fP: Ten tryb zachowuje siê
nieco inaczej ni¿ tryb emacs-a w orginalnej otoczce Korn-a
i 8-smy bit zostaje wykasowany w trybie emacs-a.
W trybie tym ró¿ne komendy edycji (zazwyczaj pod³±czone pod jeden lub wiecej
znaków kontrolnych) powoduj± natychmiastowe akcje bez odczekiwania
nastêpnego prze³amania wiersza.  Wiele komend edycji jest zwi±zywana z 
pewnymi znakami kontrolnymi podczas odpalania otoczki; te zwi±zki mog± zostaæ
zmienione przy pomocy nastêpuj±cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi±zki zostaj± wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci±g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi±zana pod dany \fBci±g\fP, który
powinnien sk³adaæ siê ze znaku kontrolnego (zapisanego przy pomocy
strza³ki w górê \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dwóch znaków przedsionkownych.  Wprowadzenie danego
\fIci±gu\fP bêdzie wówczas powodowa³o bezpo¶rednie wywo³anie danej
komendy edycji.  Proszê zwróciæ uwagê, ¿e choæ tylko
dwa znaki przedsionkowe mog± (zwykle ESC i ^X) s± wspomagane, to
równie¿ niektóre ci±gi wieloznakowe równie¿ mog± zostaæ podane.  
Nastêpuj±ce pod³±cza klawisze terminala ANSI lub xterm
(które s± w domy¶lnych podwi±zaniach).  Oczywi¶cie niektóre
sekwencje wyprowadzenia nie chc± dzia³aæ tak g³adko:
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
Wymieñ nazwy funkcji do których mo¿na pod³aczyæ klawisze.
.\"}}}
.\"{{{  bind -m string=[substitute]
.IP "\fBbind \-m\fP \fIci±g\fP\fB=\fP[\fIpodstawienie\fP]"
Dany ci±g wprowadzenia \fIci±g\fP zostanie zamieniony bezpo¶rednio na
dane \fIpodstawienie\fP które mo¿e zawieraæ komendy edycji.
.\"}}}
.PP
Nastêpuje lista dostêpnych komend edycji.
Ka¿dy z poszczególnych opisów zaczyna siê nazw± komendy,
liter± \fIn\fP, je¶li komenda mo¿e zostaæ poprzedzona licznikiem,
i wszelkimi klawiszami do których dana komenda jest pod³aczona
domy¶lnie (w zapisie sotsujacym notacjê strza³kow±, \fItzn.\fP, 
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj±cy komendê wprowadzamy stosuj±c ci±g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci±g sk³adaj±cy siê z jednej
lub wiêcej cyfr;
chyba, ¿e podano inaczej licznik, je¶li zosta³ pominiêty, wynosi 
domy¶lnie 1.
Proszê zwróciæ uwagê, ¿e nazwy komend edycji stosowane s± jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy¶lne podwi±zania zosta³y wybrane
tak, aby by³y zgodne z odpowiednimi podwi±zaniami EMACS-a.  
Znaki u¿ytkownika tty (\fIw szczególno¶ci\fP, ERASE) zosta³y
pod³±czenia do stosownych podstawnieñ i przekasowywuj± domy¶lne
pod³±czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania-histori\fP 
do przerwania tego szukania.
.\"}}}
.\"{{{  auto-insert n
.IP "\fBauto-insert\fP \fIn\fP"
Powoduje po prostu wy¶wietlenie znaku jako bezpo¶rednie wprowadzenie. 
Wiêkszo¶æ zwyk³ych znaków jest pod to pod³±czona.
.\"}}}
.\"{{{  backward-char	n ^B
.IP "\fBbackward-char\fP  \fIn\fP \fB^B\fP"
Przesuwa kursor \fIn\fP znaków wstecz.
.\"}}}
.\"{{{  backward-word  n ^[B
.IP "\fBbackward-word\fP  \fIn\fP \fB^[B\fP"
Przesuwa kursor wstecz na pocz±tek s³owa; s³owa sk³adaj± siê ze
znaków alfanumerycznych, podkre¶lenia (_) i dolara ($).
.\"}}}
.\"{{{  beginning-of-history ^[<
.IP "\fBbeginning-of-history ^[<\fP"
Przesuwa na pocz±tek histori.
.\"}}}
.\"{{{  beginning-of-line ^A
.IP "\fBbeginning-of-line ^A\fP"
Przesuwa kursor na pocz±tek edytowanego wiersza wprowadzenia.
.\"}}}
.\"{{{  capitalize-word n ^[c, ^[C
.IP "\fBcapitalize-word\fP \fIn\fP \fB^[c\fP, \fB^[C\fP"
Przemienia pierwszy znak w nastêpnych \fIn\fP s³owach na du¿± literê,
pozostawiaj±c kursor za koñcem ostatniego s³owa.
.\"}}}
.\"{{{  comment ^[#
Je¶li bierz±cy wiersz nie zaczyna siê od znaku komentarza, zostaje on
dodany na pocz±tku wiersza i wiesz zostaje wprowadzony (tak jakby
naci¶niêto prze³amanie wiersza), w przeciwnym razie istniej±ce znaki
komentarza zostaj± usuniête i kursor zostaje umieszczony na pocz±tku 
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj±cej kursor.  Je¶li ca³a pozosta³a czê¶æ
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy¶wietlona
po wype³nieniy, chyba ¿e jest to nazwa katalogu, w którym to razie zostaje
do³±czone \fB/\fP.  Je¶li nie ma komendy lub nazwy pliku zaczynajacej
siê od takiej czêsci s³owa, to zostaje wyprowadzony znak dzwonka 
(zwykle powodujacy s³yszalne zabuczenie).
.\"}}}
.\"{{{  complete-command ^X^[
.IP "\fBcomplete-command ^X^[\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne z nazwy komendy
zawieraj±cej czê¶ciowe s³owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy¿ej.
.\"}}}
.\"{{{  complete-file ^[^X
.IP "\fBcomplete-file ^[^X\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne z nazwy plikyu
zawieraj±cego czê¶ciowe s³owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy¿ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymieñ mo¿liwe dope³nienia bierz±cego s³owa.
.\"}}}
.\"{{{  delete-char-backward n ERASE, ^?, ^H
.IP "\fBdelete-char-backward\fP \fIn\fP \fBERASE\fP, \fB^?\fP, \fB^H\fP"
Skasuj \fIn\fP znaków przed kursorem.
.\"}}}
.\"{{{  delete-char-forward n
.IP "\fBdelete-char-forward\fP \fIn\fP"
Skasuj \fIn\fP znaków po kursorze.
.\"}}}
.\"{{{  delete-word-backward n ^[ERASE, ^[^?, ^[^H, ^[h
.IP "\fBdelete-word-backward\fP \fIn\fP \fB^[ERASE\fP, \fB^[^?\fP, \fB^[^H\fP, \fB^[h\fP"
Skasuj \fIn\fP s³ów przed kursorem.
.\"}}}
.\"{{{  delete-word-forward n ^[d
.IP "\fBdelete-word-forward\fP \fIn\fP \fB^[d\fP"
Kasuje znaki po koursorze, a¿ do koñca \fIn\fP s³ów.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historji w przód \fIn\fP wierszy (pó¼niej).  
Ka¿dy wiersz wprowadzenia zaczyna siê orginalnie tu¿ po ostatnim
miejscu w buforze historji, tak wiêc
\fBdown-history\fP nie jest przydaten dopuki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Przemieñ na ma³e litery nastêpnych \fIn\fP s³ów.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porousza do koñca historji.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na konieæ wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia³a jako koniec-pliku; Jest to przydatne, albowiem tryb edycji
wprowadzenia wy³±cza normaln± regularyzacjê wprowadzenia terminala.
.\"}}}
.\"{{{  eot-or-delete n ^D
.IP "\fBeot-or-delete\fP \fIn\fP \fB^D\fP"
Dzia³a jako eot je¶li jest samotne na wierszu; w przeciwnym razie
dzia³a jako delete-char-forward.
.\"}}}
.\"{{{  error
.IP "\fBerror\fP"
Error (ring the bell).
.\"}}}
.\"{{{  exchange-point-and-mark ^X^X
.IP "\fBexchange-point-and-mark ^X^X\fP"
Umie¶æ kursor na znaczniku i nastaw znacznik na miejsce w którym by³
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bierz±cego s³owa i zastêpuje dane s³owo wynikiem
rozwiniêcia nazwy pliku na danym s³owie.
Gdy nie pasuj± ¿adne pliki, zadzwoñ.
.\"}}}
.\"{{{  forward-char n ^F
.IP "\fBforward-char\fP \fIn\fP \fB^F\fP"
Przesuwa kursor naprzód o \fIn\fP znaków.
.\"}}}
.\"{{{  forward-word n ^[f
.IP "\fBforward-word\fP \fIn\fP \fB^[f\fP"
Przesuwa kursor naprzód na zakoñczenie \fIn\fP-tego s³owa.
.\"}}}
.\"{{{  goto-history n ^[g
.IP "\fBgoto-history\fP \fIn\fP \fB^[g\fP"
Przemieszcza do historji numer \fIn\fP.
.\"}}}
.\"{{{  kill-line KILL
.IP "\fBkill-line KILL\fP"
Kasuje ca³y wiersz wprowadzenia.
.\"}}}
.\"{{{  kill-region ^W
.IP "\fBkill-region ^W\fP"
Kasuje wprowadzenie pomiêdzy kursorem a znacznikiem.
.\"}}}
.\"{{{  kill-to-eol n ^K
.IP "\fBkill-to-eol\fP \fIn\fP \fB^K\fP"
Je¶li ominiêto \fIn\fP, to kasuje wprowadzenia od kursora do koñca wiersza,
w przeciwnym razie kasuje znaki pomiêdzu cursorem a
\fIn\fP-t± kolumn±.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend lub nazw plików
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
Do nazw katalogów zostaje do³±czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw plików
(je¶li s± takowe) które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursr.
Specyfikatory rodzaju plików zostaj± do³±czone tak jak powy¿ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bierz±cego wiersza wprowadzeñ przez otoczkê.
Kursor mo¿e znajdowaæ siê aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bierz±cego wiersza wprowadzeñ przez otoczkê,
po czym nastêpny wiersz z histori staje siê wierszem bierz±cym.
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
Ostatnie (\fIn\fP-te) s³owo poprzedniej komendy zostaje wprowadzone
na miejscu kursora.
.\"}}}
.\"{{{  quote ^^
.IP "\fBquote ^^\fP"
Nastêpuj±cy znak zostaje wziêty dos³ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zachêcacz i bierz±cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty³ w bierz±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w przód w bierz±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd¼ w krocz±cy tryb szukania.  Wewnêtrzna lista historji zostaje
przeszukiwana wstecz za komendami odpowiadaj±cymi wprowadzeniu.  
pocz±tkowe \fB^\fP w szukanym ci±gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan± wykonywane po opuszczeniu trybu szukania.  
Ponowne komendy \fBsearch-history\fP kontynuuj± szukanie wstecz
do nastêpnego poprzedniego wyst±pienia wzorca.  Bufor historji
zawiera tylko skoñczon± ilo¶æ wierszy; dla potrzeby najstarsze zostaj±
wy¿ucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bierz±cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj±cymi, wypycha pod³±czony znak spowrotem
do wej¶cia terminala, dzie mo¿e on zostaæ specjalnie przetworzony przez
terminal.  Jest to przydatne n.p. dla opcji BRL \fB^T\fP mini-systat'a.
.\"}}}
.\"{{{  stuff-reset
.IP "\fBstuff-reset\fP"
Dzia³a tak jak \fBstuff\fP, a potem przerywa wprowadzenie tak jak
przerwanie.
.\"}}}
.\"{{{  transport-chars ^T
.IP "\fBtranspose-chars ^T\fP"
Na koñcu wiersza lub je¶li w³±czono opcjê \fBgmacs\fP, 
zamienia dwa poprzedzaj±ce znaki; w przeciwnym razie zamienia
poprzedni i birz±cy znak, po czym przesuwa cursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historji \fIn\fP wierszy wstecz (wcze¶niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nastêpnych \fIn\fP s³ów w du¿e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisujê wersjê ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci¶niêty jakikolwiek klawisz 
(po czym ten klawisz zostaje przetworzony, chyba ¿e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad¼ ostatnio skasowny ci±g tekstu na bierz±c± pozycjê kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo¶rednio po \fByank\fP, zamienia wprowadzony tekst na
nastêpny poprzednio skasowany ci±g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny Tryb Edycji Wiersza Wprowadzeñ Vi"
Edytor vi wiersza komendy w ksh obs³uguje w zasadzie te same komendy co
edytor vi (patrz \fIvi\fP(1)), poza nastêpuj±cymi wyj±tkami:
.nr P2 \n(PD
.IP \ \ \(bu
zaczyna w trybie wprowadzania,
.IP \ \ \(bu
ma komendy uzupe³niania nazw plików i komend
(\fB=\fP, \fB\e\fP, \fB*\fP, \fB^X\fP, \fB^E\fP, \fB^F\fP i,
opcjonalnie, \fB<tab>\fP),
.IP \ \ \(bu
komenda \fB_\fP dzia³a odmiennie (w ksh jst to komenda ostatniego argumentu,
a w vi przechodzenie do pocz±tku bierz±cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fPporuszaj± siê w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
i brak jest komend, które nie maj± znaczenia w edytorze obs³ugujacym jeden 
wiersz (\fIw szczególno¶ci\fP, przewijanie ekranu, komendy ex \fB:\fP, 
\fIitp.\fP).
.nr PD \n(P2
.LP
Proszê zwróciæ uwagê, ¿e \fB^X\fP oznacza control-X; oraz \fB<esc>\fP,
\fB<space>\fP i \fB<tab>\fP stosowane s± za escape, space i tab, 
odpowiednio (bez ¿artów).
.\"}}}
.\"{{{  modes
.PP
Tak jak w vi, s± dwa tryby: tryb wprowadzania i tryb komend.
W trybie wprowadzania, wiêkszo¶æ znakow zostaje po prostu umieszczona
w buforze na bierz±cym miejscu kursora w kolejno¶ci ich wpisywania, 
chocia¿ niektóre znaki zostaj± traktowane specjalnie.
W szczególno¶ci nastêpuj±ce znaki odpowiadaj± obecnym ustawieniom tty'a
(patrz \fIstty\fP(1)) i zachowuj± ich normalne znaczenia
(normalne warto¶ci s± podane w nawiasach):
skasuj (\fB^U\fP), wyma¿ (\fB^?\fP), wyma¿ s³owo (\fB^W\fP), eof (\fB^D\fP),
przerwij (\fB^C\fP) i zakoñcz (\fB^\e\fP).
Poza powy¿szymi dodatkowo równie¿ nastêpuj±ce znaki zostaj± traktowane
specjalnie w trybie wprowadzania:
.TS
expand;
afB lw(4.5i).
^H	T{
kasuje poprzedni znak
T}
^V	T{
bazpo¶renio nastêpny: nastêpny naci¶niêty znak nie zostaje traktowany 
specjalnie (mo¿na tego u¿yæ do wprowadzenia opisywanych tu znaków)
T}
^J ^M	T{
kiniec wiersza: bierz±cy wiersz zostaje wczytany, rozpoznany i wykonany
przez otoczkê
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni¿ej)
T}
^E	T{
wyliczanie komend i nazw plików (patrz poni¿ej)
T}
^F	T{
dope³nianie nazw plików (patrz poni¿ej).
Je¶li zostanie u¿yte dwukrotnie, zo wówczas wy¶wietla listê mo¿liwych
dope³nieñ;
je¶li zostanie u¿yte trzykrotnie, to kasuje dope³nienie.
T}
^X	T{
rozwijanie nazw komend i plików (patrz poni¿ej)
T}
<tab>	T{
opcjonalnie dope³nianie nazw plików i komend (patrz \fB^F\fP powy¿ej), 
w³±czane przez \fBset \-o vi-tabcomplete\fP
T}
.TE
.\"}}}
.\"{{{  display
.PP
Je¶li jaki¶ wiersz jest d³u¿szy od szeroko¶ci ekranu
(patrz parametr \fBCOLUMNS\fP),
to zostaje wy¶wietlony znak \fB>\fP, \fB+\fP lub \fB<\fP 
w ostatniej kolumnie, wskazujacy odpowiednio na wiêcej znaków po, przed i po, oraz 
przed obecn± pozycj±.
Wiersz jest przwijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka¿dy znak zostaje interpretowany jako komenda.
Znaki którym nie odpowiada ¿adna komenda, które s± niedopuszczaln± 
komend± lub s± komendami niedowykonania, wszystkie wyzwalaj± dzwonek.
W nastêpuj±cych opisach komend, \fIn\fP wskazuje ¿e komedê mo¿na
poprzedziæ numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znaków); gdy brak przedsionka numerowego, to zak³ada siê, ¿e \fIn\fP 
jest równe 1, chyba ¿e powiemy inaczej.
Zwrot `bierz±ca pozycja' odnosi siê do pozycji pomiêdzy cursorem
a znakiem przed nim.
`S³owo' to ci±g liter, cyfr lub podkre¶leñ
albo ci±g nie nie-liter, nie-cyfr, nie-podkre¶leñ, niebia³ych-znaków
(\fItak wiêc\fP, ab2*&^ zawiera dwa s³owa), oraz `du¿e s³owo' jest ci±giem
niebia³ych znaków.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nastêpuj±cych komend brak, lub s± one odmienne od tych w normalnym
edytorze plików vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad¼ przerwê z nastêpstwem \fIn\fP-tego du¿ego s³owa
z ostatniej komendy w historji na bierz±cej pozycji w wejd¼ z tryp
wprowadzania; je¶li nie podano \fIn\fP to domy¶lnie zostaje wprowadzone
ostatnie s³owo.
.IP "\fB#\fP"
wprowad¼ znak komenta¿a (\fB#\fP) na pocz±tku bierz±cego wiersza
i przeka¿ ten wiersz do otoczki (taksoamo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z wyj±tkiem, ¿e je¶li nie podano \fIn\fP 
to dotyczy to ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj±c edytor vi; 
je¶li nie podano \fIn\fP, to edytuje bierz±cy wiersz.
W³a¶ciw± wykonywan± komend± jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope³nianie komendy lub nazwy pliku zostaje zastosowane do
 obecnego du¿ego s³owa
(po dodaniu *, je¶li to s³owo nie zawiera ¿adnych znaków dope³niania nazw
plików) - du¿e s³owo zostaje zast±pione s³owami wynikowymi.
Je¶li bierz±ce du¿e s³owo jest pierwszym w wierszu (lub wystêpuke po
jednym z nastêpuj±cych znaków: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera pochy³ka (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wyknoane rozwijanie nazwy plików.
Rozwijanie komend podpasowuje du¿e s³owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i równie¿ wszelkie wykonywalne pliki odnajdywane
przeszukuj±c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plików dopasowywuje du¿e s³owo do nazw plików w bierz±cym
katalogu.
Po rozwiniêciu, kursor zostaje umieszczony tu¿ po
ostatnim s³owie na koñcu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope³nianie nazw komend/plików: 
zastêpuje bierz±ce du¿e s³owo najd³uzszym, jednoznacznym
dopasowaniem otrzymanym przez rozwiniêcie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je¶li zosta³a w³±czona opcja 
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je¶li zosta³a w³±czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je¶li podano \fIn\fP to zostaje u¿yte \fIn\fP-te mo¿liwe 
dope³nienie (z tych zwracanych przez komenê wyliczania dope³nieñ nazw
komend/plików).
.IP "\fB=\fP and \fB^E\fP"
wyliczanie nazw komend/plików: wymieñ wszystkie komendy lub pliki
pasujêce pod obecne du¿e s³owo.
.IP "\fB^V\fP"
wy¶wietl wersjê pdksh; jest ona wy¶wietlana do nastêpnego naci¶niêcia
klawisza (ten klawisz zostaje zignorowany).
.IP "\fB@\fP\fIc\fP"
rozwiniêcie makro: wykonaj komendy znajduj±ce siê w aliasie _\fIc\fP.
.RE
.\"}}}
.\"{{{  Intra-line movement commands
.IP "Komendy przemieszczania w wierszu"
.RS
.IP "\fIn\fP\fBh\fP and \fIn\fP\fB^H\fP"
przesuñ siê na lewo \fIn\fP znaków.
.IP "\fIn\fP\fBl\fP and \fIn\fP\fB<space>\fP"
przesuñ siê w prawo \fIn\fP znaków.
.IP "\fB0\fP"
przsuñ siê do kolumny 0.
.IP "\fB^\fP"
przesuñ siê do pierwszego niebia³ego znaku.
.IP "\fIn\fP\fB|\fP"
przesuñ siê do kolumny \fIn\fP.
.IP "\fB$\fP"
przesuñ siê do ostatniego znaku.
.IP "\fIn\fP\fBb\fP"
przesuñ siê wstecz \fIn\fP s³ów.
.IP "\fIn\fP\fBB\fP"
przesuñ siê wstecz \fIn\fP du¿ych s³ów.
.IP "\fIn\fP\fBe\fP"
przesuñ siê na przód do koñca s³owo \fIn\fP razy.
.IP "\fIn\fP\fBE\fP"
przesuñ siê na przód do koñca du¿ego s³owa \fIn\fP razy.
.IP "\fIn\fP\fBw\fP"
przesuñ siê na przód o \fIn\fP s³ów.
.IP "\fIn\fP\fBW\fP"
przesuñ siê na przód o \fIn\fP du¿ych s³ów.
.IP "\fB%\fP"
odnajd¼ wzór: edytor szuka do przodu najbli¿szego nawiasu okr±g³ego
prostok±tnego lub zawi³ego i nastêpnie przesuwa siê od odpowiadaj±cego mu
nawiasu okr±g³ego prostokêtne lub zawi³ego.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesuñ siê w przód do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesuñ siê w ty³ do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesuñ siê w przod tu¿ przed \fIn\fP-te wyst±pienie znaku \fIc\fP.
.IP "\fIn\fP\fBT\fP\fIc\fP"
przesuñ siê w ty³ tu¿ przed \fIn\fP-te wyst±pienie znaku \fIc\fP.
.IP "\fIn\fP\fB;\fP"
powtarza ostatni± komendê \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP.
.IP "\fIn\fP\fB,\fP"
powtarza ostatni± komendê \fBf\fP, \fBF\fP, \fBt\fP lub \fBT\fP, 
lecz porusza siê w przeciwnym kierunku.
.RE
.\"}}}
.\"{{{  Inter-line movement commands
.IP "Komendy przemieszczania miêdzy wierszami"
.RS
.IP "\fIn\fP\fBj\fP i \fIn\fP\fB+\fP i \fIn\fP\fB^N\fP"
przejd¼ do \fIn\fP-tego nastêpnego wiersza w historji.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd¼ do \fIn\fP-tego poprzedniego wiersza w historji.
.IP "\fIn\fP\fBG\fP"
przejd¼ do wiersza \fIn\fP w historji; je¶li brak \fIn\fP, to przenosi
siê do pierwszego zapamietanego wiersza w historji.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, ¿e je¶li nie podan \fIn\fP to idzie do
ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci±g\fP"
szukaj wstecz w historji \fIn\fP-tego wiersza zawieraj±cego
\fIci±g\fP; je¶li \fIci±g\fP zaczyna siê od \fB^\fP, to reszta ci±gu
musi wystêpowaæ na samym pocz±tku wiersza historji aby pasowa³a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, ¿e szuka do przodu w histori.
.IP "\fIn\fP\fBn\fP"
szukaj \fIn\fP-tego wyst±pienia ostatnio szukanego ci±gu; kierunek jest
ten sam co kierunek ostatniego szukania.
.IP "\fIn\fP\fBN\fP"
szukaj \fIn\fP-tego wyst±pienia ostatnio szukanego ci±gu; kierunek jest
przeciwny do kierunku ostatniego szukania.
.RE
.\"}}}
.\"{{{  Edit commands
.IP "Komendy edycji"
.RS
.IP "\fIn\fP\fBa\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania tu¿ po
bierz±cej pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t± ró¿nic± ¿e dodaje do koñca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bierz±cej
pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t± ró¿nic± ¿e dodaje do tu¿ przed pierwszym niebia³ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamieñ nastêpnych \fIn\fP znaków (\fItzn.\fP, skasuj te znaki i przejd¼
do trybu wprowadzania).
.IP "\fBS\fP"
zast±p ca³y wiersz: wszystkie znaki od pierwszego niebia³ego znaku
do koñca wiersza zostaj± skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd¼ z bierz±cej pozycji do pozycji wynikajacej z \fIn\fP
\fIkomend-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wej¼ w tryb
wprowadzania);
je¶li \fIkomend±-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia³ego znaku pocz±wszy.
.IP "\fBC\fP"
zmieñ od obecnej pozycji op koniec wiersza (\fItzn.\fP, skasuj do koñca wiersza
i przejd¼ do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nastêpnych \fIn\fP znaków.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znaków.
.IP "\fBD\fP"
skasuj do koñca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikajacej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo¿e byæ komend± przemieszczania (patrz powy¿ej) lub \fBd\fP,
co powoduje skasowanie bierz±cego wiersza.
.IP "\fIn\fP\fBr\fP\fIc\fP"
zamieñ nastêpnych \fIn\fP znaków na znak \fIc\fP.
.IP "\fIn\fP\fBR\fP"
zamieñ: wejd¼ w tryb wprowadzania lecz przepisuj istniejace znaki
zamiast wprowadzania przed istniej±cymi znakami.  Zamiana zostaje wykonana
\fIn\fP krotnie.
.IP "\fIn\fP\fB~\fP"
zmieñ wielko¶æ nastêpnych \fIn\fP znaków.
.IP "\fIn\fP\fBy\fP\fImove-cmd\fP"
wytnij od obecnej pozycji po pozycjê wynikaj±c± z \fIn\fP krotnego
\fImove-cmd\fP do bufora wycinania; je¶li \fImove-cmd\fP jest \fBy\fP, to
ca³y wierz zostaje wyciêty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do koñca wiesza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto¶æ bufora wycinania tu¿ po bierz±cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko ¿e bufor zostaje wklejony na bierz±cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "Ró¿ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bierz±cy wiersz zostaje wczytany, rozpoznany i wykonany przez otoczkê.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bierz±cy wiersz.
.IP "\fIn\fP\fB.\fP"
wyknoaj ponownie ostatni± komendê edycji \fIn\fP razy.
.IP "\fBu\fP"
odwróæ ostatni± komendê edycji.
.IP "\fBU\fP"
odwróæ wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zakoñczenia powoduj± skasowania bierz±cego
wiersza i wy¶wietlenie nowej zachêty.
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
.SH B£ÊDY
Wszelkie b³êdy w pdksh nale¿y zg³aszaæ pod adres pdksh@cs.mun.ca.  
Proszê podaæ wersjê pdksh (echo $KSH_VERSION pokazuje j±), maszynê,
system operacyjny i stosowany kompilator oraz opis jak powtórzyæ dany b³±d
(najlepiej ma³y skrypt otoczki demonstruj±cy dany b³±d).  
Nastêpuj±ce mo¿e byæ równie¿ pomocne, je¶li ma znaczenie 
(je¶li nie jeste¶ pewny to podaj to równie¿): 
stosowane opcje (zarówno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo¿na otrzymaæ z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta otoczka powsta³a z publicznego klona 7-mego wydania otoczki
Bourne-a wykonwnego przez Charlesa Forsytha i z czê¶ci otoczki
BRL autorstwa Doug A.\& Gwyn, Doug Kingston,
Ron Natalie, Arnold Robbins, Lou Salkind i innych.  Pierwsze wydanie
pdksh stworzy³ Eric Gisin, a nastêpnie troszczyli siê ni± kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji ¼róde³ zawiera bardziej kompletn±
listê ludzi i ich wk³adu do rozwoju tej otoczki.
.PP
T³umaczenie tego podrêcznika na jêzyk Polski wykona³ Marcin Dalecki 
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "PATRZ RÓWNIE¯"
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
