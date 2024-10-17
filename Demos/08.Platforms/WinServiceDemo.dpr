program WinServiceDemo;

uses
  Vcl.SvcMgr,
  Server.WinService in 'Server.WinService.pas' {modService: TService},
  Server.Filters in 'Server.Filters.pas',
  Server.Listener in 'Server.Listener.pas',
  Server.Resources in 'Server.Resources.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TmodService, modService);
  Application.Run;
end.
