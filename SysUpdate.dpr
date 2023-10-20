program SysUpdate;



{$R *.dres}

uses
  Vcl.Forms,
  sysupdate.view.main in 'src\view\sysupdate.view.main.pas' {Main},
  sysupdate.services.util in 'src\services\sysupdate.services.util.pas',
  sysupdate.services.autoupdate in 'src\services\sysupdate.services.autoupdate.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
