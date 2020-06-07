unit uDmPai;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DBClient, Data.DB;

type
  TCampo = record
    Nome: string;
    Descricao: string;
    Tipo: TFieldType;
    Tamanho: Integer;
    procedure Limpa;
  end;

  TCamposArray = array of TCampo;

  TdmPai = class(TDataModule)
  private
    { Private declarations }
  protected
    procedure criarCDS(cds: TClientDataSet; campos :array of TCampo);
  public
    { Public declarations }
  end;

var
  dmPai: TdmPai;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmPai }

procedure TdmPai.criarCDS(cds: TClientDataSet; campos :array of TCampo);
var
  index, minimo, maximo: Integer;
begin
  cds.Close;
  minimo := Low(Campos);
  maximo := High(Campos);
  for index := minimo to maximo do
  begin
    with cds.FieldDefs.AddFieldDef do
    begin
      Name := Campos[index].Nome;
      DataType := Campos[index].Tipo;
      Size := Campos[index].Tamanho;
      DisplayName := Campos[index].Descricao;
    end;
  end;
  cds.IndexFieldNames := 'CODIGO';
  cds.CreateDataSet;
end;

{ TCampo }

procedure TCampo.Limpa;
begin
  Nome := '';
  Descricao := '';
  Tipo := ftUnknown;
  Tamanho := 0;
end;

end.
