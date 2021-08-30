object fmDM: TfmDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object Connection: TFDConnection
    Params.Strings = (
      'Database=delphitec'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object DriverLink: TFDPhysMySQLDriverLink
    Left = 128
    Top = 8
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    ScreenCursor = gcrAppWait
    Left = 24
    Top = 64
  end
  object tbAux: TFDQuery
    Connection = Connection
    Left = 128
    Top = 64
  end
end
