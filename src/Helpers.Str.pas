unit Helpers.Str;

interface

uses
  System.SysUtils,
  System.JSON;

type
  TStringSpacer = (ssLeft, ssRight, ssBoth);

  TStringHelper = record helper for string
  strict private
    function  GetChar(AIndex: Integer): Char;
    procedure SetChar(AIndex: Integer; const Value: Char);
  public
    procedure Clear;
    procedure CreateGUID;
    function Concat(const AElements: TArray<string>): string;
    function Replace(const APatern, ANewValue: string; AFlags: TReplaceFlags): string;
    function RemoveChar(const AChar: Char): string;
    function RemoveChars(const AChars: array of Char): string;
    function CountOccurrences(const AChar: Char): Integer;
    function IncludeTrailingPathDelimiter: string;
    function IsEmpty: Boolean;
    function NotEmpty(const ATrimmed: Boolean = True): Boolean;
    function IsFloat: Boolean;
    function IsNumbersOnly: Boolean;
    function IsLettersOnly: Boolean;
    function IsMD5Hash: Boolean;
    function IsGUID: Boolean;
    function IsBoolean: Boolean;
    function IsJSONObject: Boolean;
    function IsJSONArray: Boolean;
    function InArray(const AArray: TArray<string>; const AIgnoreCase: Boolean = True): Boolean;
    function Equals(const AStr: string): Boolean;
    function Compare(const AStr: string): Integer;
    function NumbersOnly: string;
    function LettersOnly: string;
    function Contains(const AStr: string): Boolean; overload;
    function Contains(const AStrs: array of string; const AAny: Boolean = True): Boolean; overload;
    function Quoted(const AQuoteChar: Char = #39): string;
    function DoubleQuote: string;
    function Unquote: string;
    function Format(const ATerms: array of const): string;
    function ToLower: string;
    function ToUpper: string;
    function ToUTF8: string;
    function ToAnsi: AnsiString;
    function Trim: string;
    function TrimLeft: string;
    function TrimRight: string;
    function FirstUpper: string;
    function LPAD(const ALength: Integer; const AChar: Char): string;
    function RPAD(const ALength: Integer; const AChar: Char): string;
    function LeftSpaces(const ANumSpaces: Integer): string;
    function RightSpaces(const ANumSpaces: Integer): string;
    function ToBoolean: Boolean;
    function ToInteger(const ADefValue: Integer = 0; const IsHex: Boolean = False): Integer;
    function ToFloat(const ADefValue: Extended = 0): Extended;
    function Copy(const AStart, ALength: Integer): string;
    function Delete(const AStart, ALength: Integer): string;
    function Length: Integer;
    function LengthBetween(const ALowerLimit, AHigherLimit: Integer): Boolean;
    function EscapeQuotes(const AQuote: Char = '"'): string;
    function ToJSON: TJSONObject;
    function ToJSONArray: TJSONArray;
    function Split(const ASeparator: Char): TArray<string>; overload;
    function Split(const ASeparator: string): TArray<string>; overload;
    function Pos(const ASubStr: string): Integer;
    function PosEx(const ASubStr: string; const AOffset: Integer): Integer;
    function Unaccent: string;
    function ToBase64(const AWithCRLF: Boolean = True): string;
    function DecodeBase64: string;
    function RemoveEscapes: string;
    function Spaced(const ASpacer: TStringSpacer = ssBoth): string;
    function AsVariant: Variant;
    property Char[AIndex: Integer]: Char read GetChar write SetChar;
  end;

  TStringArrayHelper = record helper for TArray<string>
  public
    function  Contains(const AStr: string): Boolean;
    function  Count: Integer;
    procedure SetLength(const ANewLength: Integer);
  end;

implementation

uses
  System.StrUtils,
  System.Character,
  System.NetEncoding,
  System.Classes,
  System.RegularExpressions,
  Helpers.Integer;

{ TStringHelper }

function TStringHelper.Contains(const AStr: string): Boolean;
begin
  Result := System.Pos(AStr, Self) > 0;
end;

function TStringHelper.AsVariant: Variant;
begin
  if Self.IsFloat then
  begin
    Result := Self.ToFloat;
  end
  else
  if Self.IsNumbersOnly then
  begin
    Result := Self.ToInteger;
  end
  else
  if Self.IsBoolean then
  begin
    Result := Variant(Self.ToBoolean);
  end
  else
  begin
    Result := Self;
  end;
end;

procedure TStringHelper.Clear;
begin
  Self := EmptyStr;
end;

function TStringHelper.Compare(const AStr: string): Integer;
begin
  Result := CompareStr(Self, AStr);
end;

function TStringHelper.Concat(const AElements: TArray<string>): string;
var
  i: Integer;
begin
  Result := Self;

  for i := 0 to Pred(System.Length(AElements)) do
  begin
    Result := Result + AElements[i];
  end;
end;

function TStringHelper.Contains(const AStrs: array of string; const AAny: Boolean): Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to System.Length(AStrs) do
  begin
    if Self.Contains(AStrs[i]) then
    begin
      Continue;
    end;

    Result := Contains(AStrs[i]);

    case AAny of
      True :
      begin
        if Result then
        begin
          Exit;
        end;
      end;
      False:
      begin
        if not Result then
        begin
          Exit;
        end;
      end;
    end;
  end;
end;

function TStringHelper.Copy(const AStart, ALength: Integer): string;
begin
  Result := System.Copy(Self, AStart, ALength);
end;

function TStringHelper.CountOccurrences(const AChar: Char): Integer;
var
  i: Integer;
begin
  Result := 0;

  {$IFDEF ANDROID}
  for i := 0 to Pred(Length) do
  {$ELSE}
  for i := 1 to Length do
  {$ENDIF}
  begin
    if Self[i] = AChar then
    begin
      Inc(Result);
    end;
  end;
end;

procedure TStringHelper.CreateGUID;
var
  guidGUID: TGUID;
begin
  System.SysUtils.CreateGUID(guidGUID);
  Self := guidGUID.ToString.ToLower.Replace('{', EmptyStr, [rfReplaceAll]).Replace('}', EmptyStr, [rfReplaceAll]);
end;

function TStringHelper.DecodeBase64: string;
var
  stmInput : TStringStream;
  stmOutput: TStringStream;
begin
  Result := EmptyStr;

  if Self.IsEmpty then
  begin
    Exit;
  end;

  stmOutput := TStringStream.Create;
  stmInput  := TStringStream.Create(Self);
  stmOutput.SetSize(stmInput.Size);
  TNetEncoding.Base64.Decode(stmInput, stmOutput);
  Result := stmOutput.DataString;
  stmInput.DisposeOf;
  stmOutput.DisposeOf;
end;

function TStringHelper.Delete(const AStart, ALength: Integer): string;
begin
  System.Delete(Self, AStart, ALength);
end;

function TStringHelper.DoubleQuote: string;
begin
  Result := Self.Replace(#39, #39#39, [rfReplaceAll]);
end;

function TStringHelper.Equals(const AStr: string): Boolean;
begin
  Result := Self = AStr;
end;

function TStringHelper.EscapeQuotes(const AQuote: Char): string;
begin
  Result := StringReplace(Self, AQuote, '\' + AQuote, [rfReplaceAll]);
end;

function TStringHelper.FirstUpper: string;
var
  strFirst: string;
begin
  Result    := Self.ToLower;
  strFirst  := Result[1];
  Result[1] := System.SysUtils.UpperCase(strFirst)[1];
end;

function TStringHelper.Format(const ATerms: array of const): string;
begin
  Result := System.SysUtils.Format(Self, ATerms);
end;

function TStringHelper.GetChar(AIndex: Integer): Char;
begin
  Result := Self[AIndex];
end;

function TStringHelper.InArray(const AArray: TArray<string>; const AIgnoreCase: Boolean): Boolean;
var
  strElement: string;
  strSelf   : string;
begin
  Result := False;

  for strElement in AArray do
  begin
    case AIgnoreCase of
      True :
      begin
        strSelf := Self;
        Result  := Self.ToLower.Equals(strElement.ToLower);
      end;
      False: Result := Self.Equals(strElement);
    end;

    if Result then
    begin
      Break;
    end;
  end;
end;

function TStringHelper.IncludeTrailingPathDelimiter: string;
begin
  Result := System.SysUtils.IncludeTrailingPathDelimiter(Self);
end;

function TStringHelper.IsBoolean: Boolean;
begin
  Result := Self.ToLower.Equals('true') or Self.ToLower.Equals('false');
end;

function TStringHelper.IsEmpty: Boolean;
begin
  Result := Self = EmptyStr;
end;

function TStringHelper.IsFloat: Boolean;
var
  chrDecimalSeparator: System.Char;
begin
  chrDecimalSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  Result := (Self.CountOccurrences(FormatSettings.DecimalSeparator) = 1) and
            Self.Replace(FormatSettings.DecimalSeparator, EmptyStr, [rfReplaceAll]).IsNumbersOnly;
  FormatSettings.DecimalSeparator := chrDecimalSeparator;
end;

function TStringHelper.IsGUID: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}');
end;

function TStringHelper.IsJSONArray: Boolean;
begin
  Result := True;

  try
    with TJSONObject.ParseJSONValue(Self) as TJSONArray do
    begin
      Free;
    end;
  except
    Result := False;
  end;
end;

function TStringHelper.IsJSONObject: Boolean;
begin
  Result := True;

  try
    with TJSONObject.ParseJSONValue(Self) as TJSONObject do
    begin
      Free;
    end;
  except
    Result := False;
  end;
end;

function TStringHelper.IsLettersOnly: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '[a-zA-Z]+');
end;

function TStringHelper.IsMD5Hash: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '[a-f0-9]{32}');
end;

