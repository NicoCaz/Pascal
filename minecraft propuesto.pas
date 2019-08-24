program propuesto;
uses
  crt;
type
  TV= array [1..50] of integer;
//-------------------------------------------------------------//
procedure leervec(var A:TV; var N:integer);
var
  i:integer;
Begin
  writeln('ingrese cantidad de elementos');
  readln(N);
  for i:= 1 to N do
    begin
      writeln('ingrese elemento ',i);
      readln(A[i]);
    end;
end;
//------------------------------------------------------------//
function verif(V:TV; N:integer; X:integer):boolean;
var
  i:integer;
begin
  i:= 1;
  while (i<N) and (V[i]<>X) do
    i:=i + 1;
  verif:= V[i] <> X;
end;
//------------------------------------------------------------//
procedure vecsinr(A:TV; N:integer; var B:TV; var M:integer);
var
  i:integer;
Begin
  B[1]:= A[1];
  M:=1;
  for i:=2 to N do
   if verif(B,M,A[i]) then
     begin
       M:=M+1;
       B[M]:=A[i];
     end;
end;
//------------------------------------------------------------//
procedure mostrarvec(A:TV; N:integer);
var
  i:integer;
begin
  writeln('el vector con los elementos sin repetir es');
  for i:= 1 to N do
    Writeln(A[i],' ');
end;
//------------------------------------------------------------//
var
  A,B:TV;
  N,M:integer;
begin
  clrscr;
  leervec(A,N);
  vecsinr(A,N,B,M);
  mostrarvec(B,M);
  readkey;
end.



























