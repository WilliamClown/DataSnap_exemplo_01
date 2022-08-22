unit Classes.Generic;

interface

uses
  System.Classes, System.Json, System.Generics.Collections;

type
  TDBObject = class abstract
  strict private
    FBody: TJSONObject;
    FQueryParams: TStrings;
  protected
    function GetQueryParamsByName(const AName: string): Variant;
  public
    constructor Create; virtual;
    function Insert: TJSONValue; virtual; abstract;
    function Update: TJSONValue; virtual; abstract;
    function Delete: TJSONValue; virtual; abstract;
    function Get: TJSONValue; virtual; abstract;

    property QueryParams: TStrings read FQueryParams write FQueryParams;
    property Body: TJSONObject read FBody write FBody;
  end;

  TDBObjectClass = class of TDBObject;

implementation

uses
  Helpers.Str,
  Helpers.Integer;

{ TDBObject }

constructor TDBObject.Create;
begin
end;

function TDBObject.GetQueryParamsByName(const AName: string): Variant;
var
  strField: string;
  bufField: TArray<string>;
  i: Integer;
begin
  Result := '';
  if QueryParams <> nil then
  begin
    for i := 0 to QueryParams.Count.Pred do
    begin
      strField := QueryParams[i];

      if strField.Pos(AName + '=') <> 1 then
      begin
        Continue;
      end;

      bufField := strField.Split('=');
      Result   := bufField[1];
      Break;
    end;
  end;
end;

end.
