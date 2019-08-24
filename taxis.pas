program taxis;
uses crt;
const
  maxtax=1000;
  maxbonos=50;
type

  st6=string[6];
  fech=array[1..3] of byte;
  tcot=array[1..2] of word;   //cota de los bonos

  lis=record
    pat:st6;         // patente
    recau:real;      // cuanto recaudo el taxi
    bonos:real;   // la cantidad de bonos que gano
    kmt:real;        // kilometros totales del taxi
    fecha:fech;      // fechas
    viaje:byte;      // viaje mas largo
  end;

  tax=record
    pat:st6;            // patente
    c_viajes:word;   // La cantidad de viejes que realizo
    recau:real;         // cuanto recaudo el taxi
    Bonos:real;      // bonos que gano
    kmt:real;           // Kilomentros totales
    km:real;            // kilomentros que recorrio desde el ultimo control
    fecha:fech;         // fecha
  end;

  bono=record
    cot:tcot;            // cota pata los bonos
    prebono:real;     // cuanto gana por determinado bono
  end;

  viajes=record
    pat:st6;             // patente
    can_fi:word;      // cantidad de fichas por viaje
  end;

  tvl=array[1..maxtax] of lis;
  tvb=array[1..maxbonos] of bono;
  TAbono=file of bono;
  TAtaxi=file of tax;
  TAviajes=file of viajes;

//-FUNCIONES-Y-PROCEDIMIENTOS------------------------------------------------//
procedure CargaBonos(var bonos:tabono;var tabla:tvb;var cantBonos:byte);
var
  aux:bono;
begin
  reset(bonos);
    CantBonos:=0;
    while not eof(bonos)do
      begin
      read(bonos,aux);
      CantBonos:=cantBonos+1;
      tabla[CantBonos]:=aux;
      end;
    close(bonos);
end;
//---------------------------------------------------------------------------//
function revision(taxi:tax;x:fech;kmmax:real):boolean;
// determinia si un taxi tiene que ir a revision  si se cumplen las dos condiciones
begin
  revision:=((((taxi.fecha[1]) <> x[1]) and ((abs(taxi.fecha[2]-12) + x[2] )>=6) or (taxi.fecha[1]<x[1]-1))or((taxi.fecha[2]) <=(x[2]-6)) or (kmmax <=taxi.km))and (taxi.pat<>'zzz999');
end;
//---------------------------------------------------------------------------//
function bonos(viaje:viajes;tablabonos:tvb;cantb:byte):real;
//determina el bono ganado por viaje
var
  aux:bono;
  i:byte;
  pertenece:boolean;
begin
  pertenece:=false;
  i:=0;
  while (i<=cantB) and not pertenece do
      begin
      i:=i+1;
      aux:=tablabonos[i];
      pertenece:=((viaje.can_fi>=aux.cot[1]) and (viaje.can_fi<=aux.cot[2]));
      end;
  bonos:=aux.prebono;
end;
//---------------------------------------------------------------------------//
procedure ActReg (var taxiAct:lis;taxi:tax;max:byte);
//actualiza el registro taxiAct con la info de taxi y max
begin
  taxiact.pat:=taxi.pat;
  taxiact.recau:=taxi.recau;
  taxiact.bonos:=taxi.bonos;
  taxiact.kmt:=taxi.kmt;
  taxiact.fecha:=taxi.fecha;
  taxiact.viaje:=max;
end;
//---------------------------------------------------------------------------//
procedure modifica(var taxi:tax;viaje:viajes;tablabonos:tvb;cantb:byte);
begin
  taxi.c_viajes:=taxi.c_viajes+1;
  taxi.recau:=taxi.recau + 50 + (25*viaje.can_fi);
  taxi.bonos:=taxi.bonos+bonos(viaje,tablabonos,cantb);
  taxi.km:=taxi.km + viaje.can_fi*0.2;
  taxi.kmt:=taxi.kmt + VIAJE.CAN_FI*0.2;
  //los demas datos se conservan