function TStringHelper.IsNumbersOnly: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '[0-9]+');
end;

function TStringHelper.LeftSpaces(const ANumSpaces: Integer): string;
var
  i: Integer;
begin
  Result := Self;
  i := 0;

  if ANumSpaces < 1 then
  begin
    Exit;
  end;

  repeat
    Result := ' ' + Result;
    i.Inc;
  until i > ANumSpaces;
end;

function TStringHelper.Length: Integer;
begin
  Result := System.Length(Self);
end;

function TStringHelper.LengthBetween(const ALowerLimit, AHigherLimit: Integer): Boolean;
begin
  Result := (Self.Length >= ALowerLimit) and (Self.Length <= AHigherLimit);
end;

function TStringHelper.LettersOnly: string;
var
  i: Integer;
begin
  Result := EmptyStr;

  {$IFDEF ANDROID}
  for i := 0 to Pred(Length) do
  {$ELSE}
  for i := 1 to Length do
  {$ENDIF}
  begin
    if Self[i].IsLetter then
    begin
      Result := Result + Self[i];
    end;
  end;
end;

function TStringHelper.LPAD(const ALength: Integer; const AChar: Char): string;
begin
  Result := Self;

  while Result.Length.MinorThan(ALength) do
  begin
    Result := AChar + Result;
  end;
