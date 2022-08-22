unit wbContainer;

interface

uses
  System.Classes,
  Web.HTTPApp,
  IPPeerServer,
  Datasnap.DSCommonServer,
  Datasnap.DSHTTP,
  Datasnap.DSHTTPWebBroker,
  Datasnap.DSServer;

type
  TwmsContainer = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TwmsContainer;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

uses
  System.SysUtils,
  System.IOUtils,
  Winapi.Windows,
  Web.WebReq,
  System.JSON,
  Helpers.JSONObject,
  Helpers.JSONValue,
  Helpers.Str,
  Helpers.Integer,
  Classes.Factory,
  Classes.Generic;

procedure TwmsContainer.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  strPathInfo: string;
  bufPathInfo: TArray<string>;
  strClass   : string;
  objOperacaoDB: TDBObject;

  procedure SetErrorResponse(const AMessage: string; const AStatusCode: Integer = 400 {Bad Request});
  begin
    with TJSONObject.Create do
    begin
      AddBooleanPair('sucesso', False);
      AddStringPair('mensagem', AMessage);
      Response.Content := Minify;
      Response.StatusCode := AStatusCode;
      Free;
    end;
  end;

  function GetQueryField(const AField: string): string;
  var
    strField: string;
    bufField: TArray<string>;
    i       : Integer;
  begin
    Result.Clear;

    for i := 0 to Request.QueryFields.Count.Pred do
    begin
      strField := Request.QueryFields[i];

      if strField.Pos(AField + '=') <> 1 then
      begin
        Continue;
      end;

      bufField := strField.Split('=');
      Result   := bufField[1];
      Break;
    end;
  end;
var
  isOperacao: Boolean;
begin
  // Recebendo o PathInfo constante na Request
  strPathInfo := Request.InternalPathInfo;
  // Eliminando o primeiro caracter / do PathInfo
  Delete(strPathInfo, 1, 1);
  // Dividindo o PathInfo em partes para idenificar a classe solicitada
  bufPathInfo := strPathInfo.Split('/');
  // Atribuindo o Content-Type da resposta como padrão para todas elas
  Response.ContentType := 'application/json';

  // Verificando se o comprimento do caminho está correto
  // Se não estiver, emita uma mensagem de erro e saia
  if not bufPathInfo.Count.Equals(3) then
  begin
    SetErrorResponse('Caminho para a solicitação inválido.');
    Exit;
  end;

  // Verificando se a versão da API é a mesma da constante na rota
  // Se não for, emita uma mensagem de erro e saia
  if not bufPathInfo[1].Equals('v1') then
  begin
    SetErrorResponse('Versão inválida da API.');
    Exit;
  end;

  strClass := bufPathInfo[2];

  // Verificando se a classe chamada na rota está registrada na factory
  // Se não estiver, emita uma mensagem de erro e saia
  if (TFactory.Instance.OperacoesDB.Keys.ToArray.Contains(strClass)) then
  begin
    // Instanciando um objeto TDBObject com base na solicitação
    objOperacaoDB := TFactory.Instance.GetOperacaoDB(strClass);
    objOperacaoDB.QueryParams := Request.QueryFields;
    if not Request.Content.IsEmpty then
      objOperacaoDB.Body := (TJSONObject.ParseJSONValue(Request.Content) as TJSONObject);
  end
  else
  begin
    SetErrorResponse('Classe %s não encontrada.'.Format([strClass]));
    Exit;
  end;

  try
    try
      with TJSONObject.Create do
      try
        case Request.MethodType of
          mtGet: AddPair(TJSONPair.Create('result', objOperacaoDB.Get));
          mtPost: AddPair(TJSONPair.Create('result', objOperacaoDB.Insert));
          mtPut: AddPair(TJSONPair.Create('result', objOperacaoDB.Update));
          mtDelete: AddPair(TJSONPair.Create('result', objOperacaoDB.Delete));
        end;
        Response.Content := Minify;
        Response.StatusCode := 200;
      finally
        Free;
      end;
    except
      // Em caso de erro...
      on E: Exception do
      begin
        SetErrorResponse(E.Message, 500);
      end;
    end;
  finally
    objOperacaoDB.Free;
  end;
end;

initialization

finalization

Web.WebReq.FreeWebModules;

end.
