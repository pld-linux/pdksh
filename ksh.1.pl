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
.TH KSH 1 "22 lutego 1999" "" "Komendy u¿ytkownika"
.\"}}}
.\"{{{  Name
.SH NAZWA
ksh \- Publiczna implementacja pow³oki Korna
.\"}}}
.\"{{{  Synopsis
.SH WYWO£ANIE
.ad l
\fBksh\fP
[\fB+-abCefhikmnprsuvxX\fP] [\fB+-o\fP \fIopcja\fP]
[ [ \fB\-c\fP \fI³añcuch_komend\fP [\fInazwa_komendy\fP]|\fB\-s\fP|\fIplik\fP ]
[\fIargument\fP ...] ]
.ad b
.\"}}}
.\"{{{  Description
.SH OPIS
\fBksh\fP to interpreter komend zaprojektowany zarówno
do interakcyjnej pracy z systemem, jak i do wykonywania skryptów.
Jego jêzyk komend jest nadzbiorem (superset) jêzyka pow³oki \fIsh\fP(1).
.\"{{{  Shell Startup
.SS "Uruchamianie pow³oki"
Nastêpuj±ce opcje mog± byæ u¿yte wy³±cznie w linii komend:
.IP "\fB\-c\fP \fI³añcuch_komend\fP"
pow³oka wykonuje komendê(y) zawart±(e) w \fI³añcuchu_komend\fP
.IP \fB\-i\fP
tryb interakcyjny \(em patrz poni¿ej
.IP \fB\-l\fP
pow³oka zameldowania \(em patrz poni¿ej
tryb interakcyjny \(em patrz poni¿ej
.IP \fB\-s\fP
pow³oka wczytuje komendy ze standardowego wej¶cia; wszelkie argumenty
nie bêd±ce opcjami s± argumentami pozycyjnymi
.IP \fB\-r\fP
tryb ograniczony \(em patrz poni¿ej
.PP
Ponadto wszelkie opcje, opisane w omówieniu wbudowanej
komend± \fBset\fP, mog± równie¿ zostaæ u¿yte w linii poleceñ.
.PP
Je¶li nie zosta³a podana ani opcja \fB\-c\fP, ani opcja \fB\-s\fP,
wówczas pierwszy argument nie bêd±cy opcj±, okre¶la
plik, z którego zostan± wczytane komendy. Je¶li brak jest argumentów
nie bêd±cych opcjami, to pow³oka wczytuje komendy ze standardowego
wej¶cia.
Nazwa pow³oki (tj. zawarto¶æ parametru \fB$0\fP)
jest ustalana jak nastêpuje: je¶li u¿yto opcji \fB\-c\fP
i podano argument nie bêd±cy opcj±, to jest on nazw±;
je¶li komendy s± wczytywane z pliku, wówczas nazwa tego pliku zostaje
u¿yta jako nazwa pow³oki; w ka¿dym innym przypadku zostaje u¿yta
nazwa, pod któr± pow³oka zosta³a wywo³ana
(tzn. warto¶æ argv[0]).
.PP
Pow³oka jest \fBinterakcyjna\fP, je¶li u¿yto opcji \fB\-i\fP
lub je¶li zarówno standardowe wej¶cie, jak i standardowe wyj¶cie b³êdów,
jest skojarzone z jakim¶ terminalem.
W interakcyjnej pow³oce kontrola zadañ (je¶li takowa jest dostêpna
w danym systemie) jest w³±czona oraz ignorowane s± nastêpuj±ce sygna³y:
INT, QUIT oraz TERM. Ponadto pow³oka wy¶wietla zachêtê przed
odczytywaniem poleceñ (patrz parametry \fBPS1\fP i \fBPS2\fP).
Dla nieinterakcyjnych pow³ok, uaktywnia siê domy¶lnie opcja \fBtrackall\fP
(patrz poni¿ej: komenda \fBset\fP).
.PP
Pow³oka jest \fBograniczona\fP, je¶li zastosowano opcjê \fB\-r\fP lub
gdy albo g³ówna czê¶æ nazwy (basename), pod jak± wywo³ano pow³okê, albo parametr
\fBSHELL\fP, pasuj± do wzorca *r*sh (na przyk³ad:
rsh, rksh, rpdksh itp.).
Po przetworzeniu przez pow³okê wszystkich plików profili i \fB$ENV\fR
w³±czane s± nastêpuj±ce ograniczenia:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
niedostêpna jest komenda \fBcd\fP
.IP \ \ \(bu
nie mog± byæ zmieniane parametry: \fBSHELL\fP, \fBENV\fP i \fBPATH\fP.
.IP \ \ \(bu
nazwy poleceñ nie mog± byæ podawane z u¿yciem ¶cie¿ek bezwzglêdnych lub
wzglêdnych [t³um.: tj. dostêpne s± tylko przez nazwê bez ¶cie¿ki]
.IP \ \ \(bu
niedostêpna jest opcja \fB\-p\fP wbudowanego polecenia \fBcommand\fP
.IP \ \ \(bu
nie mog± byæ u¿ywane przekierowania tworz±ce pliki
(np.: \fB>\fP, \fB>|\fP, \fB>>\fP, \fB<>\fP)
.nr PD \n(P2
.PP
Pow³oka jest \fBuprzywilejowana\fP, je¶li zastosowano opcjê \fB\-p\fP
lub je¶li rzeczywisty identyfikator u¿ytkownika lub jego grupy
nie jest zgodny z efektywnym identyfikatorem u¿ytkownika czy grupy
(patrz: \fIgetuid\fP(2), \fIgetgid\fP(2)).
Uprzywilejowana pow³oka nie przetwarza ani \fI$HOME/.profile\fR, ani parametru
\fBENV\fP (patrz poni¿ej), przetwarza za to plik \fI/etc/suid_profile\fR.
Wykasowanie opcji uprzywilejowania powoduje, ¿e pow³oka ustawia swój
efektywny identyfikator u¿ytkownika i grupy na warto¶ci faktycznego
identyfikatora u¿ytkownika (user-id) i jego grupy (group-id).
.PP
Je¶li g³ówna czê¶æ nazwy, pod jak± dana pow³oka zosta³a wywo³ana
(\fItzn.\fP argv[0])
zaczyna siê od \fB\-\fP lub u¿yto opcji \fB\-l\fP,
to zak³ada siê, ¿e pow³oka ma byæ pow³ok± zg³oszeniow± i wczytywana jest
zawarto¶æ plików \fI/etc/profile\fP i \fI$HOME/.profile\fP,
je¶li takie istniej± i mo¿na je odczytaæ.
.PP
Je¿eli parametr \fBENV\fR jest ustawiony podczas uruchamiania pow³oki
(albo w wypadku pow³ok zg³oszeniowych - po przetworzeniu
dowolnych plików profilowych), to jego zawarto¶æ zostaje
poddana zastêpowaniu.
Zastêpowane s± parametry, komendy, wyra¿enia arytmetyczne oraz tylda.
Nastêpnie wynikaj±ca z tej operacji nazwa jest
interpretowana jako nazwa pliku, podlegaj±cego wczytaniu i wykonaniu.
Je¶li parametr \fBENV\fP jest pusty (i niezerowy), a pdksh zosta³
skompilowany ze zdefiniowanym makrem \fBDEFAULT_ENV\fP,
to po wykonaniu wszelkich ju¿ wy¿ej wymienionych podstawieñ,
zostaje wczytany plik okre¶lony tym makrem.
.PP
Kod wyj¶cia pow³oki wynosi 127, je¶li plik komend
podany we linii wywo³ania nie móg³ zostaæ otwarty,
lub kod wyj¶cia jest niezerowy, je¶li wyst±pi³ krytyczny b³±d sk³adni
podczas wykonywania tego skryptu.
W razie braku b³êdów krytycznych, kod wyj¶cia jest równy kodowi ostatnio
wykonanej komendy lub zeru, je¶li nie wykonano ¿adnej komendy.
.\"}}}
.\"{{{  Command Syntax
.SS "Sk³adnia poleceñ"
.\"{{{  words and tokens
Pow³oka rozpoczyna analizê sk³adniow± wej¶cia od podzia³u go
na poszczególne s³owa \fIword\fP.
S³owa, stanowi±ce ci±gi znaków, ograniczane s± niecytowanymi
bia³ymi znakami \fIwhitespace\fP (spacja, tabulator i nowa linia)
lub \fImetaznakami\fP
(\fB<\fP, \fB>\fP, \fB|\fP, \fB;\fP, \fB&\fP, \fB(\fP i \fB)\fP).
Poza ograniczaniem s³ów spacje i tabulatory s± ignorowane.
Natomiast znaki zmiany linii zwykle rozgraniczaj± komendy.
Metaznaki stosowane s± do tworzenia nastêpuj±cych symboli:
\fB<\fP, \fB<&\fP, \fB<<\fP, \fB>\fP, \fB>&\fP, \fB>>\fP, \fIitd.\fP,
s³u¿±cych do okre¶lania przekierowañ (patrz: "Przekierowywanie
wej¶cia/wyj¶cia" poni¿ej);
\fB|\fP s³u¿y do tworzenia potoków;
\fB|&\fP s³u¿y do tworzenia koprocesów (patrz: "Koprocesy" poni¿ej);
\fB;\fP s³u¿y do oddzielania komend;
\fB&\fP s³u¿y do tworzenia potoków asynchronicznych;
\fB&&\fP i \fB||\fP s³u¿± do okre¶lenia wykonania warunkowego;
\fB;;\fP jest u¿ywany w poleceniach \fBcase\fP;
\fB((\fP .. \fB))\fP s± u¿ywane w wyra¿eniach arytmetycznych;
i w koñcu,
\fB(\fP .. \fB)\fP s³u¿± do tworzenia podpow³ok.
.PP
Bia³e znaki lub metaznaki mo¿na zacytowywaæ pojedynczo
przy u¿yciu znaku odwrotnego uko¶nika (\fB\e\fP) lub grupami w podwójnych
(\fB"\fP) lub pojedynczych (\fB'\fP) cudzys³owach.
Zauwa¿, i¿ nastêpuj±ce znaki podlegaj± równie¿
specjalnej interpretacji przez pow³okê i musz± byæ cytowane,
je¶li maj± byæ u¿yte dos³ownie:
\fB\e\fP, \fB"\fP, \fB'\fP, \fB#\fP, \fB$\fP, \fB`\fP, \fB~\fP, \fB{\fP,
\fB}\fP, \fB*\fP, \fB?\fP i \fB[\fP.
Pierwsze trzy to wy¿ej wspomniane symbole cytowania
(patrz: "Cytowanie" poni¿ej);
\fB#\fP, na pocz±tku s³owa rozpoczyna komentarz \(em wszystko po znaku
\fB#\fP, a¿ do koñca linii jest ignorowane;
\fB$\fP s³u¿y do wprowadzenia podstawienia parametru, komendy
lub wyra¿enia arytmetycznego (patrz: "Podstawienia" poni¿ej);
\fB`\fP rozpoczyna podstawienia komendy w starym stylu
(patrz: "Podstawienia" poni¿ej);
\fB~\fP rozpoczyna rozwiniêcie katalogu (patrz: "Rozwijanie tyld" poni¿ej);
\fB{\fP i \fB}\fP obejmuj± alternacje w stylu \fIcsh\fP(1)
(patrz: "Rozwijanie nawiasów" poni¿ej);
i na koniec, \fB*\fP, \fB?\fP oraz \fB[\fP s± stosowane przy tworzeniu
nazw plików (patrz: "Wzorce nazw plików" poni¿ej).
.\"}}}
.\"{{{  simple-command
.PP
W trakcie analizy s³ów i symboli, pow³oka tworzy komendy, których
wyró¿nia siê dwa rodzaje: \fIkomendy proste\fP, zwykle programy
do wykonania, oraz \fIkomendy z³o¿one\fP, takie jak dyrektywy \fBfor\fP i
\fBif\fP, struktury grupuj±ce i definicje funkcji.
.PP
Polecenie proste sk³ada siê z kombinacji przyporz±dkowañ warto¶ci
parametrom (patrz: "Parametry"), przekierowañ wej¶cia/wyj¶cia
(patrz: "Przekierowania wej¶cia/wyj¶cia") i s³ów komend;
Jedynym ograniczeniem jest to, ¿e wszelkie podstawienia warto¶ci
parametrów musz± wystêpowaæ przed s³owami komend.
S³owa komend, je¶li zosta³y podane, okre¶laj± polecenie, które
nale¿y wykonaæ, wraz z jego argumentami.
Komenda mo¿e byæ komend± wbudowan± pow³oki, funkcj± lub
\fIkomend± zewnêtrzn±\fP, \fItzn.\fP oddzielnym
plikiem wykonywalnym, który jest odnajdowany przy u¿yciu
warto¶ci parametru \fBPATH\fP (patrz: "Wykonywanie komend" poni¿ej).
Trzeba zauwa¿yæ, ¿e wszystkie komendy maj± swój
\fIkod zakoñczenia\fP: dla poleceñ zewnêtrznych jest on
powi±zany z kodem zwracanym przez \fIwait\fP(2) (je¶li
komenda nie zosta³a odnaleziona, wówczas kod wynosi 127,
natomiast je¶li nie mo¿na by³o jej wykonaæ, to kod wynosi 126).
Kody zwracane przez inne polecenia (komendy wbudowane,
funkcje, potoki, listy, itp.) s± precyzyjnie okre¶lone,
a ich opis towarzyszy opisowi danego konstruktu.
Kod wyj¶cia komendy zawieraj±cej jedynie przyporz±dkowania
warto¶ci parametrom, odpowiada kodowi ostatniego wykonanego podczas tego
podstawienia lub zeru, je¶li ¿adne podstawienia nie mia³y
miejsca.
.\"}}}
.\"{{{  pipeline
.PP
Przy pomocy symbolu \fB|\fP komendy mog± zostaæ powi±zane w \fIpotoki\fP.
W potokach standardowe wyj¶cie wszystkich komend poza ostatnim, zostaje
wyprowadzone (patrz \fIpipe\fP(2)) na standardowe wej¶cie nastêpnej komendy.
Kod wyj¶cia potoku jest równy kodowi zwróconemu przez ostatni± komendê
potoku.
Potok mo¿e zostaæ poprzedzony zarezerwowanym s³owem \fB!\fP,
powoduj±cym zmianê kodu wyj¶cia na jego logiczne przeciwieñstwo.
Tzn. je¶li pierwotnie kod wyj¶cia wynosi³ 0, to bêdzie on mia³ warto¶æ 1,
natomiast je¶li pierwotn± warto¶ci± nie by³o 0, to kodem przeciwstawnym
jest 0.
.\"}}}
.\"{{{  lists
.PP
\fIListê\fP komend tworzymy rozdzielaj±c potoki jednym z nastêpuj±cych symboli:
\fB&&\fP, \fB||\fP, \fB&\fP, \fB|&\fP i \fB;\fP.
Pierwsze dwa oznaczaj± warunkowe wykonanie: \fIcmd1\fP \fB&&\fP \fIcmd2\fP
wykonuje \fIcmd2\fP tylko wtedy, je¿eli kod wyj¶cia \fIcmd1\fP by³ zerowy.
Natomiast \fB||\fP zachowuje siê dok³adnie odwrotnie. \(em \fIcmd2\fP
zostaje wykonane jedynie, je¶li kod wyj¶cia \fIcmd1\fP by³
ró¿ny od zera.
\fB&&\fP i \fB||\fP wi±¿± równowa¿nie, a zarazem mocniej ni¿
\fB&\fP, \fB|&\fP i \fB;\fP, które z kolei równie¿ posiadaj± tê sam± si³ê
wi±zania.
Symbol \fB&\fP powoduje, ¿e poprzedzaj±ca go komenda zostanie wykonana
asynchronicznie, tzn. pow³oka uruchamia dan± komendê, jednak nie czeka na jej
zakoñczenie (pow³oka ¶ledzi dok³adnie wszystkie asynchroniczne
komendy \(em patrz: "Kontrola zadañ" poni¿ej).
Je¶li komenda asynchroniczna jest uruchomiona przy wy³±czonej
kontroli zadañ (tj. w wiêkszo¶ci skryptów),
wówczas jest ona uruchamiana z wy³±czonymi sygna³ami INT
i QUIT oraz przekierowanym wej¶ciem do /dev/null
(aczkolwiek przekierowania, ustalone w samej komendzie asynchronicznej
maj± tu pierwszeñstwo).
Operator \fB|&\fP rozpoczyna \fIkoproces\fP, stanowi±cy specjalnego
rodzaju komendê asynchroniczn± (patrz: "Koprocesy" poni¿ej).
Zauwa¿, ¿e po operatorach \fB&&\fP i \fB||\fP
musi wystêpowaæ komenda, podczas gdy nie jest to konieczne
po \fB&\fP, \fB|&\fP i \fB;\fP.
Kodem wyj¶cia listy komend jest kod ostatniego wykonanego w niej polecenia,
z wyj±tkiem list asynchronicznych, dla których kod wynosi 0.
.\"}}}
.\"{{{  compound-commands
.PP
Komendy z³o¿one tworzymy przy pomocy nastêpuj±cych s³ów zarezerwowanych
\(em s³owa te s± rozpoznane tylko wtedy, gdy nie s± zacytowane
i wystêpuj± jako pierwsze wyrazy w komendzie (tj. nie s± poprzedzone
¿adnymi przyporz±dkowywaniami warto¶ci parametrom czy przekierowaniami):
.TS
center;
lfB lfB lfB lfB lfB .
case	else	function	then	!
do	esac	if	time	[[
done	fi	in	until	{
elif	for	select	while	}
.TE
\fBUwaga:\fP Niektóre pow³oki (lecz nie nasza) wykonuj± polecenia steruj±ce
w podpow³oce, gdy przekierowano jeden lub wiêcej z ich deskryptorów plików,
tak wiêc wszelkiego rodzaju zmiany otoczenia w nich mog± nie dzia³aæ.
Aby zachowaæ przeno¶no¶æ nale¿y stosowaæ polecenie \fBexec\fP do
przekierowañ deskryptorów plików przed poleceniem steruj±cym.
.PP
W poni¿szym opisie poleceñ z³o¿onych, listy komend (zaznaczone przez
\fIlista\fP), po których nastêpuje s³owo zarezerwowane, musz± koñczyæ siê ¶rednikiem,
prze³amaniem wiersza lub (poprawnym gramatycznie) s³owem zarezerwowanym.
Przyk³adowo,
.RS
\fB{ echo foo; echo bar; }\fP
.br
\fB{ echo foo; echo bar<newline>}\fP
.br
\fB{ { echo foo; echo bar; } }\fP
.RE
s± poprawne, natomiast
.RS
\fB{ echo foo; echo bar }\fP
.RE
nie.
.\"{{{  ( list )
.IP "\fB(\fP \fIlista\fP \fB)\fP"
Wykonaj \fIlistê\fP w podpow³oce. Nie ma bezpo¶redniej mo¿liwo¶ci
przekazania warto¶ci parametrów podpow³oki z powrotem do jej
pow³oki macierzystej.
.\"}}}
.\"{{{  { list }
.IP "\fB{\fP \fIlista\fP \fB}\fP"
Konstrukcja z³o¿ona; \fIlista\fP zostaje wykonana, lecz nie w podpow³oce.
Zauwa¿, ¿e \fB{\fP i \fB}\fP to zarezerwowane s³owa, a nie
metaznaki.
.\"}}}
.\"{{{  case word in [ [ ( ] pattern [ | pattern ] ... ) list ;; ] ... esac
.IP "\fBcase\fP \fIs³owo\fP \fBin\fP [ [\fB(\fP] \fIwzorzec\fP [\fB|\fP \fIwzorzec\fP] ... \fB)\fP \fIlista\fP \fB;;\fP ] ... \fBesac\fP"
Wyra¿enie \fBcase\fP stara siê dopasowaæ \fIs³owo\fP do jednego
z danych \fIwzorców\fP; wykonywana jest \fIlista\fP powi±zana z pierwszym
poprawnie dopasowanym wzorcem.
Wzorce stosowane w wyra¿eniach \fBcase\fP odpowiadaj± wzorcom
stosowanym do specyfikacji nazw plików z wyj±tkiem tego, ¿e
nie obowi±zuj± ograniczenia zwi±zane z \fB\&.\fP i \fB/\fP.
Proszê zwróciæ uwagê na to, ¿e wszelkie niecytowane bia³e
znaki przed wzorcem i po nim zostaj± usuniête; wszelkie spacje we wzorcu
musz± byæ cytowane.  Zarówno s³owa, jak i wzorce podlegaj± podstawieniom
parametrów, rozwiniêciom arytmetycznym oraz podstawieniu tyldy.
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i
zamykaj±cy zamiast \fBin\fP i \fBesac\fP
(w szczególno¶ci wiêc, \fBcase $foo { *) echo bar; }\fP).
Kodem wyj¶cia wyra¿enia \fBcase\fP jest kod wykonanej
\fIlisty\fP; je¶li nie zosta³a wykonana ¿adna \fIlista\fP,
wówczas kod wyj¶cia wynosi zero.
.\"}}}
.\"{{{  for name [ in word ... term ] do list done
.IP "\fBfor\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest albo znakiem koñca linii, albo \fB;\fP.
Dla ka¿dego \fIs³owa\fP w podanej li¶cie s³ów, parameter \fInazwa\fP zostaje
ustawiony na to s³owo i \fIlista\fP zostaje wykonana. Je¿eli nie bêdzie u¿yte \fBin\fP
do specyfikacji listy s³ów, to zamiast tego zostan± u¿yte parametry
pozycyjne (\fB"$1"\fP, \fB"$2"\fP, \fIitp.\fP).
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i
zamykajacy zamiast \fBdo\fP i \fBdone\fP
(\fIw szczególno¶ci\fP, \fBfor i; { echo $i; }\fP).
Kodem wyj¶cia wyra¿enia \fBfor\fP jest ostatni kod wyj¶cia
danej \fIlisty\fP; je¶li \fIlista\fP nie zosta³a w ogóle
wykonana, wówczas kod wynosi zero.
.\"}}}
.\"{{{  if list then list [ elif list then list ] ... [ else list ] fi
.IP "\fBif\fP \fIlista\fP \fBthen\fP \fIlista\fP [\fBelif\fP \fIlista\fP \fBthen\fP \fIlista\fP] ... [\fBelse\fP \fIlista\fP] \fBfi\fP"
Je¶li kod wyj¶cia pierwszej \fIlisty\fP jest zerowy,
to zostaje wykonana druga \fIlista\fP; w przeciwnym razie, je¶li mamy takow±,
zostaje wykonana \fIlista\fP po \fBelif\fP, z podobnymi
konsekwencjami. Je¶li wszystkie listy po \fBif\fP
i \fBelif\fP wyka¿± b³±d (\fItzn.\fP zwróc± niezerowy kod), to zostanie wykonana
\fIlista\fP po \fBelse\fP.
Kodem wyj¶cia wyra¿enia \fBif\fP jest kod wykonanej \fIlisty\fP,
niestanowi±cej warunku. Je¶li ¿adna nieokre¶laj±ca warunku
\fIlista\fP nie zostanie wykonana, wówczas kod wyj¶cia wynosi zero.
.\"}}}
.\"{{{  select name [ in word ... ] do list done
.IP "\fBselect\fP \fInazwa\fP [ \fBin\fP \fIs³owo\fP ... \fIzakoñczenie\fP ] \fBdo\fP \fIlista\fP \fBdone\fP"
gdzie \fIzakoñczenie\fP jest albo prze³amaniem wiersza, albo \fB;\fP.
Wyra¿enie \fBselect\fP umo¿liwia automatyczn± prezentacjê u¿ytkownikowi
menu, wraz z mo¿liwo¶ci± wyboru z niego.
Przeliczona lista wykazanych \fIs³ów\fP zostaje wypisana na
standardowym wyj¶ciu b³êdów, po czym zostaje
wy¶wietlony symbol zachêty (\fBPS3\fP, czyli domy¶lnie `\fB#? \fP').
Nastêpnie zostaje wczytana liczba odpowiadaj±ca danemu punktowi
menu ze standardowego wej¶cia, po czym \fInazwie\fP
zostaje przyporz±dkowane w ten sposób wybrane s³owo (lub warto¶æ
pusta, je¿eli wybór by³ niew³a¶ciwy), zmiennej \fBREPLY\fP
zostaje przyporz±dkowane to, co zosta³o wczytane
(po usuniêciu pocz±tkowych i koñcowych bia³ych znaków),
i \fIlista\fP zostaje wykonana.
Je¶li wprowadzono pust± liniê (dok³adniej: zero lub wiêcej
znaczków \fBIFS\fP), wówczas menu zostaje ponownie wy¶wietlone, bez
wykonywania \fIlisty\fP.
Gdy wykonanie \fIlisty\fP zostaje zakoñczone,
wówczas przeliczona lista wyborów zostaje wy¶wietlona ponownie, je¶li
\fBREPLY\fP jest zerowe, ponownie wy¶wietlany jest symbol zachêty i tak dalej.
Proces ten siê powtarza, a¿ do wczytania znaku koñca pliku,
otrzymania sygna³u przerwania lub wykonania polecenia przerwania (break)
w ¶rodku pêtli.
Je¶li opuszczono \fBin\fP \fIs³owo\fP \fB\&...\fP, wówczas
u¿yte zostaj± parametry pozycyjne (\fItzn.\fP, \fB"$1"\fP, \fB"$2"\fP,
\fIitp.\fP).
Ze wzglêdów historycznych, mo¿emy zastosowaæ nawiasy otwieraj±cy i
zamykajacy zamiast \fBdo\fP i \fBdone\fP (\fIw szczególno¶ci\fP,
\fBselect i; { echo $i; }\fP).
Kodem wyj¶cia wyra¿enia \fBselect\fP jest zero, je¶li
u¿yto polecenia przerwania do wyj¶cia z pêtli albo
niezero w przeciwnym wypadku.
.\"}}}
.\"{{{  until list do list done
.IP "\fBuntil\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Dzia³a dok³adnie jak \fBwhile\fP, z wyj±tkiem tego, ¿e zawarto¶æ
pêtli jest wykonywana jedynie wtedy, gdy kod wyj¶cia pierwszej
\fIlisty\fP jest niezerowy.
.\"}}}
.\"{{{  while list do list done
.IP "\fBwhile\fP \fIlista\fP \fBdo\fP \fIlista\fP \fBdone\fP"
Wyra¿enie \fBwhile\fP okre¶la pêtlê o warunku sprawdzanym przed
wykonaniem. Zawarto¶æ pêtli jest wykonywana dopóki,
dopóty kod wyj¶cia pierwszej \fIlisty\fP jest zerowy.
Kodem wyj¶cia wyra¿enia \fBwhile\fP jest ostatni
kod wyj¶cia \fIlisty\fP w zawarto¶ci tej pêtli;
gdy zawarto¶æ nie zostanie w ogóle wykonana, wówczas kod wynosi zero.
.\"}}}
.\"{{{  function name { list }
.IP "\fBfunction\fP \fInazwa\fP \fB{\fP \fIlista\fP \fB}\fP"
Definiuje funkcjê o nazwie \fInazwa\fP.
Patrz: "Funkcje" poni¿ej.
Proszê zwróciæ uwagê, ¿e przekierowania tu¿ po definicji
funkcji zostaj± zastosowane podczas wykonywania jej zawarto¶ci,
a nie podczas przetwarzania jej definicji.
.\"}}}
.\"{{{  name () command
.IP "\fInazwa\fP \fB()\fP \fIpolecenie\fP"
Niemal dok³adnie to samo co w \fBfunction\fP.
Patrz: "Funkcje" poni¿ej.
.\"}}}
.\"{{{  (( expression ))
.IP "\fB((\fP \fIwyra¿enie\fP \fB))\fP"
Warto¶æ wyra¿enia arytmetycznego \fIwyra¿enie\fP zostaje przeliczona;
równowa¿ne do \fBlet "\fP\fIwyra¿enie\fP\fB"\fP.
patrz: "Wyra¿enia arytmetyczne" i opis polecenia \fBlet\fP poni¿ej..
.\"}}}
.\"{{{  [[ expression ]]
.IP "\fB[[\fP \fIexpression\fP \fB]]\fP"
Podobne do komend \fBtest\fP i \fB[\fP \&... \fB]\fP (które opisujemy
pó¼niej), z nastêpuj±cymi ró¿nicami:
.RS
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Rozdzielanie pól i generacja nazw plików nie s± wykonywane na
argumentach.
.IP \ \ \(bu
Operatory \fB\-a\fP (i) oraz \fB\-o\fP (lub) zostaj± zast±pione
odpowiednio przez \fB&&\fP i \fB||\fP.
.IP \ \ \(bu
Operatory (\fIdok³adniej\fP: \fB\-f\fP, \fB=\fP, \fB!\fP, \fIitp.\fP)
nie mog± byæ cytowane.
.IP \ \ \(bu
Drugi operand dla \fB!=\fP i \fB=\fP
jest traktowany jako wzorzec (\fIw szczególno¶ci\fP, porównanie
.ce
\fB[[ foobar = f*r ]]\fP
jest sukcesem).
.IP \ \ \(bu
Mamy do dyspozycji dwa dodatkowe operatory binarne: \fB<\fP i \fB>\fP,
które zwracaj± prawdê, gdy pierwszy ³añcuchowy operand jest odpowiednio
mniejszy lub wiêkszy od drugiego operandu ³añcuchowego.
.IP \ \ \(bu
Jednoargumentowa postaæ operacji \fBtest\fP,
która sprawdza, czy jedyny operand jest d³ugo¶ci zerowej, jest
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
\fB&&\fP i \fB||\fP stosowana jest metoda uproszczonego okre¶lania
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
.SS Cytowanie
Cytowanie stosuje siê do zapobiegania traktowaniu przez pow³okê pewnych
znaków czy s³ów w specjalny sposób.
Istniej± trzy metody cytowywania: Po pierwsze, \fB\e\fP cytuje
nastêpny znak, chyba ¿e mie¶ci siê on na koñcu wiersza, wówczas
zarówno \fB\e\fP jak i znak nowej linii zostaj± usuniête.
Po drugie pojedynczy cudzys³ów (\fB'\fP) wycytowywuje wszystko,
a¿ po nastêpny pojedynczy cudzys³ów (wraz ze zmianami linii w³±cznie).
Po trzecie, podwójny cudzys³ów (\fB"\fP) wycytowywuje wszystkie znaki,
poza \fB$\fP, \fB`\fP i \fB\e\fP, a¿ po nastêpny niecytowany podwójny
cudzys³ów.
\fB$\fP i \fB`\fP wewn±trz podwójnych cudzys³owów zachowuj± zwyk³e
znaczenie (tzn.
oznaczaj± podstawienie warto¶ci parametru, komendy lub wyra¿enia arytmetycznego),
je¶li tylko nie zostanie wykonany jakikolwiek podzia³ pól na
wyniku podwójnymi cudzys³owami wycytowanych podstawieñ.
Je¶li po \fB\e\fP, wewn±trz ci±gu znaków cytowanego podwójnymi cudzys³owami
nastêpuje \fB\e\fP, \fB$\fP,
\fB`\fP lub \fB"\fP, to zostaje on zast±piony drugim z tych znaków.
Je¶li po nim nastêpuje znak nowej linii, wówczas zarówno \fB\e\fP,
jak i znak zmiany linii zostaj± usuniête;
w przeciwnym razie zarówno znak \fB\e\fP, jak i nastêpuj±cy po nim znak
nie podlegaj± ¿adnej zamianie.
.PP
Uwaga: patrz "Tryb POSIX" poni¿ej pod wzglêdem szczególnych regu³
obowi±zuj±cych sekwencje znaków postaci
\fB"\fP...\fB`\fP...\fB\e"\fP...\fB`\fP..\fB"\fP.
.\"}}}
.\"{{{  Aliases
.SS "Aliasy"
Istniej± dwa rodzaje aliasów: normalne aliasy komend i
aliasy ¶ledzone. Aliasy komend stosowane s± zwykle jako
skróty dla d³ugich a czêsto stosowanych komend.
Pow³oka rozwija aliasy komend (\fItzn.\fP
podstawia pod nazwê aliasu jego zawarto¶æ), gdy wczytuje
pierwsze s³owo komendy.
Rozwiniêty alias zostaje ponownie przetworzony, aby uwzglêdniæ
ewentualne wystêpowanie dalszych aliasów.
Je¶li alias komendy koñczy siê spacj± lub tabulatorem, to wówczas
nastêpne s³owo zostaje równie¿ sprawdzone pod wzglêdem rozwiniêcia
aliasów. Proces rozwijania aliasów koñczy siê przy napotkaniu
s³owa, które nie jest aliasem, gdy napotka siê wycytowane s³owo,
lub gdy napotka siê alias, który jest w³a¶nie wyeksportowywany.
.PP
Nastêpuj±ce aliasy s± definiowane domy¶lnie przez pow³okê:
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
¦ledzone aliasy pozwalaj± pow³oce na zapamiêtanie, gdzie
odnalaz³a ona konkretn± komendê.
Gdy pow³oka po raz pierwszy szuka w ¶cie¿ce polcenia oznaczonego jako alias
¶ledzony, to zapamiêtuje sobie pe³n± ¶cie¿kê tej komendy.
Gdy pow³oka nastêpnie wykonuje dan± komendê po raz drugi,
wówczas sprawdza, czy ta ¶cie¿ka jest nadal aktualna i je¶li
tak jest, to nie przegl±da ju¿ wiêcej pe³nej ¶cie¿ki w poszukiwaniu
danej komendy.
¦ledzone aliasy mo¿na wy¶wietliæ lub stworzyæ stosuj±c \fBalias
\-t\fP. Zauwa¿, ¿e zmieniaj±c warto¶æ parametru \fBPATH\fP
czy¶cimy równie¿ ¶cie¿ki dla wszelkich ¶ledzonych aliasów.
Je¶li zosta³a w³±czona opcja \fBtrackall\fP (\fItzn.\fP,
\fBset \-o trackall\fP lub \fBset \-h\fP),
wówczas pow³oka ¶ledzi wszelkie komendy.
Ta opcja zostaje w³±czona domy¶lnie dla wszelkich
nieinterakcyjnych pow³ok.
Dla pow³ok interakcyjnych jedynie nastêpuj±ce komendy s±
¶ledzone domy¶lnie: \fBcat\fP, \fBcc\fP, \fBchmod\fP, \fBcp\fP,
\fBdate\fP, \fBed\fP,
\fBemacs\fP, \fBgrep\fP, \fBls\fP, \fBmail\fP, \fBmake\fP, \fBmv\fP,
\fBpr\fP, \fBrm\fP, \fBsed\fP, \fBsh\fP, \fBvi\fP i \fBwho\fP.
.\"}}}
.\"{{{  Substitution
.SS "Podstawienia"
Pierwszym krokiem, jaki wykonuje pow³oka podczas wykonywania
prostej komendy, jest przeprowadzenia podstawieñ na s³owach tej
komendy.
Istniej± trzy rodzaje podstawieñ: parametrów, komend i arytmetyczne.
Podstawienia parametrów, które dok³adniej opiszemy w nastêpnej sekcji,
maj± postaæ \fB$name\fP lub \fB${\fP...\fB}\fP;
podstawienia komend maj± postaæ \fB$(\fP\fIcommand\fP\fB)\fP lub
\fB`\fP\fIcommand\fP\fB`\fP;
a podstawienia arytmetyczne: \fB$((\fP\fIexpression\fP\fB))\fP.
.PP
Je¶li podstawienie wystêpuje poza podwójnymi cudzys³owami, wówczas
wynik tego podstawienia podlega zwykle podzia³owi s³ów lub pól, w zale¿no¶ci
od bie¿±cej warto¶ci parametru \fBIFS\fP.
Parametr \fBIFS\fP okre¶la listê znaków, s³u¿±cych jako separatory
w podziale ³añcuchów znakowych na pojedyncze wyrazy.
Wszelkie znaki z tego zestawu oraz tabulator, spacja i
nowa linia w³±cznie, nazywane s± \fIbia³ymi znakami IFS\fP.
Ci±gi jednego lub wielu bia³ych znaków z IFS w powi±zaniu
z zerem oraz jednym lub wiêcej bia³ych znaków nie wymienionych w IFS,
rozgraniczaj± pola.
Wyj±tkowo pocz±tkowe i koñcowe bia³e znaki IFS s± usuwane
(tzn. nie s± przez nie tworzone ¿adne pocz±tkowe czy koñcowe
puste pola); natomiast pocz±tkowe lub koñcowe bia³e znaki spoza IFS
tworz± puste pola.
Przyk³adowo: je¶li \fBIFS\fP zawiera `<spacja>:', to ci±g
znaków `<spacja>A<spacja>:<spacja><spacja>B::D' zawiera
cztery pola: `A', `B', `' i `D'.
Proszê zauwa¿yæ, ¿e je¶li parametr \fBIFS\fP
jest ustawiony na pusty ci±g znaków, to wówczas ¿aden podzia³ pól
nie ma miejsca; gdy parametr ten nie jest ustawiony w ogóle,
wówczas stosuje siê domy¶lnie jako rozgraniczniki
spacji, tabulatora i nowej linii.
.PP
Je¶li nie podajemy inaczej, to wynik podstawienia
podlega równie¿ rozwijaniu nawiasów i nazw plików (patrz odpowiednie
akapity poni¿ej).
.PP
Podstawienie komendy zostaje zast±pione wyj¶ciem, wygenerowanym
podczas wykonania danej komendy przez podpow³okê.
Dla podstawienia \fB$(\fP\fIkomenda\fP\fB)\fP zachodz± normalne
regu³y cytowania podczas analizy \fIkomendy\fP,
choæ jednak dla postaci \fB`\fP\fIkomenda\fP\fB`\fP, znak
\fB\e\fP z jednym z
\fB$\fP, \fB`\fP lub \fB\e\fP tu¿ po nim, zostaje usuniêty
(znak \fB\e\fP z nastêpstwem jakiegokolwiek innego znaku
zostaje niezmieniony).
Jako przypadek wyj±tkowy podczas podstawiania komend, komenda postaci
\fB<\fP \fIplik\fP  zostaje zinterpretowana, jako
oznaczaj±ca podstawienie zawarto¶ci pliku \fIplik\fP
($(< foo) ma wiêc ten sam efekt co $(cat foo), jest jednak bardziej
efektywne albowiem nie zostaje odpalony ¿aden dodatkowy proces).
.br
.\"todo: fix this( $(..) parenthesis counting).
UWAGA: Wyra¿enia \fB$(\fP\fIkomenda\fP\fB)\fP s± analizowane
obecnie poprzez odnajdywanie zaleg³ego nawiasu, niezale¿nie od
wycytowañ. Miejmy nadziejê, ¿e zostanie to mo¿liwie szybko poprawione.
.PP
Podstawienia arytmetyczne zostaj± zast±pione warto¶ci± wyniku
danego wyra¿enia.
Przyk³adowo wiêc, komenda \fBecho $((2+3*4))\fP wy¶wietla 14.
Patrz: "Wyra¿enia arytmetyczne", aby odnale¼æ opis \fIwyra¿eñ\fP.
.\"}}}
.\"{{{  Parameters
.SS "Parametry"
Parametry to zmienne w pow³oce; mo¿na im przyporz±dkowywaæ
warto¶ci oraz wyczytywaæ je przez podstawienia parametrów.
Nazwa parametru jest albo jednym ze znaków
interpunkcyjnych o specjalnym znaczeniu lub cyfr±, jakie opisujemy
poni¿ej, lub liter± z nastêpstwem jednej lub wiêcej liter albo cyfr
(`_' zalicza siê to liter).
Podstawienia parametrów maj± postaæ \fB$\fP\fInazwa\fP lub
\fB${\fP\fInazwa\fP\fB}\fP, gdzie \fInazwa\fP jest nazw±
danego parametru.
Gdy podstawienie zostanie wykonane na parametrze, który nie zosta³
ustalony, wówczas zerowy ci±g znaków jest jego wynikiem, chyba ¿e
zosta³a w³±czona opcja \fBnounset\fP (\fBset \-o nounset\fP
lub \fBset \-u\fP), co oznacza, ¿e wystêpuje wówczas b³±d.
.PP
.\"{{{  parameter assignment
Warto¶ci mo¿na przyporz±dkowywaæ parametrom na wiele ró¿nych sposobów.
Po pierwsze, pow³oka domy¶lnie ustala pewne parametry, takie jak
\fB#\fP, \fBPWD\fP, itp.; to jedyny sposób, w jaki s± ustawiane
specjalnymi paraetry o d³ugo¶ci jednego znaku. Po drugie, parametry zostaj±
importowane z otocznia pow³oki podczas jej uruchamiania. Po trzecie,
parametrom mo¿na przypisaæ warto¶ci w wierszu poleceñ, tak jak np.
`\fBFOO=bar\fP' przypisuje parametrowi FOO warto¶æ bar;
wielokrotne przypisania warto¶ci s± mo¿liwe w jednym wierszu komendy
i mo¿e po nich wystêpowaæ prosta komenda, co powoduje, ¿e
przypisania te s± wówczas jedynie aktualne podczas
wykonywania danej komendy (tego rodzaju przypisania
zostaj± równie¿ wyeksportowane, patrz poni¿ej, co do tego konsekwencji).
Proszê zwróciæ uwagê, i¿ aby pow³oka rozpozna³a je jako
przypisanie warto¶ci parametrowi, zarówno nazwa parametru jak i \fB=\fP
nie mog± byæ cytowane.
Czwartym sposobem ustawiania parametrów jest zastosowanie jednej
z komend: \fBexport\fP, \fBreadonly\fP lub \fBtypeset\fP;
patrz ich opisy w rozdziale "Wykonywanie komend".
Po czwarte, pêtle \fBfor\fP i \fBselect\fP ustawiaj± parametry,
tak jak i równie¿ komendy \fBgetopts\fP, \fBread\fP i \fBset \-A\fP.
Na zakoñczenie, parametrom mo¿na przyporz±dkowywaæ warto¶ci stosuj±c
operatory nadania warto¶ci wewn±trz wyra¿eñ arytmetycznych
(patrz: "Wyra¿enia arytmetyczne" poni¿ej) lub
stosuj±c postaæ \fB${\fP\fInazwa\fP\fB=\fP\fIwarto¶æ\fP\fB}\fP
podstawienia parametru (patrz poni¿ej).
.\"}}}
.PP
.\"{{{  environment
Parametry opatrzone atrybutem eksportowania
(ustawianego przy pomocy komendy \fBexport\fP lub
\fBtypeset \-x\fP albo przez przyporz±dkowanie warto¶ci
parametru z nastêpuj±c± prost± komend±)
zostaj± umieszczone w otoczeniu (patrz \fIenviron\fP(5)) poleceñ
wykonywanych przez pow³okê jako pary \fInazwa\fP\fB=\fP\fIwarto¶æ\fP.
Kolejno¶æ, w jakiej parametry wystêpuj± w otoczeniu komendy jest
bli¿ej nieustalona.
Podczas uruchamiania pow³oka pozyskuje parametry ze swojego
otoczenia
i automatycznie ustawia na tych parametrach atrybut eksportowania.
.\"}}}
.\"{{{  ${name[:][-+=?]word}
.PP
Mo¿na stosowaæ modyfikatory do postaci \fB${\fP\fInazwa\fP\fB}\fP
podstawienia parametru:
.IP \fB${\fP\fInazwa\fP\fB:-\fP\fIs³owo\fP\fB}\fP
je¿eli parametr\fInazwa\fP jest ustawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna
warto¶æ, w przeciwnym razie zostaje podstawione \fIs³owo\fP.
.IP \fB${\fP\fInazwa\fP\fB:+\fP\fIs³owo\fP\fB}\fP
je¶li parametr \fInazwa\fP jest ustawiony i niezerowy, wówczas zostaje podstawione
\fIs³owo\fP, inaczej nic nie zostaje podstawione.
.IP \fB${\fP\fInazwa\fP\fB:=\fP\fIs³owo\fP\fB}\fP
je¶li parametr \fInazwa\fP jest ustawiony i niezerowy, wówczas zostaje podstawiony
on sam, w przeciwnym razie zostaje mu przyporz±dkowana warto¶æ
\fIs³owo\fP i warto¶æ wynikaj±ca ze \fIs³owa\fP zostaje podstawiona.
.IP \fB${\fP\fInazwa\fP\fB:?\fP\fIs³owo\fP\fB}\fP
je¿eli parametr \fInazwa\fP jest ustawiony i niezerowy, wówczas zostaje
podstawiona jego w³asna warto¶æ, w przeciwnym razie \fIs³owo\fP
zostaje wy¶wietlone na standardowym wyj¶ciu b³êdów (tu¿ po \fInazwa\fP:)
i zachodzi b³±d
(powoduj±cy normalnie zakoñczenie ca³ego skryptu pow³oki, funkcji lub \&.-skryptu).
Je¶li s³owo zosta³o pominiête, wówczas zamiast niego zostaje u¿yty ³añcuch
`parameter null or not set'.
.PP
W powy¿szych modyfikatorach mo¿emy omin±æ \fB:\fP, czego skutkiem
bêdzie, ¿e warunki bêd± jedynie wymagaæ, aby
\fInazwa\fP by³ ustawiony lub nie (a nie ¿eby by³ ustawiony i niezerowy).
Je¶li potrzebna jest warto¶æ \fIs³owo\fP, wówczas zostaj± na nim wykonane
podstawienia parametrów, komend, arytmetyczne i tyldy;
natomiast, je¶li \fIs³owo\fP oka¿e siê niepotrzebne, wówczas jego
warto¶æ nie zostanie obliczana.
.\"}}}
.PP
Mo¿na stosowaæ, równie¿ podstawienia parametrów o nastêpuj±cej postaci:
.\"{{{  ${#name}
.IP \fB${#\fP\fInazwa\fP\fB}\fP
Liczba parametrów pozycyjnych, je¶li \fInazw±\fP jest \fB*\fP, \fB@\fP lub nie jest podana
albo d³ugo¶æ ci±gu bêd±cego warto¶ci± parametru \fInazwa\fP.
.\"}}}
.\"{{{  ${#name[*]}, ${#name[@]}
.IP "\fB${#\fP\fInazwa\fP\fB[*]}\fP, \fB${#\fP\fInazwa\fP\fB[@]}\fP"
Liczba elementów w tablicy \fInazwa\fP.
.\"}}}
.\"{{{  ${name#pattern}, ${name##pattern}
.IP "\fB${\fP\fInazwa\fP\fB#\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB##\fP\fIwzorzec\fP\fB}\fP"
Gdy \fIwzorzec\fP nak³ada siê na pocz±tek warto¶ci parametru \fInazwa\fP,
wówczas pasuj±cy tekst zostaje pominiêty w wynikaj±cym z tego podstawieniu.
Pojedynczy \fB#\fP oznacza najkrótsze mo¿liwe dopasowanie do wzorca, a
dwa \fB#\fP oznaczaj± jak najd³u¿sze dopasowanie.
.\"}}}
.\"{{{  ${name%pattern}, ${name%%pattern}
.IP "\fB${\fP\fInazwa\fP\fB%\fP\fIwzorzec\fP\fB}\fP, \fB${\fP\fInazwa\fP\fB%%\fP\fIwzorzec\fP\fB}\fP"
Podobnie jak w podstawieniu \fB${\fP..\fB#\fP..\fB}\fP, tylko ¿e dotyczy
koñca warto¶ci.
.\"}}}
.\"{{{  special shell parameters
.PP
Nastêpuj±ce specjalne parametry zostaj± ustawione domy¶lnie przez pow³okê
i nie mo¿na przyporz±dkowywaæ jawnie warto¶ci nadanych:
.\"{{{  !
.IP \fB!\fP
Id ostatniego uruchomionego w tle procesu. Je¶li nie ma aktualnie procesów
uruchomionych w tle, wówczas parametr ten jest nieustawiony.
.\"}}}
.\"{{{  #
.IP \fB#\fP
Liczba parametrów pozycyjnych (\fItzn.\fP, \fB$1\fP, \fB$2\fP,
\fIitp.\fP).
.\"}}}
.\"{{{  $
.IP \fB$\fP
ID procesu odpowiadaj±cego danej pow³oce lub PID pierwotnej pow³oki,
je¶li mamy do czynienia z podpow³ok±.
.\"}}}
.\"{{{  -
.IP \fB\-\fP
Konkatenacja bie¿±cych opcji jednoliterowych
(patrz komenda \fBset\fP poni¿ej, aby poznaæ dostêpne opcje).
.\"}}}
.\"{{{  ?
.IP \fB?\fP
Kod wyj¶cia ostatniej wykonanej komendy nieasynchronicznej.
Je¶li ostatnia komenda zosta³a zabita sygna³em, wówczas \fB$?\fP
przyjmuje warto¶æ 128 plus numer danego sygna³u.
.\"}}}
.\"{{{  0
.IP "\fB0\fP"
Nazwa, pod jak± dana pow³oka zosta³a wywo³ana (\fItzn.\fP, \fBargv[0]\fP), lub
\fBnazwa komendy\fP, która zosta³a wywo³ana przy u¿yciu opcji \fB\-c\fP
i \fBnazwa komendy\fP zosta³a podana, lub argument \fIplik\fP,
je¶li taki zosta³ podany.
Je¶li opcja \fBposix\fP nie jest ustawiona, to \fB$0\fP zawiera
nazwê bie¿±cej funkcji lub skryptu.
.\"}}}
.\"{{{  1-9
.IP "\fB1\fP ... \fB9\fP"
Pierwszych dziewiêæ parametrów pozycyjnych podanych pow³oce czy
funkcji lub \fB.\fP-skryptowi.
Dostêp do dalszych parametrów pozycyjnych odbywa siê przy pomocy
\fB${\fP\fIliczba\fP\fB}\fP.
.\"}}}
.\"{{{  *
.IP \fB*\fP
Wszystkie parametry pozycyjne (z wyj±tkiem parametru 0),
\fItzn.\fP, \fB$1 $2 $3\fP....
Gdy u¿yte poza podwójnymi cudzys³owami, wówczas parametry zostaj±
rozgraniczone w pojedyncze s³owa
(podlegaj±ce rozgraniczaniu s³ów); je¶li u¿yte pomiêdzy
podwójnymi cudzys³owami, wówczas parametry zostaj± rozgraniczone
pierwszym znakiem podanym przez parametr \fBIFS\fP
(albo pustymi ci±gami znaków, je¶li \fBIFS\fP jest zerowy).
.\"}}}
.\"{{{  @
.IP \fB@\fP
Tak jak \fB$*\fP, z wyj±tkiem zastosowania w podwójnych cudzys³owach,
gdzie oddzielne s³owo zostaje wygenerowane dla ka¿dego parametru
pozycyjnego z osobna \- je¶li brak parametrów pozycyjnych,
wówczas nie generowane jest ¿adne s³owo
("$@" mo¿e byæ u¿yte aby otrzymaæ dostêp bezpo¶redni do argumentów
bez utraty argumentów zerowych lub rozgraniczania ich przerwami).
.\"}}}
.\"}}}
.\"{{{  general shell parameters
.PP
Nastêpuj±ce parametry s± ustawiane przez pow³okê:
.\"{{{  _
.IP "\fB_\fP \fI(podkre¶lenie)\fP"
Gdy jaka¶ komenda zostaje wykonywana przez pow³okê, ten parametr przyjmuje
w otoczeniu odpowiedniego nowego procesu warto¶æ ¶cie¿ki tej komendy.
W interakcyjnym trybie pracy, ten parametr przyjmuje w pierwotnej pow³oce
ponadto warto¶æ ostatniego s³owa poprzedniej komendy
Podczas warto¶ciowania wiadomo¶ci typu \fBMAILPATH\fP,
parametr ten zawiera wiêc nazwê pliku, który siê zmieni³
(patrz parametr \fBMAILPATH\fP poni¿ej).
.\"}}}
.\"{{{  CDPATH
.IP \fBCDPATH\fP
¦cie¿ka przeszukiwania dla wbudowanej komendy \fBcd\fP.
Dzia³a tak samo jak
\fBPATH\fP dla katalogów nierozpoczynaj±cych siê od \fB/\fP
w komendach \fBcd\fP.
Proszê zwróciæ uwagê, ¿e je¶li CDPATH jest ustawiony i nie zawiera ani
\fB.\fP ani ¶cie¿ki pustej, to wówczas katalog bie¿±cy nie jest przeszukiwany.
.\"}}}
.\"{{{  COLUMNS
.IP \fBCOLUMNS\fP
Liczba kolumn terminala lub okienka.
Obecnie ustawiany warto¶ci± \fBcols\fP zwracan± przez komendê
\fIstty\fP(1), je¶li ta warto¶æ nie jest równa zeru.
Parametr ten ma znaczenie w interakcyjnym trybie edycji wiersza komendy
i dla komend \fBselect\fP, \fBset \-o\fP oraz \fBkill \-l\fP, w celu
w³a¶ciwego formatowania zwracanych informacji.
.\"}}}
.\"{{{  EDITOR
.IP \fBEDITOR\fP
Je¶li nie zosta³ ustawiony parametr \fBVISUAL\fP, wówczas kontroluje on
tryb edycji wiersza komendy w pow³okach interakcyjnych.
Patrz parametr \fBVISUAL\fP poni¿ej, aby siê dowiedzieæ, jak to dzia³a.
.\"}}}
.\"{{{  ENV
.IP \fBENV\fP
Je¶li parametr ten oka¿e siê byæ ustawionym po przetworzeniu
wszelkich plików profilowych, wówczas jego rozwiniêta warto¶æ zostaje
wykorzystana jako nazwa pliku zawieraj±cego dalsze komendy inicjalizacyjne
pow³oki. Zwykle zawiera definicje funkcji i aliasów.
.\"}}}
.\"{{{  ERRNO
.IP \fBERRNO\fP
Ca³kowita warto¶æ odpowiadaj±ca zmiennej errno pow³oki
\(em wskazuje przyczynê wyst±pienia b³êdu, gdy ostatnie wywo³anie
systemowe nie powiod³o siê.
.\" todo: ERRNO variable
.sp
Jak dotychczas niezaimplementowane.
.\"}}}
.\"{{{  EXECSHELL
.IP \fBEXECSHELL\fP
Je¶li ustawiono, to wówczas zawiera pow³okê, jakiej nale¿y u¿yæ
do wykonywania komend, których nie zdo³a³ wykonaæ \fIexecve\fP(2),
a które nie zaczynaj± siê od ci±gu `\fB#!\fP \fIpow³oka\fP'.
.\"}}}
.\"{{{  FCEDIT
.IP \fBFCEDIT\fP
Edytor u¿ywany przez komendê \fBfc\fP (patrz poni¿ej).
.\"}}}
.\"{{{  FPATH
.IP \fBFPATH\fP
Podobnie jak \fBPATH\fP, je¶li pow³oka natrafi na niezdefiniowan±
funkcjê podczas pracy, stosowane do lokalizacji pliku zawieraj±cego definicjê
tej funkcji.
Równie¿ przeszukiwane, gdy komenda nie zosta³a odnaleziona przy
u¿yciu \fBPATH\fP.
Patrz "Funkcje" poni¿ej co do dalszych informacji.
.\"}}}
.\"{{{  HISTFILE
.IP \fBHISTFILE\fP
Nazwa pliku u¿ywanego do zapisu historii komend.
Je¶li warto¶æ zosta³a ustalona, wówczas historia zostaje za³adowana
z danego pliku.
Podobnie wielokrotne wcielenia pow³oki bêd± korzysta³y z jednej
historii, je¶li dla nich warto¶ci parametru
\fBHISTFILE\fP wskazuje na jeden i ten sam plik.
.br
UWAGA: je¶li HISTFILE nie zosta³o ustawione, wówczas ¿aden plik historii
nie zostaje u¿yty. W oryginalnej wersji pow³oki
Korna natomiast, przyjmuje siê domy¶lnie \fB$HOME/.sh_history\fP;
w przysz³o¶ci mo¿e pdksh, bêdzie równie¿ stosowa³ domy¶lny
plik historii.
.\"}}}
.\"{{{  HISTSIZE
.IP \fBHISTSIZE\fP
Liczba komend zapamiêtywana w historii, domy¶lnie 128.
.\"}}}
.\"{{{  HOME
.IP \fBHOME\fP
Domy¶lna warto¶æ dla komendy \fBcd\fP oraz podstawiana pod
niewycytowane \fB~\fP (patrz: "Rozwijanie tyldy" poni¿ej).
.\"}}}
.\"{{{  IFS
.IP \fBIFS\fP
Wewnêtrzny separator pól, stosowany podczas podstawieñ
i wykonywania komendy \fBread\fP, do rozdzielania
warto¶ci na oddzielne argumenty; domy¶lnie spacja, tabulator i
prze³amanie wiersza. Szczegó³y zosta³y opisane w punkcie "Podstawienia"
powy¿ej.
.br
\fBUwaga:\fP ten parametr nie jest importowany z otoczenia,
podczas uruchamiania pow³oki.
.\"}}}
.\"{{{  KSH_VERSION
.IP \fBKSH_VERSION\fP
Wersja i data kompilacji pow³oki (tylko do odczytu).
Patrz równie¿ na komendy wersji w "Emacsowej interakcyjnej edycji wiersza
poleceñ" i "Edycji wiersza poleceñ vi" poni¿ej.
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
Jeszcze niezaimplementowane.
.\"}}}
.\"{{{  MAIL
.IP \fBMAIL\fP
Je¶li ustawiony, to u¿ytkownik jest informowany o nadej¶ciu nowej poczty
do wymienionego w tej opcji pliku docelowego.
Ten parametr jest ignorowany, je¶li zosta³ ustawiony parametr
\fBMAILPATH\fP.
.\"}}}
.\"{{{  MAILCHECK
.IP \fBMAILCHECK\fP
Jak czêsto pow³oka ma sprawdzaæ, czy pojawi³a siê nowa poczta
w plikach podanych przez \fBMAIL\fP lub \fBMAILPATH\fP.
Je¶li 0, to pow³oka sprawdza przed ka¿d± now± zachêt±.
Warto¶ci± domy¶ln± jest 600 (10 minut).
.\"}}}
.\"{{{  MAILPATH
.IP \fBMAILPATH\fP
Lista plików sprawdzanych w poszukiwaniu nowej poczty. Lista ta rozdzielana
jest dwukropkami, ponadto po nazwie ka¿dego z plików mo¿na podaæ
\fB?\fP i wiadomo¶æ, która ma byæ wy¶wietlona, je¶li nadesz³a nowa poczta.
Dla danej wiadomo¶ci zostan± wykonane podstawienia komend, parametrów
i arytmetyczne. Podczas podstawieñ parametr \fB$_\fP zawiera nazwê
tego pliku.
Domy¶lnym zawiadomieniem o nowej poczcie jest \fByou have mail in $_\fP
(\fBmasz pocztê w $_\fP).
.\"}}}
.\"{{{  OLDPWD
.IP \fBOLDPWD\fP
Poprzedni katalog roboczy.
Nieustalony, je¶li \fBcd\fP nie zmieni³o z powodzeniem
katalogu od czasu uruchomienia pow³oki lub je¶li pow³oka nie wie, gdzie
siê aktualnie znajduje.
.\"}}}
.\"{{{  OPTARG
.IP \fBOPTARG\fP
Podczas u¿ywania \fBgetopts\fP zawiera argument dla aktualnie
rozpoznawanej opcji, je¶li jest on oczekiwany.
.\"}}}
.\"{{{  OPTIND
.IP \fBOPTIND\fP
Indeks ostatniego przetworzonego argumentu podczas u¿ywania \fBgetopts\fP.
Przyporz±dkowanie 1 temu parametrowi spowoduje, ¿e ponownie wywo³ane
\fBgetopts\fP przetworzy argumenty od pocz±tku.
.\"}}}
.\"{{{  PATH
.IP \fBPATH\fP
Lista rodzielonych dwukropkiem katalogów, które s± przeszukiwane
podczas odnajdywania jakiej¶ komendy lub plików typu \fB.\fP. Pusty ³añcuch
wynikaj±cy z pocz±tkowego lub koñcowego dwukropka, albo dwóch s±siednich
dwukropków jest traktowany jako `.', czyli katalog bie¿±cy.
.\"}}}
.\"{{{  POSIXLY_CORRECT
.IP \fBPOSIXLY_CORRECT\fP
Ustawienie tego parametru powoduje w³±czenie opcji \fBposix\fP.
Patrz: "Tryb POSIX" poni¿ej.
.\"}}}
.\"{{{  PPID
.IP \fBPPID\fP
Identyfikator ID procesu rodzicielskiego pow³oki (tylko do odczytu).
.\"}}}
.\"{{{  PS1
.IP \fBPS1\fP
\fBPS1\fP to podstawowy symbol zachêty dla pow³ok interakcyjnych.
Podlega podstawieniom parametrów, komend i arytmetycznym, ponadto
\fB!\fP zostaje zast±pione kolejnym numerem polecenia
(patrz komenda \fBfc\fP
poni¿ej). Sam znak ! mo¿e zostaæ umieszczony w zachêcie u¿ywaj±c
!! w PS1.
Zauwa¿, ¿e poniewa¿ edytory wiersza komendy staraj± siê obliczyæ,
jak d³ugi jest symbol zachêty (aby móc ustaliæ, ile miejsca pozostaje
wolnego do prawego brzegu ekranu), sekwencje wyj¶ciowe w zachêcie
zwykle wprowadzaj± pewien ba³agan.
Istnieje mo¿liwo¶æ podpowiedzenia pow³oce, ¿eby nie uwzglêdnia³a
pewnych ci±gów znaków (takich jak kody wyj¶cia) przez podanie
przedrostka na pocz±tku symbolu zachêty bêd±cego niewy¶wietlalnym znakiem
(takim jak np. control-A) z nastêpstwem prze³amania wiersza
oraz odgraniczaj±c nastêpnie kody wyj¶cia przy pomocy tego
niewy¶wietlalnego znaku.
Gdy brak niewy¶wietlalnych znaków, to nie ma ¿adnej rady...
Nawiasem mówi±c, nie ja jestem odpowiedzialny za ten hack. To pochodzi
z oryginalnego ksh.
Domy¶ln± warto¶ci± jest `\fB$\ \fP' dla nieuprzywilejowanych
u¿ytkowników, a `\fB#\ \fP' dla roota..
.\"}}}
.\"{{{  PS2
.IP \fBPS2\fP
Drugorzêdna zachêta, o domy¶lnej warto¶ci `\fB>\fP ', która
jest stosowana, gdy wymagane s± dalsze wprowadzenia w celu
dokoñczenia komendy.
.\"}}}
.\"{{{  PS3
.IP \fBPS3\fP
Zachêta stosowana przez wyra¿enie
\fBselect\fP podczas wczytywania wyboru z menu.
Domy¶lnie `\fB#?\ \fP'.
.\"}}}
.\"{{{  PS4
.IP \fBPS4\fP
Stosowany jako przedrostek komend, które zostaj± wy¶wietlone podczas
¶ledzenia toku pracy
(patrz polcenie \fBset \-x\fP poni¿ej).
Domy¶lnie `\fB+\ \fP'.
.\"}}}
.\"{{{  PWD
.IP \fBPWD\fP
Obecny katalog roboczy. Mo¿e byæ nieustawiony lub zerowy, je¶li
pow³oka nie wie, gdzie siê znajduje.
.\"}}}
.\"{{{  RANDOM
.IP \fBRANDOM\fP
Prosty generator liczb pseudolosowych. Za ka¿dym razem, gdy
odnosimy siê do \fBRANDOM\fP, jego warto¶ci zostaje przyporz±dkowana
nastêpna liczba z przypadkowego ci±gu liczb.
Miejsce w danym ci±gu mo¿e zostaæ ustawione nadaj±c
warto¶æ \fBRANDOM\fP (patrz \fIrand\fP(3)).
.\"}}}
.\"{{{  REPLY
.IP \fBREPLY\fP
Domy¶lny parametr komendy
\fBread\fP, je¶li nie pozostan± podane jej ¿adne nazwy.
Stosowany równie¿ w pêtlach \fBselect\fP do zapisu warto¶ci
wczytywanej ze standardowego wej¶cia.
.\"}}}
.\"{{{  SECONDS
.IP \fBSECONDS\fP
Liczba sekund, które up³ynê³y od czasu uruchomienia pow³oki lub je¶li
parametrowi zosta³a nadana warto¶æ ca³kowita, liczba sekund od czasu
nadania tej warto¶ci plus ta warto¶æ.
.\"}}}
.\"{{{  TMOUT
.IP \fBTMOUT\fP
Gdy ustawiony na pozytywn± warto¶æ ca³kowit±, wiêksz± od zera,
wówczas ustala w interakcyjnej pow³oce czas w sekundach, przez jaki
bêdzie ona czeka³a na wprowadzenie jakiego¶ polecenia po wy¶wietleniu podstawowego symbolu
zachêty (\fBPS1\fP). Po przekroczeniu tego czasu pow³oka zakoñczy swoje dzia³anie.
.\"}}}
.\"{{{  TMPDIR
.IP \fBTMPDIR\fP
Katalog, w którym umieszczane s± tymczasowe pliki pow³oki.
Je¶li parametr ten nie jest ustawiony lub gdy nie zawiera
pe³nej ¶cie¿ki do zapisywalnego katalogu, wówczas domy¶lnie tymczasowe
pliki mieszcz± siê w \fB/tmp\fP.
.\"}}}
.\"{{{  VISUAL
.IP \fBVISUAL\fP
Je¶li zosta³ ustawiony, ustala tryb edycji wiersza komend w pow³okach
interakcyjnych. Je¶li ostatni element ¶cie¿ki podanej w tym
parametrze zawiera ci±g znaków \fBvi\fP, \fBemacs\fP lub \fBgmacs\fP,
to odpowiednio zostaje uaktywniony tryb edycji: vi, emacs lub gmacs
(Gosling emacs).
.\"}}}
.\"}}}
.\"}}}
.\"{{{  Tilde Expansion
.SS "Rozwijanie tyldy"
Rozwijanie znaków tyldy, które ma miejsce równolegle do podstawieñ parametrów,
zostaje wykonane na s³owach rozpoczynaj±cych siê niecytowanym
\fB~\fP. Znaki po tyldzie do pierwszego
\fB/\fP, je¶li taki wystêpuje, s± domy¶lnie traktowane jako
nazwa u¿ytkownika.  Je¶li nazwa u¿ytkownika jest pusta lub ma warto¶æ \fB+\fP albo \fB\-\fP,
to zostaj podstawiona warto¶æ parametrów odpowiednio\fBHOME\fP, \fBPWD\fP lub \fBOLDPWD\fP.
W przeciwnym razie zostaje
przeszukany plik hase³ (plik passwd) w celu odnalezienia danej nazwy
u¿ytkownika i w miejscu wyst±pienia tyldy zostaje
podstawiony katalog domowy danego u¿ytkownika.
Je¶li nazwa u¿ytkownika nie zostanie odnaleziona w pliku hase³
lub gdy w nazwie u¿ytkownika wystepuje jakiekolwiek cytowanie albo podstawienie
parametru, wówczas nie zostaje wykonane ¿adne
podstawienie.
.PP
W ustawieniach parametrów
(tych poprzedzaj±cych proste komendy lub tych wystêpuj±cych w argumentach
dla \fBalias\fP, \fBexport\fP, \fBreadonly\fP,
i \fBtypeset\fP), rozwijanie znaków tyld zostaje wykonywane po
jakimkolwiek niewycytowanym (\fB:\fP) i nazwy u¿ytkowników zostaj± ujête
w dwukropki.
.PP
Katalogi domowe poprzednio rozwiniêtych nazw u¿ytkowników zostaj±
umieszczone w pamiêci podrêcznej i przy ponownym u¿yciu zostaj± stamt±d
pobierane. Komenda \fBalias \-d\fP mo¿e byæ u¿yta do wylistowania,
zmiany i dodania do tej pamiêci podrêcznej
(\fIw szczególno¶ci\fP, `alias \-d fac=/usr/local/facilities; cd
~fac/bin').
.\"}}}
.\"{{{  Brace Expansion
.SS "Rozwijanie nawiasów (przemiany)"
Rozwiniêcia nawiasów przyjmuj±ce postaæ
.RS
\fIprefiks\fP\fB{\fP\fIci±g\fP1\fB,\fP...\fB,\fP\fIci±g\fPN\fB}\fP\fIsufiks\fP
.RE
zostaj± rozwiniête w N wyrazów, z których ka¿dy zawiera konkatenacjê
\fIprefiks\fP, \fIci±g\fPn i \fIsufiks\fP
(\fIw szczególno¶ci.\fP, `a{c,b{X,Y},d}e' zostaje rozwiniête do czterech wyrazów:
ace, abXe, abYe i ade).
Jak ju¿ wy¿ej wspomniano, rozwiniêcia nawiasów mog± byæ nak³adane na siebie,
a wynikaj±ce s³owa nie s± sortowane.
Wyra¿enia nawiasowe musz± zawieraæ niecytowany przecinek
(\fB,\fP), aby nastêpi³o rozwijanie
(\fItak wiêc\fP \fB{}\fP i \fB{foo}\fP nie zostaj± rozwiniête).
Rozwiniêcie nawiasów nastêpuje po podstawieniach parametrów i przed
generowaniem nazw plików.
.\"}}}
.\"{{{  File Name Patterns
.SS "Wzorce nazw plików"
.PP
Wzorcem nazwy pliku jest s³owo zwieraj±ce jeden lub wiêcej z
niecytowanych symboli \fB?\fP lub
\fB*\fP lub sekwencji \fB[\fP..\fB]\fP.
Po wykonaniu rozwiniêcia nawiasów, pow³oka zamienia wzorce nazw plików
na uporz±dkowane nazwy plików, które pasuj± do tego wzorca
(je¶li ¿adne pliki nie pasuj±, wówczas dane s³owo zostaje pozostawione
bez zmian). Elementy wzorców maj± nastêpuj±ce znaczenia:
.IP \fB?\fP
oznacza dowolny pojedynczy znak.
.IP \fB*\fP
oznacza dowoln± sekwencjê znaków.
.IP \fB[\fP..\fB]\fP
oznacza ka¿dy ze znaków pomiêdzy klamrami. Mo¿na podaæ zakresy znaków
u¿ywaj±c \fB\-\fP pomiêdzy dwoma ograniczaj±cymi zakres znakami, tzn.
\fB[a0\-9]\fP oznacza literê \fBa\fP lub dowoln± cyfrê.
Aby przedstawiæ sam znak
\fB\-\fP nale¿y go albo zacytowaæ albo musi byæ to pierwszy lub ostatni znak
w li¶cie znaków. Podobnie \fB]\fP musi albo byæ wycytowywane, albo byæ pierwszym
lub ostatnim znakiem w li¶cie, je¶li ma oznaczaæ samego siebie, a nie zakoñczenie
listy. Równie¿ \fB!\fP wystêpuj±cy na pocz±tku listy ma specjalne
znaczenie (patrz poni¿ej), tak wiêc aby reprezentowa³ samego siebie
musi zostaæ wycytowany lub wystêpowaæ dalej w li¶cie.
.IP \fB[!\fP..\fB]\fP
podobnie jak \fB[\fP..\fB]\fP, tylko ¿e oznacza dowolny znak
niewystêpuj±cy pomiêdzy klamrami.
.IP "\fB*(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
oznacza ka¿dy ci±g zawieraj±cy zero lub wiêcej wyst±pieñ podanych wzorców.
Przyk³adowo: wzorzec \fB*(foo|bar)\fP obejmuje ci±gi
`', `foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB+(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ka¿dy ci±g znaków obejmuj±cy jedno lub wiêcej wyst±pieñ danych
wzorców.
Przyk³adowo: wzorzec \fB+(foo|bar)\fP obejmuje ci±gi
`foo', `bar', `foobarfoo', \fIitp.\fP.
.IP "\fB?(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
oznacza ci±g pusty lub ci±g obejmuj±cy jeden z danych wzorców.
Przyk³adowo: wzorzec \fB?(foo|bar)\fP obejmuje jedynie ci±gi
`', `foo' i `bar'.
.IP "\fB@(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje ci±g obejmuj±cy jeden z podanych wzorców.
Przyk³adowo: wzorzec \fB@(foo|bar)\fP obejmuje wy³±cznie ci±gi
`foo' i `bar'.
.IP "\fB!(\fP\fIwzorzec\fP\fB|\fP ... \fP|\fP\fIwzorzec\fP\fB)\fP"
obejmuje dowolny ci±g nie obejmuj±cy ¿adnego z danych wzorców.
Przyk³adowo: wzorzec \fB!(foo|bar)\fP obejmuje wszystkie ci±gi poza
`foo' i `bar'; wzorzec \fB!(*)\fP nie obejmuje ¿adnego ci±gu;
wzorzec \fB!(?)*\fP obejmuje wszystkie ci±gi (proszê siê nad tym zastanowiæ).
.PP
Proszê zauwa¿yæ, ¿e wzorce w pdksh obecnie nigdy nie obejmuj± \fB.\fP i
\fB..\fP, w przeciwieñstwie do oryginalnej pow³oki
ksh, Bourne'a sh i basha, tak wiêc to bêdzie musia³o siê ewentualnie
zmieniæ (na z³e).
.PP
Proszê zauwa¿yæ, ¿e powy¿sze elementy wzorców nigdy nie obejmuj± kropki
(\fB.\fP) na pocz±tku nazwy pliku ani uko¶nika (\fB/\fP),
nawet gdy zosta³y one podane jawnie w sekwencji
\fB[\fP..\fB]\fP; ponadto nazwy \fB.\fP i \fB..\fP
nigdy nie s± obejmowane, nawet poprzez wzorzec \fB.*\fP.
.PP
Je¶li zosta³a ustawiona opcja \fBmarkdirs\fP, wówczas,
wszelkie katalogi wynikaj±ce z generacji nazw plików
zostaj± oznaczone koñcz±cym \fB/\fP.
.PP
.\" todo: implement this ([[:alpha:]], \fIetc.\fP)
POSIX-owe klasy znaków (\fItzn.\fP,
\fB[:\fP\fInazwa_klasy\fP\fB:]\fP wewn±trz wyra¿enia typu \fB[\fP..\fB]\fP)
jak na razie nie zosta³y zaimplementowane.
.\"}}}
.\"{{{  Input/Output Redirection
.SS "Przekierowanie wej¶cia/wyj¶cia"
Podczas wykonywania komendy, jej standardowe wej¶cie, standardowe wyj¶cie
i standardowe wyj¶cie b³êdów (odpowiednio deskryptory plików 0, 1 i 2)
s± zwykle dziedziczone po pow³oce.
Trzema wyj±tkami od tej regu³y s± komendy w potokach, dla których
standardowe wej¶cie i/lub standardowe wyj¶cie odpowiadaj± tym, ustalonym przez
potok, komendy asychroniczne, tworzone je¶li kontrola prac zosta³a
wy³±czona, których standardowe wej¶cie zostaje ustawione na
\fB/dev/null\fP, oraz komendy, dla których zosta³o ustawione jedno lub
kilka z nastêpuj±cych przekierowañ:
.IP "\fB>\fP \fIplik\fP"
Standardowe wyj¶cie zostaje przekierowane do \fIplik\fP-u.
Je¶li \fIplik\fP nie istnieje, wówczas zostaje utworzony;
je¶li istnieje i jest to regularny plik oraz zosta³a ustawiona
opcja \fBnoclobber\fP, wówczas wystêpuje b³±d, w przeciwnym razie
dany plik zostaje uciêty do pocz±tku.
Proszê zwróciæ uwagê, i¿ oznacza to, ¿e komenda \fIjaka¶_komenda < foo > foo\fP
otworzy plik \fIfoo\fP do odczytu, a nastêpnie
skasuje jego zawarto¶æ, gdy otworzy go do zapisu,
zanim \fIjaka¶_komenda\fP otrzyma szansê przeczytania czegokolwiek z \fIfoo\fP.
.IP "\fB>|\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e zawarto¶æ pliku zostanie skasowana
niezale¿nie od ustawienia opcji \fBnoclobber\fP.
.IP "\fB>>\fP \fIplik\fP"
tak jak dla \fB>\fP, tylko ¿e je¶li dany plik ju¿ istnieje, to
nowe dane bêd± dopisywane do niego, zamiast kasowania poprzedniej jego zawarto¶ci.
Ponadto plik ten zostaje otwarty w trybie dopisywania, tak wiêc
wszelkiego rodzaju operacje zapisu na nim dotycz± jego aktualnego koñca.
(patrz \fIopen\fP(2)).
.IP "\fB<\fP \fIplik\fP"
standardowe wej¶cie zostaje przekierowane do \fIplik\fPu,
który jest otwierany w trybie do odczytu.
.IP "\fB<>\fP \fIplik\fP"
tak jak dla \fB<\fP, tylko ¿e plik zostaje otworzony w trybie
zapisu i czytania.
.IP "\fB<<\fP \fIznacznik\fP"
po wczytaniu wiersza komendy zawieraj±cego tego rodzaju przekierowanie
(zwane tu-dokumentem), pow³oka kopiuje wiersze z komendy
do tymczasowego pliku, a¿ do natrafienia na wiersz
odpowiadaj±cy \fIznacznik\fPowi.
Podczas wykonywania polecenia jego standardowe wej¶cie jest przekierowane
do pewnego pliku tymczasowego.
Je¶li \fIznacznik\fP nie zawiera wycytowanych znaków, zawarto¶æ danego
pliku tymczasowego zostaje przetworzona tak, jakby zawiera³a siê w
podwójnych cudzys³owach za ka¿dym razem, gdy dana komenda jest wykonywana.
Tak wiêc zostan± na nim wykonane podstawienia parametrów,
komend i arytmetyczne wraz z interpretacj± odwrotnego uko¶nika
(\fB\e\fP) i znaków wyj¶æ dla \fB$\fP, \fB`\fP, \fB\e\fP i \fB\enowa_linia\fP.
Je¶li wiele tu-dokumentów zostanie zastosowanych w jednym i tym samym
wierszy komendy, to s± one zachowane w podanej kolejno¶ci.
.IP "\fB<<-\fP \fIznacznik\fP"
tak jak dla \fB<<\fP, tylko ¿e pocz±tkowe tabulatory
zostaj± usuniête z tu-dokumentu.
.IP "\fB<&\fP \fIfd\fP"
standardowe wej¶cie zostaje powielone z deskryptora pliku \fIfd\fP.
\fIfd\fP mo¿e byæ pojedyncz± cyfr±, wskazuj±c± na numer
istniej±cego deskryptora pliku, liter±  \fBp\fP, wskazuj±c± na plik
powi±zany w wyj¶ciem obecnego koprocesu, lub
znakiem \fB\-\fP, wskazuj±cym, ¿e standardowe wej¶cie powinno zostaæ
zamkniête.
.IP "\fB>&\fP \fIfd\fP"
tak jak dla \fB<&\fP, tylko ¿e operacja dotyczy standardowego wyj¶cia.
.PP
W ka¿dym z powy¿szych przekierowañ, mo¿na podaæ jawnie deskryptor
pliku, którego ma ono dotyczyæ, (\fItzn.\fP standardowego wej¶cia
lub standardowego wyj¶cia) przez poprzedzaj±c± odpowiedni± pojedyncz± cyfrê.
Podstawienia parametrów komend, arytmetyczne, tyld, tak jak i
(gdy pow³oka jest interakcyjna) generacje nazw plików -
zostan± wykonane na argumentach przekierowañ \fIplik\fP, \fIznacznik\fP
i \fIfd\fP.
Trzeba jednak zauwa¿yæ, ¿e wyniki wszelkiego rodzaju generowania nazw
plików zostan± u¿yte tylko wtedy, gdy okre¶laj± nazwê jednego pliku;
je¶li natomiast obejmuj± one wiele plików, wówczas zostaje zastosowane
dane s³owo bez rozwiniêæ wynikaj±cych z generacji nazw plików.
Proszê zwróciæ uwagê, ¿e w pow³okach ograniczonych,
przekierowania tworz±ce nowe pliki nie mog± byæ stosowane.
.PP
Dla prostych poleceñ, przekierowania mog± wystêpowaæ w dowolnym miejscu
komendy, w komendach z³o¿onych (wyra¿eniach \fBif\fP, \fIitp.\fP),
wszelkie przekierowania musz± znajdowaæ siê na koñcu.
Przekierowania s± przetwarzane po tworzeniu potoków i w kolejno¶ci,
w jakiej zosta³y podane, tak wiêc
.RS
\fBcat /foo/bar 2>&1 > /dev/null | cat \-n\fP
.RE
wy¶wietli b³±d z numerem linii wiersza poprzedzaj±cym go.
.\"}}}
.\"{{{  Arithmetic Expressions
.SS "Wyra¿enia arytmetyczne"
Ca³kowite wyra¿enia arytmetyczne mog± byæ stosowane przy pomocy
komendy \fBlet\fP, wewn±trz wyra¿eñ \fB$((\fP..\fB))\fP,
wewn±trz odwo³añ do tablic (\fIw szczególno¶ci\fP,
\fInazwa\fP\fB[\fP\fIwyra¿enie\fP\fB]\fP),
jako numeryczne argumenty komendy \fBtest\fP,
i jako warto¶ci w przyporz±dkowywaniach do ca³kowitych parametrów.
.PP
Wyra¿enia mog± zawieraæ alfanumeryczne identyfikatory parametrów,
odwo³ania do tablic i ca³kowite sta³e. Mog± zostaæ równie¿
po³±czone nastêpuj±cymi operatorami jêzyka C:
(wymienione i zgrupowane w kolejno¶ci rosn±cego
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
\fB?:\fP (priorytet jest bezpo¶rednio wy¿szy od przyporz±dkowania)
.TP
Operatory grupuj±ce:
\fB( )\fP
.PP
Sta³e ca³kowite mog± byæ podane w dowolnej bazie, stosuj±c notacjê
\fIbaza\fP\fB#\fP\fIliczba\fP, gdzie \fIbaza\fP jest dziesiêtn± liczb±
ca³kowit± specyfikuj±c± bazê, a \fIliczba\fP jest liczb±
zapisan± w danej bazie.
.LP
Operatory s± wyliczane w nastêpuj±cy sposób:
.RS
.IP "unarny \fB+\fP"
wynikiem jest argument (podane wy³±cznie dla pe³no¶ci opisu).
.IP "unary \fB\-\fP"
negacja.
.IP "\fB!\fP"
logiczna negacja; wynikiem jest 1 je¶li argument jest zerowy, a 0 je¶li nie.
.IP "\fB~\fP"
arytmetyczna negacja (bit-w-bit).
.IP "\fB++\fP"
inkrement; musi byæ zastosowanym do parametru (a nie litera³u lub
innego wyra¿enia) - parametr zostaje powiêkszony o 1.
Je¶li zosta³ zastosowany jako operator przedrostkowy, wówczas wynikiem jest
inkrementowana warto¶æ parametru, a je¶li zosta³ zastosowany jako
operator przyrostkowy, to wynikiem jest pierwotna warto¶æ parametru.
.IP "\fB--\fP"
podobnie do \fB++\fP, tylko ¿e wynikiem jest zmniejszenie parametru o 1.
.IP "\fB,\fP"
Rozdziela dwa wyra¿enia arytmetyczne; lewa strona zostaje wyliczona
jako pierwsza, a nastêpnie prawa strona. Wynikiem jest warto¶æ
wyra¿enia po prawej stronie.
.IP "\fB=\fP"
przyporz±dkowanie; zmiennej po lewej zostaje nadana warto¶æ po prawej.
.IP "\fB*= /= %= += \-= <<= >>= &= ^= |=\fP"
operatory przyporz±dkowania; \fI<var> <op>\fP\fB=\fP \fI<expr>\fP
jest tym samym co
\fI<var>\fP \fB=\fP \fI<var> <op>\fP \fB(\fP \fI<expr>\fP \fB)\fP.
.IP "\fB||\fP"
logiczna alternatywa; wynikiem jest 1 je¶li przynajmniej jeden
z argumentów jest niezerowy, 0 gdy nie.
Argument po prawej zostaje wyliczony jedynie, gdy argument po lewej
jest zerowy.
.IP "\fB&&\fP"
logiczna koniunkcja; wynikiem jest 1 je¶li obydwa argumenty s± niezerowe,
0 gdy nie.
Prawy argument zostaje wyliczony jedynie, gdy lewy jest niezerowy.
.IP "\fB|\fP"
arytmetyczna alternatywa (bit-w-bit).
.IP "\fB^\fP"
arytmetyczne albo (bit-w-bit).
.IP "\fB&\fP"
arytmetyczna koniunkcja (bit-w-bit).
.IP "\fB==\fP"
równo¶æ; wynikiem jest 1, je¶li obydwa argumenty s± sobie równe, 0 gdy nie.
.IP "\fB!=\fP"
nierówno¶æ; wynikiem jest 0, je¶li obydwa argumenty s± sobie równe, 1 gdy nie.
.IP "\fB<\fP"
mniejsze od; wynikiem jest 1, je¶li lewy argument jest mniejszy od prawego,
0 gdy nie.
.IP "\fB<= >= >\fP"
mniejsze lub równe, wiêksze lub równe, wiêksze od. Patrz <.
.IP "\fB<< >>\fP"
przesuñ w lewo (prawo); wynikiem jest lewy argument z bitami przesuniêtymi
na lewo (prawo) o liczbê pól podan± w prawym argumencie.
.IP "\fB+ - * /\fP"
suma, ró¿nica, iloczyn i iloraz.
.IP "\fB%\fP"
reszta; wynikiem jest reszta z dzielenia lewego argumentu przez prawy.
Znak wyniku jest nieustalony, je¶li który¶ z argumentów jest ujemny.
.IP "\fI<arg1>\fP \fB?\fP \fI<arg2>\fP \fB:\fP \fI<arg3>\fP"
je¶li \fI<arg1>\fP jest niezerowy, to wynikiem jest \fI<arg2>\fP,
w przeciwnym razie \fI<arg3>\fP.
.RE
.\"}}}
.\"{{{  Co-Processes
.SS "Koprocesy"
Koproces to potok stworzony poprzez operator \fB|&\fP,
który jest procesemy asynchronicznym, do którego pow³oka mo¿e
zarówno pisaæ (u¿ywaj±c \fBprint \-p\fP), jak i czytaæ (u¿ywaj±c \fBread \-p\fP).
Wej¶ciem i wyj¶ciem koprocesu mo¿na równie¿ manipulowaæ
przy pomocy przekierowañ \fB>&p\fP i odpowiednio \fB<&p\fP.
Po uruchomieniu koprocesu, nastêpne nie mog± byæ uruchomione dopóki
dany koproces nie zakoñczy pracy lub dopóki wej¶cie koprocesu
nie zostanie przekierowane przez \fBexec \fP\fIn\fP\fB>&p\fP.
Je¶li wej¶cie koprocesu zostanie przekierowane w ten sposób, to
nastêpny w kolejce do uruchomienia koproces bêdzie
wspó³dzieli³ wyj¶cie z pierwszym koprocesem, chyba ¿e wyj¶cie pierwszego
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
deskryptora (w szczególno¶ci, \fBexec 3>&p;exec 3>&-\fP).
.IP \ \ \(bu
aby koprocesy mog³y wspó³dzieliæ jedno wyj¶cie, pow³oka musi
zachowaæ otwart± czê¶æ wpisow± danego potoku wyj¶ciowego.
Oznacza to, ¿e zakoñczenie pliku nie zostanie wykryte do czasu, a¿
wszystkie koprocesy wspó³dziel±ce wyj¶cie  zostan± zakoñczone
(gdy zostan± one zakoñczone, wówczas  pow³oka zamyka swoj± kopiê
potoku).
Mo¿na temu zapobiec przekierowuj±c wyj¶cie na numerowany
deskryptor pliku
(poniewa¿ powoduje to równie¿ zamkniêcie przez pow³okê swojej kopii).
Proszê zwróciæ uwagê, i¿ to zachowanie  jest nieco odmienne od oryginalnej
pow³oki Korna, która zamyka czê¶æ zapisow± swojej kopii wyj¶cia
koprocesu, gdy ostatnio uruchomiony koproces
(zamiast gdy wszystkie wspó³dziel±ce koprocesy) zostanie zakoñczony.
.IP \ \ \(bu
\fBprint \-p\fP ignoruje sygna³ SIGPIPE podczas zapisu, je¶li
dany sygna³ nie zosta³ przechwycony lub zignorowany; nie zachodzi to jednak,
gdy wej¶cie koprocesu zosta³o powielone na inny deskryptor pliku
i stosowane jest \fBprint \-u\fP\fIn\fP.
.nr PD \n(P2
.\"}}}
.\"{{{  Functions
.SS "Funkcje"
Funkcje definiuje siê albo przy pomocy syntaktyki pow³oki
Korna \fBfunction\fP \fIname\fP,
albo syntaktyki pow³oki Bourne'a/POSIX-owej: \fIname\fP\fB()\fP
(patrz poni¿ej, co do ró¿nic zachodz±cych pomiêdzy tymi dwiema formami).
Funkcje, tak jak i \fB.\fP-skrypty, s± wykonywane w bie¿±cym
otoczeniu, aczkolwiek, w przeciwieñstwie do \fB.\fP-skryptów,
argumenty pow³oki
(\fItzn.\fP argumenty pozycyjne, \fB$1\fP, \fIitd.\fP) nigdy nie s±
widoczne wewn±trz nich.
Podczas ustalania po³o¿enia komendy, funkcje s± przeszukiwane po przeszukaniu
specjalnych komend wbudowanych, za¶ przed regularnymi oraz nieregularnymi
komendami wbudowanymi i przed przeszukaniem \fBPATH\fP.
.PP
Istniej±ca funkcja mo¿e zostaæ usuniêta poprzez
\fBunset \-f\fP \fInazwa-funkcji\fP.
Listê funkcji mo¿na otrzymaæ poprzez \fBtypeset +f\fP, a definicje
funkcji mo¿na otrzymaæ poprzez \fBtypeset \-f\fP.
\fBautoload\fP (co jest aliasem dla \fBtypeset \-fu\fP) mo¿e zostaæ
u¿yte do tworzenia niezdefiniowanych funkcji.
Je¶li ma byæ wykonana niezdefiniowana funkcja, wówczas pow³oka
przeszukuje ¶cie¿kê podan± w parametrze \fBFPATH\fP szukaj±c pliku
o nazwie identycznej z nazw± danej funkcji. Je¶li plik taki zostanie
odnaleziony, to bêdzie wczytany i wykonany.
Je¶li po wykonaniu tego pliku dana funkcja bêdzie zdefiniowana, wówczas
zostanie ona wykonana, w przeciwnym razie zostanie wykonane zwyk³e
odnajdywanie komend
(\fItzn.\fP, pow³oka przeszukuje tablicê zwyk³ych komend wbudowanych
i \fBPATH\fP).
Proszê zwróciæ uwagê, ¿e je¶li komenda nie zostanie odnaleziona
na podstawie \fBPATH\fP, wówczas zostaje podjêta próba odnalezienia
funkcji przez \fBFPATH\fP (jest to nieudokumentowanym zachowaniem
siê oryginalnej pow³oki Korna).
.PP
Funkcje mog± mieæ dwa atrybuty - ¶ledzenia i eksportowania, które
mog± byæ ustawiane przez \fBtypeset \-ft\fP i odpowiednio
\fBtypeset \-fx\fP.
Podczas wykonywania funkcji ¶ledzonej, opcja \fBxtrace\fP pow³oki
zostaje w³±czona na czas danej funkcji, w przeciwnym razie
opcja \fBxtrace\fP pozostaje wy³±czona.
Atrybut eksportowania nie jest obecnie u¿ywany.  W oryginalnej
pow³oce Korna, wyeksportowane funkcje s± widoczne dla skryptów pow³oki,
gdy s± one wykonywane.
.PP
Poniewa¿ funkcje s± wykonywane w obecnym kontek¶cie pow³oki,
przyporz±dkowania parametrów wykonane wewn±trz funkcji pozostaj±
widoczne po zakoñczeniu danej funkcji.
Je¶li jest to niepo¿±dane, wówczas komenda \fBtypeset\fP mo¿e
byæ zastosowana wewn±trz funkcji do tworzenia lokalnych parametrów.
Proszê zwróciæ uwagê, i¿ w ¿aden sposób nie mo¿na ograniczyæ widoczno¶ci
parametrów specjalnych (tzn. \fB$$\fP, \fB$!\fP).
.PP
Kodem wyj¶cia funkcji jest kod wyj¶cia ostatniej wykonanej w niej komendy.
Funkcjê mo¿na przerwaæ bezpo¶rednio przy pomocy komendy \fBreturn\fP;
mo¿na to równie¿ zastosowaæ do jawnego okre¶lenia kodu wyj¶cia.
.PP
Funkcje zdefiniowane przy pomocy zarezerwowanego s³owa \fBfunction\fP, s±
traktowane odmiennie w nastêpuj±cych punktach od funkcji zdefiniowanych
poprzez notacjê \fB()\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
parametr \fB$0\fP zostaje ustawiony na nazwê funkcji
(funkcje w stylu Bourne'a nie dotykaj± \fB$0\fP).
.IP \ \ \(bu
przyporz±dkowania warto¶ci parametrom poprzedzaj±ce wywo³anie
funkcji nie zostaj± zachowane w bie¿±cym kontek¶cie pow³oki
(wykonywanie funkcji w stylu Bourne'a zachowuje te
przyporz±dkowania).
.IP \ \ \(bu
\fBOPTIND\fP zostanie zachowany i skasowany
na pocz±tku oraz nastêpnie odtworzony na zakoñczenie funkcji, tak wiêc
\fBgetopts\fP mo¿e byæ poprawnie stosowane zarówno wewn±trz funckji, jak i poza
nimi
(funkcje w stylu Bourne'a nie dotykaj± \fBOPTIND\fP, tak wiêc
stosowanie \fBgetopts\fP wewn±trz funkcji jest niezgodne ze stosowaniem
\fBgetopts\fP poza funkcjami).
.br
.nr PD \n(P2
W przysz³o¶ci zostan± dodane równie¿ nastêpuj±ce ró¿nice:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
Podczas wykonywania funkcji bêdzie stosowany oddzielny kontekst
¶ledzenia/sygna³ów.
Tak wiêc ¶ledzenia ustawione wewn±trz funkcji nie bêd± mia³y wp³ywu
na ¶ledzenia i sygna³y pow³oki, nieignorowane przez ni± (które mog±
byæ przechwytywane), i bêd± mia³y domy¶lne ich znaczenie wewn±trz funkcji.
.IP \ \ \(bu
¦ledzenie EXIT-a, je¶li zostanie ustawione wewn±trz funkcji,
zostanie wykonane po zakoñczeniu funkcji.
.nr PD \n(P2
.\"}}}
.\"{{{  POSIX mode
.SS "Tryb POSIX-owy"
Dana pow³oka ma byæ w zasadzie zgodna ze standardem POSIX,
jednak, w niektórych przypadkach, zachowanie zgodne ze
standardem POSIX jest albo sprzeczne z zachowaniem oryginalnej
pow³oki Korna, albo z wygod± u¿ytkownika.
To, jak pow³oka zachowuje siê w takich wypadkach, jest ustalane
stanem opcji posix (\fBset \-o posix\fP) \(em je¶li jest ona
w³±czona, to zachowuje siê zgodnie z POSIX-em, a w przeciwnym
razie - nie.
Opcja \fBposix\fP zostaje automatycznie ustawiona, je¶li pow³oka startuje
w otoczeniu zawieraj±cym ustawiony parametr \fBPOSIXLY_CORRECT\fP.
(Pow³okê mo¿na równie¿ skompilowaæ tak, aby zachowanie zgodne z
POSIX-em by³o domy¶lnie ustawione, ale jest to zwykle
niepo¿±dane).
.PP
A oto lista wp³ywów ustawienia opcji \fBposix\fP:
.nr P2 \n(PD
.nr PD 0
.IP \ \ \(bu
\fB\e"\fP wewn±trz cytowanych podwójnymi cudzys³owami \fB`\fP..\fB`\fP
podstawieñ komend:
w trybie POSIX-owym, \fB\e"\fP jest interpretowany podczas interpretacji
komendy;
w trybie nie-POSIX-owym, odwrotny uko¶nik zostaje usuniêty przed
interpretacj± podstawienia komendy.
Na przyk³ad\fBecho "`echo \e"hi\e"`"\fP produkuje `"hi"' w
trybie POSIX-owym, `hi' a w trybie nie-POSIX-owym.
W celu unikniêcia problemów, proszê stosowaæ postaæ \fB$(...\fP)
podstawienia komend.
.IP \ \ \(bu
wyj¶cie \fBkill \-l\fP: w trybie POSIX-owym nazwy sygna³ów
s± wymieniane wiersz po wierszu;
w nie-POSIX-owym trybie numery sygna³ów, ich nazwy i opis zostaj± wymienione
w kolumnach.
W przysz³o¶ci zostanie dodana nowa opcja (zapewne \fB\-v\fP) w celu
rozró¿nienia tych dwóch zachowañ.
.IP \ \ \(bu
kod wyj¶cia \fBfg\fP: w trybie POSIX-owym, kod wyj¶cia wynosi
0, je¶li nie wyst±pi³y ¿adne b³êdy;
w trybie nie-POSIX-owym, kod wyj¶cia odpowiada kodowi ostatniego zadania
wykonywanego w pierwszym planie.
.IP \ \ \(bu
kod wyj¶cia polecenia\fBeval\fP: je¿eli argumentem eval bêdzie puste polecenie
(\fInp.\fP: \fBeval "`false`"\fP), to jego kodem wyj¶cia w trybie POSIX-owym bêdzie 0.
W trybie nie-POSIX-owym, kodem wyj¶cia bêdzie kod wyj¶cia ostatniego podstawienia
komendy, które zosta³o dokonane podczas przetwarzania argumentów polecenia eval
(lub 0, je¶li nie by³o podstawieñ komen).
.IP \ \ \(bu
\fBgetopts\fP: w trybie POSIX-owym, opcje musz± zaczynaæ siê od \fB\-\fP;
w trybie nie-POSIX-owym, opcje mog± siê zaczynaæ albo od \fB\-\fP, albo od \fB+\fP.
.IP \ \ \(bu
rozwijanie nawiasów (zwane równie¿ przemian±): w trybie POSIX-owym
rozwijanie nawiasów jest wy³±czone; w trybie nie-POSIX-owym
rozwijanie nawiasów jest w³±czone.
Proszê zauwa¿yæ, ¿e \fBset \-o posix\fP (lub ustawienie
parametru \fBPOSIXLY_CORRECT\fP)
automatycznie wy³±cza opcjê \fBbraceexpand\fP, mo¿e ona byæ jednak jawnie
w³±czona pó¼niej.
.IP \ \ \(bu
\fBset \-\fP: w trybie POSIX-owym, nie wy³±cza to ani opcji \fBverbose\fP, ani
\fBxtrace\fP; w trybie nie-POSIX-owym, wy³±cza.
.IP \ \ \(bu
kod wyj¶cia \fBset\fP: w trybie POSIX-owym,
kod wyj¶cia wynosi 0, je¶li nie wyst±pi³y ¿adne b³êdy;
w trybie nie-POSIX-owym, kod wyj¶cia odpowiada kodowi
wszelkich podstawieñ komend wykonywanych podczas generacji komendy set.
Przyk³adowo, `\fBset \-\- `false`; echo $?\fP' wypisuje 0 w trybie POSIX-owym,
a 1 w trybie nie-POSIX-owym.  Taka konstukcja stosowana jest w wiêkszo¶ci
skryptów pow³oki stosuj±cych stary wariant komendy \fIgetopt\fP(1).
.IP \ \ \(bu
rozwijanie argumentów komend \fBalias\fP, \fBexport\fP, \fBreadonly\fP i
\fBtypeset\fP: w trybie POSIX-owym, nastêpuje normalne rozwijanie argumentów;
w trybie nie-POSIX-owym, rozdzielanie pól, dopasowywanie nazw plików,
rozwijanie nawiasów i (zwyk³e) rozwijanie tyld s± wy³±czone, ale
rozwijanie tyld w przyporz±dkowaniach pozostaje w³±czone.
.IP \ \ \(bu
specyfikacja sygna³ów: w trybie POSIX-owym, sygna³y mog± byæ
podawane jedynie cyframi, je¶li numery sygna³ów s± zgodne z
warto¶ciami z POSIX-a (\fItzn.\fP HUP=1, INT=2, QUIT=3, ABRT=6,
KILL=9, ALRM=14 i TERM=15); w trybie nie-POSIX-owym,
sygna³y  zawsze mog± byæ podane cyframi.
.IP \ \ \(bu
rozwijanie aliasów: w trybie POSIX-owym, rozwijanie aliasów
zostaje jedynie wykonywane, podczas wczytywania s³ów komend; w trybie
nie-POSIX-owym, rozwijanie aliasów zostaje wykonane równie¿ na
ka¿dym s³owie po jakim¶ aliasie, które koñczy siê bia³± przerw±.
Na przyk³ad nastêpuj±ca pêtla for
.RS
.ft B
alias a='for ' i='j'
.br
a i in 1 2; do echo i=$i j=$j; done
.ft P
.RE
u¿ywa parameteru \fBi\fP w trybie POSIX-owym, natomiast \fBj\fP w
trybie nie-POSIX-owym.
.IP \ \ \(bu
test: w trybie POSIX-owym, wyra¿enie "\fB-t\fP" (poprzedzone pewn±
liczb± argumentów "\fB!\fP") zawsze jest prawdziwe, gdy¿ jest
ci±giem o d³ugo¶ci niezerowej; w nie-POSIX-owym trybie, sprawdza czy
deskryptor pliku 1 jest jakim¶ tty (\fItzn.\fP,
argument \fIfd\fP do testu \fB-t\fP mo¿e zostaæ pominiêty i jest
domy¶lnie równy 1).
.nr PD \n(P2
.\"}}}
.\"{{{  Command Execution (built-in commands)
.SS "Wykonywanie komend"
Po wyliczeniu argumentów wiersza komendy, wykonaniu przekierowañ
i przyporz±dkowañ parametrów, zostaje ustalony typ komendy:
specjalna wbudowana, funkcja, regularna wbudowana
lub nazwa pliku, który nale¿y wykonaæ, znajdowanego przy pomocy parametru
\fBPATH\fP.
Testy te zostaj± wykonane w wy¿ej podanym porz±dku.
Specjalne wbudowane komendy ró¿ni± siê tym od innych komend,
¿e do ich odnalezienia nie jest u¿ywany parametr \fBPATH\fP, b³±d
podczas ich wykonywania mo¿e spowodowaæ zakoñczenie pow³oki nieinterakcyjnej
i przyporz±dkowania warto¶ci parametrów poprzedzaj±ce
komendê zostaj± zachowane po jej wykonaniu.
Aby tylko wprowadziæ zamieszanie, je¶li opcja
posix zosta³a w³±czona (patrz komenda \fBset\fP
poni¿ej), to pewne specjale komendy staj± siê bardzo specjalne, gdy¿
nie jest wykonywane rozdzielanie pól, rozwijanie nazw plików,
rozwijanie nawiasów, ani rozwijanie tyld na argumentach,
które wygl±daj± jak przyporz±dkowania.
Zwyk³e wbudowane komendy wyró¿niaj± siê jedynie tym, ¿e
do ich odnalezienia nie jest stosowany parametr \fBPATH\fP.
.PP
Oryginalny ksh i POSIX ró¿ni± siê nieco w tym, jakie
komendy s± traktowane jako specjalne, a jakie jako zwyk³e:
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
W przysz³o¶ci dodatkowe specjalne komendy oraz regularne komendy ksh
mog± byæ traktowane odmiennie od specjalnych i regularnych komand
POSIX.
.PP
Po ustaleniu typu komendy, wszelkie przyporz±dkowania warto¶ci parametrów
zostaj± wykonane i wyeksportowane na czas trwania komendy.
.PP
Poni¿ej opisujemy specjalne i regularne polecenia wbudowane:
.\"{{{  . plik [ arg1 ... ]
.IP "\fB\&.\fP \fIplik\fP [\fIarg1\fP ...]"
Wykonaj komendy z \fIplik\fPu w bie¿±cym otoczeniu.
Plik zostaje odszukiwany przy u¿yciu katalogów z \fBPATH\fP.
Je¶li zosta³y podane argumenty, to parametry pozycyjne mog± byæ
u¿ywane w celu uzyskania dostêpu do nich podczas wykonywania \fIplik\fPu.
Je¿eli nie zosta³y podane ¿adne argumenty, to argumenty pozycyjne
odpowiadaj± tym z bie¿±cego otoczenia, w którym dana komenda zosta³a
u¿yta.
.\"}}}
.\"{{{  : [ ... ]
.IP "\fB:\fP [ ... ]"
Komenda zerowa. Kodem wyj¶cia jest zero.
.\"}}}
.\"{{{  alias [ -d | +-t [ -r ] ] [+-px] [+-] [nazwa1[=warto¶æ1] ...]
.IP "\fBalias\fP [ \fB\-d\fP | \fB\(+-t\fP [\fB\-r\fP] ] [\fB\(+-px\fP] [\fB\(+-\fP] [\fIname1\fP[\fB=\fP\fIvalue1\fP] ...]"
Bez argumentów, \fBalias\fP wy¶wietla wszystkie obecne aliasy.
Dla ka¿dej nazwy bez podanej warto¶ci zostaje wy±wietlony istniej±cy
odpowiedni alias.
Ka¿da nazwa z podan± warto¶ci± definiuje alias (patrz: "Aliasy" powy¿ej).
.sp
Do wy¶wietlania aliasów u¿ywany jest jeden z dwóch formatów:
zwykle aliasy s± wy¶wietlane jako \fInazwa\fP\fB=\fP\fIwarto¶æ\fP, przy czym
\fIwarto¶æ\fP jest cytowana; je¶li opcje mia³y przedrostek \fB+\fP
lub samo \fB+\fP zosta³o podane we wierszu komendy, tylko \fInazwa\fP
zostaje wy¶wietlona.
Ponad to, je¶li zosta³a zastosowana opcja \fB\-p\fP, to dodatkow ka¿dy wiersz
zaczyna siê od ci±gu "\fBalias\fP\ ".
.sp
Opcja \fB\-x\fP ustawia (a \fB+x\fP kasuje) atrybut eksportu dla aliasu,
lub je¶li nie podano ¿adnych nazw, wy¶wietla aliasy wraz z ich atrybutem
eksportu (eksportowanie aliasu nie ma ma ¿adnego efektu).
.sp
Opcja \fB\-t\fP wskazuje, ¿e ¶ledzone aliasy maj± byæ wy¶wietlone/ustawione
(warto¶ci podane w wierszu komendy zostaj± zignorowane dla ¶ledzonych
aliasów).
Opcja \fB\-r\fP wskazuje, ¿e wszystkie ¶ledzone aliasy
maj± zostaæ usuniête.
.sp
Opcja \fB\-d\fP nakazuje wy¶witlenie lub ustawienie aliasów katalogów,
które s± stosowane w rozwiniêciach tyld
(patrz: "Rozwiniêcia tyld" powy¿ej).
.\"}}}
.\"{{{  bg [job ...]
.IP "\fBbg\fP [\fIjob\fP ...]"
Podejmij ponownie wymienione zatrzymane zadanie(-a) w tle.
Je¶li nie podano ¿adnego zadania, to przyjmuje siê domy¶lnie \fB%+\fP.
Ta komenda jest dostêpna jedynie w systemach obs³uguj±cych kontrolê zadañ.
Dalsze informacje mo¿na znale¼æ poni¿ej w rozdziale "Kontrola zadañ".
.\"}}}
.\"{{{  bind [-l] [-m] [key[=editing-command] ...]
.IP "\fBbind\fP [\fB\-m\fP] [\fIklawisz\fP[\fB=\fP\fIkomenda-edycji\fP] ...]"
Ustawienie lub wyliczenie obecnych przyporz±dkowañ klawiszy/makr w
emacsowym trybie edycji komend.
Patrz "Interakcyjna emacsowa edycja wiersza komendy" w celu pe³nego opisu.
.\"}}}
.\"{{{  break [level]
.IP "\fBbreak\fP [\fIpoziom\fP]"
\fBbreak\fP przerywa \fIpoziom\fP zagnie¿d¿enia w pêtlach
for, select, until lub while.
Domy¶lnie \fIpoziom\fP wynosi 1.
.\"}}}
.\"{{{  builtin command [arg1 ...]
.IP "\fBbuiltin\fP \fIkomenda\fP [\fIarg1\fP ...]"
Wykonuje wbudowan± komendê \fIkomenda\fP.
.\"}}}
.\"{{{  cd [-LP] [dir]
.IP "\fBcd\fP [\fB\-LP\fP] [\fIkatalog\fP]"
Ustawia aktualny katalog roboczy na \fIkatalog\fP.
Je¶li zosta³ ustawiony parametr \fBCDPATH\fP, to wypisuje
listê katalogów, w których bêdzie szukaæ \fIkatalog\fPu.
Pusta zawarto¶æ w \fBCDPATH\fP oznacza katalog bie¿±cy.
Je¶li zostanie u¿yty niepusty katalog z \fBCDPATH\fP,
to na standardowym wyj¶ciu bêdzie wy¶wietlona jego pe³na ¶cie¿ka.
Je¶li nie podano \fIkatalog\fPu, to
zostanie u¿yty katalog domowy \fB$HOME\fP.  Je¶li \fIkatalog\fPiem jest
\fB\-\fP, to zostanie zastosowany poprzedni katalog roboczy (patrz
parametr OLDPWD).
Je¶li u¿yto opcji \fB\-L\fP (¶cie¿ka logiczna) lub je¶li
nie zosta³a ustawiona opcja \fBphysical\fP
(patrz komenda \fBset\fP poni¿ej), wówczas odniesienia do \fB..\fP w
\fIkatalogu\fP s± wzglêdne wobec ¶cie¿ki zastosowanej do doj¶cia do danego
katalogu.
Je¶li podano opcjê \fB\-P\fP (fizyczna ¶cie¿ka) lub gdy zosta³a ustawiona
opcja \fBphysical\fP, to \fB..\fP jest wzglêdne wobec drzewa katalogów
systemu plików.
Parametry \fBPWD\fP i \fBOLDPWD\fP zostaj± uaktualnione tak, aby odpowiednio
zawiera³y bie¿±cy i poprzedni katalog roboczy.
.\"}}}
.\"{{{  cd [-LP] old new
.IP "\fBcd\fP [\fB\-LP\fP] \fIstary nowy\fP"
Ci±g \fInowy\fP zostaje podstawiony w zamian za \fIstary\fP w bie¿±cym
katalogu i pow³oka próbuje przej¶æ do nowego katalogu.
.\"}}}
.\"{{{  command [ -pvV ] cmd [arg1 ...]
.IP "\fBcommand\fP [\fB\-pvV\fP] \fIkomenda\fP [\fIarg1\fP ...]"
Je¶li nie zosta³a podana opcja \fB\-v\fP ani opcja \fB\-V\fP, to
\fIkomenda\fP
zostaje wykonana dok³adnie tak, jakby nie podano \fBcommand\fP,
z dwoma wyj±tkami: po pierwsze, \fIkomenda\fP nie mo¿e byæ funkcj± w pow³oce,
oraz po drugie, specjalne wbudowane komendy trac± swoj± specjalno¶æ (tzn.
przekierowania i b³êdy w u¿yciu nie powoduj±, ¿e pow³oka zostaje zakoñczona, a
przyporz±dkowania parametrów nie zostaj± wykonane).
Je¶li podano opcjê \fB\-p\fP, zostaje zastosowana pewna domy¶lna ¶cie¿ka
zamiast obecnej warto¶ci \fBPATH\fP (warto¶æ domy¶lna ¶cie¿ki jest zale¿na
od systemu, w jakim pracujemy: w systemach POSIX-owych jest to
warto¶æ zwracana przez
.ce
\fBgetconf CS_PATH\fP
).
.sp
Je¶li podano opcjê \fB\-v\fP, to zamiast wykonania polecenia \fIkomenda\fP,
zostaje podana informacja, co by zosta³o wykonane (i to samo dotyczy
równie¿ \fIarg1\fP ...):
dla specjalnych i zwyk³ych wbudowanych komend i funkcji,
zostaj± po prostu wy¶wietlone ich nazwy,
dla aliasów, zostaje wy¶wietlona komenda definiuj±ca dany alias,
oraz dla komend odnajdowanych przez przeszukiwanie zawarto¶ci
parametru \fBPATH\fP, zostaje wy¶wietlona pe³na ¶cie¿ka danej komendy.
Je¶li komenda nie zostanie odnaleziona, (tzn. przeszukiwanie ¶cie¿ki
nie powiedzie siê), nic nie zostaje wy¶wietlone i \fBcommand\fP zostaje
zakoñczone z niezerowym kodem wyj¶cia.
Opcja \fB\-V\fP jest podobna do opcji \fB\-v\fP, tylko ¿e bardziej
gadatliwa.
.\"}}}
.\"{{{  continue [levels]
.IP "\fBcontinue\fP [\fIpoziom\fP]"
\fBcontinue\fP skacze na pocz±tek \fIpoziom\fPu z najg³êbiej
zagnie¿d¿onej pêtli for,
select, until lub while.
\fIlevel\fP domy¶lnie 1.
.\"}}}
.\"{{{  echo [-neE] [arg ...]
.IP "\fBecho\fP [\fB\-neE\fP] [\fIarg\fP ...]"
Wy¶wietla na standardowym wyj¶ciu swoje argumenty (rozdzielone spacjami),
zakoñczone prze³amaniem wiersza.
Prze³amanie wiersza nie nastêpuje, je¶li którykolwiek z parametrów
zawiera sekwencjê odwrotnego uko¶nika \fB\ec\fP.
Patrz komenda \fBprint\fP poni¿ej, co do listy innych rozpoznawanych
sekwencji odwrotnych uko¶ników.
.sp
Nastêpuj±ce opcje zosta³y dodane dla zachowania zgodno¶ci ze
skryptami z systemów BSD:
\fB\-n\fP wy³±cza koñcowe prze³amanie wiersza, \fB\-e\fP w³±cza
interpretacjê odwrotnych uko¶ników (operacja zerowa, albowiem ma to
domy¶lnie miejsce) oraz \fB\-E\fP wy³±czaj±ce interpretacjê
odwrotnych uko¶ników.
.\"}}}
.\"{{{  eval command ...
.IP "\fBeval\fP \fIkomenda ...\fP"
Argumenty zostaj± powi±zane (z przerwami pomiêdzy nimi) do jednego
ci±gu, który nastêpnie pow³oka rozpoznaje i wykonuje w obecnym
otoczeniu.
.\"}}}
.\"{{{  exec [command [arg ...]]
.IP "\fBexec\fP [\fIkomenda\fP [\fIarg\fP ...]]"
Komenda zostaje wykonana bez rozwidlania (fork), zastêpuj±c proces pow³oki.
.sp
Je¶li nie podano ¿adnych argumentów wszelkie przekierowania wej¶cia/wyj¶cia
s± dozwolone i pow³oka nie zostaje zast±piona.
Wszelkie deskryptory plików wiêksze ni¿ 2 otwarte lub z\fIdup\fP(2)-owane
w ten sposób nie s± dostêpne dla innych wykonywanych komend
(\fItzn.\fP, komend nie wbudowanych w pow³okê).
Zauwa¿, ¿e pow³oka Bourne'a ró¿ni siê w tym:
przekazuje bowiem deskryptory plików.
.\"}}}
.\"{{{  exit [kod]
.IP "\fBexit\fP [\fIkod\fP]"
Pow³oka zostaje zakoñczona z podanym kodem wyj¶cia.
Je¶li \fIkod\fP nie zosta³ podany, wówczas kod wyj¶cia
przyjmuje bie¿±c± warto¶æ parametru \fB?\fP.
.\"}}}
.\"{{{  export [-p] [parameter[=value] ...]
.IP "\fBexport\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Ustawia atrybut eksportu danego parametru.
Eksportowane parametry zostaj± przekazywane w otoczeniu do wykonywanych
komend.
Je¶li podano warto¶ci, to zostaj± one równie¿ przyporz±dkowane
danym parametrom.
.sp
Je¶li nie podano ¿adnych parametrów, wówczas nazwy wszystkich parametrów
z atrybutem eksportu zostaj± wy¶wietlone wiersz po wierszu, chyba ¿e u¿yto
opcji \fB\-p\fP, wtedy zostaj± wy¶wietlone komendy
\fBexport\fP definiuj±ce wszystkie eksportowane parametry wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  false
.IP "\fBfalse\fP"
Komenda koñcz±ca siê z niezerowym kodem powrotu.
.\"}}}
.\"{{{  fc [-e editor | -l [-n]] [-r] [first [ last ]]
.IP "\fBfc\fP [\fB\-e\fP \fIedytor\fP | \fB\-l\fP [\fB\-n\fP]] [\fB\-r\fP] [\fIpierwszy\fP [\fIostatni\fP]]"
\fIpierwszy\fP i \fIostatni\fP wybieraj± komendy z historii.
Komendy mo¿emy wybieraæ przy pomocy ich numeru w historii
lub podaj±c ci±g znaków okre¶laj±cy ostatnio u¿yt± komendê rozpoczynaj±c±
siê od tego¿ ci±gu.
Opcja \fB\-l\fP wy¶wietla dan± komendê na stdout,
a \fB\-n\fP wy³±cza domy¶lne numery komend.  Opcja \fB\-r\fP
odwraca kolejno¶æ komend w li¶cie historii.  Bez \fB\-l\fP, wybrane
komendy podlegaj± edycji przez edytor podany poprzez opcjê
\fB\-e\fP, albo je¶li nie podano \fB\-e\fP, przez edytor
podany w parametrze \fBFCEDIT\fP (je¶li nie zosta³ ustawiony ten
parametr, wówczas stosuje siê \fB/bin/ed\fP),
i nastêpnie wykonana przez pow³okê.
.\" -(rl)- 
.\"}}}
.\"{{{  fc [-e - | -s] [-g] [old=new] [prefix]
.IP "\fBfc\fP [\fB\-e \-\fP | \fB\-s\fP] [\fB\-g\fP] [\fIstare\fP\fB=\fP\fInowe\fP] [\fIprefix\fP]"
Wykonaj ponownie wybran± komendê (domy¶lnie poprzedni± komendê) po
wykonaniu opcjonalnej zamiany \fIstare\fP na \fInowe\fP.  Je¶li
podano \fB\-g\fP, wówczas wszelkie wyst±pienia \fIstare\fP zostaj±
zast±pione przez \fInowe\fP.  Z tej komendy korzysta siê zwykle
przy pomocy zdefiniowanego domy¶lnie aliasu \fBr='fc \-e \-'\fP.
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
\fBgetopts\fP jest stosowany przez procedury pow³oki
do rozeznawania podanych argumentów
(lub parametrów pozycyjnychi, je¶li nie podano ¿adnych argumentów)
i do sprawdzenia zasadno¶ci opcji.
\fIci±gopt\fP zawiera litery opcji, które
\fBgetopts\fP ma rozpoznawaæ.  Je¶li po literze wystêpuje przecinek,
wówczas oczekuje siê, ¿e opcja posiada argument.
Opcje nieposiadaj±ce argumentów mog± byæ grupowane w jeden argument.
Je¶li opcja oczekuje argument i znak opcji nie jest ostatnim znakiem
argumentu w którym siê znajduje, wówczas reszta argumentu
zostaje potraktowana jako argument danej opcji. W przeciwnym razie
nastêpny argument jest argumentem opcji.
.sp
Za ka¿dym razem, gdy zostaje wywo³ane \fBgetopts\fP,
umieszcza siê nastêpn± opcjê w parametrze pow³oki
\fInazwa\fP i indeks nastêpnego argumentu pod obróbkê
w parametrze pow³oki \fBOPTIND\fP.
Je¶li opcja zosta³a podana z \fB+\fP, to opcja zostaje umieszczana
w \fInazwa\fP z przedrostkiem \fB+\fP.
Je¶li opcja wymaga argumentu, to \fBgetopts\fP umieszcza go
w parametrze pow³oki \fBOPTARG\fP.
Je¶li natrafi siê na niedopuszczaln± opcjê lub brakuje
argumentu opcji, wówczas w \fInazwa\fP zostaje umieszczony znak zapytania
albo dwukropek
(wskazuj±c na nielegaln± opcjê, albo odpowiednio brak argumentu)
i \fBOPTARG\fP zostaje ustawiony na znak, który by³ przyczyn± tego problemu.
Ponadto zostaje wówczas wy¶wietlony komunikat o b³êdzie na standardowym
wyj¶ciu b³êdów, je¶li \fIci±gopt\fP nie zaczyna siê od dwukropka.
.sp
Gdy napotkamy na koniec opcji, \fBgetopts\fP przerywa pracê
niezerowym kodem wyj¶cia.
Opcje koñcz± siê na pierwszym (nie podlegaj±cym opcji) argumencie,
który nie rozpoczyna siê od \-, albo je¶li natrafimy na argument \fB\-\-\fP.
.sp
Rozpoznawanie opcji mo¿e zostaæ ponowione ustawiaj±c \fBOPTIND\fP na 1
(co nastêpuje automatycznie za ka¿dym razem, gdy pow³oka lub
funkcja w pow³oce zostaje wywo³ana).
.sp
Ostrze¿enie: Zmiana warto¶ci parametru pow³oki \fBOPTIND\fP na
warto¶æ wiêksz± ni¿ 1, lub rozpoznawanie odmiennych zestawów
parametrów bez ponowienia \fBOPTIND\fP mo¿e doprowadziæ do nieoczekiwanych
wyników.
.\"}}}
.\"{{{  hash [-r] [name ...]
.IP "\fBhash\fP [\fB\-r\fP] [\fInazwa ...\fP]"
Je¶li brak argumentów, wówczas wszystkie ¶cie¿ki
wykonywalnych komend z kluczem s± wymieniane.
Opcja \fB\-r\fP nakazuje wyrzucenia wszelkim komend z kluczem z tablicy
kluczy.
Ka¿da \fInazwa\fP zostaje odszukiwana tak, jak by to by³a nazwa komendy
i dodana do tablicy kluczy je¶li jest to wykonywalna komenda.
.\"}}}
.\"{{{  jobs [-lpn] [job ...]
.IP "\fBjobs\fP [\fB\-lpn\fP] [\fIzadanie\fP ...]"
Wy¶wietl informacje o danych zadaniach; gdy nie podano ¿adnych
zadañ wszystkie zadania zostaj± wy¶wietlone.
Je¶li podano opcjê \fB\-n\fP, wówczas informacje zostaj± wy¶wietlone
jedynie o zadaniach których stan zmieni³ siê od czasu ostatniego
powiadomienia.
Zastosowanie opcji \fB\-l\fP powoduje dodatkowo
wykazanie identyfikatora ka¿dego
procesu w zadaniach.
Opcja \fB\-p\fP powoduje, ¿e zostaje wy¶wietlona jedynie
jedynie grupa procesowa ka¿dego zadania.
patrz Kontrola Zadañ dla informacji o formie parametru
\fIzdanie\fP i formacie w którym zostaj± wykazywane zadania.
.\"}}}
.\"{{{  kill [-s signame | -signum | -signame] { job | pid | -pgrp } ...
.IP "\fBkill\fP [\fB\-s\fP \fInazsyg\fP | \fB\-numsyg\fP | \fB\-nazsyg\fP ] { \fIjob\fP | \fIpid\fP | \fB\-\fP\fIpgrp\fP } ..."
Wy¶lij dany sygna³ do danych zadañ, procesów z danym id, lub grup
procesów.
Je¶li nie podano jawnie ¿adnego sygna³u, wówczas domy¶lnie zostaje wys³any
sygna³ TERM.
Je¶li podano zadanie, wówczas sygna³ zostaje wys³any do grupy
procesów danego zadania.
Patrz poni¿ej Kontrola Zadañ dla informacji o formacie \fIzadania\fP.
.IP "\fBkill \-l\fP [\fIkod_wyj¶cia\fP ...]"
Wypisz nazwê sygna³u, który zabi³ procesy, które zakoñczy³y siê
danym \fIkodem_wyj¶cia\fP.
Je¶li brak argumentów, wówczas zostaje wy¶wietlona lista
wszelkich sygna³ów i ich numerów, wraz z krótkim ich opisem.
.\"}}}
.\"{{{  let [expression ...]
.IP "\fBlet\fP [\fIwyra¿enie\fP ...]"
Ka¿de wyra¿enie zostaje wyliczone, patrz Wyra¿enie Arytmetyczne powy¿ej.
Je¶li wszelkie wyra¿enia zosta³y poprawnie wyliczone, kodem wyj¶cia
jest 0 (1), je¶li warto¶ci± ostatniego wyra¿enia
 nie by³o zero (zero).
Je¶li wyst±pi b³±d podczas rozpoznawania lub wyliczania wyra¿enia,
kod wyj¶cia jest wiêkszy od 1.
Poniewa¿ mo¿e zaj¶æ konieczno¶æ wycytowania wyra¿eñ, wiêc
\fB((\fP \fIwyr.\fP \fB))\fP jest syntaktycznie s³odszym wariantem \fBlet
"\fP\fIwyr\fP\fB"\fP.
.\"}}}
.\"{{{  print [-nprsun | -R [-en]] [argument ...]
.IP "\fBprint\fP [\fB\-nprsu\fP\fIn\fP | \fB\-R\fP [\fB\-en\fP]] [\fIargument ...\fP]"
\fBPrint\fP wy¶wietla swe argumenty na standardowym wyj¶ciu, rozdzielone
przerwami i zakoñczone prze³amaniem wiersza. Opcja
\fB\-n\fP zapobiega domy¶lnemu prze³amaniu wiersza.
Domy¶lnie pewne wyprowadzenia z C zostaj± odpowiednio przet³umaczone.
W¶ród nich mamy \eb, \ef, \en, \er, \et, \ev, i \e0###
(# oznacza cyfrê w systemie ósemkowym, tzn. od 0 po 3).
\ec jest równowa¿ne z zastosowaniem opcji \fB\-n\fP.  \e wyra¿eniom
mo¿na zapobiec przy pomocy opcji \fB\-r\fP.
Opcja \fB\-s\fP powoduje wypis do pliku historii zamiast
standardowego wyj¶cia, a opcja
\fB\-u\fP powoduje wypis do deskryptora pliku \fIn\fP (\fIn\fP
wynosi domy¶lnie 1 przy pominiêciu),
natomiast opcja \fB\-p\fP pisze do do koprocesu
(patrz Koprocesy powy¿ej).
.sp
Opcja \fB\-R\fP jest stosowana do emulacji, w pewnym stopniu, komendy
echo w wydaniu BSD, która nie przetwarza sekwencji \e bez podania opcji
\fB\-e\fP.
Jak powy¿ej opcja \fB\-n\fP zapobiega koñcowemu prze³amaniu wiersza.
.\"}}}
.\"{{{  pwd [-LP]
.IP "\fBpwd\fP [\fB\-LP\fP]"
Wypisz bie¿±cy katalog roboczy.
Przy zastosowaniu opcji \fB\-L\fP lub gdy nie zosta³a ustawiona opcja
\fBphysical\fP
(patrz komenda \fBset\fP poni¿ej), zostaje wy¶wietlona ¶cie¿ka
logiczna (tzn. ¶cie¿ka konieczna aby wykonaæ \fBcd\fP do bie¿±cego katalogu).
Przy zastosowaniu opcji \fB\-P\fP (¶cie¿ka fizyczna) lub gdy
zosta³a ustawiona opcja \fBphysical\fP, zostaje wy¶wietlona ¶cie¿ka
ustalona przez system plików (¶ledz±c katalogi \fB..\fP a¿ po katalog g³ówny).
.\"}}}
.\"{{{  read [-prsun] [parameter ...]
.IP "\fBread\fP [\fB\-prsu\fP\fIn\fP] [\fIparametr ...\fP]"
Wczytuje wiersz wprowadzenia ze standardowego wej¶cia, rozdziela ten
wiersz na pola przy uwzglêdnieniu parametru \fBIFS\fP (
patrz Podstawienia powy¿ej), i przyporz±dkowuje pola odpowiednio danym
parametrom.
Je¶li mamy wiêcej parametrów ni¿ pól, wówczas dodatkowe parametry zostaj±
ustawione na zero, a natomiast je¶li jest wiêcej pól ni¿ paramterów to
ostatni parametr otrzymuje jako warto¶æ wszystkie dodatkowe pola (wraz ze
wszelkimi rozdzielaj±cymi przerwami).
Je¶li nie podano ¿adnych parametrów, wówczas zostaje zastosowany
parametr \fBREPLY\fP.
Je¶li wiersz wprowadzania koñczy siê odwrotnym uko¶nikiem
i nie podano opcji \fB\-r\fP, to odwrotny uko¶nik i prze³amanie
wiersza zostaj± usuniête i zostaje wczytana dalsza czê¶æ danych.
Gdy nie zostanie wczytane ¿adne wprowadzenie, \fBread\fP koñczy siê
niezerowym kodem wyj¶cia.
.sp
Pierwszy parametr mo¿e mieæ do³±czony znak zapytania i ci±g, co oznacza, ¿e
dany ci±g zostanie zastosowany jako zachêta do wprowadzenia
(wy¶wietlana na standardowym wyj¶ciu b³êdów zanim
zostanie wczytane jakiekolwiek wprowadzenie) je¶li wej¶cie jest terminalem
(\fIe.g.\fP, \fBread nco¶?'ile co¶ków: '\fP).
.sp
Opcje \fB\-u\fP\fIn\fP i \fB\-p\fPpowoduj±, ¿e wprowadzenia zostanie
wczytywane z deskryptora pliku \fIn\fP albo odpowiednio bie¿±cego koprocesu
(patrz komentarze na ten temat w Koprocesy powy¿ej).
Je¶li zastosowano opcjê \fB\-s\fP, wówczas wprowadzenie zostaje zachowane
w pliku historii.
.\"}}}
.\"{{{  readonly [-p] [parameter[=value] ...]
.IP "\fBreadonly\fP [\fB\-p\fP] [\fIparametr\fP[\fB=\fP\fIwarto¶æ\fP]] ..."
Patrz parametr wy³±cznego odczytu nazwanych parametrów.
Je¶li zosta³y podane warto¶ci wówczas zostaj± one nadane parametrom przed
ustawieniem danego atrybutu.
Po nadaniu cechy wy³±cznego odczytu parametrowi, nie ma wiêcej mo¿liwo¶ci
wykasowania go lub zmiany jego warto¶ci.
.sp
Je¶li nie podano ¿adnych parametrów, wówczas zostaj± wypisane nazwy
wszystkich parametrów w cech± wy³±cznego odczytu wiersz po wierszu, chyba
¿e zastosowano opcjê \fB\-p\fP, co powoduje wypisanie pe³nych komend
\fBreadonly\fP definiuj±cych parametry wy³±cznego odczytu wraz z ich
warto¶ciami.
.\"}}}
.\"{{{  return [kod]
.IP "\fBreturn\fP [\fIkod\fP]"
Powrót z funkcji lub \fB.\fP skryptu, z kodem wyj¶cia \fIkod\fP.
Je¶li nie podano warto¶ci \fIkod\fP, wówczas zostaje domy¶lnie
zastosowany kod wyj¶cia ostatnio wykonanej komendy.
Przy zastosowaniu poza funkcj± lub \fB.\fP skryptem, komenda ta ma ten
sam efekt co \fBexit\fP.
Proszê zwróciæ uwagê, i¿ pdksh traktuje zarówno profile jak i pliki z
\fB$ENV\fP jako \fB.\fP skrypty, podczas gdy
oryginalny Korn shell jedynie profile traktuje jako \fB.\fP skrypty.
.\"}}}
.\"{{{  set [+-abCefhkmnpsuvxX] [+-o [option]] [+-A name] [--] [arg ...]
.IP "\fBset\fP [\fB\(+-abCefhkmnpsuvxX\fP] [\fB\(+-o\fP [\fIopcja\fP]] [\fB\(+-A\fP \fInazwa\fP] [\fB\-\-\fP] [\fIarg\fP ...]"
Komenda set s³u¿y do ustawiania (\fB\-\fP) albo kasowania (\fB+\fP)
opcji pow³oki, ustawiania parametrów pozycyjnych lub
ustawiania parametru ci±gowego.
Opcje mog± byæ zmienione przy pomocy syntaktyki \fB\(+-o\fP \fIopcja\fP,
gdzie \fIopcja\fP jest pe³n± nazw± pewnej opcji lub stosuj±c postaæ
\fB\(+-\fP\fIlitera\fP, gdzie \fIlitera\fP oznacza jednoliterow±
nazwê danej opcji (niewszystkie opcje posiadaj± jednoliterow± nazwê).
Nastêpuj±ca tablica wylicza zarówno litery opcji (gdy mamy takowe), jak i
pe³ne ich nazwy wraz z opisem wp³ywów danej opcji.
.sp
.TS
expand;
afB lfB lw(3i).
\-A		T{
Ustawia elementy parametru ci±gowego \fInazwa\fP na \fIarg\fP ...;
Je¶li zastosowano \fB\-A\fP, ci±g zostaje uprzednio ponowiony (\fItzn.\fP, wyczyszczony);
Je¶li zastosowano \fB+A\fP, zastaj± ustawione pierwsze N elementów (gdzie N
jest ilo¶ci± \fIarg\fPsów), reszta pozostaje niezmieniona.
T}
\-a	allexport	T{
wszystkie nowe parametry zostaj± tworzone z cech± eksportowania
T}
\-b	notify	T{
Wypisuj komunikaty o zadaniach asynchronicznie, zamiast tu¿ przed zachêt±.
Ma tylko znaczenia je¶li zosta³a w³±czona kontrola zadañ (\fB\-m\fP).
T}
\-C	noclobber	T{
Zapobiegaj przepisywaniu istniej±cych ju¿ plików poprzez przekierowania
\fB>\fP (do wymuszenia przepisania musi zostaæ zastosowane \fB>|\fP).
T}
\-e	errexit	T{
Wyjd¼ (po wykonaniu komendy pu³apki \fBERR\fP) tu¿ po wyst±pieniu
b³êdu lub niepomy¶lnym wykonaniu jakiej¶ komendy
(\fItzn.\fP, je¶li zosta³a ona zakoñczona niezerowym kodem wyj¶cia).
Nie dotyczy to komend, których kod wyj¶cia zostaje jawnie przetestowany
konstruktem pow³oki takim jak wyra¿enia \fBif\fP, \fBuntil\fP,
\fBwhile\fP, \fB&&\fP lub
\fB||\fP.
T}
\-f	noglob	T{
Nie rozwijaj wzorców nazw plików.
T}
\-h	trackall	T{
Twórz ¶ledzone aliasy dla wszystkich wykonywanych komend (patrz Aliasy
powy¿ej).
Domy¶lnie w³±czone dla nieinterakcyjnych pow³ok.
T}
\-i	interactive	T{
W³±cz tryb interakcyjny \- mo¿e zostaæ
w³±czone/wy³±czone jedynie podczas odpalania pow³oki.
T}
\-k	keyword	T{
Przyporz±dkowania warto¶ci parametrom zostaj± rozpoznawane
gdziekolwiek w komendzie.
T}
\-l	login	T{
Pow³oka ma byæ pow³ok± zameldowania \- mo¿e zostaæ
w³±czone/wy³±czone jedynie podczas odpalania pow³oki
(patrz Odpalania Pow³oki powy¿ej).
T}
\-m	monitor	T{
W³±cz kontrolê zadañ (domy¶lne dla pow³ok interakcyjnych).
T}
\-n	noexec	T{
Nie wykonuj jakichkolwiek komend \- przydatne do sprawdzania
syntaktyki skryptów (ignorowane dla interakcyjnych pow³ok).
T}
\-p	privileged	T{
Ustawiane automatycznie, je¶li gdy pow³oka zostaje odpalona i rzeczywiste
uid lub gid nie jest identyczne z odpowiednio efektywnym uid lub gid.
Patrz Odpalanie Pow³oki powy¿ej dla opisu, co to znaczy.
T}
-r	restricted	T{
Ustaw tryb ograniczony \(em ta opcja mo¿e zostaæ jedynie
zastosowana podczas odpalania pow³oki.  Patrz Odpalania Pow³oki
dla opisu, co to znaczy.
T}
\-s	stdin	T{
Gdy zostanie zastosowane podczas odpalania pow³oki, wówczas komendy
zostaj± wczytywane ze standardowego wej¶cia.
Ustawione automatycznie, je¶li pow³oka zosta³a odpalona bez jakichkolwiek
argumentów.
.sp
Je¶li \fB\-s\fP zostaje zastosowane w komendzie \fBset\fP, wówczas
podane argumenty zostaj± uporz±dkowane zanim zostan± one przydzielone
parametrom pozycyjnym
(lub ci±gowi \fInazwa\fP, je¶li \fB\-A\fP zosta³o zastosowane).
T}
\-u	nounset	T{
Odniesienie do nieustawionego parametru zostaje traktowane jako b³±d,
chyba ¿e zosta³ zastosowany jeden z modyfikatorów \fB\-\fP, \fB+\fP
lub \fB=\fP.
T}
\-v	verbose	T{
Wypisuj wprowadzenia pow³oki na standardowym wyj¶ciu b³êdów podczas
ich wczytywania.
T}
\-x	xtrace	T{
Wypisuj komendy i przyporz±dkowania parametrów podczas ich wykonywania
poprzedzone warto¶ci± \fBPS4\fP.
T}
\-X	markdirs	T{
Podczas generowania nazw plików oznaczaj katalogi koñcz±cym \fB/\fP.
T}
	bgnice	T{
Zadania w tle zostaj± wykonywane z ni¿szym priorytetem.
T}
	braceexpand	T{
W³±cz rozwijanie nawiasów (aka, alternacja).
T}
	emacs	T{
W³±cz edycjê wiersza komendy  w stylu BRL emacsa (dotyczy wy³±cznie
pow³ok interakcyjnych);
patrz Emacsowy Interakcyjny Tryb Edycji Wiersza Wprowadzenia.
T}
	gmacs	T{
W³±cz edycjê wiersza komendy w stylu gmacsa (Gosling emacs)
(dotyczy wy³±cznie pow³ok interakcyjnych);
obecnie identyczne z trybem edycji emacs z wyj±tkiem tego, ¿e przemiana (^T)
zachowuje siê nieco inaczej.
T}
	ignoreeof	T{
Pow³oka nie zostanie zakoñczona je¶li zostanie wczytany znak zakoñczenia
pliku. Nale¿y u¿yæ jawnie \fBexit\fP.
T}
	nohup	T{
Nie zabijaj bie¿±cych zadañ sygna³em \fBHUP\fP gdy pow³oka zameldowania
zostaje zakoñczona.
Obecnie ustawione domy¶lnie, co siê jednak zmieni w przysz³o¶ci w celu
poprawienia kompatybilno¶ci z oryginalnym Korn shell (który nie posiada
tej opcji, aczkolwiek wysy³a sygna³ \fBHUP\fP).
T}
	nolog	T{
Bez znaczenia \- w oryginalnej pow³oce Korn. Zapobiega sortowaniu definicji
funkcji w pliku historii.
T}
	physical	T{
Powoduje, ¿e komendy \fBcd\fP oraz \fBpwd\fP stosuj± `fizyczne'
(tzn. pochodz±ce od systemu plików) \fB..\fP katalogi zamiast `logicznych'
katalogów (tzn., ¿e pow³oka interpretuje \fB..\fP, co pozwala
u¿ytkownikowi nietroszczyæ siê o dowi±zania symboliczne do katalogów).
Domy¶lnie wykasowane.  Proszê zwróciæ uwagê, i¿ ustawianie tej opcji
nie wp³ywa na bie¿±c± warto¶æ parametru \fBPWD\fP;
jedynie komenda \fBcd\fP zmienia \fBPWD\fP.
Patrz komendy \fBcd\fP i \fBpwd\fP powy¿ej dla dalszych szczegó³ów.
T}
	posix	T{
W³±cz tryb POSIX-owy.  Patrz: "Tryb POSIX-owy" powy¿ej.
T}
	vi	T{
W³±cz edycjê wiersza komendy  w stylu vi (dotyczy tylko pow³ok
interakcyjnych).
T}
	viraw	T{
Bez znaczenia \- w oryginalnej pow³oce Korna, dopóki nie zosta³o
ustawione viraw, tryb wiersza komendy vi
pozostawia³ pracê napêdowi tty a¿ do wprowadzenia ESC (^[).
pdksh jest zawsze w trybie viraw.
T}
	vi-esccomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend / plików
gdy zostanie wprowadzone escape (^[) w trybie komendy.
T}
	vi-show8	T{
Dodaj przedrostek `M-' dla znaków z ustawionym ósmym bitem.
Je¶li nie zostanie ustawiona ta opcja, wówczas, znaki z zakresu
128-160 zostaj± wypisane bez zmian, co mo¿e byæ przyczyn± problemów.
T}
	vi-tabcomplete	T{
W trybie edycji wiersza komendy vi wykonuj rozwijania komend/ plików
je¶li tab (^I) zostanie wprowadzone w trybie wprowadzania.
T}
.TE
.sp
Tych opcji mo¿na u¿yæ równie¿ podczas odpalania pow³oki.
Obecny zestaw opcji (z jednoliterowymi nazwami) znajduje siê w
parametrze \fB\-\fP.
\fBset -o\fP bez podania nazwy opcji wy¶wietla
wszystkie opcja i informacjê o ich ustawieniu lub nie;
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
kasuje zarówno opcjê \fB\-x\fP, jak i \fB\-v\fP.
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
\fBtest\fP wylicza \fIwyra¿enia\fP i zwraca kod wyj¶cia zero je¶li
prawda, i kod 1 jeden je¶li fa³sz, a wiêcej ni¿ 1 je¶li wyst±pi³ b³±d.
Zostaje zwykle zastosowane jako komenda warunkowa wyra¿eñ \fBif\fP i
\fBwhile\fP.
Mamy do dyspozycji nastêpuj±ce podstawowe wyra¿enia:
.sp
.TS
afB ltw(2.8i).
\fIci±g\fP	T{
\fIci±g\fP ma niezerow± d³ugo¶æ.  Proszê zwróciæ uwagê, i¿ mog± wyst±piæ
trudno¶ci je¶li \fIci±g\fP oka¿e siê byæ operatorem
(\fIdok³adniej\fP, \fB-r\fP) - ogólnie lepiej jest zamiast tego stosowaæ
test postaci
.RS
\fB[ X"\fP\fIciag\fP\fB" != X ]\fP
.RE
(podwójne wycytowania zostaj± zastosowane je¶li
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
\fIplik\fP jest potokiem nazwanym
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
w³a¶ciciel \fIpliku\fP zgadza siê z efektywnym user-id pow³oki
T}
\-G \fIplik\fP	T{
grupa \fIpliku\fP  zgadza siê z efektywn± group-id pow³oki
T}
\-h \fIplik\fP	T{
\fIplik\fP jest symbolicznym [WK: twardym?] dowi±zaniem
T}
\-H \fIplik\fP	T{
\fIplik\fP jest zale¿nym od kontekstu katalogiem (tylko sensowne pod HP-UX)
T}
\-L \fIplik\fP	T{
\fIplik\fP jest symbolicznym dowi±zaniem
T}
\-S \fIplik\fP	T{
\fIplik\fP jest gniazdem
T}
\-o \fIopcja\fP	T{
\fIOpcja\fP pow³oki jest ustawiona (patrz komenda \fBset\fP powy¿ej
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
pierwszy \fIplik\fP jest to¿samy z drugim \fIplikiem\fP
T}
\-t\ [\fIfd\fP]	T{
Deskryptor pliku jest przyrz±dem tty.
Je¶li nie zosta³a ustawiona opcja posix (\fBset \-o posix\fP,
patrz Tryb POSIX powy¿ej), wówczas \fIfd\fP mo¿e zostaæ pominiêty,
co oznacza przyjêcie domy¶lnej warto¶ci 1
(zachowanie siê jest wówczas odmienne z powodu specjalnych regu³
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
W szczególno¶ci., \fB[ -w /dev/fd/2 ]\fP sprawdza czy jest dostêpny zapis na
deskryptor pliku 2.
.sp
Proszê zwróciæ uwagê, ¿e zachodz± specjalne regu³y
(zawdziêczane ), je¶li liczba argumentów
do \fBtest\fP lub \fB[\fP \&... \fB]\fP jest mniejsza od piêciu:
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête, tak ¿e pozostaje tylko
jeden argument, wówczas zostaje przeprowadzony test d³ugo¶ci ci±gu
(ponownie, nawet je¶li dany argument jest unarnym operatorem);
je¶li pierwsze argumenty \fB!\fP mog± zostaæ pominiête tak, ¿e pozostaj± trzy
argumenty i drugi argument jest operatorem binarnym, wówczas zostaje
wykonana dana binarna operacja (nawet je¶li pierwszy argument
jest unarnym operatorem operator, wraz z nieusuniêtym \fB!\fP).
.sp
\fBUwaga:\fP Czêstym b³êdem jest stosowanie \fBif [ $co¶ = tam ]\fP, co
daje wynik negatywny je¶li parametr \fBco¶\fP jest zerowy lub
nieustawiony, zawiera przerwy
(\fItzn.\fP, znaki z \fBIFS\fP), lub gdy jest operatorem jednoargumentowym,
takim jak \fB!\fP lub \fB\-n\fP.  Proszê zamiast tego stosowaæ testy typu
\fBif [ "X$co¶" = Xtam ]\fP.
.\"}}}
.\"{{{  times
.IP \fBtimes\fP
Wy¶wietla zgromadzony czas w przestrzeni u¿ytkownika oraz systemu,
który potrzebowa³a pow³oka i w niej wystartowane
procesy, które siê zakoñczy³y.
.\"}}}
.\"{{{  trap [handler signal ...]
.IP "\fBtrap\fP [\fIobrabiacz\fP \fIsygna³ ...\fP]"
Ustawia obrabiacz, który nale¿y wykonaæ w razie odebrania danego sygna³u.
\fBObrabiacz\fP mo¿e byæ albo zerowym ci±giem, wskazuj±cym na zamiar
ignorowania sygna³ów danego typu, minusem (\fB\-\fP),
wskazuj±cym, ¿e ma zostaæ podjêta akcja domy¶lna dla danego sygna³u
(patrz signal(2 or 3)), lub ci±giem zawieraj±cym komendy pow³oki
które maj± zostaæ wyliczone i wykonane przy pierwszej okazji
(\fItzn.\fP, po zakoñczeniu bie¿±cej komendy, lub przed
wypisaniem nastêpnego symboli zachêty \fBPS1\fP) po odebraniu
jednego z danych sygna³ów.
\fBSignal\fP jest nazw± danego sygna³u (\fItak jak np.\fP, PIPE lub ALRM)
lub jego numerem (patrz komenda \fBkill \-l\fP powy¿ej).
Istniej± dwa specjalne sygna³y: \fBEXIT\fP (równie¿ znany jako \fB0\fP),
który zostaje wykonany tu¿ przed zakoñczeniem pow³oki, i
\fBERR\fP który zostaje wykonany po wyst±pieniu b³êdu
(b³êdem jest co¶, co powodowa³oby zakoñczenie pow³oki
je¶li zosta³y ustawione opcje \fB\-e\fP lub \fBerrexit\fP \(em
patrz komendy \fBset\fP powy¿ej).
Obrabiacze \fBEXIT\fP zostaj± wykonane w otoczeniu
ostatniej wykonywanej komendy.
Proszê zwróciæ uwagê, ¿e dla pow³ok nieinterakcyjnych obrabiacz wykroczeñ
nie mo¿e zostaæ zmieniony dla sygna³ów, które by³y ignorowane podczas
startu danej pow³oki.
.sp
Bez argumentów, \fBtrap\fP wylicza, jako seria komend \fBtrap\fP,
obecny status wykroczeñ, które zosta³y ustawione od czasu startu pow³oki.
.sp
.\" todo: add these features (trap DEBUG, trap ERR/EXIT in function)
Traktowanie sygna³ów \fBDEBUG\fP oraz \fBERR\fP i
\fBEXIT\fP i oryginalnej pow³oki Korna w funkcjach nie zosta³o jak do tej
pory jeszcze zrealizowane.
.\"}}}
.\"{{{  true
.IP \fBtrue\fP
Komenda koñcz±ca siê zerow± warto¶ci± kodu wyj¶cia.
.\"}}}
.\"{{{  typeset [[+-Ulprtux] [-L[n]] [-R[n]] [-Z[n]] [-i[n]] | -f [-tux]] [name[=value] ...]
.IP "\fBtypeset\fP [[\(+-Ulprtux] [\fB\-L\fP[\fIn\fP]] [\fB\-R\fP[\fIn\fP]] [\fB\-Z\fP[\fIn\fP]] [\fB\-i\fP[\fIn\fP]] | \fB\-f\fP [\fB\-tux\fP]] [\fInazwa\fP[\fB=\fP\fIwarto¶æ\fP] ...]"
Wy¶wietlaj lub ustawiaj warto¶ci atrybutów parametrów.
Bez argumentów \fInazwa\fP, zostaj± wy¶wietlone atrybuty parametrów:
je¶li brak argumentów bêd±cych opcjami, zostaj± wy¶wietlone atrybuty
wszystkich parametrów jako komendy typeset; je¶li podano opcjê
(lub \fB\-\fP bez litery opcji)
wszystkie parametry i ich warto¶ci posiadaj±ce dany atrybut zostaj±
wy¶wietlone;
je¶li opcje zaczynaj± siê od \fB+\fP, to nie zostaj± wy¶wietlone warto¶ci
parametrów.
.sp
Je¶li podano argumenty If \fInazwa\fP, zostaj± ustawione atrybuty
danych parametrów (\fB\-\fP) lub odpowiednio wykasowane (\fB+\fP).
Warto¶ci parametrów mog± zostaæ ewentualnie podane.
Je¶li typeset zostanie zastosowane wewn±trz funkcji,
wszystkie nowotworzone parametry pozostaj± lokalne dla danej funkcji.
.sp
Je¶li zastosowano \fB\-f\fP, wówczas typeset operuje na atrybutach funkcji.
Tak jak dla parametrów, je¶li brak \fInazw\fPs, zostaj± wymienione funkcje
wraz z ich warto¶ciami (\fItzn.\fP, definicjami), chyba ¿e podano
opcje zaczynaj±ce siê od \fB+\fP, w którym wypadku
zostaj± wymienione tylko nazwy funkcji.
.sp
.TS
expand;
afB lw(4.5i).
\-L\fIn\fP	T{
Atrybut przyrównania do lewego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bie¿±ca szeroko¶æ parametru
(lub szeroko¶æ pierwszej przyporz±dkowywanej warto¶ci).
Prowadz±ce bia³e przerwy (tak jak i zera, je¶li
ustawiono opcjê \fB\-Z\fP) zostaj± wykasowane.
Je¶li trzeba, warto¶ci zostaj± albo obciête lub dodane przerwy
do osi±gniêcia wymaganej szeroko¶ci.
T}
\-R\fIn\fP	T{
Atrybut przyrównania do prawego brzegu: \fIn\fP oznacza szeroko¶æ pola.
Je¶li brak \fIn\fP, to zostaje zastosowana bie¿±ca szeroko¶æ parametru
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
Tej opcji brak w oryginalnej pow³oce Korna.
T}
\-f	T{
Tryb funkcji: wy¶wietlaj lub ustawiaj funkcje i ich atrybuty, zamiast
parametrów.
T}
\-l	T{
Atrybut ma³ej litery: wszystkie znaki z du¿ej litery zostaj±
w warto¶ci zamienione na ma³e litery.
(W oryginalnej pow³oce Korna, parametr ten oznacza³ `d³ugi ca³kowity'
gdy by³ stosowany w po³±czeniu z opcj± \fB\-i\fP).
T}
\-p	T{
Wypisuj pe³ne komendy typeset, które mo¿na nastêpnie zastosowaæ do
odtworzenia danych atrybutów (lecz nie warto¶ci) parametrów.
To jest wynikiem domy¶lnym (opcja ta istnieje w celu zachowania
kompatybilno¶ci z ksh93).
T}
\-r	T{
Atrybut wy³±cznego odczytu: parametry z danym atrybutem
nie przyjmuj± nowych warto¶ci i nie mog± zostaæ wykasowane.
Po ustawieniu tego atrybutu nie mo¿na go ju¿ wiêcej odaktywniæ.
T}
\-t	T{
Atrybut zaznaczenia: bez znaczenia dla pow³oki; istnieje jedynie do
zastosowania w aplikacjach.
.sp
Dla funkcji \fB\-t\fP, to atrybut ¶ledzenia.
Je¶li zostaj± wykonywane funkcje z atrybutem ¶ledzenia, to
opcja pow³oki \fBxtrace\fP (\fB\-x\fP) zostaje tymczasowo w³±czona.
T}
\-u	T{
Atrybut du¿ej litery: wszystkie znaki z ma³ej litery w warto¶ciach zostaj±
przestawione na du¿e litery.
(W oryginalnej pow³oce Korna, ten parametr oznacza³ `ca³kowity bez znaku' je¶li
zosta³ zastosowany w po³±czeniu z opcj± \fB\-i\fP, oznacza³o to, ¿e
nie mo¿na by³o stosowaæ du¿ych liter dla baz wiêkszych ni¿ 10.
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
Wy¶wietlij lub ustaw ograniczenia dla procesów.
Je¶li brak opcji, to ograniczenie ilo¶ci plików (\fB\-f\fP) zostaje
przyjête jako domy¶le.
\fBwarto¶æ\fP, je¶li podana, mo¿e byæ albo wyra¿eniem arytmetycznym
lub s³owem \fBunlimited\fP (nieograniczone).
Ograniczenia dotycz± pow³oki i wszelkich procesów przez ni± tworzonych
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
Ustaw jedynie ograniczenie twarde (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-S\fP
Ustaw jedynie ograniczenie miêkkie (domy¶lnie zostaj± ustawione zarówno
ograniczenie twarde jak te¿ i miêkkie).
.IP \fB\-c\fP
Ogranicz wielko¶ci plików zrzutów core do \fIn\fP bloków.
.IP \fB\-d\fP
Ogranicz wielko¶æ obszaru danych do \fIn\fP kilobajtów.
.IP \fB\-f\fP
Ogranicz wielko¶æ plików zapisywanych przez pow³okê i jej programy pochodne
do \fIn\fP plików (pliki dowolnej wielko¶ci mog± byæ wczytywane).
.IP \fB\-l\fP
Ogranicz do \fIn\fP kilobajtów ilo¶æ podkluczonej (podpiêtej) fizycznej pamiêci.
.IP \fB\-m\fP
Ogranicz do \fIn\fP kilobajtów ilo¶æ u¿ywanej fizycznej pamiêci.
.IP \fB\-n\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie otwartych deskryptorów plików.
.IP \fB\-p\fP
Ogranicz do \fIn\fP ilo¶æ jednocze¶nie wykonywanych procesów danego
u¿ytkownika.
.IP \fB\-s\fP
Ogranicz do \fIn\fP kilobajtów rozmiar obszaru stosu.
.IP \fB\-t\fP
Ogranicz do \fIn\fP sekund czas zu¿ywany przez pojedyncze procesy.
.IP \fB\-v\fP
Ogranicz do \fIn\fP kilobajtów ilo¶æ u¿ywanej wirtualnej pamiêci;
pod niektórymi systemami jest to maksymalny stosowany wirtualny adres
(w bajtach a nie kilobajtach).
.IP \fB\-w\fP
Ogranicz do \fIn\fP kilobajtów ilo¶æ stosowanego obszaru odk³adania.
.PP
Dla \fBulimit\fP blok to zawsze 512 bajtów.
.RE
.\"}}}
.\"{{{  umask [-S] [mask]
.IP "\fBumask\fP [\fB\-S\fP] [\fImaska\fP]"
.RS
Wy¶wietl lub ustaw maskê zezwoleñ w tworzeniu plików, lub umask
(patrz \fIumask\fP(2)).
Je¶li zastosowano opcjê \fB\-S\fP, maska jest wy¶wietlana lub podawana
symbolicznie, w przeciwnym razie jako liczba ósemkowa.
.sp
Symboliczne maski s± podobne do tych stosowanych przez \fIchmod\fP(1):
.RS
[\fBugoa\fP]{{\fB=+-\fP}{\fBrwx\fP}*}+[\fB,\fP...]
.RE
gdzie pierwsza grupa znaków jest czê¶ci± \fIkto\fP, a druga grupa czê¶ci±
\fIop\fP, i ostatnio grupa czê¶ci± \fIperm\fP.
Czê¶æ \fIkto\fP okre¶la, która czê¶æ umaski ma zostaæ zmodyfikowana.
Litery oznaczaj±:
.RS
.IP \fBu\fP
prawa u¿ytkownika
.IP \fBg\fP
prawa grupy
.IP \fBo\fP
prawa pozosta³ych (nieu¿ytkownika, niegrupy)
.IP \fBa\fP
wszelkie prawa naraz (u¿ytkownika, grupy i pozosta³ych)
.RE
.sp
Czê¶æ \fIop\fP wskazujê jak prawa \fIkto\fP maj± byæ zmienione:
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
Gdy stosuje siê maski symboliczne, to opisuj± one, które prawa mog± zostaæ
udostêpnione (w przeciwieñstwie do masek ósemkowych, w których ustawienie
bitu oznacza, ¿e ma on zostaæ wykasowany).
Przyk³ad: `ug=rwx,o=' ustawia maskê tak, ¿e pliki nie bêd± odczytywalne,
zapisywalne i wykonywalne przez `innych'. Jest ono równowa¿ne
(w wiêkszo¶ci systemów) oktalnej masce `07'.
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
Status zakoñczenia jest niezerowy je¶li który¶ z danych parametrów by³
ju¿ wykasowany, a zero z przeciwnym razie.
.\"}}}
.\"{{{  wait [job]
.IP "\fBwait\fP [\fIzadanie\fP]"
Czekaj na zakoñczenie danego zadania/zadañ.
Kodem wyj¶cia wait jest kod ostatniego podanego zadania:
je¶li dane zadanie zosta³o zabite sygna³em, kod wyj¶cia wynosi
128 + number danego sygna³u (patrz \fBkill \-l\fP \fIkod_wyj¶cia\fP
powy¿ej); je¶li ostatnie dane zadanie nie mo¿e zostaæ odnalezione
(bo nigdy nie istnia³o, lub ju¿ zosta³o zakoñczone), to kod wyj¶cia
zakoñczenia wait wynosi 127.
Patrz Kontrola Zadañ poni¿ej w celu informacji o
formacie \fIzadanie\fP.
\fBWait\fP zostaje zakoñczone je¶li zajdzie sygna³, na który zosta³
ustawiony obrabiacz, lub gdy zostanie odebrany sygna³ HUP, INT lub
QUIT.
.sp
Je¶li nie podano zadañ, \fBwait\fP wait czeka na zakoñczenie
wszelkich obecnych zadañ (je¶li istniej± takowe) i koñczy siê
zerowym kodem wyj¶cia.
Je¶li kontrola zadañ zosta³a w³±czona, to zostaje wy¶wietlony
kod wyj¶cia zadañ
(to nie ma miejsca, je¶li zadania zosta³y jawnie podane).
.\"}}}
.\"{{{  whence [-pv] [name ...]
.IP "\fBwhence\fP [\fB\-pv\fP] [nazwa ...]"
Dla ka¿dej nazwy zostaje wymieniony odpowiednio typ komendy
(reserved word, built-in, alias,
function, tracked alias lub executable).
Je¶li podano opcjê \fB\-p\fP, to zostaje odszukana ¶cie¿ka
dla \fInazw\fP, bêd±cych zarezerwowanymi s³owami, aliasami, itp.
Bez opcji \fB\-v\fP \fBwhence\fP dzia³a podobnie do \fBcommand \-v\fP,
poza tym, ¿e \fBwhence\fP odszukuje zarezerwowane s³owa i nie wypisuje
aliasów jako komendy alias;
z opcj± \fB\-v\fP, \fBwhence\fP to to samo co \fBcommand \-V\fP.
Zauwa¿, ¿e dla \fBwhence\fP, opcja \fB\-p\fP nie ma wp³ywu
na przeszukiwan± ¶cie¿kê, tak jak dla \fBcommand\fP.
Je¶li typ jednej lub wiêcej spo¶ród nazw nie móg³ zostaæ ustalony
to kod wyj¶cia jest niezerowy.
.\"}}}
.\"}}}
.\"{{{  job control (and its built-in commands)
.SS "Kontrola zadañ"
Kontrola zadañ oznacza zdolno¶æ pow³oki to monitorowania i kontrolowania
wykonywanych \fBzadañ\fP,
które s± procesami lub grupami procesów tworzonych przez komendy lub
potoki.
Pow³oka przynajmniej ¶ledzi status obecnych zadañ w tle
(\fItzn.\fP, asynchronicznych); t± informacjê mo¿na otrzymaæ
wykonuj±c komendê \fBjobs\fP.
Je¶li zosta³a uaktywniona pe³na kontrola zadañ
(stosuj±c \fBset \-m\fP lub
\fBset \-o monitor\fP), tak jak w pow³okach interakcyjnych,
to procesy pewnego zadania zostaj± umieszczane we w³asnej grupie
procesów, pierwszoplanowe zadnia mog± zostaæ zatrzymane przy pomocy
klawisza wstrzymania z terminalu (zwykle ^Z),
zadania mog± zostaæ ponownie podjête albo na pierwszym planie albo
w tle, stosuj±c odpowiednio komendy \fBfg\fP i \fBbg\fP,
i status terminala zostaje zachowany a nastêpnie odtworzony, je¶li
zadanie na pierwszym planie zostaje zatrzymane lub odpowiednio
wznowione.
.sp
Proszê zwróciæ uwagê, ¿e tylko komendy tworz±ce procesy
(\fItzn.\fP,
komendy asynchroniczne, komendy podpow³ok i niewbudowane komendy
nie bêd±ce funkcjami) mog± zostaæ wstrzymane; takie komendy
jak \fBread\fP nie mog± tego.
.sp
Gdy zostaje stworzone zadanie, to przyporz±dkowuje mu siê numer zadania.
Dla interakcyjnych pow³ok, numer ten zostaje wy¶wietlony w \fB[\fP..\fB]\fP,
i w nastêpstwie identyfikatory procesów w zadaniu, je¶li zostaje
wykonywane asynchroniczne zadanie.
Do zadania mo¿emy odnosiæ siê w komendach \fBbg\fP, \fBfg\fP, \fBjobs\fP,
\fBkill\fP i
\fBwait\fP albo poprzez id ostatniego procesu w potoku komend
(tak jak jest on zapisywany w parametrze \fB$!\fP) lub poprzedzaj±c
numer zadania znakiem procentu (\fB%\fP).
Równie¿ nastêpuj±ce sekwencjê z procentem mog± byæ stosowane do
odnoszenia siê do zadañ:
.sp
.TS
expand;
afB lw(4.5i).
%+	T{
Ostatnio zatrzymane zadanie lub, gdy brak zatrzymanych zadañ, najstarsze
wykonywane zadanie.
T}
%%\fR, \fP%	T{
To samo co \fB%+\fP.
T}
%\-	T{
Zadanie, które by³oby pod \fB%+\fP gdyby nie zosta³o zakoñczone.
T}
%\fIn\fP	T{
Zadanie z numerem zadania \fIn\fP.
T}
%?\fIci±g\fP	T{
Zadanie zawieraj±ce ci±g \fIci±g\fP (wystêpuje b³±d, gdy odpowiada mu
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
pow³oka wy¶wietla nastêpuj±ce informacje o statusie:
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
Wskazuje obecny stan danego zadania
i mo¿e to byæ
.RS
.IP "\fBRunning\fP"
Zadanie nie jest ani wstrzymane ani zakoñczone (proszê zwróciæ uwagê, i¿
przebieg nie koniecznie musi oznaczaæ spotrzebowywanie
czasu CPU \(em proces mo¿e byæ zablokowany, czekaj±c na pewne zaj¶cie).
.IP "\fBDone\fP [\fB(\fP\fInumer\fP\fB)\fP]"
zadanie zakoñczone. \fInumer\fP to kod wyj¶cia danego zadania,
który zostaje pominiêty, je¶li wynosi on zero.
.IP "\fBStopped\fP [\fB(\fP\fIsygna³\fP\fB)\fP]"
zadanie zosta³o wstrzymane danym sygna³em \fIsygna³\fP (gdy brak sygna³u,
to zadanie zosta³o zatrzymane przez SIGTSTP).
.IP "\fIopis-sygna³u\fP [\fB(core dumped)\fP]"
zadanie zosta³o zabite sygna³em (\fItzn.\fP, Memory\ fault,
Hangup, \fIitp.\fP \(em zastosuj
\fBkill \-l\fP dla otrzymania listy opisów sygna³ów).
Wiadomo¶æ \fB(core\ dumped)\fP wskazuje, ¿e proces stworzy³ plik zrzutu core.
.RE
.IP "\ \fIcommand\fP"
to komenda, która stworzy³a dany proces.
Je¶li dane zadanie zawiera kilka procesów, to ka¿dy proces zostanie wy¶wietlony
w osobnym wierszy pokazuj±cym jego \fIcommand\fP i ewentualnie jego
\fIstatus\fP, je¶li jest on odmienny od statusu poprzedniego procesu.
.PP
Je¶li próbuje siê zakoñczyæ pow³okê, podczas gdy istniej± zadania w
stanie zatrzymania, to pow³oka ostrzega u¿ytkownika, ¿e s± zadania w stanie
zatrzymania i nie koñczy pracy.
Gdy tu¿ potem zostanie podjêta ponowna próba zakoñczenia pow³oki, to
zatrzymane zadania otrzymuj± sygna³ \fBHUP\fP i pow³oka koñczy pracê.
podobnie, je¶li nie zosta³a ustawiona opcja \fBnohup\fP,
i s± zadania w pracy, gdy zostanie podjêta próba zakoñczenia pow³oki
zameldowania, pow³oka ostrzega u¿ytkownika i nie koñczy pracy.
Gdy tu¿ potem zostanie ponownie podjêta próba zakoñczenia pracy pow³oki,
to bie¿±ce procesy otrzymuj± sygna³ \fBHUP\fP i pow³oka koñczy pracê.
.\"}}}
.\"{{{  Emacs Interactive Input Line Editing
.SS "Interakcyjna edycja wiersza poleceñ w trybie emacs"
Je¶li zosta³a ustawiona opcja \fBemacs\fP,jest w³±czona interakcyjna
edycja wiersza wprowadzeñ.  \fBOstrze¿enie\fP: Ten tryb zachowuje siê
nieco inaczej ni¿ tryb emacsa w oryginalnej pow³oce Korna
i 8-my bit zostaje wykasowany w trybie emacsa.
W trybie tym ró¿ne komendy edycji (zazwyczaj pod³±czone pod jeden lub wiêcej
znaków steruj±cych) powoduj± natychmiastowe akcje bez odczekiwania
nastêpnego prze³amania wiersza.  Wiele komend edycji jest zwi±zywanych z
pewnymi znakami steruj±cymi podczas odpalania pow³oki; te zwi±zki mog± zostaæ
zmienione przy pomocy nastêpuj±cych komend:
.\"{{{  bind
.IP \fBbind\fP
Obecne zwi±zki zostaj± wyliczone.
.\"}}}
.\"{{{  bind string=[editing-command]
.IP "\fBbind\fP \fIci±g\fP\fB=\fP[\fIkomenda-edycji\fP]"
Dana komenda edycji zostaje podwi±zana pod dany \fBci±g\fP, który
powinien sk³adaæ siê ze znaku steruj±cego (zapisanego przy pomocy
strza³ki w górê \fB^\fP\fIX\fP), poprzedzonego ewentualnie
jednym z dwóch znaków przedsionkownych.  Wprowadzenie danego
\fIci±gu\fP bêdzie wówczas powodowa³o bezpo¶rednie wywo³anie danej
komendy edycji.  Proszê zwróciæ uwagê, ¿e choæ tylko
dwa znaki przedsionkowe (zwykle ESC i ^X) s± wspomagane, to
mog± równie¿ zostaæ podane niektóre ci±gi wieloznakowe.
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
dane \fIpodstawienie\fP, które mo¿e zawieraæ komendy edycji.
.\"}}}
.PP
Nastêpuje lista dostêpnych komend edycji.
Ka¿dy z poszczególnych opisów zaczyna siê nazw± komendy,
liter± \fIn\fP, je¶li komenda mo¿e zostaæ poprzedzona licznikiem,
i wszelkimi klawiszami, do których dana komenda jest pod³±czona
domy¶lnie (w zapisie stosuj±cym notacjê strza³kow±, \fItzn.\fP,
znak ASCII ESC jest pisany jako ^[).
Licznik poprzedzaj±cy komendê wprowadzamy stosuj±c ci±g
\fB^[\fP\fIn\fP, gdzie \fIn\fP to ci±g sk³adaj±cy siê z jednej
lub wiêcej cyfr;
chyba ¿e podano inaczej licznik, je¶li zosta³ pominiêty, wynosi
domy¶lnie 1.
Proszê zwróciæ uwagê, ¿e nazwy komend edycji stosowane s± jedynie
w komendzie \fBbind\fP.  Ponadto, wiele komend edycji jest przydatnych
na terminalach z widocznym kursorem.  Domy¶lne podwi±zania zosta³y wybrane
tak, aby by³y zgodne z odpowiednimi podwi±zaniami Emacsa.
Znaki u¿ytkownika tty (\fIw szczególno¶ci\fP, ERASE) zosta³y
pod³±czenia do stosownych podstawieñ i kasuj± domy¶lne
pod³±czenia.
.\"{{{  abort ^G
.IP "\fBabort ^G\fP"
Przydatne w odpowiedzi na zapytanie o wzorzec \fBprzeszukiwania_historii\fP
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
Przesuwa na pocz±tek historii.
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
Je¶li bie¿±cy wiersz nie zaczyna siê od znaku komentarza, zostaje on
dodany na pocz±tku wiersza i wiersz zostaje wprowadzony (tak jakby
naci¶niêto prze³amanie wiersza), w przeciwnym razie istniej±ce znaki
komentarza zostaj± usuniête i kursor zostaje umieszczony na pocz±tku
wiersza.
.\"}}}
.\"{{{  complete ^[^[
.IP "\fBcomplete ^[^[\fP"
Automatycznie dope³nia tyle ile jest jednoznaczne w nazwie komendy
lub nazwie pliku zawieraj±cej kursor.  Je¶li ca³a pozosta³a czê¶æ
komendy lub nazwy pliku jest jednoznaczna to przerwa zostaje wy¶wietlona
po wype³nieniu, chyba ¿e jest to nazwa katalogu, w którym to razie zostaje
do³±czone \fB/\fP.  Je¶li nie ma komendy lub nazwy pliku zaczynaj±cej
siê od takiej czê¶ci s³owa, to zostaje wyprowadzony znak dzwonka
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
Automatycznie dope³nia tyle ile jest jednoznaczne z nazwy pliku
zawieraj±cego czê¶ciowe s³owo przed kursorem, tak jak w komendzie
\fBcomplete\fP opisanej powy¿ej.
.\"}}}
.\"{{{  complete-list ^[=
.IP "\fBcomplete-list ^[=\fP"
Wymieñ mo¿liwe dope³nienia bie¿±cego s³owa.
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
Kasuje znaki po kursorze, a¿ do koñca \fIn\fP s³ów.
.\"}}}
.\"{{{  down-history n ^N
.IP "\fBdown-history\fP \fIn\fP \fB^N\fP"
Przewija bufor historii w przód \fIn\fP wierszy (pó¼niej).
Ka¿dy wiersz wprowadzenia zaczyna siê oryginalnie tu¿ po ostatnim
miejscu w buforze historii, tak wiêc
\fBdown-history\fP nie jest przydatny dopóki nie wykonano
\fBsearch-history\fP lub \fBup-history\fP.
.\"}}}
.\"{{{  downcase-word n ^[L, ^[l
.IP "\fBdowncase-word\fP \fIn\fP \fB^[L\fP, \fB^[l\fP"
Zamieñ na ma³e litery nastêpnych \fIn\fP s³ów.
.\"}}}
.\"{{{  end-of-history ^[>
.IP "\fBend-of-history ^[>\fP"
Porusza do koñca historii.
.\"}}}
.\"{{{  end-of-line ^E
.IP "\fBend-of-line ^E\fP"
Przesuwa kursor na koniec wiersza wprowadzenia.
.\"}}}
.\"{{{  eot ^_
.IP "\fBeot ^_\fP"
Dzia³a jako koniec pliku; Jest to przydatne, albowiem tryb edycji
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
Umie¶æ kursor na znaczniku i ustaw znacznik na miejsce, w którym by³
kursor.
.\"}}}
.\"{{{  expand-file ^[*
.IP "\fBexpand-file ^[*\fP"
Dodaje * do bie¿±cego s³owa i zastêpuje dane s³owo wynikiem
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
Przemieszcza do historii numer \fIn\fP.
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
w przeciwnym razie kasuje znaki pomiêdzy kursorem a \fIn\fP-t± kolumn±.
.\"}}}
.\"{{{  list ^[?
.IP "\fBlist ^[?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend lub nazw plików
(je¶li s± takowe), które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursor.
Do nazw katalogów zostaje do³±czone \fB/\fP.
.\"}}}
.\"{{{  list-command ^X?
.IP "\fBlist-command ^X?\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw komend
(je¶li s± takowe), które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursor.
.\"}}}
.\"{{{  list-file ^X^Y
.IP "\fBlist-file ^X^Y\fP"
Wy¶wietla sortowan±, skolumnowan± listê nazw plików
(je¶li s± takowe), które mog³yby dope³niæ czê¶ciowe s³owo zawieraj±ce kursor.
Specyfikatory rodzaju plików zostaj± do³±czone tak jak powy¿ej opisano
pod \fBlist\fP.
.\"}}}
.\"{{{  newline ^J and ^M
.IP "\fBnewline ^J\fP, \fB^M\fP"
Powoduje przetworzenie bie¿±cego wiersza wprowadzeñ przez pow³okê.
Kursor mo¿e znajdowaæ siê aktualnie gdziekolwiek w wierszu.
.\"}}}
.\"{{{  newline-and-next ^O
.IP "\fBnewline-and-next ^O\fP"
Powoduje przetworzenie bie¿±cego wiersza wprowadzeñ przez pow³okê,
po czym nastêpny wiersz z historii staje siê wierszem bie¿±cym.
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
Nastêpny znak zostaje wziêty dos³ownie zamiast jako komenda edycji.
.\"}}}
.\"{{{  redraw ^L
.IP "\fBredraw ^L\fP"
Przerysuj ponownie zachêtê i bie¿±cy wiersz wprowadzenia.
.\"}}}
.\"{{{  search-character-backward n ^[^]
.IP "\fBsearch-character-backward\fP \fIn\fP \fB^[^]\fP"
Szukaj w ty³ w bie¿±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-character-forward n ^]
.IP "\fBsearch-character-forward\fP \fIn\fP \fB^]\fP"
Szukaj w przód w bie¿±cym wierszu \fIn\fP-tego wyst±pienia
nastêpnego wprowadzonego znaku.
.\"}}}
.\"{{{  search-history ^R
.IP "\fBsearch-history ^R\fP"
Wejd¼ w krocz±cy tryb szukania.  Wewnêtrzna lista historii zostaje
przeszukiwana wstecz za komendami odpowiadaj±cymi wprowadzeniu.
pocz±tkowe \fB^\fP w szukanym ci±gu zakotwicza szukanie.  Klawisz przerwania
powoduje opuszczenie trybu szukania.
Inne komendy zostan± wykonywane po opuszczeniu trybu szukania.
Ponowne komendy \fBsearch-history\fP kontynuuj± szukanie wstecz
do nastêpnego poprzedniego wyst±pienia wzorca.  Bufor historii
zawiera tylko skoñczon± ilo¶æ wierszy; dla potrzeby najstarsze zostaj±
wyrzucone.
.\"}}}
.\"{{{  set-mark-command ^[<space>
.IP "\fBset-mark-command ^[\fP<space>"
Postaw znacznik na bie¿±cej pozycji kursora.
.\"}}}
.\"{{{  stuff
.IP "\fBstuff\fP"
Pod systemami to wspomagaj±cymi, wypycha pod³±czony znak  z powrotem
do wej¶cia terminala, gdzie mo¿e on zostaæ specjalnie przetworzony przez
terminal.  Jest to przydatne np. dla opcji BRL \fB^T\fP minisystata.
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
poprzedni i bie¿±cy znak, po czym przesuwa kursor jeden znak na prawo.
.\"}}}
.\"{{{  up-history n ^P
.IP "\fBup-history\fP \fIn\fP \fB^P\fP"
Przewija bufor historii \fIn\fP wierszy wstecz (wcze¶niej).
.\"}}}
.\"{{{  upcase-word n ^[U, ^[u
.IP "\fBupcase-word\fP \fIn\fP \fB^[U\fP, \fB^[u\fP"
Zamienia nastêpnych \fIn\fP s³ów w du¿e litery.
.\"}}}
.\"{{{  version ^V
.IP "\fBversion ^V\fP"
Wypisuje wersjê ksh.  Obecny bufor edycji zostaje odtworzony
gdy tylko zostanie naci¶niêty jakikolwiek klawisz
(po czym ten klawisz zostaje przetworzony, chyba ¿e
 jest to przerwa).
.\"}}}
.\"{{{  yank ^Y
.IP "\fByank ^Y\fP"
Wprowad¼ ostatnio skasowany ci±g tekstu na bie¿±c± pozycjê kursora.
.\"}}}
.\"{{{  yank-pop ^[y
.IP "\fByank-pop ^[y\fP"
bezpo¶rednio po \fByank\fP, zamienia wprowadzony tekst na
nastêpny poprzednio skasowany ci±g tekstu.
.\"}}}
.\"}}}
.\"{{{  Vi Interactive Input Line Editing
.\"{{{  introduction
.SS "Interkacyjny tryb edycji wiersza poleceñ vi"
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
komenda \fB_\fP dzia³a odmiennie (w ksh jest to komenda ostatniego argumentu,
a w vi przechodzenie do pocz±tku bie¿±cego wiersza),
.IP \ \ \(bu
komendy \fB/\fP i \fBG\fP poruszaj± siê w kierunkach odwrotnych do komendy
\fBj\fP
.IP \ \ \(bu
brak jest komend, które nie maj± znaczenia w edytorze obs³uguj±cym jeden
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
W trybie wprowadzania, wiêkszo¶æ znaków zostaje po prostu umieszczona
w buforze na bie¿±cym miejscu kursora w kolejno¶ci ich wpisywania,
chocia¿ niektóre znaki zostaj± traktowane specjalnie.
W szczególno¶ci nastêpuj±ce znaki odpowiadaj± obecnym ustawieniom tty
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
bezpo¶rednio nastêpny: nastêpny naci¶niêty znak nie zostaje traktowany
specjalnie (mo¿na tego u¿yæ do wprowadzenia opisywanych tu znaków)
T}
^J ^M	T{
koniec wiersza: bie¿±cy wiersz zostaje wczytany, rozpoznany i wykonany
przez pow³okê
T}
<esc>	T{
wprowadza edytor w tryb komend (patrz poni¿ej)
T}
^E	T{
wyliczanie komend i nazw plików (patrz poni¿ej)
T}
^F	T{
dope³nianie nazw plików (patrz poni¿ej).
Je¶li zostanie u¿yte dwukrotnie, to wówczas wy¶wietla listê mo¿liwych
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
w ostatniej kolumnie, wskazuj±cy odpowiednio na wiêcej znaków po, przed i po, oraz
przed obecn± pozycj±.
Wiersz jest przewijany poziomo w razie potrzeby.
.\"}}}
.\"{{{  command mode
.PP
W trybie komend, ka¿dy znak zostaje interpretowany jako komenda.
Znaki którym nie odpowiada ¿adna komenda, które s± niedopuszczaln±
komend± lub s± komendami nie do wykonania, wszystkie wyzwalaj± dzwonek.
W nastêpuj±cych opisach komend, \fIn\fP wskazuje, ¿e komendê mo¿na
poprzedziæ numerem (\fItzn.\fP, \fB10l\fP przesuwa w prawo o 10
znaków); gdy brak przedrostka numerowego, to zak³ada siê, ¿e \fIn\fP
jest równe 1, chyba ¿e powiemy inaczej.
Zwrot `bie¿±ca pozycja' odnosi siê do pozycji pomiêdzy kursorem
a znakiem przed nim.
`S³owo' to ci±g liter, cyfr lub podkre¶leñ
albo ci±g nie nieliter, niecyfr, niepodkre¶leñ, niebia³ych-znaków
(\fItak wiêc\fP, ab2*&^ zawiera dwa s³owa), oraz `du¿e s³owo' jest ci±giem
niebia³ych znaków.
.\"{{{  Special ksh vi commands
.IP "Specjalne ksh komendy vi"
Nastêpuj±cych komend brak lub s± one odmienne od tych w normalnym
edytorze plików vi:
.RS
.IP "\fIn\fP\fB_\fP"
wprowad¼ przerwê z nastêpstwem \fIn\fP-tego du¿ego s³owa
z ostatniej komendy w historii na bie¿±cej pozycji i wejd¼ w tryb
wprowadzania; je¶li nie podano \fIn\fP to domy¶lnie zostaje wprowadzone
ostatnie s³owo.
.IP "\fB#\fP"
wprowad¼ znak komentarza (\fB#\fP) na pocz±tku bie¿±cego wiersza
i przeka¿ ten wiersz do pow³oki ( tak samo jak \fBI#^J\fP).
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, z tym ¿e, je¶li nie podano \fIn\fP
to dotyczy to ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fBv\fP"
edytuj wiersze \fIn\fP stosuj±c edytor vi;
je¶li nie podano \fIn\fP, to edytuje bie¿±cy wiersz.
W³a¶ciw± wykonywan± komend± jest
`\fBfc \-e ${VISUAL:-${EDITOR:-vi}}\fP \fIn\fP'.
.IP "\fB*\fP i \fB^X\fP"
dope³nianie komendy lub nazwy pliku zostaje zastosowane do obecnego du¿ego
s³owa (po dodaniu *, je¶li to s³owo nie zawiera ¿adnych znaków dope³niania
nazw plików) - du¿e s³owo zostaje zast±pione s³owami wynikowymi.
Je¶li bie¿±ce du¿e s³owo jest pierwszym w wierszu (lub wystêpuje po
jednym z nastêpuj±cych znaków: \fB;\fP, \fB|\fP, \fB&\fP, \fB(\fP, \fB)\fP)
i nie zawiera uko¶nika (\fB/\fP) to rozwijanie komendy zostaje wykonane,
w przeciwnym razie zostaje wykonane rozwijanie nazwy plików.
Rozwijanie komend podpasowuje du¿e s³owo pod wszelkie aliasy, funkcje
i wbudowane komendy jak i równie¿ wszelkie wykonywalne pliki odnajdywane
przeszukuj±c katalogi wymienione w parametrze \fBPATH\fP.
Rozwijanie nazw plików dopasowuje du¿e s³owo do nazw plików w bie¿±cym
katalogu.
Po rozwiniêciu, kursor zostaje umieszczony tu¿ po
ostatnim s³owie na koñcu i edytor jest w trybie wprowadzania.
.IP "\fIn\fP\fB\e\fP, \fIn\fP\fB^F\fP, \fIn\fP\fB<tab>\fP and \fIn\fP\fB<esc>\fP"
dope³nianie nazw komend/plików:
zastêpuje bie¿±ce du¿e s³owo najd³u¿szym, jednoznacznym
dopasowaniem otrzymanym przez rozwiniêcie nazwy komendy/pliku.
\fB<tab>\fP zostaje jedynie rozpoznane je¶li zosta³a w³±czona opcja
\fBvi-tabcomplete\fP, podczas gdy \fB<esc>\fP zostaje jedynie rozpoznane
je¶li zosta³a w³±czona opcja \fBvi-esccomplete\fP (patrz \fBset \-o\fP).
Je¶li podano \fIn\fP to zostaje u¿yte \fIn\fP-te mo¿liwe
dope³nienie (z tych zwracanych przez komendê wyliczania dope³nieñ nazw
komend/plików).
.IP "\fB=\fP and \fB^E\fP"
wyliczanie nazw komend/plików: wymieñ wszystkie komendy lub pliki
pasuj±ce pod obecne du¿e s³owo.
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
przesuñ siê do kolumny 0.
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
odnajd¼ wzór: edytor szuka do przodu najbli¿szego nawiasu
zamykaj±cego (okr±g³ego, prostok±tnego lub klamrowego),
a nastêpnie przesuwa siê miêdzy nim a odpowiadaj±cym mu
nawiasem otwieraj±cym.
.IP "\fIn\fP\fBf\fP\fIc\fP"
przesuñ siê w przód do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBF\fP\fIc\fP"
przesuñ siê w ty³ do \fIn\fP-tego wyst±pienia znaku \fIc\fP.
.IP "\fIn\fP\fBt\fP\fIc\fP"
przesuñ siê w przód tu¿ przed \fIn\fP-te wyst±pienie znaku \fIc\fP.
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
przejd¼ do \fIn\fP-tego nastêpnego wiersza w historii.
.IP "\fIn\fP\fBk\fP and \fIn\fP\fB-\fP and \fIn\fP\fB^P\fP"
przejd¼ do \fIn\fP-tego poprzedniego wiersza w historii.
.IP "\fIn\fP\fBG\fP"
przejd¼ do wiersza \fIn\fP w historii; je¶li brak \fIn\fP, to przenosi
siê do pierwszego zapamiêtanego wiersza w historii.
.IP "\fIn\fP\fBg\fP"
tak jak \fBG\fP, tylko, ¿e je¶li nie podano \fIn\fP to idzie do
ostatnio zapamiêtanego wiersza.
.IP "\fIn\fP\fB/\fP\fIci±g\fP"
szukaj wstecz w historii \fIn\fP-tego wiersza zawieraj±cego
\fIci±g\fP; je¶li \fIci±g\fP zaczyna siê od \fB^\fP, to reszta ci±gu
musi wystêpowaæ na samym pocz±tku wiersza historii aby pasowa³a.
.IP "\fIn\fP\fB?\fP\fIstring\fP"
tak jak \fB/\fP, tylko, ¿e szuka do przodu w historii.
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
bie¿±cej pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBA\fP"
tak jak \fBa\fP, z t± ró¿nic±, ¿e dodaje do koñca wiersza.
.IP "\fIn\fP\fBi\fP"
dodaj tekst \fIn\fP-krotnie: przechodzi w tryb wprowadzania na bie¿±cej
pozycji.
Dodanie zostaje jedynie wykonane, je¶li zostanie ponownie uruchomiony
tryb komendy (\fItzn.\fP, je¶li <esc> zostanie u¿yte).
.IP "\fIn\fP\fBI\fP"
tak jak \fBi\fP, z t± ró¿nic±, ¿e dodaje do tu¿ przed pierwszym niebia³ym
znakiem.
.IP "\fIn\fP\fBs\fP"
zamieñ nastêpnych \fIn\fP znaków (\fItzn.\fP, skasuj te znaki i przejd¼
do trybu wprowadzania).
.IP "\fBS\fP"
zast±p ca³y wiersz: wszystkie znaki od pierwszego niebia³ego znaku
do koñca wiersza zostaj± skasowane i zostaje uruchomiony tryb
wprowadzania.
.IP "\fIn\fP\fBc\fP\fIkomenda-przemieszczenia\fP"
przejd¼ z bie¿±cej pozycji do pozycji wynikaj±cej z \fIn\fP
\fIkomenda-przemieszczenia\fPs (\fItj.\fP, skasuj wskazany region i wejd¼ w tryb
wprowadzania);
je¶li \fIkomend±-przemieszczenia\fP jest \fBc\fP, to wiersz
zostaje zmieniony od pierwszego niebia³ego znaku pocz±wszy.
.IP "\fBC\fP"
zmieñ od obecnej pozycji do koñca wiersza (\fItzn.\fP skasuj do koñca
wiersza i przejd¼ do trybu wprowadzania).
.IP "\fIn\fP\fBx\fP"
skasuj nastêpnych \fIn\fP znaków.
.IP "\fIn\fP\fBX\fP"
skasuj poprzednich \fIn\fP znaków.
.IP "\fBD\fP"
skasuj do koñca wiersza.
.IP "\fIn\fP\fBd\fP\fImove-cmd\fP"
skasuj od obecnej pozycji do pozycji wynikaj±cej z \fIn\fP krotnego
\fImove-cmd\fP;
\fImove-cmd\fP mo¿e byæ komend± przemieszczania (patrz powy¿ej) lub \fBd\fP,
co powoduje skasowanie bie¿±cego wiersza.
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
ca³y wiersz zostaje wyciêty.
.IP "\fBY\fP"
wytnij od obecnej pozycji do koñca wiersza.
.IP "\fIn\fP\fBp\fP"
wklej zawarto¶æ bufora wycinania tu¿ po bie¿±cej pozycji,
\fIn\fP krotnie.
.IP "\fIn\fP\fBP\fP"
tak jak \fBp\fP, tylko ¿e bufor zostaje wklejony na bie¿±cej pozycji.
.RE
.\"}}}
.\"{{{  Miscellaneous vi commands
.IP "Ró¿ne komendy vi"
.RS
.IP "\fB^J\fP and \fB^M\fP"
bie¿±cy wiersz zostaje wczytany, rozpoznany i wykonany przez pow³okê.
.IP "\fB^L\fP and \fB^R\fP"
odrysuj bie¿±cy wiersz.
.IP "\fIn\fP\fB.\fP"
wykonaj ponownie ostatni± komendê edycji \fIn\fP razy.
.IP "\fBu\fP"
odwróæ ostatni± komendê edycji.
.IP "\fBU\fP"
odwróæ wszelkie zmiany dokonane w danym wierszu.
.IP "\fIintr\fP and \fIquit\fP"
znaki terminala przerwy i zakoñczenia powoduj± skasowania bie¿±cego
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
Wszelkie b³êdy w pdksh nale¿y zg³aszaæ pod adresem pdksh@cs.mun.ca.
Proszê podaæ wersjê pdksh (echo $KSH_VERSION), maszynê,
system operacyjny i stosowany kompilator oraz opis jak powtórzyæ dany b³±d
(najlepiej ma³y skrypt pow³oki demonstruj±cy dany b³±d).
Nastêpuj±ce mo¿e byæ równie¿ pomocne, je¶li ma znaczenie
(je¶li nie jeste¶ pewny to podaj to równie¿):
stosowane opcje (zarówno z opcje options.h jak i ustawione
\-o opcje) i twoja kopia config.h (plik generowany przez skrypt
configure).  Nowe wersje pdksh mo¿na otrzymaæ z
ftp://ftp.cs.mun.ca/pub/pdksh/.
.\"}}}
.\"{{{  Authors
.SH AUTORZY
Ta pow³oka powsta³a z publicznego klonu siódmego wydania pow³oki
Bourne'a wykonanego przez Charlesa Forsytha i z czê¶ci pow³oki
BRL autorstwa Doug A.\& Gwyna, Douga Kingstona,
Rona Natalie;a, Arnolda Robbinsa, Lou Salkinda i innych.  Pierwsze wydanie
pdksh stworzy³ Eric Gisin, a nastêpnie troszczyli siê ni± kolejno
John R.\& MacMillan (chance!john@sq.sq.com), i
Simon J.\& Gerraty (sjg@zen.void.oz.au).  Obecnym opiekunem jest
Michael Rendell (michael@cs.mun.ca).
Plik CONTRIBUTORS w dystrybucji ¼róde³ zawiera bardziej kompletn±
listê ludzi i ich wk³adu do rozwoju tej pow³oki.
.PP
T³umaczenie tego podrêcznika na jêzyk polski wykona³ Marcin Dalecki
<dalecki@cs.net.pl>.
.\"}}}
.\"{{{  See also
.SH "ZOBACZ TAK¯E"
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
