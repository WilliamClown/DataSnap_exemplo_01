library mod_teste01;

uses
  {$IFDEF MSWINDOWS}
  Winapi.ActiveX,
  System.Win.ComObj,
  {$ENDIF }
  Web.WebBroker,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  Data.DBXCommon,
  Datasnap.DSSession,
  Classes.Factory in 'src\Classes.Factory.pas',
  Classes.Generic in 'src\Classes.Generic.pas',
  Helpers.JSONObject in 'src\Helpers.JSONObject.pas',
  Helpers.JSONValue in 'src\Helpers.JSONValue.pas',
  Helpers.Str in 'src\Helpers.Str.pas',
  uDMConexao in 'src\uDMConexao.pas' {dmConexao: TDataModule},
  wbContainer in 'src\wbContainer.pas' {wmsContainer: TWebModule},
  Helpers.Integer in 'src\Helpers.Integer.pas';

{$R *.res}
// httpd.conf entries:
//
(*
  LoadModule teste01_module modules/mod_teste01.dll

  <Location /xyz>
  SetHandler mod_teste01-handler
  </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
// 1. The TApacheModuleData variable name is changed.
// 2. The project is renamed.
// 3. The output directory is not the apache/modules directory.
// 4. The dynamic library extension depends on a platform. Use .dll on Windows and .so on Linux.
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;

exports
  GModuleData name 'teste01_module';

procedure TerminateThreads;
begin
  TDSSessionManager.Instance.Free;
  Data.DBXCommon.TDBXScheduler.Instance.Free;
end;

begin
{$IFDEF MSWINDOWS}
  CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  TApacheApplication(Application).OnTerminate := TerminateThreads;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;

end.
