Program sigef ;
type estudante = record
  nome,disc,curso,obs,ob : string; // nome, disciplina, curso e observacoes respectivamente
  idade,cod, num ,pos, faltas: integer; // idade, codigo , enumero e faltas do estudante respectivamente
  val1,val2,val3 :char; // validacao das notas
  n1,n2,n3, med : real;// nota 1, nota2, nota 3 e media respectivamente
  ppf,estado :boolean; // variavel para validar mais de 20 % das faltas
end;
// declaracao de variaveis globais
var
nfpp: real;
testeNulo: boolean;
est,grava : estudante;
arq : file of estudante;
n, codAlt,codigo : integer; //codigo para atualizar
achou : boolean ;// variavel para auxiliar na pesquisa
tot, disp,tot_adm,_ , f_exc,tot_exc, auth : integer;
menup , n1,n2: integer;
s : string;
resp : char;
// fim da declaracao de variaveis globais


//==============================================================================================================

Procedure encerra ;

var
i, p: integer;
msg: string;

Begin
  
  cursoroff;
  clrscr;
  
  gotoxy(26, 4);
  textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
  //  writeln('MAPA DE CONTROLO DE FALTAS' ) ;
  gotoxy(24, 2);
  write('______________________________' ) ;
  gotoxy(24, 5);
  write('______________________________' ) ;
  
  textcolor(lightgreen);
  gotoxy(20,16);
  write(#218);
  for i:=1 to 35 do write(#196);
  write(#191+#10+#8);
  for i:=1 to 1 do write(#179+#10+#8);
  gotoxy(20, 17);
  for i:=1 to 1 do write(#179+#10+#8);
  write(#192);
  for i:=1 to 35 do write(#196);
  write(#217);
  textbackground(black);
  
  p := 0;
  gotoxy(38, 17);
  textcolor(white);
  write(p, '%');
  
  for i:=1 to 35 do
  begin
    
    if      (p < 15) then msg := ' Desligando Sistema...            '
    else if (p < 25) then msg := ' Armazenando Dados...             '
    else if (p < 40) then msg := '  Buscando Erros...               '
    else if (p < 55) then msg := '    Encerrando Rede...              '
    else if (p < 70) then msg := '  Comprimindo Dados...              '
    else if (p < 85) then msg := '  Encerrando Layout...              '
    else if (p < 95) then msg := '  Fechando Interface...             '
    else                  msg := '       Terminado.                   ';
    
    gotoxy(20 + i, 17);
    delay(100) ;
    textbackground(lightgreen );
    textcolor(white);
    write(' ');
    
    if (i <= 17 ) then textbackground(black );
    gotoxy(38, 17);
    
    if (p > 100 ) then p := 100;
    
    write(p, '%');
    gotoxy(28, 19);
    textbackground(black);
    write(msg) ;
    
    p := p + round(100 / 35);
    
  end;
  
  //  PARA FECHAR
  //textbackground(black ); // PARA A TELA FICAR PRETA
  //delay(2500);
  
  
End;

//====================================================================================



//===========================================================================================
procedure confirmasair ;

var
msga: string; // DEPOIS USAR DE PARAMETRO
csc: char;
i, cspos: integer;
csestado: array[1..2] of byte;


procedure quad(x: integer; C:byte);
Var i: integer;
begin
  
  
  
  textcolor(c);
  gotoxy(x,9);
  write(#218);
  for i:=1 to 5 do write(#196);
  write(#191+#10+#8);
  for i:=1 to 1 do write(#179+#10+#8);
  gotoxy(x, 9 + 1);
  for i:=1 to 1 do write(#179+#10+#8);
  write(#192);
  for i:=1 to 5 do write(#196);
  write(#217);
  textbackground(black);
  
end;


Procedure seleciona(selec: integer; c:byte);
Begin
  
  case (selec) of
    1:
    begin
      textcolor(c);
      gotoxy(29, 10);
      write('SIM') ;
    end;
    
    2:
    begin
      textcolor(c);
      gotoxy(45, 10);
      write('NAO') ;
    end;
    
  end;
  
End;



Begin
  
  cursoroff;
  clrscr;
  
  textcolor(white);
  gotoxy(24, 3);      // AJUSTE O TEXTO COM ESPACO. NAO MUDE OS NRS
  msga := '      FECHAR O PROGRAMA?';
  write(msga) ;
  gotoxy(24, 4);
  write('______________________________' ) ;
  
  cspos := 1;
  
  seleciona(1, lightgreen);
  for i := 2 to 2 do seleciona(i, white);
  
  quad(27, lightgreen); // 1
  
  csc := readkey;
  
  while (csc <> #13) do
  begin
    csc:= readkey;
    
    case (csc) of
      
      
      #75:	// ESQUERDA
      begin
        if (cspos > 1) then cspos := cspos - 1;
        
        for i := 1 to 2 do
        begin
          if (i <> cspos) then
          begin
            csestado[i] := black;
            seleciona(i,white);
          end
          else
          begin
            csestado[i] := lightgreen;
            seleciona(i,lightgreen);
          end;
        end;
      end;
      
      
      #77: // DIREITA
      begin
        if (cspos < 2) then cspos := cspos + 1;
        
        for i := 1 to 2 do
        begin
          if (i <> cspos) then
          begin
            csestado[i] := black;
            seleciona(i,white);
          end
          else
          begin
            csestado[i] := lightred;
            seleciona(i,lightred);
          end;
        end;
      end;
      
    end;
    
    quad(27,csestado[1]); // 1
    quad(43,csestado[2]); // 2
    
  end;
  
  if (cspos = 1) then
  begin
    menup := 0;
    encerra;
  end;
  
  
End;


//====================================================================================================================


Procedure formulario ;

var
fc: char;
i, fpos: integer;
festado: array[1..8] of byte;

// VARIAVEIS DE TESTE =====================================================
tnome, tcurso, tdisciplina: string;
tfaltas: integer;
//=======================================================================


procedure quad(x,y: integer; C:byte; a,b: integer);
Var i: integer;
begin
  
  textcolor(c);
  gotoxy(x,y);
  write(#218);
  for i:=1 to a do write(#196);
  write(#191+#10+#8);
  for i:=1 to b do write(#179+#10+#8);
  gotoxy(x, y + 1);
  for i:=1 to b do write(#179+#10+#8);
  write(#192);
  for i:=1 to a do write(#196);
  write(#217);
  textbackground(black);
  
end;


Procedure seleciona(selec: integer; c:byte);
Begin
  
  case (selec) of
    1:
    begin
      textcolor(c);
      gotoxy(11, 12);
      write('NOME DO ESTUDANTE') ;
    end;
    
    2:
    begin
      textcolor(c);
      gotoxy(11, 18);
      write('CURSO') ;
    end;
    
    3:
    begin
      textcolor(c);
      gotoxy(40, 18);
      write('DISCIPLINA') ;
    end;
    
    4:
    begin
      textcolor(c);
      gotoxy(11, 24);
      write('NR. DE FALTAS') ;
    end;
    
    5:
    begin
      textcolor(c);
      gotoxy(11, 32);
      write('NOTA DO PRIMEIRO TESTE') ;
    end;
    
    6:
    begin
      textcolor(c);
      gotoxy(11, 38);
      write('NOTA DO SEGUNDO TESTE') ;
    end;
    
    7:
    begin
      textcolor(c);
      gotoxy(11, 44);
      write('NOTA DO TERCEIRO TESTE') ;
    end;
    
    8:
    begin
      textcolor(c);
      gotoxy(34, 52);
      write('SUBMETER') ;
    end;
  end;
  
End;


// PROGRAMA PRINCIPAL ========================================================================================================================================================================================================================
Begin
  
  clrscr;
  cursoroff;
  
  gotoxy(26, 4);
  textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
  //  writeln('MAPA DE CONTROLO DE FALTAS' ) ;
  gotoxy(24, 2);
  write('______________________________' ) ;
  gotoxy(24, 5);
  write('______________________________' ) ;
  
  
  // BORDA GRANDE
  quad(8,9,white,58,45);
  quad(7,8,white,60,47);
  
  
  quad(10,13,white,25,1); // 1
  quad(10,19,white,25,1); // 2
  quad(39,19,white,25,1); // 3
  quad(10,25,white,25,1); // 4
  quad(10,33,white,25,1); // 5
  quad(10,39,white,25,1); // 6
  quad(10,45,white,25,1); // 7
  
  
  // CRIA QUADRADO DE MENSAGEM DE REPROVA POR FALTAS
  gotoxy(40, 24);
  write('NOTIFICACAO') ;
  quad(39,25,white,25,1);
  
  
  // QUADRO DE CADASTRO
  quad(28,51,white,18,1);
  
  
  for i := 1 to 8 do seleciona(i, white);
End;

//===================================================================================================================



Procedure sobre;
var
f: char;
i: integer;
Begin
  cursoroff;
  clrscr;
  
  gotoxy(29, 4);
  textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
  
  gotoxy(27, 2);
  write('______________________________' ) ;
  gotoxy(27, 5);
  write('______________________________' ) ;
  
  textcolor(white);
  gotoxy(31,29);
  write(#218);
  for i:=1 to 21 do write(#196);
  write(#191+#10+#8);
  for i:=1 to 1 do write(#179+#10+#8);
  gotoxy(31,30);
  for i:=1 to 1 do write(#179+#10+#8);
  write(#192);
  for i:=1 to 21 do write(#196);
  write(#217);
  textbackground(black);
  
  //===========================================
  textcolor(white);
  gotoxy(8,9);
  write(#218);
  for i:=1 to 67 do write(#196);
  write(#191+#10+#8);
  for i:=1 to 15 do write(#179+#10+#8);
  gotoxy(8,10);
  for i:=1 to 15 do write(#179+#10+#8);
  write(#192);
  for i:=1 to 67 do write(#196);
  write(#217);
  textbackground(black);
  
  //===========================================
  
  textcolor(lightgreen);
  gotoxy(78,9);
  write(#10+#8);
  for i:=1 to 17 do write(#179+#10+#8);
  gotoxy(10,26);
  for i:=1 to 67 do write(#196);
  write(#217);
  textbackground(black);
  
  
  textcolor(lightgreen);
  gotoxy(10,12); writeln('SOBRE');
  textcolor(white);
  gotoxy(10,15); writeln('ESTE SOFTWARE FOI CRIADO COM O ENFOQUE DE PROVER MAIS DINAMICA NO');
  gotoxy(10,16); writeln('CADASTRO DOS ESTUDANTES DA UNIVERSIDADE EDUARDO MONDLANE.' ) ;
  gotoxy(10,18); writeln('FOI DESENVOLVIDO POR AUGUSTO CHISSANO, EDILSON RICARDO, FRANCISCO');
  gotoxy(10,19); writeln('JUNIOR, HERCO ZAUZAU, KEIL BAMBO E MILTON JUNIOR.' ) ;
  textcolor(lightgreen);
  gotoxy(10,24); writeln('NOVEMBRO DE 2021.');
  
  textcolor(white);
  gotoxy(35,30); write('[ESC] PARA SAIR') ;
  f := readkey;
  while (f <> #27) do f := readkey;
  
End;

//==============================================================================================================

Procedure loading ;

var
i, p: integer;
msg: string;

Begin
  
  cursoroff;
  
  gotoxy(26, 4);
  textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
  
  gotoxy(24, 2);
  write('______________________________' ) ;
  gotoxy(24, 5);
  write('______________________________' ) ;
  
  textcolor(lightgreen);
  gotoxy(20,16);
  write(#218);
  for i:=1 to 35 do write(#196);
  write(#191+#10+#8);
  for i:=1 to 1 do write(#179+#10+#8);
  gotoxy(20, 17);
  for i:=1 to 1 do write(#179+#10+#8);
  write(#192);
  for i:=1 to 35 do write(#196);
  write(#217);
  textbackground(black);
  
  p := 0;
  gotoxy(38, 17);
  textcolor(white);
  write(p, '%');
  //  delay(1000);
  
  for i:=1 to 35 do
  begin
    
    if      (p < 15) then msg := ' Carregando Sistema...            '
    else if (p < 25) then msg := 'Buscando Dados Salvos...          '
    else if (p < 40) then msg := '  Verificando Erros...            '
  else if (p < 55) then msg := ' Estabelecendo Rede...            '
  else if (p < 70) then msg := '  Organizando Dados...            '
  else if (p < 85) then msg := ' Organizando Layout...            '
  else if (p < 95) then msg := '  Gerando Interface...            '
  else                  msg := '      Iniciando...                ';
  
  gotoxy(20 + i, 17);
  delay(random(250)) ;   // 1000
  textbackground(lightgreen );
  textcolor(white);
  write(' ');
  
  if (i <= 17 ) then textbackground(black );
  gotoxy(38, 17);
  
  if (p > 100 ) then p := 100;
  
  write(p, '%');
  gotoxy(28, 19);
  textbackground(black);
  write(msg) ;
  
  p := p + round(100 / 35);
  
end;

//  PARA FECHAR
textbackground(black ); // PARA A TELA FICAR PRETA
delay(500);
clrscr;

End;


// procedure abrir_arquivo;
procedure abrir_arquivo;
begin
  assign (arq, 'dados.uni');
  { $I-}
  Reset (arq);
  { $I+}
  if (IOResult <> 0 ) then
  Rewrite (arq);
end;
// fim abrir arquivo

// procedure abrir_arquivo;
procedure gravadados (var fich: estudante);


var
submete1 : char;

procedure geranum(num: real; x,y: integer; seq: real) ;

var
ng: real;
i: integer;
c: char;

Begin
  
  textcolor(white);
  cursoroff;
  
  ng := 0;
  
  gotoxy(x + 3, y);
  textcolor(lightgreen);
  write('  [ENTER]');
  textcolor(white);
  write(' PARA SALVAR');
  gotoxy(x, y);
  write(ng:0:0) ;
  
  //   PARA ESTE E OUTROS CASOS DE LER VALLORES, COLOQUE O READ DEPOIS DE TODO LAYOUT SER DESENHADO E ORGANIZE A POSICAO COM GOTO()
  
  c := readkey;
  
  while (c <> #13) and (c <> #27) do
  begin
    c:= readkey;
    
    case (c) of
      
      #72: // CIMA
      begin
        if (ng < num) then ng := ng + seq;
      end;
      
      
      #80: // BAIXO
      begin
        if (ng > 0) then ng := ng - seq;
      end;
      
      #27: //ESC
      ng := 0;
      
      
    end;
    
    gotoxy(x, y);
    if (num > 20) then
    write(ng:0:0, ' ')
    else
    write(ng:1:1, ' ');
    
  end;
  
  if (c = #13) then nfpp := ng;
  if (c = #27) then
  begin
    ng := 0;
    nfpp := ng;
    testeNulo := true;
  end;
  
End;
// ======================================================================


begin
  formulario;
  with est do
  begin
    cursoron;
    
    gotoxy(11, 14);
    readln(nome);
    gotoxy(11, 20);
    readln(curso);
    gotoxy(40, 20);
    readln(disc);
    estado := true;
    med := 0;
    
    geranum(96, 12,26, 1); // FALTAS
    faltas := int(nfpp);
    
    if  (faltas < ((20/100)* 96)) then
    begin
      ppf := false;
      
      gotoxy(40,34);
      textcolor(lightred);
      writeln('[ESC] PARA TESTE NAO FEITO') ;
      textcolor(white );
      geranum(20, 12,34, 0.5);
      n1 := nfpp;
      
      gotoxy(40,40);
      textcolor(lightred);
      writeln('[ESC] PARA TESTE NAO FEITO') ;
      textcolor(white );
      geranum(20, 12,40, 0.5);
      n2 := nfpp;
      
      gotoxy(40,46);
      textcolor(lightred);
      writeln('[ESC] PARA TESTE NAO FEITO') ;
      textcolor(white );
      geranum(20, 12,46, 0.5);
      n3 := nfpp;
      
      textcolor(lightgreen);
      gotoxy(34, 52);
      write('SUBMETER') ;
      
      
      med := (n1+n2+n3) /3 ;
      
    end
    else
    begin
      n1 := 0;
      n2 := 0;
      n3 := 0;
      gotoxy(40, 26);
      textcolor(lightred);
      writeln('EXCLUIDO POR FALTAS') ;
      
      textcolor(lightgreen);
      gotoxy(34, 52);
      write('SUBMETER') ;
      
      textcolor(white);
      ppf := true;  //atribuicao true a variavel ppf caso tenha muitas faltas
    end;
    
    //# fim da validacao da porcentagem das faltas
    //observacao
    if ((med<10) or (ppf = true) or (testeNulo = true)) then  //condicao de exclusao
    begin
      obs := 'excluido';
        testeNulo := false;
      gotoxy(40, 26);
      textcolor(lightred);
      writeln('EXCLUIDO') ;
    end
    else if ((med >10 ) and (med <14)) then
    begin
      obs := 'admitido';
      
      gotoxy(40, 26);
      textcolor(lightgreen);
      writeln('ADMITIDO') ;
    end
    else
    begin
      obs := 'dispensado';
      
      gotoxy(40, 26);
      textcolor(lightgreen);
      writeln('DISPENSADO') ;
    end;
    
    submete1 := readkey;
    
    while (submete1 <> #13) do submete1 := readkey;
    
    clrscr;
    
    
    //estatisticas
    if ((med<10) or (ppf = true)or (val1= 'n')or (val1= 'N') or (val2= 'n')or (val2= 'N')or (val3= 'n')or (val3= 'N') ) then  //condicao de exclusao
    tot_exc  := tot_exc +1
    else if ((med >10 ) and (med <14)) then
    tot_adm   := tot_adm  +1
    
    else
    disp   := disp  +1;
    // obs := 'dispensado';
    
    
    
    if (ppf = true ) then
    f_exc := f_exc +1;
    cod:= filesize(arq)+1;
    tot := tot +1;
    //# fim estatistica
    
  end;
  write (arq ,est);
  
end;

// fim abrir arquivo
{teste}
procedure novoingresso;

var
i: integer;

begin
  
  //  textcolor(lightgreen);
  assign(arq,'dados.uni');
  {$I-}
  Reset(arq);
  if IOResult = 0 then
  repeat
    begin
      clrscr;
      seek(arq,filesize(arq));
      gravadados(grava);
      
      gotoxy(29, 4);
      textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
      
      gotoxy(27, 2);
      write('______________________________' ) ;
      gotoxy(27, 5);
      write('______________________________' ) ;
      
      textcolor(white);
      gotoxy(29,29);
      write(#218);
      for i:=1 to 25 do write(#196);
      write(#191+#10+#8);
      for i:=1 to 1 do write(#179+#10+#8);
      gotoxy(29,30);
      for i:=1 to 1 do write(#179+#10+#8);
      write(#192);
      for i:=1 to 25 do write(#196);
      write(#217);
      textbackground(black);
      
      //===========================================
      textcolor(white);
      gotoxy(8,9);
      write(#218);
      for i:=1 to 67 do write(#196);
      write(#191+#10+#8);
      for i:=1 to 15 do write(#179+#10+#8);
      gotoxy(8,10);
      for i:=1 to 15 do write(#179+#10+#8);
      write(#192);
      for i:=1 to 67 do write(#196);
      write(#217);
      textbackground(black);
      
      //===========================================
      
      textcolor(lightgreen);
      gotoxy(78,9);
      write(#10+#8);
      for i:=1 to 17 do write(#179+#10+#8);
      gotoxy(10,26);
      for i:=1 to 67 do write(#196);
      write(#217);
      textbackground(black);
      
      //  ========================================================================
      
      textcolor(lightgreen );
      gotoxy(28,12); writeln('ALUNO REGISTRADO COM SUCESSO!');
      gotoxy(26,13); writeln('________________________________') ;
      textcolor(white);
      gotoxy(32,18); writeln('CODIGO DO ALUNO: ',est.cod);
      gotoxy(30,30); writeln('ADICIONAR REGISTRO [S/N]?');
      resp:=readkey;
    end
  until upcase(resp)='N'
    else
    repeat
      begin
        rewrite(arq);
        clrscr;
        gravadados(est);
        
        gotoxy(29, 4);
        textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
        
        gotoxy(27, 2);
        write('______________________________' ) ;
        gotoxy(27, 5);
        write('______________________________' ) ;
        
        textcolor(white);
        gotoxy(29,29);
        write(#218);
        for i:=1 to 25 do write(#196);
        write(#191+#10+#8);
        for i:=1 to 1 do write(#179+#10+#8);
        gotoxy(29,30);
        for i:=1 to 1 do write(#179+#10+#8);
        write(#192);
        for i:=1 to 25 do write(#196);
        write(#217);
        textbackground(black);
        
        //===========================================
        textcolor(white);
        gotoxy(8,9);
        write(#218);
        for i:=1 to 67 do write(#196);
        write(#191+#10+#8);
        for i:=1 to 15 do write(#179+#10+#8);
        gotoxy(8,10);
        for i:=1 to 15 do write(#179+#10+#8);
        write(#192);
        for i:=1 to 67 do write(#196);
        write(#217);
        textbackground(black);
        
        //===========================================
        
        textcolor(lightgreen);
        gotoxy(78,9);
        write(#10+#8);
        for i:=1 to 17 do write(#179+#10+#8);
        gotoxy(10,26);
        for i:=1 to 67 do write(#196);
        write(#217);
        textbackground(black);
        
        //  ========================================================================
        
        textcolor(lightgreen );
        gotoxy(28,12); writeln('ALUNO REGISTRADO COM SUCESSO!');
        gotoxy(26,13); writeln('________________________________') ;
        textcolor(white);
        gotoxy(32,18); writeln('CODIGO DO ALUNO: ',est.cod);
        gotoxy(30,30); writeln('ADICIONAR REGISTRO [S/N]?');
        
        readln(resp);
      end;
    until upcase(resp)='N';
      close(arq);
    end;
    
    
    //	================================================================================================================
    
    procedure lertodos;
    
    var
    fp: char;
    ctab, i: integer;
    
    //=================================================================================================
    procedure quad(x,y: integer; C:byte; a,b: integer);
    Var i: integer;
    begin
      
      textcolor(c);
      gotoxy(x,y);
      write(#218);
      for i:=1 to a do write(#196);
      write(#191+#10+#8);
      for i:=1 to b do write(#179+#10+#8);
      gotoxy(x, y + 1);
      for i:=1 to b do write(#179+#10+#8);
      write(#192);
      for i:=1 to a do write(#196);
      write(#217);
      textbackground(black);
      
    end;
    //================================================================================================
    
    //=================================================================================================
    procedure tabela(x,y: integer; C:byte; a,b: integer);
    Var i: integer;
    begin
      
      textcolor(c);
      gotoxy(x,y);
      write(#218);
      for i:=1 to a do write(#196);
      write(#191+#10+#8);
      for i:=1 to b do write(#179+#10+#8);
      gotoxy(x, y + 1);
      for i:=1 to b do write(#179+#10+#8);
      write(#192);
      for i:=1 to a do write(#196);
      write(#217);
      textbackground(black);
      
    end;
    //================================================================================================
    
    
    begin
      ctab := 7;
      
      cursoroff;
      
      textcolor(lightgreen);
      clrscr;
      assign(arq,'dados.uni');
      Reset(arq);
      while not eof(arq) do
      begin
        read(arq,est);
        writeln;
        textcolor(white);
        gotoxy(29,3); writeln ('PAUTA FINAL DOS ESTUDANTES');
        with est do
        begin
          if (estado = true) then
          begin
            textcolor(white);
            quad(20,ctab - 2,white,40,13);
            
            gotoxy(23,ctab); textcolor(white); write('NOME: '); textcolor(lightgreen); write(upcase(nome)) ;
              gotoxy(23,ctab + 1); textcolor(white); writeln('____________________________________'); textcolor(white);
              gotoxy(23,ctab + 2); textcolor(white); write ('CODIGO:         ',cod);
              gotoxy(23,ctab + 3); textcolor(white); write('CURSO:          ', upcase(curso));
                gotoxy(23,ctab + 4);textcolor(white); write('DISCIPLINA:     ', upcase(est.disc));
                  gotoxy(23,ctab + 5); textcolor(white); write ('NR. DE FALTAS:  ', est.faltas);
                  
                  gotoxy(23,ctab + 6); textcolor(white); write ('PRIMEIRA NOTA:  ');
                  if (est.n1 < 10) then textcolor(lightred)
                  else textcolor(lightgreen);
                  write(est.n1:1:1);
                  
                  gotoxy(23,ctab + 7); textcolor(white); write ('SEGUNDA NOTA:   ');
                  if (est.n2 < 10) then textcolor(lightred)
                  else textcolor(lightgreen);
                  write(est.n2:1:1);
                  
                  gotoxy(23,ctab + 8); textcolor(white); write ('TERCEIRA NOTA:  ');
                  if (est.n3 < 10) then textcolor(lightred)
                  else textcolor(lightgreen);
                  write(est.n3:1:1);
                  
                  gotoxy(23,ctab + 9); textcolor(white); write ('MEDIA FINAL:    ');
                  if (est.med < 10) then textcolor(lightred)
                  else textcolor(lightgreen);
                  write(est.med:2:2);
                  
                  gotoxy(23,ctab + 10);
                  textcolor(white);
                  write('OBSERVACAO:     ');
                  if (est.med < 10) then textcolor(lightred)
                  else textcolor(lightgreen);
                  write(upcase(est.obs));
                  end;
                  
                  ctab := ctab + 15;
                end;
              end;
              close(arq);
              
              //==================================================================
              
              textcolor(white);
              gotoxy(63,5);
              write(#10+#8);
              for i:=1 to (ctab - 7) do write(#179+#10+#8);
              gotoxy(21,(ctab - 2));
              for i:=1 to 41 do write(#196);
              write(#217);
              textbackground(black);
              
              //==================================================================
              
              writeln ;
              textcolor(white);
              quad(30,ctab ,white,20,1);
              gotoxy(33, ctab + 1);
              write('[ESC] PARA SAIR' ) ;
              
              while (fp <> #27) do fp := readkey; ;
              if (fp = #27) then clrscr;
              
              
              
            end;
            //    ===================================================================================
            
            
            
            
            
            // procedimento pesquisa
            procedure pesquisar ;
            
            var codigo_p, escolha: integer;
            nome_p :string;
            flp: char;
            i: integer;
            
            
            // =================================================================================================
            
            
            procedure escolhe ;
            
            var
            msga: string; // DEPOIS USAR DE PARAMETRO
            ec: char;
            i, epos: integer;
            eestado: array[1..2] of byte;
            
            
            procedure quad(x: integer; C:byte);
            Var i: integer;
            begin
              
              textcolor(c);
              gotoxy(x,9);
              write(#218);
              for i:=1 to 20 do write(#196);
              write(#191+#10+#8);
              for i:=1 to 1 do write(#179+#10+#8);
              gotoxy(x, 9 + 1);
              for i:=1 to 1 do write(#179+#10+#8);
              write(#192);
              for i:=1 to 20 do write(#196);
              write(#217);
              textbackground(black);
              
            end;
            
            
            Procedure seleciona(selec: integer; c:byte);
            Begin
              
              case (selec) of
                1:
                begin
                  textcolor(c);
                  gotoxy(20, 10);
                  write('PESQUISA POR NOME') ;
                end;
                
                2:
                begin
                  textcolor(c);
                  gotoxy(45, 10);
                  write('PESQUISA POR CODIGO') ;
                end;
                
              end;
              
            End;
            
            procedure quadsp(x,y: integer; C:byte; a,b: integer);
            Var i: integer;
            begin
              
              textcolor(c);
              gotoxy(x,y);
              write(#218);
              for i:=1 to a do write(#196);
              write(#191+#10+#8);
              for i:=1 to b do write(#179+#10+#8);
              gotoxy(x, y + 1);
              for i:=1 to b do write(#179+#10+#8);
              write(#192);
              for i:=1 to a do write(#196);
              write(#217);
              textbackground(black);
              
            end;
            
            
            
            Begin
              
              cursoroff;
              
              textcolor(white);
              gotoxy(24, 3);      // AJUSTE O TEXTO COM ESPACO. NAO MUDE OS NRS
              msga := '     ESCOLHA O TIPO DE PESQUISA';
              write(msga) ;
              gotoxy(24, 4);
              write('___________________________________' ) ;
              
              epos := 1;
              
              seleciona(1, lightgreen);
              for i := 2 to 2 do seleciona(i, white);
              
              quad(18, lightgreen); // 1
              
              ec := readkey;
              
              while (ec <> #13) do
              begin
                ec:= readkey;
                
                case (ec) of
                  
                  
                  #75:	// ESQUERDA
                  begin
                    if (epos > 1) then epos := epos - 1;
                    
                    for i := 1 to 2 do
                    begin
                      if (i <> epos) then
                      begin
                        eestado[i] := black;
                        seleciona(i,white);
                      end
                      else
                      begin
                        eestado[i] := lightgreen;
                        seleciona(i,lightgreen);
                      end;
                    end;
                  end;
                  
                  
                  #77: // DIREITA
                  begin
                    if (epos < 2) then epos := epos + 1;
                    
                    for i := 1 to 2 do
                    begin
                      if (i <> epos) then
                      begin
                        eestado[i] := black;
                        seleciona(i,white);
                      end
                      else
                      begin
                        eestado[i] := lightgreen;
                        seleciona(i,lightgreen);
                      end;
                    end;
                  end;
                  
                end;
                
                quad(18,eestado[1]); // 1
                quad(43,eestado[2]); // 2
                
              end;
              
              
              escolha := epos;
              
              
              quadsp(19,15,white,25,1);
              quadsp(46,15,lightgreen,15,1);
              gotoxy(50,16);
              write('PESQUISAR') ;
              
              
              
            End;
            
            //==========================================================================================================
            
            
            
            begin
              
              clrscr;
              
              escolhe;
              
              cursoron;
              
              if ( escolha = 2 ) then
              begin
                gotoxy(20,16);
                readln(codigo_p);
              end
              else
              if ( escolha = 1 ) then
              begin
                gotoxy(20,16);
                readln(nome_p);
              end;
              
              cursoroff;
              clrscr;
              
              
              gotoxy(29, 4);
              textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
              
              gotoxy(27, 2);
              write('______________________________' ) ;
              gotoxy(27, 5);
              write('______________________________' ) ;
              
              textcolor(white);
              gotoxy(31,29);
              write(#218);
              for i:=1 to 21 do write(#196);
              write(#191+#10+#8);
              for i:=1 to 1 do write(#179+#10+#8);
              gotoxy(31,30);
              for i:=1 to 1 do write(#179+#10+#8);
              write(#192);
              for i:=1 to 21 do write(#196);
              write(#217);
              textbackground(black);
              
              //===========================================
              textcolor(white);
              gotoxy(8,9);
              write(#218);
              for i:=1 to 67 do write(#196);
              write(#191+#10+#8);
              for i:=1 to 15 do write(#179+#10+#8);
              gotoxy(8,10);
              for i:=1 to 15 do write(#179+#10+#8);
              write(#192);
              for i:=1 to 67 do write(#196);
              write(#217);
              textbackground(black);
              
              //===========================================
              
              textcolor(lightgreen);
              gotoxy(78,9);
              write(#10+#8);
              for i:=1 to 17 do write(#179+#10+#8);
              gotoxy(10,26);
              for i:=1 to 67 do write(#196);
              write(#217);
              textbackground(black);
              
              textcolor(white);
              gotoxy(35,30); write('[ESC] PARA SAIR') ;
              
              
              
              assign(arq,'dados.uni');
              reset(arq);
              
              while not EOF(arq) do
              begin
                read(arq,est);
                
                if ( escolha = 2 ) then
                begin
                  if (est.cod=codigo_p) then
                  begin
                    with est do
                    begin
                      if (estado = true) then
                      begin
                        gotoxy(10, 12); writeln('NOME: ',upcase(nome));
                          textcolor(lightgreen );
                          gotoxy(10, 13); writeln('____________________________' ) ;
                          textcolor(white);
                          gotoxy(10, 15); writeln('CODIGO: ',cod);
                          gotoxy(10, 16); writeln('CURSO: ', upcase(curso));
                            gotoxy(10, 17); writeln ('DISCIPLINA: ',upcase(est.disc));
                              gotoxy(10, 18); writeln ('NR. FALTAS: ',est.faltas);
                              gotoxy(10, 19); writeln ('NOTA 1: ',est.n1:1:1);
                              gotoxy(10, 20); writeln ('NOTA 2: ',est.n2:1:1);
                              gotoxy(10, 21); writeln ('NOTA 3: ',est.n3:1:1);
                              gotoxy(10, 22); writeln ('MEDIA: ',est.med:1:1);
                              gotoxy(10, 23); writeln ('OBSERVACAO: ',upcase(est.obs));
                                
                              end
                              else
                              begin
                                textcolor(lightred );
                                clrscr;
                                gotoxy(15,15);
                                writeln ('ESTUDANTE APAGADO OU INEXISTENTE   [ESC]');
                                textcolor(white );
                              end;
                              
                              
                            end;
                          end;
                        end
                        else
                        if ( escolha = 1 ) then
                        begin
                          
                          if (est.nome=nome_p) then
                          begin
                            with est do
                            begin
                              if (estado = true) then
                              begin
                                
                                gotoxy(10, 12); writeln('NOME: ',upcase(nome));
                                  textcolor(lightgreen );
                                  gotoxy(10, 13); writeln('____________________________' ) ;
                                  textcolor(white);
                                  gotoxy(10, 15); writeln('CODIGO: ',cod);
                                  gotoxy(10, 16); writeln('CURSO: ', upcase(curso));
                                    gotoxy(10, 17); writeln ('DISCIPLINA: ',upcase(est.disc));
                                      gotoxy(10, 18); writeln ('NR. FALTAS: ',est.faltas);
                                      gotoxy(10, 19); writeln ('NOTA 1: ',est.n1:1:1);
                                      gotoxy(10, 20); writeln ('NOTA 2: ',est.n2:1:1);
                                      gotoxy(10, 21); writeln ('NOTA 3: ',est.n3:1:1);
                                      gotoxy(10, 22); writeln ('MEDIA: ',est.med:1:1);
                                      gotoxy(10, 23); writeln ('OBSERVACAO: ',upcase(est.obs));
                                        
                                      end
                                      else
                                      begin
                                        textcolor(lightred );
                                        clrscr;
                                        gotoxy(15,15);
                                        writeln ('ESTUDANTE APAGADO OU INEXISTENTE   [ESC]');
                                        textcolor(white )
                                      end;
                                      
                                    end;
                                  end;
                                end;
                              end;
                              
                              flp := readkey;
                              
                              while (flp <> #27) do flp := readkey;
                            end;
                            
                            
                            // #Fim  procedimento pesquisa
                            
                            // procedimento remocao
                            procedure remover ;
                            var
                            j,val :integer;
                            
                            procedure confirmaremove ;
                            
                            var
                            msga: string;
                            crc: char;
                            i, crpos: integer;
                            crestado: array[1..2] of byte;
                            
                            
                            procedure quad(x: integer; C:byte);
                            Var i: integer;
                            begin
                              
                              textcolor(c);
                              gotoxy(x,9);
                              write(#218);
                              for i:=1 to 5 do write(#196);
                              write(#191+#10+#8);
                              for i:=1 to 1 do write(#179+#10+#8);
                              gotoxy(x, 9 + 1);
                              for i:=1 to 1 do write(#179+#10+#8);
                              write(#192);
                              for i:=1 to 5 do write(#196);
                              write(#217);
                              textbackground(black);
                              
                            end;
                            
                            
                            Procedure seleciona(selec: integer; c:byte);
                            Begin
                              
                              case (selec) of
                                1:
                                begin
                                  textcolor(c);
                                  gotoxy(29, 10);
                                  write('SIM') ;
                                end;
                                
                                2:
                                begin
                                  textcolor(c);
                                  gotoxy(45, 10);
                                  write('NAO') ;
                                end;
                                
                              end;
                              
                            End;
                            
                            
                            
                            Begin
                              
                              cursoroff;
                              
                              textcolor(white);
                              
                              crpos := 1;
                              
                              seleciona(1, lightgreen);
                              for i := 2 to 2 do seleciona(i, white);
                              
                              quad(27, lightgreen); // 1
                              
                              crc := readkey;
                              
                              while (crc <> #13) do
                              begin
                                crc:= readkey;
                                
                                case (crc) of
                                  
                                  
                                  #75:	// ESQUERDA
                                  begin
                                    if (crpos > 1) then crpos := crpos - 1;
                                    
                                    for i := 1 to 2 do
                                    begin
                                      if (i <> crpos) then
                                      begin
                                        crestado[i] := black;
                                        seleciona(i,white);
                                      end
                                      else
                                      begin
                                        crestado[i] := lightgreen;
                                        seleciona(i,lightgreen);
                                      end;
                                    end;
                                  end;
                                  
                                  
                                  #77: // DIREITA
                                  begin
                                    if (crpos < 2) then crpos := crpos + 1;
                                    
                                    for i := 1 to 2 do
                                    begin
                                      if (i <> crpos) then
                                      begin
                                        crestado[i] := black;
                                        seleciona(i,white);
                                      end
                                      else
                                      begin
                                        crestado[i] := lightred;
                                        seleciona(i,lightred);
                                      end;
                                    end;
                                  end;
                                  
                                end;
                                
                                quad(27,crestado[1]); // 1
                                quad(43,crestado[2]); // 2
                                
                              end;
                              
                              val := crpos;
                              
                            End;
                            
                            procedure quadrm(x,y: integer; C:byte; a,b: integer);
                            Var i: integer;
                            begin
                              
                              textcolor(c);
                              gotoxy(x,y);
                              write(#218);
                              for i:=1 to a do write(#196);
                              write(#191+#10+#8);
                              for i:=1 to b do write(#179+#10+#8);
                              gotoxy(x, y + 1);
                              for i:=1 to b do write(#179+#10+#8);
                              write(#192);
                              for i:=1 to a do write(#196);
                              write(#217);
                              textbackground(black);
                              
                            end;
                            
                            begin
                              clrscr;
                              assign(arq,'dados.uni');
                              Reset(arq);
                              
                              quadrm(19,15,white,25,1);
                              quadrm(46,15,lightred,15,1);
                              gotoxy(51,16);
                              write('REMOVER') ;
                              textcolor(white );
                              
                              
                              gotoxy(27,5 ); writeln('DIGITE O CODIGO DO ESTUDANTE');
                              gotoxy(22,6); writeln('_____________________________________');
                              
                              cursoron;
                              gotoxy(20,16); readln(n);
                              cursoroff;
                              
                              
                              
                              seek(arq,n-1);
                              read(arq,est);
                              clrscr;
                              with est do
                              begin
                                
                                gotoxy(30, 3);
                                writeln ('ELIMINAR ',upcase(nome), '?');
                                  
                                  confirmaremove;
                                  
                                  
                                  if (val =1) then
                                  begin
                                    clrscr;
                                    gotoxy(25, 10);
                                    textcolor(lightred );
                                    writeln ('ESTUDANTE ',upcase(nome),' ELIMINADO(A)!');
                                      textcolor(white);
                                      delay(3000);
                                      estado := false;
                                      //estatisticas
                                      if ((med<10) or (ppf = true)or (val1= 'n')or (val1= 'N') or (val2= 'n')or (val2= 'N')or (val3= 'n')or (val3= 'N') ) then  //condicao de exclusao
                                      tot_exc  := tot_exc -1
                                      else if ((med >10 ) and (med <14)) then
                                      tot_adm   := tot_adm  -1
                                      
                                      else
                                      disp   := disp  -1;
                                      // obs := 'dispensado';
                                      
                                      
                                      
                                      if (ppf = true ) then
                                      f_exc := f_exc -1;
                                      cod:= filesize(arq)-1;
                                      tot := tot -1;
                                      //# fim estatistica
                                    end
                                    else
                                    begin
                                      clrscr;
                                      gotoxy(25, 10);
                                      textcolor(lightgreen );
                                      writeln ('ESTUDANTE NAO ELIMINADO(A)!');
                                      textcolor(white );
                                      delay(3000 );
                                    end;
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                  end;
                                  seek(arq,n-1);
                                  write(arq,est);
                                  close(arq);
                                end;
                                // Fim  procedimento pesquisa
                                
                                // procedimento actualizar
                                procedure actualizar;
                                var
                                n :integer;
                                
                                procedure at;
                                
                                var
                                i: integer;
                                
                                //=================================================================================================
                                procedure quadat(x,y: integer; C:byte; a,b: integer);
                                Var i: integer;
                                begin
                                  
                                  textcolor(c);
                                  gotoxy(x,y);
                                  write(#218);
                                  for i:=1 to a do write(#196);
                                  write(#191+#10+#8);
                                  for i:=1 to b do write(#179+#10+#8);
                                  gotoxy(x, y + 1);
                                  for i:=1 to b do write(#179+#10+#8);
                                  write(#192);
                                  for i:=1 to a do write(#196);
                                  write(#217);
                                  textbackground(black);
                                  
                                end;
                                //================================================================================================
                                
                                
                                Begin
                                  
                                  quadat(10,5,white,25,1);
                                  quadat(37,5,lightgreen,15,1);
                                  gotoxy(40,6);
                                  write('ACTUALIZAR') ;
                                  gotoxy(11,6);;
                                  
                                  
                                End;
                                
                                begin
                                  
                                  clrscr;
                                  at;
                                  
                                  assign(arq,'dados.uni');
                                  Reset(arq);
                                  
                                  gotoxy(17,2);
                                  textcolor(white );
                                  write('DIGITE O CODIGO DO ESTUDANTE: ');
                                  gotoxy(11,6);
                                  cursoron;
                                  readln(n);
                                  seek(arq,n-1);
                                  read(arq,est);
                                  clrscr;
                                  with est do
                                  begin
                                    if (estado = true) then
                                    begin
                                      
                                      clrscr;
                                      at;
                                      gotoxy(17,2);
                                      textcolor(white );
                                      write('DIGITE O NOME DO ESTUDANTE: ');
                                      gotoxy(11,6);
                                      readln(nome);
                                      
                                      clrscr;
                                      at;
                                      gotoxy(17,2);
                                      textcolor(white );
                                      write('DIGITE O CURSO DO ESTUDANTE: ');
                                      gotoxy(11,6);
                                      readln(curso);
                                      
                                      clrscr;
                                      at;
                                      gotoxy(17,2);
                                      textcolor(white );
                                      write('DIGITE A DISCIPLINA DO ESTUDANTE: ');
                                      gotoxy(11,6);
                                      readln(disc);
                                      
                                      // validacao de faltas
                                      repeat
                                        
                                        clrscr;
                                        at;
                                        gotoxy(17,2);
                                        textcolor(white );
                                        write('DIGITE O NR. DE FALTAS [MAX: 96]: ');
                                        gotoxy(11,6);
                                        readln (faltas);
                                        
                                      until ( (faltas >=0) and (faltas < 96) ); // validacao do numero de faltas
                                      
                                      if  (faltas < ((20/100)* 96)) then
                                      begin
                                        //validacao da existencia do primeiro teste
                                        ppf := false;
                                        
                                        repeat
                                          clrscr;
                                          at;
                                          gotoxy(17,2);
                                          textcolor(white );
                                          write('DIGITE A PRIMEIRA NOTA: ');
                                          gotoxy(11,6);
                                          readln (n1);
                                        until ( (n1>=0) and (n1 <= 20)) ;
                                        
                                        
                                        repeat
                                          clrscr;
                                          at;
                                          gotoxy(17,2);
                                          textcolor(white );
                                          write('DIGITE A SEGUNDA NOTA: ');
                                          gotoxy(11,6);
                                          readln (n2);
                                        until ( (n2>=0) and (n2 <= 20)) ;
                                        
                                        
                                        repeat
                                          clrscr;
                                          at;
                                          gotoxy(17,2);
                                          textcolor(white );
                                          write('DIGITE A TERCEIRA NOTA: ');
                                          gotoxy(11,6);
                                          readln (n3);
                                        until ( (n3>=0) and (n3 <= 20)) ;
                                        
                                        
                                        med := (n1+n2+n3) /3 ;
                                      end
                                      else
                                      begin
                                        n1 := 0;
                                        n2 := 0;
                                        n3 := 0;
                                        med := 0;
                                        clrscr;
                                        textcolor(lightred );
                                        gotoxy(20,5);
                                        cursoroff;
                                        write ('ESTUDANTE COM MAIS DE 20% DE FALTAS. EXCLUIDO.');
                                        delay(4000 );
                                        ppf := true;  //atribuicao true a variavel ppf caso tenha muitas faltas
                                        
                                        
                                      end;
                                      
                                      //# fim da validacao da porcentagem das faltas
                                      //observacao
                                      if ((med<10) or (ppf = true)or (val1= 'n')or (val1= 'N') or (val2= 'n')or (val2= 'N')or (val3= 'n')or (val3= 'N') ) then  //condicao de exclusao
                                      
                                      obs := 'excluido'
                                      else if ((med >10 ) and (med <14)) then
                                      
                                      obs := 'admitido'
                                      else
                                      obs := 'dispensado';
                                      
                                    end
                                    else
                                    begin
                                      clrscr;
                                      textcolor(lightred );
                                      gotoxy(20,5);
                                      cursoroff;
                                      writeln ('ESTUDANTE REMOVIDO OU INEXISTENTE! ');
                                      delay(4000 );
                                    end;
                                    
                                    
                                    cod:= n;
                                  end;
                                  seek(arq,n-1);
                                  write(arq,est);
                                  close(arq);
                                end;
                                // #fim do procedimento actualizar
                                procedure estatisticas ;
                                
                                var
                                fes: char;
                                i: integer;
                                
                                begin
                                  
                                  clrscr;
                                  
                                  gotoxy(29, 4);
                                  textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
                                  
                                  gotoxy(27, 2);
                                  write('______________________________' ) ;
                                  gotoxy(27, 5);
                                  write('______________________________' ) ;
                                  
                                  textcolor(white);
                                  gotoxy(31,29);
                                  write(#218);
                                  for i:=1 to 21 do write(#196);
                                  write(#191+#10+#8);
                                  for i:=1 to 1 do write(#179+#10+#8);
                                  gotoxy(31,30);
                                  for i:=1 to 1 do write(#179+#10+#8);
                                  write(#192);
                                  for i:=1 to 21 do write(#196);
                                  write(#217);
                                  textbackground(black);
                                  
                                  //===========================================
                                  textcolor(white);
                                  gotoxy(8,9);
                                  write(#218);
                                  for i:=1 to 67 do write(#196);
                                  write(#191+#10+#8);
                                  for i:=1 to 15 do write(#179+#10+#8);
                                  gotoxy(8,10);
                                  for i:=1 to 15 do write(#179+#10+#8);
                                  write(#192);
                                  for i:=1 to 67 do write(#196);
                                  write(#217);
                                  textbackground(black);
                                  
                                  //===========================================
                                  
                                  textcolor(lightgreen);
                                  gotoxy(78,9);
                                  write(#10+#8);
                                  for i:=1 to 17 do write(#179+#10+#8);
                                  gotoxy(10,26);
                                  for i:=1 to 67 do write(#196);
                                  write(#217);
                                  textbackground(black);
                                  
                                  textcolor(white);
                                  gotoxy(10, 12 ); writeln ('TOTAL DE ALUNOS: ', tot);
                                  
                                  gotoxy(10, 14 ); writeln ('TOTAL DE EXCLUIDOS: ', tot_exc );
                                  
                                  gotoxy(10, 16 ); writeln ('TOTAL DE EXCLUIDOS POR FALTAS: ', f_exc );
                                  
                                  gotoxy(10, 18 );  writeln ('TOTAL DE ADMITIDOS: ', tot_adm );
                                  
                                  gotoxy(10, 20 );  writeln ('TOTAL DE DISPENSADOS: ', disp );
                                  
                                  gotoxy(35, 30 ); write('[ESC] PARA SAIR') ;
                                  fes := readkey;
                                  while (fes <> #27) do fes := readkey;
                                  
                                end;
                                
                                
                                
                                procedure menuprincipal ;
                                
                                var
                                c: char;
                                i, pos: integer;
                                estado: array[1..7] of byte;
                                
                                //==================================================================
                                procedure quad(x: integer; C:byte);
                                Var i: integer;
                                begin
                                  
                                  textcolor(c);
                                  gotoxy(25,x);
                                  write(#218);
                                  for i:=1 to 22 do write(#196);
                                  write(#191+#10+#8);
                                  for i:=1 to 1 do write(#179+#10+#8);
                                  gotoxy(25, x + 1);
                                  for i:=1 to 1 do write(#179+#10+#8);
                                  write(#192);
                                  for i:=1 to 22 do write(#196);
                                  write(#217);
                                  textbackground(black);
                                  
                                end;
                                //==================================================================
                                
                                Procedure seleciona(selec: integer; c:byte);
                                Begin
                                  
                                  case (selec) of
                                    1:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 12);
                                      write('CADASTRAR ESTUDANTE') ;
                                    end;
                                    
                                    2:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 16);
                                      write('ACTUALIZAR DADOS') ;
                                    end;
                                    
                                    3:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 20);
                                      write('PESQUISAR ESTUDANTE') ;
                                    end;
                                    
                                    4:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 24);
                                      write('REMOVER ESTUDANTE') ;
                                    end;
                                    
                                    5:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 28);
                                      write('CONSULTAR PAUTA') ;
                                    end;
                                    
                                    6:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 32);
                                      write('SOBRE O PROGRAMA') ;
                                    end;
                                    
                                    7:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 36);
                                      write('SAIR') ;
                                    end;
                                    
                                    {7:
                                    begin
                                      textcolor(c);
                                      gotoxy(27, 40);
                                      write('SAIR') ;
                                    end;  }
                                  end;
                                  
                                End;
                                
                                //==================================================================
                                
                                
                                Begin
                                  
                                  repeat
                                    
                                    clrscr;
                                    cursoroff;
                                    
                                    gotoxy(26, 4);
                                    textcolor(lightgreen); write('M'); textcolor(white); write('APA DE '); textcolor(lightgreen); write('C'); textcolor(white); write('ONTROLO DE '); textcolor(lightgreen); write('F'); textcolor(white); write('ALTAS');
                                    //  writeln('MAPA DE CONTROLO DE FALTAS' ) ;
                                    gotoxy(24, 2);
                                    write('______________________________' ) ;
                                    gotoxy(24, 5);
                                    write('______________________________' ) ;
                                    
                                    
                                    textcolor(white);
                                    gotoxy(22,9);
                                    write(#218);
                                    for i:=1 to 32 do write(#196);
                                    write(#191+#10+#8);
                                    for i:=1 to 32 do write(#179+#10+#8);
                                    gotoxy(22,10);
                                    for i:=1 to 32 do write(#179+#10+#8);
                                    write(#192);
                                    for i:=1 to 32 do write(#196);
                                    write(#217);
                                    textbackground(black);
                                    
                                    //==================================================================
                                    
                                    textcolor(lightgreen);
                                    gotoxy(57,9);
                                    write(#10+#8);
                                    for i:=1 to 34 do write(#179+#10+#8);
                                    gotoxy(23,43);
                                    for i:=1 to 33 do write(#196);
                                    write(#217);
                                    textbackground(black);
                                    
                                    //==================================================================
                                    
                                    pos := 1;
                                    
                                    seleciona(1, lightgreen);
                                    for i := 2 to 7 do seleciona(i, white);
                                    quad(11, lightgreen); // 1
                                    
                                    c:= readkey;
                                    
                                    while (c <> #13) do
                                    begin
                                      c:= readkey;
                                      
                                      case (c) of
                                        
                                        #72: // CIMA
                                        begin
                                          if (pos > 1) then pos := pos - 1;
                                          
                                          for i := 1 to 7 do
                                          begin
                                            if (i <> pos) then
                                            begin
                                              estado[i] := black;
                                              seleciona(i,white);
                                            end
                                            else
                                            begin
                                              estado[i] := lightgreen;
                                              seleciona(i,lightgreen);
                                            end;
                                          end;
                                        end;
                                        
                                        
                                        #80: // BAIXO
                                        begin
                                          if (pos < 7) then pos := pos + 1;
                                          
                                          for i := 1 to 7 do
                                          begin
                                            if (i <> pos) then
                                            begin
                                              estado[i] := black;
                                              seleciona(i,white);
                                            end
                                            else
                                            begin
                                              estado[i] := lightgreen;
                                              seleciona(i,lightgreen);
                                              if (pos = 7) then
                                              begin
                                                estado[i] := lightred;
                                                seleciona(i,lightred);
                                              end;
                                            end;
                                          end;
                                        end;
                                        
                                        else
                                        if (pos = 1) then estado[1] := lightgreen;
                                        
                                        
                                        
                                      end;
                                      
                                      quad(11,estado[1]); // 1
                                      quad(15,estado[2]); // 2
                                      quad(19,estado[3]); // 3
                                      quad(23,estado[4]); // 4
                                      quad(27,estado[5]); // 5
                                      quad(31,estado[6]); // 6
                                      quad(35,estado[7]); // 7
                                      //                                      quad(39,estado[8]); // 8
                                      
                                    end;
                                    
                                  //      End;
                                  
                                  //==================================================================================
                                  
                                  
                                  
                                  if (c = #13) then menup := pos;
                                  
                                  textcolor(lightgreen);
                                  
                                  case menup of
                                    1 : novoingresso ;
                                    2 : actualizar ;
                                    3 : pesquisar ;
                                    4 : remover ;
                                    5 : lertodos ;
                                    //                                    6 : estatisticas ;
                                    6 : sobre;
                                    7 : confirmasair
                                  end;
                                until (menup = 0);
                              end;
                              
                              
                              
                              
                              
                              //====================================================================================================
                              
                              Begin   //comeco do programa principal
                                est.med:=0;
                                abrir_arquivo;
                                loading;
                                menuprincipal;
                              End.