end;
//---------------------------------------------------------------------------//
procedure actualiza(var a_taxi:TAtaxi;var a_viajes:TAviajes; tablaBonos:tvb;
cantb:byte;VAR V1:TVL;var cantR,cantVPI,canttt,cantt0:word;X:FECH;KMMAX:REAL);
var
    temp:tataxi;
    error:text;
    aux_tax:tax;
    aux_via:viajes;
    auxl:lis;
    max:byte;
begin
    reset(a_viajes);
    assign(temp,'temp.dat');rewrite(temp);
    assign(error,'errores.txt');rewrite(error);
    reset(a_taxi);
    read(a_viajes,aux_via);
    read(a_taxi,aux_tax);
    max:=0;
    CantVPI:=0;
    cantR:=0;
    canttt:=0;//lo inicio en 0 por el centinela
    cantt0:=0;
    while not eof(a_taxi) or not eof(a_viajes) do
        if (aux_tax.pat)<(aux_via.pat) then
            begin {no hay viajes para esta patente de taxi}
             if revision(aux_tax,x,kmmax) then
                begin
                cantR:=CantR+1;
                ActReg(auxl,aux_tax,max);
                v1[cantR]:=auxl;
                end;
            cantt0:=cantt0+1;
            write(temp,aux_tax);
            read(a_taxi,aux_tax);
            canttt:=canttt+1;
            max:=0;
            end
        else
            if (aux_tax.pat)>(aux_via.pat)  then
               begin{no hay taxis para esta patente de viajes}
               CantVPI:=cantVPI+1;
               writeln(error,aux_via.pat:6,aux_via.can_fi:4);
               read(a_viajes,aux_via);
               end
            else
               begin {la patente de taxi y de viaje son iguales}
               while aux_tax.pat=aux_via.pat do
                  begin
                  Modifica(aux_tax,aux_via,tablabonos,cantb);
                  //modifica actualiza el registro
                  //aux_tax con la info del viaje act
                  if max < aux_via.can_fi then
                     max:= aux_via.can_fi;
                  read(a_viajes,aux_via);
                  end;//end while
               if revision(aux_tax,x,kmmax) then
                  begin
                  cantR:=CantR+1;
                  ActReg(auxl,aux_tax,max);
                  v1[cantR]:=auxl;
                  end;
               write(temp,aux_tax);
               read(a_taxi,aux_tax);
               canttt:=canttt+1;
               max:=0;
               end;
  write(temp,aux_tax);
  close(a_taxi);close(a_viajes);close(temp);close(error);
  erase(a_taxi);
  rename(temp,'taxis.dat');
end;

//---------------------------------------------------------------------------//
procedure ordena(var v1:tvl;can:word);
//Ordena el vector de manera asendente por sus kmt
var
  aux:lis;
  i,k,top:integer;
begin
   top:=can;
   repeat
     k:=0;
     for i:=1 to top-1 do
        if v1[i].kmt > v1[i+1].kmt then
           begin
            aux:=v1[i];
            v1[i]:=v1[i+1];
            v1[i+1]:=aux;
            k:=i;
           end;
      top:=k;
   until k<=1;
end;

//---------------------------------------------------------------------------//
PROCEDURE muestra_lista(var v1:tvl; cont:word);
// muestra los taxis que tienen que ir a revicion
var
  i:integer;
begin
  writeln('Pantente   MontoRec   BonosTotales    kmtot      fechaUltC    viajeMasLargo');
  for i:=1 to cont do
  begin
  with v1[i] do
  writeln(pat:6,recau:13:2,'$',bonos:13:2,'$',kmt:13:2,'Km',fecha[1]:8,'/',fecha[2]:3,'/',fecha[3]:3,viaje:10);
  end;
  writeln('Cantidad de taxis para inspeccionar: ',cont);
end;

//---------------------------------------------------------------------------//
procedure listaTaxis(var a_taxi:tataxi; var salida:text);    // muestra el archivo taxis
var
  aux:tax;