end;

function TStringHelper.NotEmpty(const ATrimmed: Boolean): Boolean;
begin
  case ATrimmed of
    True : Result := not Self.Trim.IsEmpty;
    False: Result := not Self.IsEmpty;
  end;
end;

function TStringHelper.NumbersOnly: string;
var
  i: Integer;
begin
  Result := EmptyStr;

  {$IFDEF ANDROID}
  for i := 0 to Pred(Length) do
  {$ELSE}
  for i := 1 to Length do
  {$ENDIF}
  begin
    if Self[i].IsNumber then
    begin
      Result := Result + Self[i];
    end;
  end;
end;

function TStringHelper.Pos(const ASubStr: string): Integer;
begin
  Result := System.Pos(ASubStr, Self);
end;

function TStringHelper.PosEx(const ASubStr: string; const AOffset: Integer): Integer;
begin
  Result := System.StrUtils.PosEx(ASubStr, Self, AOffset);
end;

function TStringHelper.Quoted(const AQuoteChar: Char): string;
begin
  Result := AQuoteChar + Self + AQuoteChar;
end;

function TStringHelper.RemoveChar(const AChar: Char): string;
begin
  Result := Self.Replace(AChar, EmptyStr, [rfReplaceAll]);
end;

function TStringHelper.RemoveChars(const AChars: array of Char): string;
var
  i: Integer;
