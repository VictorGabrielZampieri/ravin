object frmListaClientes: TfrmListaClientes
  Left = 0
  Top = 0
  Caption = 'Lista de Clientes'
  ClientHeight = 466
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlListaClientes: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 466
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      640
      466)
    object lblInformacoesGerenciais: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 624
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alTop
      Caption = 'Informa'#231#245'es gerenciais'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -21
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 221
    end
    object Shape1: TShape
      Left = 8
      Top = 44
      Width = 104
      Height = 73
      Brush.Color = 14671839
      Pen.Color = clWhite
      Shape = stRoundRect
    end
    object Shape2: TShape
      Left = 228
      Top = 44
      Width = 104
      Height = 73
      Brush.Color = 14671839
      Pen.Color = clWhite
      Shape = stRoundRect
    end
    object Shape5: TShape
      Left = 118
      Top = 44
      Width = 104
      Height = 73
      Brush.Color = 14671839
      Pen.Color = clWhite
      Shape = stRoundRect
    end
    object lblListaClientesTitulo: TLabel
      AlignWithMargins = True
      Left = 8
      Top = 153
      Width = 153
      Height = 25
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Caption = 'Lista de clientes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -21
      Font.Name = 'Roboto'
      Font.Style = []
      ParentFont = False
    end
    inline frmBotaoCancelar: TfrmBotaoCancelar
      Left = 134
      Top = 415
      Width = 120
      Height = 59
      Anchors = [akLeft, akBottom]
      TabOrder = 0
      ExplicitLeft = 134
      ExplicitTop = 415
      ExplicitWidth = 120
      ExplicitHeight = 59
      inherited pnlFundo: TPanel
        Width = 120
        Height = 59
        ExplicitWidth = 120
        ExplicitHeight = 59
        inherited spbBotaoCancelar: TSpeedButton
          Width = 120
          Height = 59
          Caption = 'Cancelar'
          OnClick = frmBotaoCancelarspbBotaoCancelarClick
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 120
          ExplicitHeight = 50
        end
      end
    end
    inline frmBotaoPrimario: TfrmBotaoPrimario
      Left = 8
      Top = 415
      Width = 120
      Height = 59
      Anchors = [akLeft, akBottom]
      Color = clWhite
      ParentBackground = False
      ParentColor = False
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 415
      ExplicitWidth = 120
      ExplicitHeight = 59
      inherited pnlFundo: TPanel
        Width = 120
        Height = 59
        ExplicitWidth = 120
        ExplicitHeight = 59
        inherited spbBotaoPrimario: TSpeedButton
          Width = 120
          Height = 59
          Caption = 'Inserir'
          OnClick = frmBotaoPrimariospbBotaoPrimarioClick
          ExplicitLeft = 16
          ExplicitTop = 8
          ExplicitWidth = 120
          ExplicitHeight = 45
        end
      end
    end
    object lvwClientes: TListView
      AlignWithMargins = True
      Left = 8
      Top = 181
      Width = 624
      Height = 225
      Margins.Left = 8
      Margins.Top = 140
      Margins.Right = 8
      Margins.Bottom = 60
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BiDiMode = bdLeftToRight
      BorderStyle = bsNone
      Color = clWhite
      Columns = <
        item
          Caption = 'Nome'
          Width = 300
        end
        item
          Caption = 'Cpf'
          Width = 150
        end
        item
          Caption = 'Telefone'
          Width = 150
        end
        item
          Caption = 'Status'
          Width = 100
        end>
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Roboto'
      Font.Style = []
      GridLines = True
      ParentBiDiMode = False
      ParentFont = False
      TabOrder = 2
      ViewStyle = vsReport
      OnSelectItem = lvwClientesSelectItem
    end
  end
end
