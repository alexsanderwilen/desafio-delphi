unit UCustomIdHTTP;

interface

uses
  System.Classes, IdHTTP, IdSSL, IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdCTypes;

type
  TCustomIdHTTP = class(TIdHTTP)
  public
    constructor Create(AOwner: TComponent);
  private
    procedure OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
  end;

{ TCustomIdHTTP }

constructor TCustomIdHTTP.Create(AOwner: TComponent);
begin
  IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  with IOHandler as TIdSSLIOHandlerSocketOpenSSL do begin
    OnStatusInfoEx := Self.OnStatusInfoEx;
    SSLOptions.Method := sslvSSLv23;
    SSLOptions.SSLVersions := [sslvTLSv1_2, sslvTLSv1_1, sslvTLSv1];
  end;
  inherited Create(AOwner);
end;

procedure TCustomIdHTTP.OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT;
  const AType, AMsg: String);
begin

end;

end.
