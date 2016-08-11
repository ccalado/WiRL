(*
  Copyright 2015-2016, MARS - REST Library

  Home: https://github.com/MARS-library

*)
unit Server.Forms.Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Diagnostics, System.Actions,

  MARS.Core.Engine,
  MARS.http.Server.Indy,
  MARS.Core.Application;

type
  TMainForm = class(TForm)
    TopPanel: TPanel;
    StartButton: TButton;
    StopButton: TButton;
    MainActionList: TActionList;
    StartServerAction: TAction;
    StopServerAction: TAction;
    PortNumberEdit: TEdit;
    Label1: TLabel;
    procedure StartServerActionExecute(Sender: TObject);
    procedure StartServerActionUpdate(Sender: TObject);
    procedure StopServerActionExecute(Sender: TObject);
    procedure StopServerActionUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FServer: TMARShttpServerIndy;
    FEngine: TMARSEngine;
  public
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopServerAction.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  StartServerAction.Execute;
end;

procedure TMainForm.StartServerActionExecute(Sender: TObject);
begin
  FEngine := TMARSEngine.Create;

  // Engine configuration
  FEngine.Port := StrToIntDef(PortNumberEdit.Text, 8080);
  FEngine.ThreadPoolSize := 75;
  FEngine.Name := 'MARS Auth Demo';
  FEngine.BasePath := '/rest';

  FEngine.AddApplication(
      'Auth Application'
    , '/app'
    , ['Server.Resources.TFirstResource',
       'Server.Resources.TAuthResource'
      ]
  );

//  FEngine.AddApplication(
//      'Diagnostics'
//    , '/diagnostics'
//    , [ 'MARS.Diagnostics.Resources.TDiagnosticsResource'
//       ,'MARS.Diagnostics.Resources.TResourcesResource'
//      ]
//  ).System := True;
//  TMARSDiagnosticsManager.FEngine := FEngine;
//  TMARSDiagnosticsManager.Instance; // force instance creation

  // Create http server
  FServer := TMARShttpServerIndy.Create(FEngine);

  if not FServer.Active then
    FServer.Active := True;
end;

procedure TMainForm.StartServerActionUpdate(Sender: TObject);
begin
  StartServerAction.Enabled := (FServer = nil) or (FServer.Active = False);
end;

procedure TMainForm.StopServerActionExecute(Sender: TObject);
begin
  FServer.Active := False;
  FServer.Free;
  FServer := nil;

  FEngine.Free;
  FEngine := nil;
end;

procedure TMainForm.StopServerActionUpdate(Sender: TObject);
begin
  StopServerAction.Enabled := Assigned(FServer) and (FServer.Active = True);
end;

end.
