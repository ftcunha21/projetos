unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Data.DB, IPPeerClient, Data.Bind.Components, Vcl.Grids, Vcl.DBGrids,
  Data.Bind.ObjectScope, System.JSON, REST.Client, System.Types, REST.Types,
  XMLIntf, XMLDoc, SHELLAPI, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, IdText,IdAttachmentFile;

type
  TfPrincipal = class(TForm)
    GroupBox1: TGroupBox;
    edNome: TLabeledEdit;
    edIdentidade: TLabeledEdit;
    edTelefone: TLabeledEdit;
    edEmail: TLabeledEdit;
    edCPF: TLabeledEdit;
    GroupBox2: TGroupBox;
    edLogradouro: TLabeledEdit;
    edCEP: TLabeledEdit;
    edComplemento: TLabeledEdit;
    edCidade: TLabeledEdit;
    edNumero: TLabeledEdit;
    edBairro: TLabeledEdit;
    edUf: TLabeledEdit;
    Bevel1: TBevel;
    bSalvar: TBitBtn;
    bSair: TBitBtn;
    edPais: TLabeledEdit;
    Bevel2: TBevel;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    procedure bSairClick(Sender: TObject);
    procedure edCPFExit(Sender: TObject);
    procedure edCEPExit(Sender: TObject);
    procedure edCEPKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bSalvarClick(Sender: TObject);
  private
    { Private declarations }
    function Valida_cpf_cnpj(numerocpf: string): boolean;
    function BuscaEndereco(_CEP: string):boolean;
    function GeraXML(_Destino: string): boolean;
    function EmailBody: TStrings;
    procedure EnviarEmailSMTP(mailTo: string; mailSubject: string; mailBody: TStrings; mailAttach: String);
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

function TfPrincipal.Valida_cpf_cnpj(numerocpf: string): boolean;
var
  vetor: array[1..14]of integer;
  tipo: string;
  soma1, soma2, somaux1, somaux2, digito1, digito2, cont, num: integer;
begin
  /////////////////////////////////////////////////////
  //  verifica se o numero digitado é um cpf válido  //
  /////////////////////////////////////////////////////
  //soma1 é a soma de cada um dos digitos vezes onze //
  //menos a posicao (1o*10, 2o*9, 3o*8, etc.Ate o 9o,//
  //o mesmo acontecendo para soma2 (com a 12-posicao)//
  /////////////////////////////////////////////////////
  if Trim(numerocpf) = '00000000000'
    then Result:= false
  else if Trim(numerocpf) = '11111111111'
    then Result:= false
  else if Trim(numerocpf) = '22222222222'
    then Result:= false
  else if Trim(numerocpf) = '33333333333'
    then Result:= false
  else if Trim(numerocpf) = '44444444444'
    then Result:= false
  else if Trim(numerocpf) = '55555555555'
    then Result:= false
  else if Trim(numerocpf) = '66666666666'
    then Result:= false
  else if Trim(numerocpf) = '77777777777'
    then Result:= false
  else if Trim(numerocpf) = '88888888888'
    then Result:= false
  else if Trim(numerocpf) = '99999999999'
    then Result:= false
  else begin
    result:= false;
    if length(numerocpf) = 11 then
      begin
        soma1:= 0;
        soma2:= 0;
        tipo:= 'CPF';
        for cont:= 1 to 11 do
          begin
            num:= strtoint(copy(numerocpf,cont,1));
            if cont <= 9 then
              begin
                soma1 := soma1 + ((num)*(11-cont));
                soma2 := soma2 + ((num)*(12-cont));
              end;
          end;
        //.
        //primeiro dígito verificador
        //compara o décimo numero do cpf com o valor calculado
        //usar (div) ao invés de (/), para retornar a parte inteira
        //da divisão
        digito1 := trunc(11 -(soma1 -((soma1 div 11)* 11)));
        if (digito1 = 10) or (digito1 = 11)
          then digito1 := 0;
        if digito1 = strtoint(copy(numerocpf,10,1))then
          begin
            soma2 := soma2 + (digito1 * 2);
            //.
            //segundo dígito verificador
            //compara o décimo primeiro numero do cpf com o valor calculado
            digito2 := trunc(11 -(soma2 -((soma2 div 11)* 11)));
            if (digito2 = 10) or (digito2 = 11)
              then digito2 := 0;
            if digito2 = strtoint(copy(numerocpf,11,1))
              then result := true;
          end;
      end;
    /////////////////////////////////////////////////////
    //  verifica se o numero digitado é um cgc válido  //
    /////////////////////////////////////////////////////
    if length(numerocpf) = 14 then
      begin
        soma1:= 0;
        soma2:= 0;
        somaux1:= 0;
        somaux2:= 0;
        tipo:= 'CGC';
        //.
        //..
        //copia cada numero do cnpj para uma posiçao do vetor
        for cont := 1 to 14
          do vetor[cont]:= strtoint(copy(numerocpf,cont,1));
        //.
        //..
        //digito de verificacao 1
        soma1 := (vetor[1]*5) + (Vetor[2]*4) + (Vetor[3]*3) +
                 (Vetor[4]*2) + (Vetor[5]*9) + (Vetor[6]*8) +
                 (Vetor[7]*7) + (Vetor[8]*6) + (Vetor[9]*5) +
                 (Vetor[10]*4) + (Vetor[11]*3) + (Vetor[12]*2);
        somaux1 := trunc(soma1 -((soma1 div 11)* 11));
        if (11 - somaux1) >= 10
          then digito1:= 0
          else digito1:= (11 - somaux1);
        //.
        //..
        //digito de verificao 2
        soma2 := (Vetor[1]*6) + (Vetor[2]*5) + (Vetor[3]*4) +
                 (Vetor[4]*3) + (Vetor[5]*2) + (Vetor[6]*9) +
                 (Vetor[7]*8) + (Vetor[8]*7) + (Vetor[9]*6) +
                 (Vetor[10]*5) + (Vetor[11]*4) + (Vetor[12]*3)+
                 (digito1 * 2);
        somaux2 := trunc(soma2 - ((soma2 div 11)*11));
        if (11 - somaux2) >= 10
          then digito2:= 0
          else digito2:= (11 - somaux2);
       //.
       //..
       //compara digitos de verificao com numeros digitados 13/14
        if (digito1 = Vetor[13]) and (digito2 = Vetor[14])
          then result := true
      end;
  end;
