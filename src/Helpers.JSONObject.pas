unit Helpers.JSONObject;

interface

uses
  System.Classes, System.JSON;

{$I Includes.Version.inc}

type
  TJSONObjectHelper = class helper for TJSONObject
  strict private
    function  GetNode(const AName: string): TJSONValue;
    procedure SetNode(const AName: string; const Value: TJSONValue);
    {$IFDEF DELPHI_SYDNEY_BELLOW}
    function  JSONFormat(const AJSONObject: TJSONObject): string;
    {$ENDIF}
  public
    function HasProperty(const AProperty: string; const AIgnoreCase: Boolean = True): Boolean;
    function IndexOf(const AProperty: string): Integer;
    procedure Clear;
    procedure ClearObject;
    function IsJSONArray(const AProperty: string): Boolean;
    function IsJSONObject(const AProperty: string): Boolean;
    function AddStringPair(const Str, Val: string): TJSONObject;
    function AddIntegerPair(const Str: string; const Val: Integer): TJSONObject;
    function AddFloatPair(const Str: string; const Val: Extended): TJSONObject;
    function AddBooleanPair(const Str: string; const Val: Boolean): TJSONObject;
    function AddDatePair(const Str: string; const Val: TDate): TJSONObject;
    function AddTimePair(const Str: string; const Val: TTime): TJSONObject;
    function AddDateTimePair(const Str: string; const Val: TDateTime): TJSONObject;
    function AddISODatePair(const Str: string; const Val: TDate): TJSONObject;
    function AddISODateTimePair(const Str: string; const Val: TDateTime): TJSONObject;
    function AddBinaryPair(const Str: string; const Val: TStream): TJSONObject;
    function AddVariantPair(const Str: string; const Val: Variant): TJSONObject;
    function DeleteNode(const ANode: string): Boolean;
    {$IFDEF DELPHI_RIO_UP}
    function PrettyFormat(const ASpaces: Integer = 4): string;
    {$ELSE}
    function PrettyFormat: string;
    {$ENDIF}
    function Minify: string;
    function Nodes: TArray<string>;
    property Node[const AName: string]: TJSONValue read GetNode write SetNode;
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  System.NetEncoding,
  Soap.EncdDecd,
  Helpers.Integer,
  Helpers.Str,
  Helpers.Variant
  {$IFDEF DELPHI_SYDNEY_BELLOW},
  REST.Json{$ENDIF};

{ TJSONObjectHalper }

function TJSONObjectHelper.AddBinaryPair(const Str: string; const Val: TStream): TJSONObject;
begin
  Result := Self.AddPair(Str, string(EncodeBase64(Val, Val.Size)));
end;

function TJSONObjectHelper.AddBooleanPair(const Str: string; const Val: Boolean): TJSONObject;
begin
  Result := Self.AddPair(Str, TJSONBool.Create(Val));
end;

function TJSONObjectHelper.AddDatePair(const Str: string; const Val: TDate): TJSONObject;
begin
  Result := Self.AddPair(Str, FormatDateTime(FormatSettings.ShortDateFormat, Val));
end;

function TJSONObjectHelper.AddDateTimePair(const Str: string; const Val: TDateTime): TJSONObject;
begin
  Result := Self.AddPair(Str, FormatDateTime(FormatSettings.ShortDateFormat + ' HH' + FormatSettings.TimeSeparator + 'NN' + FormatSettings.TimeSeparator + 'SS', Val));
end;

function TJSONObjectHelper.AddFloatPair(const Str: string; const Val: Extended): TJSONObject;
begin
  Result := Self.AddPair(Str, TJSONNumber.Create(Val));
end;

function TJSONObjectHelper.AddIntegerPair(const Str: string; const Val: Integer): TJSONObject;
begin
  Result := Self.AddPair(Str, TJSONNumber.Create(Val));
end;

function TJSONObjectHelper.AddISODatePair(const Str: string; const Val: TDate): TJSONObject;
begin
  Result := Self.AddPair(Str, FormatDateTime('YYYY-MM-DD', Val));
end;

function TJSONObjectHelper.AddISODateTimePair(const Str: string; const Val: TDateTime): TJSONObject;
begin
  Result := Self.AddPair(Str, FormatDateTime('YYYY-MM-DD HH:NN:SS', Val));
end;

function TJSONObjectHelper.AddStringPair(const Str, Val: string): TJSONObject;
begin
  case Val.IsEmpty of
    True : Result := Self.AddPair(Str, nil);
    False: Result := Self.AddPair(Str, Val);
  end;
