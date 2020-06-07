unit uFrmPaiCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.ComCtrls,
  System.UITypes, Datasnap.DBClient;

type
  TfrmPaiCadastro = class(TForm)
    pnlCabecalho: TPanel;
    pnlAcoes: TPanel;
    edtCodigo: TEdit;
    Label1: TLabel;
    btnIncluir: TButton;
    btnSalvar: TButton;
    btnCancelar: TButton;
    btnEditar: TButton;
    ds: TDataSource;
    btnExcluir: TButton;
    pnlNavigator: TPanel;
    btnPrimeiro: TButton;
    btnAnterior: TButton;
    btnProximo: TButton;
    btnUltimo: TButton;
    pgcDados: TPageControl;
    tsPrincipal: TTabSheet;
    procedure dsStateChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnPrimeiroClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnUltimoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    AutoInc: Integer;
    procedure focoPrimeiroControle();
    procedure tratarCampoCodigo;
    function registroExistente(pcodigo: Integer): Boolean;
  public
    cdsControleCodigo: TClientDataSet;
  end;

var
  frmPaiCadastro: TfrmPaiCadastro;

const
  cTagCaracterMaiusculo = 0;
  cTagCaracterMinusculo = 100;
  cTagSomenteNumero = 101;
  CTagNumerosDecimais = 102;

implementation

uses
  Vcl.DBCtrls;

{$R *.dfm}


procedure TfrmPaiCadastro.dsDataChange(Sender: TObject; Field: TField);
begin
   btnPrimeiro.Enabled := (btnEditar.Enabled) and not ((Sender as TDataSource).DataSet.Bof);
   btnAnterior.Enabled := btnPrimeiro.Enabled;
   btnProximo.Enabled := (btnEditar.Enabled) and not ((Sender as TDataSource).DataSet.Eof);
   btnUltimo.Enabled := btnProximo.Enabled;

   edtCodigo.Text := (Sender as TDataSource).DataSet.FieldByName('CODIGO').AsString;
end;

procedure TfrmPaiCadastro.dsStateChange(Sender: TObject);
begin
   btnIncluir.Enabled := (Sender as TDataSource).State in [dsBrowse];
   btnSalvar.Enabled := (Sender as TDataSource).State in [dsEdit, dsInsert];
   btnCancelar.Enabled := btnSalvar.Enabled;
   btnEditar.Enabled := (btnIncluir.Enabled) and not ((Sender as TDataSource).DataSet.IsEmpty);
   btnExcluir.Enabled := btnEditar.Enabled;
   edtCodigo.Enabled := not btnSalvar.Enabled;
end;

procedure TfrmPaiCadastro.edtCodigoExit(Sender: TObject);
begin
  tratarCampoCodigo;
end;

procedure TfrmPaiCadastro.focoPrimeiroControle;
var
  index: Integer;
  menorTabControl: Integer;
  controle: TWinControl;
begin
  pgcDados.ActivePage := tsPrincipal;
  tsPrincipal.SetFocus;
  MenorTabControl := 999;
  for index := 0 to tsPrincipal.ControlCount -1 do
  begin
    if (tsPrincipal.Controls[index] is TDBEdit) then
      if ((tsPrincipal.Controls[index] as TDBEdit).TabOrder = 0) and
         ((tsPrincipal.Controls[index] as TDBEdit).Enabled)  then
      begin
        controle := (tsPrincipal.Controls[index] as TDBEdit);
        Break;
      end
      else
      begin
        if (MenorTabControl > (tsPrincipal.Controls[index] as TDBEdit).TabOrder) and
           ((tsPrincipal.Controls[index] as TWinControl).Enabled)  then
        begin
          MenorTabControl := (tsPrincipal.Controls[index] as TDBEdit).TabOrder;
          controle := (tsPrincipal.Controls[index] as TDBEdit);
        end;
      end;
  end;
  controle.SetFocus;
end;

procedure TfrmPaiCadastro.btnIncluirClick(Sender: TObject);
begin
  if (ds.DataSet.State in [dsInsert, dsEdit]) then
    Exit;

  Inc(AutoInc);

  while registroExistente(autoInc) do
  begin
    Inc(AutoInc);
  end;

  ds.DataSet.Insert;
  ds.DataSet.FieldByName('CODIGO').AsInteger := AutoInc;
  edtCodigo.Text := AutoInc.ToString;

  focoPrimeiroControle();
