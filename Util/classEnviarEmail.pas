unit classEnviarEmail;

interface

uses
  IdSMTP, IdSSLOpenSSL, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, System.Classes;

type
  TEmail = class
    Port :Integer;
    Host :String;
    Username :String;
    Password :String;
  public
    constructor create(pPort: Integer; pHost, pUsername, pPassword: String);
    procedure enviarEmail(remetente, nomeRemetente: String; destinatarios, assunto, mensagem:String; anexo: String = '');
  end;

implementation

uses
  System.SysUtils, Vcl.Dialogs;

{ TEmail }

constructor TEmail.create(pPort: Integer; pHost, pUsername, pPassword: String);
begin
  Self.Port := pPort;
  self.Host := pHost;
  self.Username := pUsername;
  self.Password := pPassword;
end;

procedure TEmail.enviarEmail(remetente, nomeRemetente: String; destinatarios, assunto, mensagem,
  anexo: String);
var
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  index: Integer;
begin
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create();
  IdSMTP := TIdSMTP.Create();
  IdMessage := TIdMessage.Create();

  try
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS := utUseImplicitTLS;
    IdSMTP.AuthType := satDefault;
    IdSMTP.Port := self.Port;
    IdSMTP.Host := self.Host;
    IdSMTP.Username := self.Username;
    IdSMTP.Password := self.Password;

    IdMessage.From.Address := remetente;
    IdMessage.From.Name := nomeRemetente;
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;

    IdMessage.Recipients.Add.Text := destinatarios;

    IdMessage.Subject := assunto;
    IdMessage.Encoding := meMIME;

    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body.Add(mensagem);
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    if (anexo <> '') then
    begin
      if FileExists(anexo) then
      begin
        TIdAttachmentFile.Create(IdMessage.MessageParts, anexo);
      end;
    end;

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

    try
      IdSMTP.Send(IdMessage);
      MessageDlg('Mensagem enviada com sucesso!', mtInformation, [mbOK], 0);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar a mensagem: ' +
          E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    IdSMTP.Disconnect;
    UnLoadOpenSSLLibrary;
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);
  end;
end;

end.
