unit Classes.Pessoas;

interface

Uses
  Classes, Classes.Generic, System.Json, System.Generics.Collections,
  uDMConexao;

{$METHODINFO ON}
type
  TPessoas = class(TDBObject)
  strict private
    FDMPessoa: TdmConexao;
  public
    constructor Create; override;
    destructor Destroy; override;

    function Insert: TJSONValue; override;
    function Update: TJSONValue; override;
    function Delete: TJSONValue; override;
    function Get: TJSONValue; override;
  end;
{$METHODINFO Off}

implementation

{ TPessoas }

uses
  Classes.Factory, Helpers.Str, System.SysUtils;



{ TPessoas }

constructor TPessoas.Create;
begin
  FDMPessoa := TdmConexao.Create(nil);
end;

function TPessoas.Delete: TJSONValue;
begin

end;

destructor TPessoas.Destroy;
begin
  FDMPessoa.Free;
  inherited;
end;

function TPessoas.Get: TJSONValue;
var
  jsonObject: TJSONObject;
  jsonArray: TJSONArray;
  I: Integer;
begin
  FDMPessoa.qPessoas.Close;
  if ((QueryParams <> nil) and (not QueryParams.Text.IsEmpty)) then
    FDMPessoa.qPessoas.FieldByName('ID').Value := GetQueryParamsByName('id');
  FDMPessoa.qPessoas.Open;

  if FDMPessoa.qPessoas.RecordCount > 0 then
  begin
    jsonArray := TJSONArray.Create;

    while not FDMPessoa.qPessoas.Eof do
    begin
      jsonObject := TJSONObject.Create;
      for I := 0 to FDMPessoa.qPessoas.Fields.Count - 1 do
      begin
        jsonObject.AddPair(TJSONPair.Create(FDMPessoa.qPessoas.Fields[I].FieldName, FDMPessoa.qPessoas.Fields[I].Value));
      end;

      jsonArray.AddElement(jsonObject);
      FDMPessoa.qPessoas.Next;
    end;

    Result := jsonArray;
  end
  else
    Result := TJSONArray.Create;
end;

function TPessoas.Insert: TJSONValue;
begin

end;

function TPessoas.Update: TJSONValue;
begin

end;

initialization
  TFactory.Instance.RegisterClass('pessoas', TPessoas);

end.