begin
  Result := Self;

  for i := 0 to System.Length(AChars).Pred do
  begin
    Result := Result.RemoveChar(AChars[i]);
  end;
end;

function TStringHelper.RemoveEscapes: string;
begin
  Result := Self.Replace('\/', '/', [rfReplaceAll]).Replace('\"', '"', [rfReplaceAll]).Replace('\r', #13, [rfReplaceAll]).Replace('\n', #10, [rfReplaceAll]);
end;

function TStringHelper.Replace(const APatern, ANewValue: string; AFlags: TReplaceFlags): string;
begin
  Result := StringReplace(Self, APatern, ANewValue, AFlags);
end;

function TStringHelper.RightSpaces(const ANumSpaces: Integer): string;
var
  i: Integer;
begin
  Result := Self;
  i := 0;

  if ANumSpaces < 1 then
  begin
    Exit;
  end;

  repeat
    Result := Result + ' ';
    i.Inc;
  until i > ANumSpaces;
end;

function TStringHelper.RPAD(const ALength: Integer; const AChar: Char): string;
begin
  Result := Self;

  while Result.Length.MinorThan(ALength) do
  begin
    Result := Result + AChar;
  end;
end;

procedure TStringHelper.SetChar(AIndex: Integer; const Value: Char);
begin
  Self[AIndex] := Value;
end;

function TStringHelper.Spaced(const ASpacer: TStringSpacer): string;
begin
  case ASpacer of
    ssLeft : Result := ' ' + Self;
    ssRight: Result := Self + ' ';
    ssBoth : Result := ' ' + Self + ' ';
  end;
end;

function TStringHelper.Split(const ASeparator: string): TArray<string>;
var
  strTemp : string;
  intPos  : Integer;
  intIndex: Integer;
begin
  SetLength(Result, 0);
  strTemp := Self;

  if ASeparator.IsEmpty then
  begin
    Exit;
  end;

  intPos   := System.Pos(ASeparator, strTemp);
  intIndex := 0;

  while intPos > 0 do
  begin
    SetLength(Result, intIndex.Succ);
    Result[intIndex] := strTemp.Copy(1, intPos.Pred).Trim;
    System.Delete(strTemp, 1, intPos + ASeparator.Length.Pred);
    intPos := System.Pos(ASeparator, strTemp);
    intIndex.Inc;
  end;

  SetLength(Result, intIndex.Succ);
  Result[intIndex] := strTemp;
end;

function TStringHelper.Split(const ASeparator: Char): TArray<string>;
var
  strSep: string;
begin
  strSep := ' ';
{$IFDEF ANDROID}
  strSep[0] := ASeparator;
{$ELSE}
  strSep[1] := ASeparator;
{$ENDIF}
  Result := Split(strSep);
end;

function TStringHelper.ToAnsi: AnsiString;
begin
  Result := RawByteString(Self);
end;

function TStringHelper.ToBase64(const AWithCRLF: Boolean): string;
var
  stmInput : TStringStream;
  stmResult: TStringStream;
begin
  Result := EmptyStr;

  if Self.IsEmpty then
  begin
    Exit;
  end;

  stmInput  := TStringStream.Create(Self);
  stmResult := TStringStream.Create;
  stmResult.SetSize(stmInput.Size);
  TNetEncoding.Base64.Encode(stmInput, stmResult);
  Result := stmResult.DataString;

  if not AWithCRLF then
  begin
    Result.Replace(sLineBreak, EmptyStr, [rfReplaceAll]);
  end;

  stmInput.DisposeOf;
  stmResult.DisposeOf;
end;

function TStringHelper.ToBoolean: Boolean;
begin
  Result := Self.IsBoolean and Self.ToLower.Equals('true');
end;

function TStringHelper.ToFloat(const ADefValue: Extended): Extended;
var
  chrDecimalSeparator: System.Char;
begin
  chrDecimalSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  Result := StrToFloatDef(Self, 0);
  FormatSettings.DecimalSeparator := chrDecimalSeparator;
end;

function TStringHelper.ToInteger(const ADefValue: Integer; const IsHex: Boolean): Integer;
begin
{$IF CompilerVersion = 31.0}
  Result := ADefValue;
{$ENDIF}
  case IsHex of
    True : Result := StrToIntDef('$' + Self, ADefValue);
    False: Result := StrToIntDef(Self, ADefValue);
  end;
end;

function TStringHelper.ToJSON: TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(Self) as TJSONObject;
end;

function TStringHelper.ToJSONArray: TJSONArray;
begin
  Result := TJSONObject.ParseJSONValue(Self) as TJSONArray;
end;

function TStringHelper.ToLower: string;
begin
  Result := LowerCase(Self);
end;

function TStringHelper.ToUpper: string;
begin
  Result := UpperCase(Self);
end;

function TStringHelper.ToUTF8: string;
begin
  Result := string(UTF8Encode(Self));
end;

function TStringHelper.Trim: string;
begin
  Result := System.SysUtils.Trim(Self);
end;

function TStringHelper.TrimLeft: string;
begin
  Result := System.SysUtils.TrimLeft(Self);
end;

function TStringHelper.TrimRight: string;
begin
  Result := System.SysUtils.TrimRight(Self);
end;

function TStringHelper.Unaccent: string;
const
  STR_ACCENTS    = 'ÁÀÂÃÄÉÈÊÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇÑÝáàâãäéèêêëíìîïóòôõöúùûüçñý';
  STR_NO_ACCENTS = 'AAAAAEEEEEIIIIOOOOOUUUUCNYaaaaaeeeeeiiiiooooouuuucny';
{$IFDEF ANDROID}
  INT_START = 0;
  INT_END   = 1;
{$ELSE}
  INT_START = 1;
  INT_END   = 0;
{$ENDIF}

var
  i     : Integer;
  intPos: Integer;
begin
  Result := Self;

  for i := INT_START to Result.Length - INT_END do
  begin
    intPos := System.Pos(Result[i], STR_ACCENTS);

    if intPos > 0 then
    begin
      Result[i] := STR_NO_ACCENTS[intPos - INT_END];
    end;
  end;
end;

function TStringHelper.Unquote: string;
var
  intIndex: Integer;
begin
  Result := Self;
  {$IFDEF ANDROID}
  intIndex := 0;
  {$ELSE}
  intIndex := 1;
  {$ENDIF}

  case Result[intIndex].IsInArray(['"', #39]) of
    False: Exit;
    True : Result.Delete(1, 1);
  end;

  if Result[Result.Length{$IFDEF ANDROID}.Pred{$ENDIF}].IsInArray(['"', #39]) then
  begin
    Result.Delete(Result.Length, 1);
  end;
end;

{ TStringArrayHelper }

function TStringArrayHelper.Contains(const AStr: string): Boolean;
var
  strElement: string;
begin
  Result := False;

  for strElement in Self do
  begin
    Result := strElement.Equals(AStr);

    if Result then
    begin
      Break;
    end;
  end;
end;

function TStringArrayHelper.Count: Integer;
begin
  Result := Length(Self);
end;

procedure TStringArrayHelper.SetLength(const ANewLength: Integer);
begin
  System.SetLength(Self, ANewLength);
end;

end.
