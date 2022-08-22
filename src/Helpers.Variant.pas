unit Helpers.Variant;

interface

uses
  System.Variants;

type
  TVariantHelper = record helper for Variant
    function IsFloat: Boolean;
    function IsNull: Boolean;
    function IsNumeric: Boolean;
    function IsOrdinal: Boolean;
    function IsString: Boolean;
    function IsBoolean: Boolean;
    function ToBoolean: Boolean;
    function ToCardinal: Cardinal;
    function ToCardinalDef(const ADefValue: Cardinal): Cardinal;
    function ToCurrency: Currency;
    function ToDateTime: TDateTime;
    function ToDateTimeDef(const ADefValue: TDateTime): TDateTime;
    function ToDouble: Double;
    function ToDoubleDef(const ADefValue: Double): Double;
    function ToExtended: Extended;
    function ToExtendedDef(const ADefValue: Extended): Extended;
    function ToFloat: Real;
    function ToFloatDef(const ADefValue: Real): Real;
    function ToGUID: TGUID;
    function ToInteger: Integer;
    function ToIntegerDef(const ADefValue: Integer): Integer;
    function ToDBString: string;
    function ToQuotedString: string;
    function ToSingle: Single;
    function ToSingleDef(const ADefValue: Single): Single;
    function ToAnsiString: AnsiString;
    function ToString: string;
    function ToWideString: WideString;
    function TypeOfVar: TVarType;
    function Size: Integer;
  end;

implementation

uses
  System.SysUtils,
  Helpers.Str;

{ TVariantHelper }

function TVariantHelper.ToAnsiString: AnsiString;
begin
  Result := VarToStr(Self).ToAnsi;
end;

function TVariantHelper.ToBoolean: Boolean;
begin
  Result := Self.IsBoolean and Boolean(Self);
end;

function TVariantHelper.ToCardinal: Cardinal;
begin
  Result := 0;

  if IsNumeric then
  begin
    Result := Cardinal(Self);
  end;
end;

function TVariantHelper.ToCardinalDef(const ADefValue: Cardinal): Cardinal;
begin
  Result := ADefValue;

  if IsNumeric then
  begin
    Result := Cardinal(Self);
  end;
end;

function TVariantHelper.ToCurrency: Currency;
begin
    Result := 0;

  if IsFloat then
  begin
    Result := Currency(Self);
  end;
end;

function TVariantHelper.ToDateTime: TDateTime;
begin
  Result := 0;

  if IsNumeric then
  begin
    Result := VarToDateTime(Self);
  end;
end;

function TVariantHelper.ToDateTimeDef(const ADefValue: TDateTime): TDateTime;
begin
  Result := ADefValue;

  if IsNumeric then
  begin
    Result := VarToDateTime(Self);
  end;
end;

function TVariantHelper.ToDBString: string;
var
  fmtSettings: TFormatSettings;
begin
  Result := EmptyStr;
  fmtSettings := FormatSettings;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.DateSeparator    := '-';
  FormatSettings.ShortDateFormat  := 'yyyy-mm-dd';

  try
    case TypeOfVar of
      varEmpty,
      varNull    : Result := 'NULL';
      varByte,
      varSmallint,
      varShortInt,
      varInteger,
      varWord,
      varLongWord,
      varInt64,
      varUInt64  : Result := Self.ToInteger.ToString;
      varSingle,
      varDouble,
      varCurrency: Result := FormatFloat('#.#', ToFloat);
      varDate    : Result := QuotedStr(DateTimeToStr(ToDateTime, fmtSettings));
      varBoolean : Result := ToString;
      varStrArg,
      varOleStr,
      varUStrArg,
      varString,
      varUString : Result := ToQuotedString;
    end;
  finally
    FormatSettings := fmtSettings;
  end;
end;

function TVariantHelper.ToDouble: Double;
begin
  Result := 0;

  if IsFloat then
  begin
    Result := Double(Self);
  end;
end;

function TVariantHelper.ToDoubleDef(const ADefValue: Double): Double;
begin
  Result := ADefValue;

  if IsFloat then
  begin
    Result := Double(Self);
  end;
end;

function TVariantHelper.ToExtended: Extended;
begin
  Result := 0;

  if IsFloat then
  begin
    Result := Extended(Self);
  end;
end;

function TVariantHelper.ToExtendedDef(const ADefValue: Extended): Extended;
begin
  Result := ADefValue;

  if IsFloat then
  begin
    Result := Extended(Self);
  end;
end;

function TVariantHelper.ToFloat: Real;
begin
  Result := 0;

  if IsFloat then
  begin
    Result := Real(Self);
  end;
end;

function TVariantHelper.ToFloatDef(const ADefValue: Real): Real;
begin
  Result := ADefValue;

  if IsFloat then
  begin
    Result := Real(Self);
  end;
end;

function TVariantHelper.ToGUID: TGUID;
begin
  Result := StringToGUID(Self.ToString);
end;

function TVariantHelper.ToInteger: Integer;
begin
  Result := 0;

  if IsNumeric then
  begin
    Result := Integer(Self);
  end;
end;

function TVariantHelper.ToIntegerDef(const ADefValue: Integer): Integer;
begin
  Result := ADefValue;

  if IsNumeric then
  begin
    Result := Integer(Self);
  end;
end;

function TVariantHelper.ToQuotedString: string;
begin
  Result := QuotedStr(VarToStr(Self));
end;

function TVariantHelper.ToSingle: Single;
begin
  Result := 0;

  if IsFloat then
  begin
    Result := Single(Self);
  end;
end;

function TVariantHelper.ToSingleDef(const ADefValue: Single): Single;
begin
  Result := ADefValue;

  if IsFloat then
  begin
    Result := Single(Self);
  end;
end;

function TVariantHelper.ToString: string;
begin
  Result := VarToStr(Self);
end;

function TVariantHelper.ToWideString: WideString;
begin
  Result := VarToWideStr(Self);
end;

function TVariantHelper.TypeOfVar: TVarType;
begin
  Result := VarType(Self);
end;

function TVariantHelper.IsBoolean: Boolean;
var
  strValue: string;
begin
  strValue := Self.ToString.ToLower;
  Result   := strValue.InArray(['true', 'false']);
end;

function TVariantHelper.IsFloat: Boolean;
begin
  Result := VarIsFloat(Self);
end;

function TVariantHelper.IsNull: Boolean;
begin
  Result := VarIsNull(Self);
end;

function TVariantHelper.IsNumeric: Boolean;
begin
  Result := VarIsNumeric(Self);
end;

function TVariantHelper.IsOrdinal: Boolean;
begin
  Result := VarIsOrdinal(Self);
end;

function TVariantHelper.IsString: Boolean;
begin
  Result := VarIsStr(Self);
end;

function TVariantHelper.Size: Integer;
begin
  Result := Length(Self.ToString);
end;

end.

