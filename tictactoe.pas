unit tictactoe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  x,i,wahl,zahler,zz,zeit : integer;            //zz = Zzähler
  gedrückt1,gedrückt2 : array[1..9] of boolean;
  z : string;

implementation

{$R *.dfm}

procedure setzen;
begin
  gedrückt2[wahl] := true;
tbutton(form1.findcomponent('button'+inttostr(wahl))).Caption := 'o';
end;

procedure zufall;

begin
   repeat
           wahl :=  random(9)+1;
           if   (gedrückt1[wahl]) or   (gedrückt2[wahl])  then
             begin
              wahl := 0;
             end;

until wahl<>0;
end;

procedure fallenstellen;
begin
   zz := 0;
repeat
zz := zz+1;


case zz of

//L-falle stellen (manchmal sinnlos zb   xo    zu xox
//                                         x        x

1: z := '271';
2: z := '293';

3: z := '613';
4: z := '679';

5: z := '817';
6: z := '839';

7: z := '497';
8: z := '431';




// doppelfalle stellen  weniger wichtig

9: z := '421';
10: z := '263';
11: z := '689';
12: z := '487';
13: z := '598';

end;

if (gedrückt2[strtoint(z[1])]) and (gedrückt2[strtoint(z[2])]) and not ((gedrückt1[strtoint(z[3])]) or (gedrückt2[strtoint(z[3])]))
then
wahl := strtoint(z[3]);


until zz = 13 ;

end;

procedure ersteZüge;
begin
 if (gedrückt1[1] or gedrückt2[1]) and (not gedrückt1[7] and not gedrückt2[7])   then
wahl := 7;



if not gedrückt1[9] and not gedrückt2[9] then
wahl := 9;


if not gedrückt1[5] and not gedrückt2[5] then
wahl := 5;
end;

procedure  angegriffen  ;
begin
   zz := 0;
repeat
zz := zz+1;


case zz of



// doppelfallenabwehr  weniger wichtig

1: z := '421';
2: z := '263';
3: z := '689';
4: z := '487';

//  L fallenabwehr

5: z := '271';
6: z := '293';

7: z := '613';
8: z := '679';

9: z := '817';
10: z := '839';

11: z := '497';
12: z := '431';

//doppelfalle diagonalabwehr  weniger wichtig

13: z := '378';  //diese  hier
14: z := '198';  // und diese hier wurden zu wichtig eingestuft


//normale abwehr wichtig

15: z := '123';
16: z := '132';
17: z := '321';

18: z := '147';
19: z := '174';
20: z := '741';

21: z := '159';
22: z := '195';
23: z := '951';

24: z := '258';
25: z := '285';
26: z := '852';

27: z := '369';
28: z := '396';
29: z := '963';

30: z := '357';
31: z := '375';
32: z := '753';

33: z := '456';
34: z := '465';
35: z := '654';

36: z := '789';
37: z := '798';
38: z := '987';

end;

if (gedrückt1[strtoint(z[1])]) and (gedrückt1[strtoint(z[2])]) and not ((gedrückt1[strtoint(z[3])]) or (gedrückt2[strtoint(z[3])]))
then
begin
wahl := strtoint(z[3]);
end;


until zz = 38 ;
end;

procedure angreifen;
begin
  zz := 0;
repeat
zz := zz+1;


case zz of 
1: z := '123';
2: z := '132';
3: z := '321';

4: z := '147';
5: z := '174';
6: z := '741';

7: z := '159';
8: z := '195';
9: z := '951';

10: z := '258';
11: z := '285';
12: z := '852';

13: z := '369';
14: z := '396';
15: z := '963';

16: z := '357';
17: z := '375';
18: z := '753';

19: z := '456';
20: z := '465';
21: z := '654';

22: z := '789';
23: z := '798';
24: z := '987';
end;