end;

function TfPrincipal.BuscaEndereco(_CEP: string): boolean;
var
  JSON: TJSONObject;
  erro: Boolean;
begin
  try
     // conexão com o a api via cep
    RESTClient1.BaseURL:='https://viacep.com.br/ws/' + Trim(_CEP) + '/json/';
    with RESTRequest1 do begin
      Method := TRESTRequestMethod.rmGET;
      Accept := 'application/json';
      AcceptCharset:= 'application/json; charset=utf-8';
      Execute;
    end;

    try
      // cria objeto que recebera o retorno do viacep
      JSON:= TJSONObject.Create;

      // lendo retorno da api via cep
      JSON:= TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
      try
        erro:= JSON.GetValue('erro').Value.ToBoolean;
      except
        erro:= false;
      end;

      if erro then
          Result:= False
      else begin
        edLogradouro.Text:= JSON.GetValue('logradouro').Value;
        edComplemento.Text:= JSON.GetValue('complemento').Value;
        edBairro.Text:= JSON.GetValue('bairro').Value;
        edCidade.Text:= JSON.GetValue('localidade').Value;
        edUf.Text:= JSON.GetValue('uf').Value;
        edPais.Text:= 'Brasil';
        Result:= True;
      end;
    finally
      JSON:= nil;
    end;
  except
    on E:Exception do begin
      Result:= False;
      ShowMessage(E.Message);
      Exit;
    end;
  end;
end;

function TfPrincipal.GeraXML(_Destino: string): boolean;
var
  _XML: TXMLDocument;
begin
  // gera arquivo xml dos dados da tela
  try
    try
      _XML := TXMLDocument.Create(nil);
      _XML.Active := True;

      _XML.DocumentElement := _XML.CreateNode('Cadastro', ntElement, '');

      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Nome').NodeValue := Trim(edNome.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Identidade').NodeValue := Trim(edIdentidade.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Cpf').NodeValue := Trim(edCPF.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Telefone').NodeValue := Trim(edTelefone.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Email').NodeValue := Trim(edEmail.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Cep').NodeValue := Trim(edCEP.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Logradouro').NodeValue := Trim(edLogradouro.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Numero').NodeValue := Trim(edNumero.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Complemento').NodeValue := Trim(edComplemento.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Bairro').NodeValue := Trim(edBairro.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Cidade').NodeValue := Trim(edCidade.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Uf').NodeValue := Trim(edUf.Text);
      _XML.DocumentElement.ChildNodes['Cliente'].AddChild('Pais').NodeValue := Trim(edPais.Text);

      _XML.SaveToFile(_Destino);

      Result:= True;
    except
      Result:= False;
    end;
  finally
    _XML.Free
  end;

end;

function TfPrincipal.EmailBody: TStrings;
var
  _Msg: TStringList;