begin
  reset(a_taxi);
  writeln('Patente CantViajes MontoRecaudado   BonosTotales   KmTotales   KmRecorrido   FechaUltControl');
  while not eof(a_taxi) do
    begin
    read(a_taxi,aux);
      with aux do
      begin
      writeln(pat:6,c_viajes:6,recau:16:2,'$',bonos:16:2,'$',kmt:13:2,'Km',km:10:2,'Km',fecha[1]:8,'/',fecha[2],'/',fecha[3]);
      writeln(salida,pat:6,c_viajes:6,recau:16:2,'$',bonos:16:2,'$',kmt:13:2,'Km',km:10:2,'Km',fecha[1]:8,'/',fecha[2],'/',fecha[3]);
      end;
    end;
    close(a_taxi);
end;
//-PROGRAMA-PRINCIPAL-----------------------------------------------//
var
   A_taxi:TAtaxi;
   A_viaje:TAviajes;
   a_bonos:tabono;
   tablaBonos:tvb;
   arch:text;
   VTC:tvl; //vector de taxis que deben ir a control
   FecAct:fech;
   cantB:byte; //CANTB cantidad de bonos
   kmmax:real;
   cantC,CantVPI,CanttT,cantt0:word;
   //cantC cantidad de taxis que deben ir a control
   //CantVPI cantidad de viajes con patentes inexistentes
   //canttt cantidad de taxis total
   //cantt0 cantidad de taxis que no hicieron viajes
begin
   clrscr;
   assign(arch,'salida.txt');rewrite(arch);
   assign(a_taxi,'taxis.dat');
   assign(a_viaje,'viajes.dat');
   assign(a_bonos,'tabla_de_bonos.dat');
   {$i-}
   reset(a_taxi);
   {$i+}
   if IOResult<>0 then
     writeln('No se pudo encontrar taxis.dat')
   else
     begin
     {$i-}
     reset(a_viaje);
     {$i+}
     if IOResult<>0 then
        writeln('No se pudo encontrar viajes.dat')
     else
        begin
        {$i-}
        reset(a_bonos);
        {$i+}
        if IOResult<>0 then
           writeln('No se pudo encontrar tabla_de_bonos.dat')
        else
           begin
           close(a_taxi);close(a_viaje);close(a_bonos);
           writeln('Todos los archivos se encontraron');

           CargaBonos(a_bonos,TablaBonos,CantB);
           writeln('ingrese la fecha actual (YY / MM / DD)');
           readln(fecact[1],fecact[2],fecact[3]);
           writeln('Ingrese los KMs maximos para ir a revicion');
           readln(kmmax);

           writeln(arch,'----------------TAXIS-ANTES-DE-ACTUALIZAR------------------------');
           writeln('----------------TAXIS-ANTES-DE-ACTUALIZAR------------------------');
           listaTaxis(a_taxi,arch);

           actualiza(a_taxi,a_viaje,tablabonos,cantb,vtc,cantC,cantVPI,canttt,cantt0,FecAct,kmmax);

           writeln('---------------MUESTRA-TAXIS-ACTUALIZADO------------------------');
           writeln(arch,'---------------MUESTRA-TAXIS-ACTUALIZADO------------------------');
           listaTaxis(a_taxi,arch);
           close(arch);

           writeln('La cantidad de viajes con patentes inexistenes es:',CantVPI);
           if canttt<>0then
              writeln('El porcentaje de taxis que no hicieron viajes: ',(cantt0*100)/canttt:8:2,'%')
           else
              writeln('No hay taxis totales');

           writeln('FechaActual:',FecAct[1]:4,'/',FecAct[2],'/',FecAct[3],'   Kilometros maximos',KMMAX:8:2);

           writeln('---------------MUESTRA-VECTOR-ORDENADO------------------------');
           ordena(vtc,cantC);
           muestra_lista(vtc,cantC);
           end;
        end;
     end;
   readln;
end.