if (gedrückt2[strtoint(z[1])]) and (gedrückt2[strtoint(z[2])]) and not ((gedrückt1[strtoint(z[3])]) or (gedrückt2[strtoint(z[3])]))
then
wahl := strtoint(z[3]);


until zz = 24 ;

end;

procedure compzug;
begin

zufall;                  //zufall das zumindest was gezogen wird falls ihm garnichts einfällt

fallenstellen;           //versucht  zb x    zu  xx    machen
                         //             ox       ox
ersteZüge;               //seine  lieblingszüge (verhindern unteranderem die bekannte falle   ox     )
                                                                                  //         xx
                                                                                  //       o

angegriffen;            // wenn gefahr zb xx besteht mal melden

angreifen;              // wenn möglichkeit zum gewinnen dann setze(wichtigstes)


setzen;                 // setzt den zuletzt!!! gewählten zug

end;






procedure putzen( form: tform);
begin
zahler :=0;
for i  := 1 to 9 do
begin
tbutton(form.findcomponent('button'+inttostr(i))).Caption := '';
gedrückt1[i] := false;
gedrückt2[i] := false;
end;
end;
procedure win(wer : integer);
begin
zahler := zahler+1;
x := 0;

if wer=1 then
begin

if (gedrückt1[1]) and (gedrückt1[2]) and (gedrückt1[3]) then
x :=1;

if (gedrückt1[1]) and (gedrückt1[4]) and (gedrückt1[7]) then
x :=1;

if (gedrückt1[1]) and (gedrückt1[5]) and (gedrückt1[9]) then
x :=1;

if (gedrückt1[2]) and (gedrückt1[5]) and (gedrückt1[8]) then
x :=1;

if (gedrückt1[3]) and (gedrückt1[6]) and (gedrückt1[9]) then
x :=1;

if (gedrückt1[3]) and (gedrückt1[5]) and (gedrückt1[7]) then
x :=1;

if (gedrückt1[4]) and (gedrückt1[5]) and (gedrückt1[6]) then
x :=1;

if (gedrückt1[7]) and (gedrückt1[8]) and (gedrückt1[9]) then
x :=1;
end

else
begin

if (gedrückt2[1]) and (gedrückt2[2]) and (gedrückt2[3]) then
x :=2;

if (gedrückt2[1]) and (gedrückt2[4]) and (gedrückt2[7]) then
x :=2;

if (gedrückt2[1]) and (gedrückt2[5]) and (gedrückt2[9]) then
x :=2;

if (gedrückt2[2]) and (gedrückt2[5]) and (gedrückt2[8]) then
x :=2;

if (gedrückt2[3]) and (gedrückt2[6]) and (gedrückt2[9]) then
x :=2;

if (gedrückt2[3]) and (gedrückt2[5]) and (gedrückt2[7]) then
x :=2;

if (gedrückt2[4]) and (gedrückt2[5]) and (gedrückt2[6]) then
x :=2;

if (gedrückt2[7]) and (gedrückt2[8]) and (gedrückt2[9]) then
x :=2;

end;



if x = 1 then
showmessage('Das Menschenkind hat gewonnen')
else
if x = 2 then
showmessage('Der Rechner hat gesiegt')
else
if zahler=9  then  showmessage('unentschieden');

if (x <> 0) or (zahler=9)  then
putzen(form1);


end;


procedure TForm1.Button1Click(Sender: TObject);
begin
if   (gedrückt1[tbutton(sender).tag]) or   (gedrückt2[tbutton(sender).tag])  then
begin
showmessage('ungültiger Zug');    //hier wurde schonmal geklickt
system.Exit;
end;

//Menschenzug
gedrückt1[tbutton(sender).tag] := true;
tbutton(sender).Caption := 'x';

win(1);      //hat der mensch schon gewonnen? Oder unentschieden?
compzug;     //compi legt
win(2);      //hat der compi schon gewonnen? Oder unentschieden?


end;





procedure TForm1.FormActivate(Sender: TObject);
begin

randomize;
putzen(form1);
end;



end.