end;

procedure TfrmPaiCadastro.btnPrimeiroClick(Sender: TObject);
begin
  ds.DataSet.First;
end;

procedure TfrmPaiCadastro.btnProximoClick(Sender: TObject);
begin
  ds.DataSet.Next;
end;

procedure TfrmPaiCadastro.btnSalvarClick(Sender: TObject);
begin
  if (ds.DataSet.State in [dsInsert, dsEdit]) then
  begin
    ds.DataSet.Post;
    edtCodigo.SetFocus;
  end;
end;

procedure TfrmPaiCadastro.btnUltimoClick(Sender: TObject);
begin
  ds.DataSet.Last;
end;

procedure TfrmPaiCadastro.btnAnteriorClick(Sender: TObject);
begin
  ds.DataSet.Prior;
end;

procedure TfrmPaiCadastro.btnCancelarClick(Sender: TObject);
begin
  if ds.DataSet.State in [dsInsert, dsEdit] then
  begin
    ds.DataSet.Cancel;
    dsStateChange(ds);
    edtCodigo.SetFocus;
  end;
end;

procedure TfrmPaiCadastro.btnEditarClick(Sender: TObject);
begin
  if not(ds.DataSet.State in [dsInsert, dsEdit]) then
  begin
    ds.DataSet.Edit;
    focoPrimeiroControle();
  end;
end;

procedure TfrmPaiCadastro.btnExcluirClick(Sender: TObject);
begin
  if (MessageDlg('Deseja mesmo excluir este registro?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    ds.DataSet.Delete;
    dsStateChange(ds);
    edtCodigo.SetFocus;
  end;
end;

procedure TfrmPaiCadastro.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnSalvar.Enabled then
  begin
    if ds.DataSet.State in [dsInsert, dsEdit] then
    begin
      CanClose := False;
      MessageDlg('Salve ou cancele a operação corrente antes de fechar a janela.',
        mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TfrmPaiCadastro.FormCreate(Sender: TObject);
begin
  AutoInc := 0;
end;

procedure TfrmPaiCadastro.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    vk_f3:begin
      btnIncluir.Click;
    end;
    vk_f4:begin
      btnSalvar.Click;
    end;
    vk_f5:begin
      btnCancelar.Click;
    end;
    vk_f6:begin
      btnEditar.Click;
    end;
    vk_f7:begin
      btnExcluir.Click;
    end;
  end;
end;

procedure TfrmPaiCadastro.FormKeyPress(Sender: TObject; var Key: Char);
var
  ComponenteAtivo: TComponent;
begin
  if(Key = #13)then
  begin
    Perform(Wm_NextDlgCtl,0,0);
  end
  else
  begin
    ComponenteAtivo := Screen.ActiveControl;
    if (ComponenteAtivo is TDBEdit) or
       (ComponenteAtivo is TEdit) then
    begin
      case ComponenteAtivo.Tag of
        cTagCaracterMaiusculo: begin
          Key := Char(AnsiUpperCase(Key)[1]);
        end;
        cTagCaracterMinusculo: begin
          Key := Char(AnsiLowerCase(Key)[1]);
        end;
        cTagSomenteNumero: begin
          if(not(key in ['0'..'9']) and (word(key) <> vk_back))then
            key := #0;
        end;
        CTagNumerosDecimais: begin
          if not(key in ['0'..'9',',',#8]) then
            key :=#0;
        end;
      end;
    end;
  end;
end;

function TfrmPaiCadastro.registroExistente(pCodigo: Integer): Boolean;
begin
  result := false;
  if(not(Assigned(cdsControleCodigo)))then
    exit;

  try
    cdsControleCodigo.DisableControls;
    result := (cdsControleCodigo.FindKey([pCodigo]))
  finally
    cdsControleCodigo.EnableControls;
  end;
end;

procedure TfrmPaiCadastro.tratarCampoCodigo;
begin
  if Length(Trim(edtCodigo.Text)) <> 0 then
  begin
    if(Assigned(cdsControleCodigo))then
    begin
      if(cdsControleCodigo.FindKey([StrToInt(Trim(edtCodigo.Text))]))then
      begin
        focoPrimeiroControle();
      end
      else begin
        AutoInc := StrToInt(edtCodigo.Text)-1;
        btnIncluir.Click;
      end;
    end;
  end;
end;

end.
