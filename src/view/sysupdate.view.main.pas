unit sysupdate.view.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  dxGDIPlusClasses, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.WinXCtrls;

type
  TMain = class(TForm)
    PanelContainer: TPanel;
    PanelMain: TPanel;
    PanelHeader: TPanel;
    PanelLogo: TPanel;
    ImageLogo: TImage;
    PanelTitle: TPanel;
    LabelTitle: TLabel;
    PanelFooter: TPanel;
    PanelBody: TPanel;
    PanelDescription: TPanel;
    PanelProgressBar: TPanel;
    LabelDescription: TLabel;
    ActionList: TActionList;
    ImageList: TImageList;
    actionAtualizar: TAction;
    actionCancelar: TAction;
    buttonAtualizar: TButton;
    Button2: TButton;
    PanelLabelProgressBar: TPanel;
    LabelProgressBar: TLabel;
    procedure FormShow(Sender: TObject);
    procedure actionAtualizarExecute(Sender: TObject);
    procedure actionCancelarExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure BuildMessage;
    procedure UpgradeApp;
    procedure ActiveIndicator;
  public
    { Public declarations }
  end;

var
  main: TMain;

implementation

{$R *.dfm}

uses sysupdate.services.util, sysupdate.services.autoupdate;

{ TMain }

procedure TMain.actionAtualizarExecute(Sender: TObject);
begin
  UpgradeApp;
end;

procedure TMain.actionCancelarExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TMain.ActiveIndicator;
begin
  if LabelProgressBar.Visible then
  begin
    LabelProgressBar.Visible := False;
  end
  else
  begin
    LabelProgressBar.Visible := True;
  end;
  LabelProgressBar.Refresh;
end;

procedure TMain.BuildMessage;
var
  oUtils: TUtils;
  FVersao, FMessage, sPath, sAppName: String;
begin
  try
    oUtils := TUtils.Create;
    sPath := ExtractFilePath(Application.ExeName);
    sAppName := oUtils.ReadIni(sPath +  'versionLocal.ini', 'version', 'InternalName');
    FVersao := oUtils.ReadIni(sPath +  'versionFTP.ini', 'version', 'number');
    FMessage := 'Está disponível a versão ' + FVersao + ' do ' + sAppName +
      '  para atualização . Clique em "Atualizar" para prossegir com a atualização ou em "Cancelar" para sair sem atualizar.';
    LabelDescription.Caption := FMessage;
  finally
    oUtils.Free;
  end;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  main := nil;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  BuildMessage;
end;

procedure TMain.UpgradeApp;
var
  FUpdate : TAutoUpdate;
begin
  FUpdate := TAutoUpdate.Create(Self);
  try
    FUpdate.Username := 'alocarioca.novorioexpress.com';
    FUpdate.Password := 'al0c@rioca';
    FUpdate.Host := 'ftp.novorioexpress.com';
    FUpdate.Port := 21;
    ActiveIndicator;
    FUpdate.Execute;
    ActiveIndicator;
    Application.Terminate;
  finally
    FUpdate.Free;
  end;
end;

end.
