object frmPaiCadastro: TfrmPaiCadastro
  Left = 0
  Top = 0
  Caption = 'frmPaiCadastro'
  ClientHeight = 308
  ClientWidth = 574
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 574
    Height = 56
    Align = alTop
    TabOrder = 0
    DesignSize = (
      574
      56)
    object Label1: TLabel
      Left = 4
      Top = 6
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object edtCodigo: TEdit
      Left = 4
      Top = 25
      Width = 94
      Height = 21
      TabOrder = 0
      OnExit = edtCodigoExit
    end
    object pnlNavigator: TPanel
      Left = 399
      Top = 7
      Width = 171
      Height = 41
      Anchors = [akTop, akRight]
      TabOrder = 1
      object btnPrimeiro: TButton
        Left = 5
        Top = 9
        Width = 36
        Height = 25
        Hint = 'Primeiro Registro'
        Caption = '<<'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnPrimeiroClick
      end
      object btnAnterior: TButton
        Left = 47
        Top = 9
        Width = 36
        Height = 25
        Hint = 'Registro Anterior'
        Caption = '<'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnAnteriorClick
      end
      object btnProximo: TButton
        Left = 88
        Top = 9
        Width = 36
        Height = 25
        Hint = 'Pr'#243'ximo Registro'
        Caption = '>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnProximoClick
      end
      object btnUltimo: TButton
        Left = 130
        Top = 9
        Width = 36
        Height = 25
        Hint = #218'ltimo Registro'
        Caption = '>>'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnUltimoClick
      end
    end
  end
  object pnlAcoes: TPanel
    Left = 0
    Top = 56
    Width = 98
    Height = 252
    Align = alLeft
    TabOrder = 1
    object btnIncluir: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 90
      Height = 25
      Hint = 'Incluir'
      Align = alTop
      BiDiMode = bdLeftToRight
      Caption = '[ F3 ] - &Incluir'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnIncluirClick
    end
    object btnSalvar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 35
      Width = 90
      Height = 25
      Hint = 'Salvar'
      Align = alTop
      Caption = '[ F4 ] - &Salvar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnSalvarClick
    end
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 66
      Width = 90
      Height = 25
      Hint = 'Cancelar'
      Align = alTop
      BiDiMode = bdRightToLeft
      Caption = '[ F5 ] -& Cancelar'
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnEditar: TButton
      AlignWithMargins = True
      Left = 4
      Top = 97
      Width = 90
      Height = 25
      Hint = 'Editar'
      Align = alTop
      Caption = '[ F6 ] - &Editar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnEditarClick
    end
    object btnExcluir: TButton
      AlignWithMargins = True
      Left = 4
      Top = 128
      Width = 90
      Height = 25
      Hint = 'Excluir'
      Align = alTop
      Caption = '[ F7 ] - E&xcluir'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnExcluirClick
    end
  end
  object pgcDados: TPageControl
    Left = 98
    Top = 56
    Width = 476
    Height = 252
    ActivePage = tsPrincipal
    Align = alClient
    TabOrder = 2
    object tsPrincipal: TTabSheet
      Caption = 'Dados'
    end
  end
  object ds: TDataSource
    OnStateChange = dsStateChange
    OnDataChange = dsDataChange
    Left = 310
    Top = 125
  end
end
