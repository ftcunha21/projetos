object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Cadastro de Clientes'
  ClientHeight = 531
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 441
    Height = 531
    Shape = bsSpacer
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 13
    Width = 425
    Height = 169
    Caption = 'Dados do Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object edNome: TLabeledEdit
      Left = 16
      Top = 43
      Width = 390
      Height = 21
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome'
      TabOrder = 0
    end
    object edIdentidade: TLabeledEdit
      Left = 16
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'Identidade'
      TabOrder = 1
    end
    object edTelefone: TLabeledEdit
      Left = 285
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 49
      EditLabel.Height = 13
      EditLabel.Caption = 'Telefone'
      TabOrder = 3
    end
    object edEmail: TLabeledEdit
      Left = 16
      Top = 128
      Width = 390
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Email'
      TabOrder = 4
    end
    object edCPF: TLabeledEdit
      Left = 151
      Top = 88
      Width = 121
      Height = 21
      EditLabel.Width = 99
      EditLabel.Height = 13
      EditLabel.Caption = 'CPF (s'#243' n'#250'meros)'
      MaxLength = 11
      NumbersOnly = True
      TabOrder = 2
      OnExit = edCPFExit
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 188
    Width = 425
    Height = 285
    Caption = 'Endere'#231'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel2: TBevel
      Left = -527
      Top = -260
      Width = 952
      Height = 545
      Shape = bsSpacer
    end
    object edLogradouro: TLabeledEdit
      Left = 16
      Top = 85
      Width = 390
      Height = 21
      EditLabel.Width = 65
      EditLabel.Height = 13
      EditLabel.Caption = 'Logradouro'
      Enabled = False
      TabOrder = 1
    end
    object edCEP: TLabeledEdit
      Left = 16
      Top = 40
      Width = 113
      Height = 21
      EditLabel.Width = 108
      EditLabel.Height = 13
      EditLabel.Caption = 'C.E.P. (s'#243' n'#250'meros)'
      MaxLength = 8
      NumbersOnly = True
      TabOrder = 0
      OnExit = edCEPExit
      OnKeyUp = edCEPKeyUp
    end
    object edComplemento: TLabeledEdit
      Left = 71
      Top = 128
      Width = 335
      Height = 21
      EditLabel.Width = 79
      EditLabel.Height = 13
      EditLabel.Caption = 'Complemento'
      TabOrder = 3
    end
    object edCidade: TLabeledEdit
      Left = 16
      Top = 208
      Width = 358
      Height = 21
      EditLabel.Width = 38
      EditLabel.Height = 13
      EditLabel.Caption = 'Cidade'
      Enabled = False
      TabOrder = 5
    end
    object edNumero: TLabeledEdit
      Left = 16
      Top = 128
      Width = 49
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#250'mero'
      NumbersOnly = True
      TabOrder = 2
    end
    object edBairro: TLabeledEdit
      Left = 16
      Top = 165
      Width = 390
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Bairro'
      Enabled = False
      TabOrder = 4
    end
    object edUf: TLabeledEdit
      Left = 380
      Top = 208
      Width = 26
      Height = 21
      EditLabel.Width = 14
      EditLabel.Height = 13
      EditLabel.Caption = 'UF'
      Enabled = False
      TabOrder = 6
    end
    object edPais: TLabeledEdit
      Left = 16
      Top = 246
      Width = 390
      Height = 21
      EditLabel.Width = 23
      EditLabel.Height = 13
      EditLabel.Caption = 'Pa'#237's'
      Enabled = False
      TabOrder = 7
    end
  end
  object bSalvar: TBitBtn
    Left = 8
    Top = 484
    Width = 75
    Height = 25
    Caption = 'Salvar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 2
    OnClick = bSalvarClick
  end
  object bSair: TBitBtn
    Left = 358
    Top = 484
    Width = 75
    Height = 25
    Caption = 'Sair'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333333333333333333FFF33FF333FFF339993370733
      999333777FF37FF377733339993000399933333777F777F77733333399970799
      93333333777F7377733333333999399933333333377737773333333333990993
      3333333333737F73333333333331013333333333333777FF3333333333910193
      333333333337773FF3333333399000993333333337377737FF33333399900099
      93333333773777377FF333399930003999333337773777F777FF339993370733
      9993337773337333777333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bSairClick
  end
  object RESTResponse1: TRESTResponse
    Left = 349
    Top = 171
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkHTTPHEADER
        name = 'X-VTEX-API-AppKey'
      end
      item
        Kind = pkHTTPHEADER
        name = 'X-VTEX-API-AppToken'
      end
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 264
    Top = 176
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 184
    Top = 171
  end
end
