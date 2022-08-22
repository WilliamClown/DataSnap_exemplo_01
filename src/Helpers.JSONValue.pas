unit Helpers.JSONValue;

interface

uses
  System.JSON;

type
  TJSONValueHelper = class helper for TJSONValue
    procedure Clear;
    function IsJSONObject: Boolean;
    function IsJSONArray: Boolean;
    function IsChar: Boolean;
    function IsString: Boolean;
    function Length: Integer;
    function IsInteger: Boolean;
    function InRange(const AMin, AMax: Integer): Boolean;
    function IsFloat: Boolean;
    function InRangeF(const AMin, AMax: Double): Boolean;
    function &In(const AValues: TArray<string>): Boolean;
    function IsBoolean: Boolean;
    function AsJSONArray: TJSONArray;
    function AsJSONObject: TJSONObject;
    function AsInteger: Integer;
    function AsFloat: Double;
    function AsString: String;
    function AsBoolean: Boolean;
    function AsDateTime: TDateTime;
    function AsUnsignedInt: UInt64;
    function AsVariant: Variant;
  end;

implementation

uses
{$IFDEF IOS}
  Macapi.CoreFoundation,
{$ENDIF}
  System.SysUtils,
  System.DateUtils,
  Helpers.Str;

{ TJSONValueHelper }

function TJSONValueHelper.&In(const AValues: TArray<string>): Boolean;
begin
  Result := Self.AsString.InArray(AValues);
end;

function TJSONValueHelper.AsBoolean: Boolean;
begin
  case Self is TJSONNull of
    True : Result := false;
    False:
    begin
      try
        Result := Self.GetValue<Boolean>;
      except
        Result := False;
      end;
    end;
  end;
end;

function TJSONValueHelper.AsDateTime: TDateTime;
begin
  try
    Result := ISO8601ToDate(Self.AsString.Trim);
  except
    Result := 0;
  end;
end;

function TJSONValueHelper.AsFloat: Double;
begin
  case Self is TJSONNull of
    True : Result := 0;
    False:
    begin
      try
        Result := Self.GetValue<Double>;
      except
        Result := 0;
      end;
    end;
  end;
end;

function TJSONValueHelper.AsInteger: Integer;
begin
  case Self is TJSONNull of
    True : Result := 0;
    False:
    begin
      try
        Result := Self.GetValue<Integer>;
      except
        Result := 0;
      end;
    end;
  end;
end;

function TJSONValueHelper.AsJSONArray: TJSONArray;
begin
  try
    Result := Self as TJSONArray;
  except
    Result := nil;
  end;
end;

function TJSONValueHelper.AsJSONObject: TJSONObject;
begin
  try
    Result := Self as TJSONObject;
  except
    Result := nil;
  end;
end;

function TJSONValueHelper.AsString: String;
begin
  try
    case Self.ToString.Trim.Unquote = 'null' of
      True : Result := EmptyStr;
      False: Result := Self.ToString.Trim.Unquote;
    end;
  except
    Result := EmptyStr;
  end;
end;

function TJSONValueHelper.AsUnsignedInt: UInt64;
begin
  case Self is TJSONNull of
    True : Result := 0;
    False:
    begin
      try
        Result := Self.GetValue<UInt64>;
      except
        Result := 0;
      end;
    end;
  end;
end;

function TJSONValueHelper.AsVariant: Variant;
begin
  case Self is TJSONNull of
    True : Result := varNull;
    False: Result := Self.GetValue<Variant>;
  end;
end;

procedure TJSONValueHelper.Clear;
begin
  if Assigned(Self) then
  begin
    {$IFNDEF VCL}
    Self.DisposeOf;
    {$ELSE}
    FreeAndNil(Self);
    {$ENDIF}
  end;
end;

function TJSONValueHelper.InRange(const AMin, AMax: Integer): Boolean;
begin
  Result := IsInteger and
            (Self.AsInteger >= AMin) and
            (Self.AsInteger <= AMax);
end;

function TJSONValueHelper.InRangeF(const AMin, AMax: Double): Boolean;
begin
  Result := IsFloat and
            (Self.AsFloat >= AMin) and
            (Self.AsFloat <= AMax);
end;

function TJSONValueHelper.IsBoolean: Boolean;
var
  strValue: string;
begin
  strValue := Self.AsString.ToLower;
  Result   := (strValue = 'true') or (strValue = 'false');
end;

function TJSONValueHelper.IsChar: Boolean;
begin
  Result := Self.AsString.Length = 1;
end;

function TJSONValueHelper.IsFloat: Boolean;
var
  strValue: string;
begin
  strValue := Self.AsString;
  Result   := strValue.Contains('.') and (strValue.Length - strValue.NumbersOnly.Length = 1);
end;

function TJSONValueHelper.IsInteger: Boolean;
begin
  Result := Self.AsString.IsNumbersOnly;
end;

function TJSONValueHelper.IsJSONArray: Boolean;
begin
  try
    Result := Self is TJSONArray;
  except
    Result := False;
  end;
end;

function TJSONValueHelper.IsJSONObject: Boolean;
begin
  try
    Result := Self is TJSONObject;
  except
    Result := False;
  end;
end;

function TJSONValueHelper.IsString: Boolean;
begin
  Result := Self.AsString.LettersOnly.Length > 0;
end;

function TJSONValueHelper.Length: Integer;
begin
  Result := Self.AsString.Length;
end;

end.
