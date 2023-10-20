unit sysupdate.services.util;

interface

uses IniFiles, System.SysUtils, Dialogs, System.UITypes, Vcl.ExtCtrls,
  System.Classes, IdBaseComponent, IdComponent, idftpcommon,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP;

type
  TUtils = class(TObject)
  private
  public
    class function ReadIni(sFile: String; sSection: String;
      sKey: String): String;
    class function WriteIni(sFile: String; sSection: String; sKey: String;
      sValue: String): Boolean;
  end;

implementation

{ TUtils }

class function TUtils.ReadIni(sFile, sSection, sKey: String): String;
var
  Ini: TIniFile;
  sMess: String;
begin
  Result := '';
  Ini := TIniFile.Create(sFile);
  try
    Result := Ini.ReadString(sSection, sKey, '');
    Ini.Free;
  except
    on e: Exception do
    begin
      sMess := e.Message;
      Ini.Free;
      MessageDlg(sMess, mtError, [mbOK], 0);
    end;
  end;

end;

class function TUtils.WriteIni(sFile, sSection, sKey, sValue: String): Boolean;
var
  Ini: TIniFile;
  sMess: String;
begin
  Result := False;
  Ini := TIniFile.Create(sFile);
  try
    Ini.WriteString(sSection, sKey, sValue);
    Result := True;
    Ini.Free;
  except
    on e: Exception do
    begin
      sMess := e.Message;
      Ini.Free;
      MessageDlg(sMess, mtError, [mbOK], 0);
    end;
  end;
end;

end.
