inherited frmCadCliente: TfrmCadCliente
  Caption = 'Desafio - Cadastro de Clientes'
  ClientHeight = 562
  ClientWidth = 619
  ExplicitWidth = 635
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlCabecalho: TPanel
    Width = 619
    ExplicitWidth = 619
    inherited edtCodigo: TEdit
      Tag = 101
    end
    inherited pnlNavigator: TPanel
      Left = 444
      ExplicitLeft = 444
    end
  end
  inherited pnlAcoes: TPanel
    Height = 506
    ExplicitHeight = 506
  end
  inherited pgcDados: TPageControl
    Width = 521
    Height = 506
    ExplicitWidth = 521
    ExplicitHeight = 506
    inherited tsPrincipal: TTabSheet
      ExplicitWidth = 513
      ExplicitHeight = 478
      object Label2: TLabel
        Left = 45
        Top = -15
        Width = 41
        Height = 13
        Caption = 'CODIGO'
      end
      object Label3: TLabel
        Left = 35
        Top = 16
        Width = 29
        Height = 13
        Caption = 'NOME'
        FocusControl = edtNome
      end
      object Label4: TLabel
        Left = 350
        Top = 12
        Width = 61
        Height = 13
        Caption = 'IDENTIDADE'
        FocusControl = edtIdentidade
      end
      object Label5: TLabel
        Left = 188
        Top = 58
        Width = 19
        Height = 13
        Caption = 'CPF'
        FocusControl = edtCPF
      end
      object Label6: TLabel
        Left = 35
        Top = 58
        Width = 50
        Height = 13
        Caption = 'TELEFONE'
        FocusControl = edtTelefone
      end
      object Label7: TLabel
        Left = 35
        Top = 103
        Width = 30
        Height = 13
        Caption = 'EMAIL'
        FocusControl = edtEmail
      end
      object Label9: TLabel
        Left = 35
        Top = 150
        Width = 19
        Height = 13
        Caption = 'CEP'
        FocusControl = edtCEP
      end
      object Label10: TLabel
        Left = 171
        Top = 150
        Width = 71
        Height = 13
        Caption = 'LOGRADOURO'
        FocusControl = edtLogradouro
      end
      object Label11: TLabel
        Left = 35
        Top = 193
        Width = 43
        Height = 13
        Caption = 'NUMERO'
        FocusControl = edtNumero
      end
      object Label12: TLabel
        Left = 171
        Top = 193
        Width = 75
        Height = 13
        Caption = 'COMPLEMENTO'
        FocusControl = edtComplemento
      end
      object Label13: TLabel
        Left = 35
        Top = 240
        Width = 39
        Height = 13
        Caption = 'BAIRRO'
        FocusControl = edtBairro
      end
      object Label17: TLabel
        Left = 35
        Top = 282
        Width = 38
        Height = 13
        Caption = 'CIDADE'
        FocusControl = edtCidade
      end
      object Label18: TLabel
        Left = 295
        Top = 282
        Width = 40
        Height = 13
        Caption = 'ESTADO'
        FocusControl = edtEstado
      end
      object Label19: TLabel
        Left = 35
        Top = 329
        Width = 23
        Height = 13
        Caption = 'PAIS'
        FocusControl = edtPais
      end
      object edtNome: TDBEdit
        Left = 35
        Top = 31
        Width = 300
        Height = 21
        DataField = 'NOME'
        DataSource = ds
        TabOrder = 0
      end
      object edtIdentidade: TDBEdit
        Left = 350
        Top = 31
        Width = 121
        Height = 21
        DataField = 'IDENTIDADE'
        DataSource = ds
        TabOrder = 1
      end
      object edtCPF: TDBEdit
        Tag = 101
        Left = 188
        Top = 73
        Width = 147
        Height = 21
        DataField = 'CPF'
        DataSource = ds
        TabOrder = 3
      end
      object edtTelefone: TDBEdit
        Tag = 101
        Left = 35
        Top = 73
        Width = 147
        Height = 21
        DataField = 'TELEFONE'
        DataSource = ds
        TabOrder = 2
      end
      object edtEmail: TDBEdit
        Tag = 100
        Left = 35
        Top = 118
        Width = 300
        Height = 21
        DataField = 'EMAIL'
        DataSource = ds
        TabOrder = 4
        OnExit = edtEmailExit
      end
      object edtCEP: TDBEdit
        Tag = 101
        Left = 35
        Top = 165
        Width = 121
        Height = 21
        DataField = 'CEP'
        DataSource = ds
        TabOrder = 5
        OnExit = edtCEPExit
      end
      object edtLogradouro: TDBEdit
        Left = 171
        Top = 166
        Width = 300
        Height = 21
        DataField = 'LOGRADOURO'
        DataSource = ds
        TabOrder = 6
      end
      object edtNumero: TDBEdit
        Left = 35
        Top = 208
        Width = 121
        Height = 21
        DataField = 'NUMERO'
        DataSource = ds
        TabOrder = 7
      end
      object edtComplemento: TDBEdit
        Left = 171
        Top = 208
        Width = 300
        Height = 21
        DataField = 'COMPLEMENTO'
        DataSource = ds
        TabOrder = 8
      end
      object edtBairro: TDBEdit
        Left = 35
        Top = 255
        Width = 300
        Height = 21
        DataField = 'BAIRRO'
        DataSource = ds
        TabOrder = 9
      end
      object edtCidade: TDBEdit
        Left = 35
        Top = 301
        Width = 246
        Height = 21
        DataField = 'CIDADE'
        DataSource = ds
        TabOrder = 10
      end
      object edtEstado: TDBEdit
        Left = 295
        Top = 301
        Width = 40
        Height = 21
        DataField = 'ESTADO'
        DataSource = ds
        TabOrder = 11
      end
      object edtPais: TDBEdit
        Left = 35
        Top = 348
        Width = 300
        Height = 21
        DataField = 'PAIS'
        DataSource = ds
        TabOrder = 12
      end
    end
  end
  inherited ds: TDataSource
    DataSet = DMCadCliente.cdsCliente
    Left = 570
    Top = 220
  end
end