end;

function TJSONObjectHelper.AddTimePair(const Str: string; const Val: TTime): TJSONObject;
begin
  Result := Self.AddPair(Str, FormatDateTime('HH' + FormatSettings.TimeSeparator + 'NN' + FormatSettings.TimeSeparator + 'SS', Val));
end;

function TJSONObjectHelper.AddVariantPair(const Str: string; const Val: Variant): TJSONObject;
begin
  case Val.TypeOfVar of
    varByte,
    varWord,
    varUInt32,
    varInt64,
    varUInt64,
    varShortInt,
    varInteger,
    varSmallInt: Result := Self.AddIntegerPair(Str, Val.ToInteger);
    varSingle,
    varDouble,
    varCurrency: Result := Self.AddFloatPair(Str, Val.ToFloat);
    varDate    : Result := Self.AddDatePair(Str, Val.ToDateTime);
    varBoolean : Result := Self.AddBooleanPair(Str, Val.ToBoolean);
    varOleStr,
    varString,
    varUString : Result := Self.AddStringPair(Str, Val.ToString);
    varDispatch,
    varUnknown,
    varAny,
    varArray,
    varByRef,
    varError,
    varRecord  : Result := Self.AddPair(Str, nil);
  else
    Result := Self.AddPair(Str, nil);
  end;
end;

procedure TJSONObjectHelper.Clear;
begin
  if Assigned(Self) then
  begin
    Self.DisposeOf;
  end;
end;

procedure TJSONObjectHelper.ClearObject;
var
  i: Integer;
begin
  for i := 0 to Pred(Self.Count) do
  begin
    Self.Pairs[i].DisposeOf;
  end;
end;

function TJSONObjectHelper.DeleteNode(const ANode: string): Boolean;
begin
  Result := Self.HasProperty(ANode);

  if not Result then
  begin
    Exit;
  end;

  Self.Pairs[Self.IndexOf(ANode)].DisposeOf;
end;

function TJSONObjectHelper.GetNode(const AName: string): TJSONValue;
begin
  Result := nil;

  if not HasProperty(AName) then
  begin
    Exit;
  end;

  Result := GetValue(AName);
end;

function TJSONObjectHelper.HasProperty(const AProperty: string; const AIgnoreCase: Boolean): Boolean;
begin
  Result := AProperty.InArray(Self.Nodes, AIgnoreCase);
end;

function TJSONObjectHelper.IndexOf(const AProperty: string): Integer;
begin
  for Result := 0 to Count.Pred do
  begin
    if Pairs[Result].ToString.Contains(AProperty.Quoted('"')) then
    begin
      Exit;
    end;
  end;

  Result := -1;
end;

function TJSONObjectHelper.IsJSONArray(const AProperty: string): Boolean;
begin
  Result := HasProperty(AProperty) and (Self.GetValue(AProperty) is TJSONArray);
end;

function TJSONObjectHelper.IsJSONObject(const AProperty: string): Boolean;
begin
  Result := HasProperty(AProperty) and (Self.GetValue(AProperty) is TJSONObject);
end;

{$IFDEF DELPHI_SYDNEY_BELLOW}
function TJSONObjectHelper.JSONFormat(const AJSONObject: TJSONObject): string;
begin
  Result := TJson.Format(AJSONObject);
end;
{$ENDIF}

function TJSONObjectHelper.Minify: string;
begin
  Result := Self.ToJSON;
end;

function TJSONObjectHelper.Nodes: TArray<string>;
var
  jsonPair: TJSONPair;
  intPos  : Integer;
begin
  SetLength(Result, 0);

  for jsonPair in Self do
  begin
    intPos := Length(Result);
    SetLength(Result, intPos + 1);
    Result[intPos] := jsonPair.JsonString.ToString.Unquote;
  end;
end;

{$IFDEF DELPHI_RIO_UP}
function TJSONObjectHelper.PrettyFormat(const ASpaces: Integer): string;
begin
  Result := Self.Format(ASpaces);
end;
{$ELSE}
function TJSONObjectHelper.PrettyFormat: string;
begin
  Result := JSONFormat(Self);
end;
{$ENDIF}

procedure TJSONObjectHelper.SetNode(const AName: string; const Value: TJSONValue);
begin
  if HasProperty(AName) then
  begin
    Self.Pairs[Self.IndexOf(AName)].Destroy;
  end;

  AddPair(AName, Value);
end;

end.
