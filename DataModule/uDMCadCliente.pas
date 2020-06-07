unit uDMCadCliente;

interface

uses
  System.SysUtils, System.Classes, uDmPai, Data.DB,
  Datasnap.DBClient, IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, Xml.adomxmldom, Xml.Win.msxmldom,
  Xml.omnixmldom;

type
  TDMCadCliente = class(TdmPai)
    cdsCliente: TClientDataSet;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    cdsEndereco: TClientDataSet;
    XMLDocument1: TXMLDocument;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsClienteAfterPost(DataSet: TDataSet);
  private
    procedure carregarCdsCEPViaJson(url: String);
  public
    function CepValido :Boolean;
    procedure CarregarDadosCEP;
    function quantidadeDigitosCepValido(cep: string): Boolean;
    function gerarXml: String;
    procedure EnviarEmailCliente;
  end;

const
  CampoCliente: array[1..14] of TCampo = (
    (nome: 'CODIGO';      Descricao: 'Código';      Tipo: TFieldType.ftInteger;),
    (Nome: 'NOME';        Descricao: 'Nome';        Tipo: TFieldType.ftString; Tamanho:  80; ),
    (Nome: 'IDENTIDADE';  Descricao: 'Identidade';  Tipo: TFieldType.ftString; Tamanho:  20; ),
    (Nome: 'CPF';         Descricao: 'CPF';         Tipo: TFieldType.ftString; Tamanho:  11; ),
    (Nome: 'TELEFONE';    Descricao: 'Telefone';    Tipo: TFieldType.ftString; Tamanho:  11; ),
    (Nome: 'EMAIL';       Descricao: 'E-mail';      Tipo: TFieldType.ftString; Tamanho: 200; ),
    (Nome: 'CEP';         Descricao: 'CEP';         Tipo: TFieldType.ftString; Tamanho:   9; ),
    (Nome: 'LOGRADOURO';  Descricao: 'Logradouro';  Tipo: TFieldType.ftString; Tamanho:  80; ),
    (Nome: 'NUMERO';      Descricao: 'Número';      Tipo: TFieldType.ftString; Tamanho:  20; ),
    (Nome: 'COMPLEMENTO'; Descricao: 'Complemento'; Tipo: TFieldType.ftString; Tamanho:  80; ),
    (Nome: 'BAIRRO';      Descricao: 'Bairro';      Tipo: TFieldType.ftString; Tamanho:  80; ),
    (Nome: 'CIDADE';      Descricao: 'Cidade';      Tipo: TFieldType.ftString; Tamanho:  80; ),
    (Nome: 'ESTADO';      Descricao: 'Estado';      Tipo: TFieldType.ftString; Tamanho:   2; ),
    (Nome: 'PAIS';        Descricao: 'País';        Tipo: TFieldType.ftString; Tamanho:  80;));

var
  DMCadCliente: TDMCadCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses classUtil, classEnviarEmail;

{$R *.dfm}

{ TDMCadCliente }

procedure TDMCadCliente.cdsClienteAfterPost(DataSet: TDataSet);
begin
  inherited;
  if(Length(Trim(cdsCliente.FieldByName('EMAIL').AsString))> 0)then
    EnviarEmailCliente;
end;

function TDMCadCliente.CepValido: Boolean;
var
  validaQuantidadeDigitos: Boolean;
begin
  validaQuantidadeDigitos := quantidadeDigitosCepValido(cdsCliente.FieldByName('CEP').AsString);

  result := validaQuantidadeDigitos;
end;

procedure TDMCadCliente.DataModuleCreate(Sender: TObject);
begin
  inherited;
  criarCDS(cdsCliente, CampoCliente);
end;

procedure TDMCadCliente.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  cdsCliente.Close;
end;

procedure TDMCadCliente.EnviarEmailCliente;
var
  email: TEmail;
begin
  email := TEmail.Create(465, 'smtp.gmail.com', 'desafiodelphi@gmail.com', 'DESafio123#@!');
  email.enviarEmail(
            'desafiodelphi@gmail.com',
            'Desafio Delphi',
            cdsCliente.FieldByName('EMAIL').AsString,
            'Cadastro',
            gerarXML());

end;

function TDMCadCliente.gerarXml: String;
const
  node = '<%s>';
var
  I: Integer;
begin
  XMLDocument1.XML.Add('<?xml version="1.0" encoding="UTF-8"?>');
  XMLDocument1.XML.Add('<CLIENTE>');
  for I := 0 to cdsCliente.FieldCount-1 do
  begin
    if cdsCliente.Fields[i].FieldName = 'CEP'  then
      XMLDocument1.XML.Add('<ENDERECO>');

    XMLDocument1.XML.Add(Format(node, [cdsCliente.Fields[i].FieldName]));
    XMLDocument1.XML.Add(cdsCliente.Fields[i].AsString);
    XMLDocument1.XML.Add(Format(node, ['/'+ cdsCliente.Fields[i].FieldName]));
  end;
  XMLDocument1.XML.Add('</ENDERECO>');
  XMLDocument1.XML.Add('</CLIENTE>');
  XMLDocument1.Active := true;
  result := XMLDocument1.xml.Text;
end;

procedure TDMCadCliente.CarregarDadosCEP;
const
  url = 'https://viacep.com.br/ws/%s/json';
begin
  carregarCdsCEPViaJson(format(url, [cdsCliente.FieldByName('CEP').AsString]));
end;

function TDMCadCliente.quantidadeDigitosCepValido(cep: string): Boolean;
begin
  result := length(TUtil.somenteNumero(cep)) = 8;
end;

procedure TDMCadCliente.carregarCdsCEPViaJson(url: String);
begin
  try
    try
      cdsEndereco.Close;
      RESTClient1.BaseURL := url;
      RESTRequest1.Execute;

      if (RESTResponse1.StatusCode = 200) and (cdsEndereco.fields[0].FieldName = 'erro') then
      begin
        raise Exception.Create('CEP informado não encontrado.');
      end;
      if (RESTResponse1.StatusCode = 200)then
      begin
        if cdsCliente.State in [dsInsert, dsEdit] then
        begin
          cdsCliente.FieldByName('LOGRADOURO').AsString := cdsEndereco.FieldByName('logradouro').AsString.ToUpper;
          cdsCliente.FieldByName('COMPLEMENTO').AsString := cdsEndereco.FieldByName('complemento').AsString.ToUpper;
          cdsCliente.FieldByName('BAIRRO').AsString := cdsEndereco.FieldByName('bairro').AsString.ToUpper;
          cdsCliente.FieldByName('CIDADE').AsString := cdsEndereco.FieldByName('localidade').AsString.ToUpper;
          cdsCliente.FieldByName('ESTADO').AsString := cdsEndereco.FieldByName('uf').AsString.ToUpper;
        end;
      end;
    except
      on E: Exception do
        raise Exception.Create(e.Message);
    end;
  finally
    cdsEndereco.Close;
  end;
end;




end.
