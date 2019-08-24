program act2tp9;
uses crt;
type
  st3=string[3];
  st7=string[7];

  Tarj=record
  ndt:st3;  //numero de tarjeta
  ndp:st7; //nombre de propietario
  Tope:real;
  gastoMes:real;
  end;

  TAT=file of Tarj;//TIPO ARCHIVO TARJETAS

  Op=record
  ndt:st3;//numero de tarjeta
  monto:real;
  codOP:byte; //codigo de operacion
  end;
  TAO=file of OP; //TIPO ARCHIVO OPERACIONES


procedure leeTXT(var dat:TAT);//devuelve archivo de tipo tarjeta
var
  arch:text;
  T:tarj;
begin
  assign(arch,'tarjetazo.txt');
  reset(arch);
  reset(dat);
  while not eof(arch) do
    begin
    readln(arch,t.ndt,t.ndp,t.tope,t.gastomes);
    write(dat,t);
    end;
  close(arch);
  close(dat);
end;

procedure actualiza(var TajDat:tat;var Opedat:tao);
var
  i:byte;
  txt:text;
  Taux:tarj;
  OPaux:OP;
begin
  assign(txt,'comprazo.txt');
  reset(txt);
  reset(tajDat);
  reset(opeDat);                                        //preparo para leer los 3 archivos
//  read(tajdat,taux);
  readln(txt,OPaux.ndt,OPaux.monto,Opaux.codop);        //leo la primer linea del de texto y lo guardo en OPaux operacion auxiliar o actual
  while not eof(txt) do                                 //mientras no se termine el archivo de texto
    begin
    read(tajdat,taux);                                  //leo tajdat y guardo en taux
    //readln(txt,OPaux.ndt,OPaux.monto,Opaux.codop);
    while (OPaux.ndt=taux.ndt)and(Opaux.ndt<>'999') do  //mientras el ndt de la operacion leida de archivo de texto
      begin//comparo operacion con tarjeta               sea igual al ndt de la tarjeta leida de archivo dat
        if opaux.monto>(taux.tope-taux.gastomes)then
          write(opedat,opaux) //rechazo la operacion
        else
          begin
          taux.gastoMes:=opaux.monto+taux.gastoMes;
          seek(tajdat,filepos(tajdat)-1);
          write(tajdat,taux);
          end;
        readln(txt,OPaux.ndt,OPaux.monto,OPaux.codop);
      end;
    end;
  close(txt);   //cierra archivo de texto
  close(tajdat);//cierra archivo TARJETAS.DAT
  close(opedat);//cierra archivo RECHAZADOS.DAT

  reset(tajdat);
  for i:=1 to filesize(tajdat) do
  begin
  read(tajdat,taux);
  writeln(taux.ndt,' ',taux.ndp,' ',taux.tope:8:2,' ',taux.gastoMes:8:2);
  end;

end;



//programa-principal-------------------------------------------------------------//
var
  arch:TAT;
  arch2:TAO;
begin
  clrscr;
  assign(arch,'TARJETAS.DAT');
  leetxt(arch);   //genero tarjetas.dat a partir de un txt
  assign(arch2,'RECHAZADOS.DAT');
  actualiza(arch,arch2);

  readln;
end.
