program Desafio;

uses
  Vcl.Forms,
  uDmPai in 'DataModule\uDmPai.pas' {dmPai: TDataModule},
  uDMCadCliente in 'DataModule\uDMCadCliente.pas' {DMCadCliente: TDataModule},
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uFrmPaiCadastro in 'uFrmPaiCadastro.pas' {frmPaiCadastro},
  uFrmCadCliente in 'uFrmCadCliente.pas' {frmCadCliente},
  classUtil in 'Util\classUtil.pas',
  classEnviarEmail in 'Util\classEnviarEmail.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
