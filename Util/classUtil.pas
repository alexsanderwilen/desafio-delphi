unit classUtil;

interface

type
  TUtil = class
    class function somenteNumero(texto: String) : String;
    class function validarEmail(email: string): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ Util }

class function TUtil.somenteNumero(texto: String): String;
var
  index: integer;
  novoTexto: string;
begin
  novoTexto := '';
  for index := 1 To Length(Texto) Do
  begin
    if (Texto[index] in ['0'..'9']) then
    begin
      novoTexto := novoTexto + Copy(Texto, index, 1);
    end;
  end;
  result := novoTexto;
end;

class function TUtil.validarEmail(email: string): Boolean;
begin
  email := Trim(UpperCase(email));
  if Pos('@', email) > 1 then begin
    Delete(email, 1, pos('@', email));
    Result := (Length(email) > 0) and (Pos('.', email) > 2) and (Pos(' ', email) = 0);
  end else begin
    Result := False;
  end;
end;

end.
