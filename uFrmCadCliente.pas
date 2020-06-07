unit uFrmCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmPaiCadastro, Vcl.Buttons, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Mask, Vcl.DBCtrls, IPPeerClient, REST.Response.Adapter, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfrmCadCliente = class(TfrmPaiCadastro)
    Label2: TLabel;
    Label3: TLabel;
    edtNome: TDBEdit;
    Label4: TLabel;
    edtIdentidade: TDBEdit;
    Label5: TLabel;
    edtCPF: TDBEdit;
    Label6: TLabel;
    edtTelefone: TDBEdit;
    Label7: TLabel;
    edtEmail: TDBEdit;
    Label9: TLabel;
    edtCEP: TDBEdit;
    Label10: TLabel;
    edtLogradouro: TDBEdit;
    Label11: TLabel;
    edtNumero: TDBEdit;
    Label12: TLabel;
    edtComplemento: TDBEdit;
    Label13: TLabel;
    edtBairro: TDBEdit;
    Label17: TLabel;
    edtCidade: TDBEdit;
    Label18: TLabel;
    edtEstado: TDBEdit;
    Label19: TLabel;
    edtPais: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

uses uDMCadCliente, classUtil;

procedure TfrmCadCliente.edtCEPExit(Sender: TObject);
begin
  inherited;

  if(edtCEP.Text = '')then
    exit;

  if not(DMCadCliente.CepValido)then
  begin
    ShowMessage('Número de dígitos do CEP diferente de 8, verifique.');
    edtCEP.SetFocus;
    abort;
  end;

  DMCadCliente.CarregarDadosCEP;
end;

procedure TfrmCadCliente.edtEmailExit(Sender: TObject);
begin
  inherited;
  if (Trim(edtEmail.Text) <> '') then
  begin
    if not(TUtil.validarEmail(edtEmail.Text)) then
    begin
      ShowMessage('Email inválido, verifique!');
      edtEmail.SetFocus;
      abort;
    end;
  end;
end;

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  inherited;
  DMCadCliente := TDMCadCliente.Create(self);
  ds.DataSet := DMCadCliente.cdsCliente;
  cdsControleCodigo := DMCadCliente.cdsCliente;
end;

end.
