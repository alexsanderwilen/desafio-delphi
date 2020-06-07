inherited DMCadCliente: TDMCadCliente
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 276
  Width = 471
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = cdsClienteAfterPost
    Left = 90
    Top = 50
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://viacep.com.br/ws/36507130/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 249
    Top = 40
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 249
    Top = 85
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 249
    Top = 130
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = cdsEndereco
    FieldDefs = <>
    Response = RESTResponse1
    Left = 249
    Top = 179
  end
  object cdsEndereco: TClientDataSet
    PersistDataPacket.Data = {
      C60100009619E0BD0100000018000000090001000000030000002E0103636570
      02004A000000010005574944544802000200FE010A6C6F677261646F75726F02
      004A000000010005574944544802000200FE010B636F6D706C656D656E746F02
      004A000000010005574944544802000200FE010662616972726F02004A000000
      010005574944544802000200FE010A6C6F63616C696461646502004A00000001
      0005574944544802000200FE0102756602004A00000001000557494454480200
      0200FE0107756E696461646502004A000000010005574944544802000200FE01
      046962676502004A000000010005574944544802000200FE010367696102004A
      000000010005574944544802000200FE0101000A4348414E47455F4C4F470400
      8200030000000100000000000000040000000400000012003300360035003000
      37002D0031003300300034004100760065006E00690064006100200064006F00
      7300200045007800200043006F006D0062006100740065006E00740065007300
      000024004C0061007500720069006E0064006F00200064006500200043006100
      7300740072006F00060055006200E10004004D00470000000E00330031003600
      39003900300031000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cep'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'logradouro'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'complemento'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'bairro'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'localidade'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'uf'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'unidade'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'ibge'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'gia'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 90
    Top = 105
  end
  object XMLDocument1: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    Left = 385
    Top = 40
    DOMVendorDesc = 'Omni XML'
  end
end