begin
  _Msg:= TStringList.Create;

  _Msg.Add('Cadastro de Cliente:');
  _Msg.Add('');
  _Msg.Add('Nome: ' + Trim(edNome.Text));
  _Msg.Add('Identidade: ' + Trim(edIdentidade.Text));
  _Msg.Add('Cpf: ' + Trim(edCPF.Text));
  _Msg.Add('Telefone: ' + Trim(edTelefone.Text));
  _Msg.Add('Email: ' + Trim(edEmail.Text));
  _Msg.Add('Cep: ' + Trim(edCEP.Text));
  _Msg.Add('Logradouro: ' + Trim(edLogradouro.Text));
  _Msg.Add('Numero: ' + Trim(edNumero.Text));
  _Msg.Add('Complemento: ' + Trim(edComplemento.Text));
  _Msg.Add('Bairro: ' + Trim(edBairro.Text));
  _Msg.Add('Cidade: ' + Trim(edCidade.Text));
  _Msg.Add('Uf: ' + Trim(edUf.Text));
  _Msg.Add('Pais: ' + Trim(edPais.Text));
  _Msg.Add('');

  Result:= _Msg;
end;

procedure TfPrincipal.EnviarEmailSMTP(mailTo: string; mailSubject: string; mailBody: TStrings; mailAttach: String);
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
begin
 // instanciação dos objetos
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(self);
  IdSMTP := TIdSMTP.Create(self);
  IdMessage := TIdMessage.Create(self);

  try
    // Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.SSLVersions := [sslvSSLv23];
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    // Configuração do servidor SMTP (TIdSMTP)
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := 465;
    IdSMTP.Host := 'smtp.gmail.com';
    IdSMTP.Username := 'ftcunha.dev@gmail.com';
    IdSMTP.Password := 'dev@teste@2021F';
    IdSMTP.ReadTimeout := 100000;
    IdSMTP.ConnectTimeout := 100000;

    // Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := 'ftcunha.dev@gmail.com';
    IdMessage.From.Name := 'Cadastro Cliente';
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := mailTo;
    IdMessage.Subject := mailSubject;
    IdMessage.CharSet := 'iso-8859-1';
    IdMessage.Encoding := meMIME;



    // Configuração do corpo do email (TIdText)
    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body:= mailBody;
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    // Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        MessageDlg('Erro na conexão ou autenticação: ' +
          E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    // anexa arquivo
    if mailAttach <> EmptyStr then
      if FileExists(mailAttach) then
        TIdAttachmentFile.Create(IdMessage.MessageParts, mailAttach);

    // Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Mensagem enviada com sucesso!', mtInformation, [mbOK], 0);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar a mensagem: ' + E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    // desconecta do servidor
    IdSMTP.Disconnect;
    // liberação da DLL
    UnLoadOpenSSLLibrary;
    // liberação dos objetos da memória
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;
end;

procedure TfPrincipal.bSalvarClick(Sender: TObject);
begin
  // gera o xml dos dados
  try
    bSalvar.Enabled:= False;
    fPrincipal.Repaint;

    if GeraXML(GetCurrentDir + '\CadCli.xml') then
      begin
        //chama o programa de email e preenche com os dados do cliente + anexo do xml gerado
        EnviarEmailSMTP('fabiotellesdacunha@gmail.com',
                        'Cadastro de Cliente',
                        EmailBody,
                        GetCurrentDir + '\CadCli.xml');
      end;
  finally
    bSalvar.Enabled:= True;
  end;
end;

procedure TfPrincipal.edCEPExit(Sender: TObject);
begin
  if Trim(edCEP.Text).Length < 8  then
    begin
      ShowMessage('Informe um CEP válido antes de prosseguir!');
      edCEP.SetFocus;
    end;

end;

procedure TfPrincipal.edCEPKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Trim(edCEP.Text).Length = 8  then
    begin
      try
        edCEP.Enabled:= False;
        fPrincipal.Repaint;

        if BuscaEndereco(Trim(edCEP.Text)) then
          edNumero.SetFocus
        else begin
          edLogradouro.Clear;
          edNumero.Clear;
          edComplemento.Clear;
          edBairro.Clear;
          edCidade.Clear;
          edUf.Clear;
          edPais.Clear;
          ShowMessage('CEP não encontrado!');
          edCEP.SetFocus;
        end;
      finally
        edCEP.Enabled:= True;
      end;
    end;

end;

procedure TfPrincipal.edCPFExit(Sender: TObject);
begin
  // valida o cpf /cnpj
  if edCPF.Text <> EmptyStr then
    if not Valida_cpf_cnpj(Trim(edCPF.Text)) then
      begin
        MessageDLG('CPF inválido.',mtError,[mbok],0);
        edCPF.SetFocus;
      end;
end;

procedure TfPrincipal.bSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.

