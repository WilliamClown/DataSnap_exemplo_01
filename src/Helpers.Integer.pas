unit Helpers.Integer;

interface

type
  TIntegerArrayHelper = record helper for TArray<Integer>
  public
    function Count: Integer;
    procedure SetLength(const ANewLength: Integer);
  end;

  TIntegerHelper = record helper for Integer
    function ArrayPos(const AArray: TArray<Integer>): Integer;
    function InArrayPos(const AArray: TArray<Integer>): Boolean;
    procedure Add(const AValue: Integer);
    procedure Subtract(const AValue: Integer);
    function Equals(const AVal: Integer): Boolean;
    function Differs(const AVal: Integer): Boolean;
    function Pred: Integer;
    function Succ: Integer;
    function BiggerThan(const AInt: Integer): Boolean;
    function MinorThan(const AInt: Integer): Boolean;
    procedure Inc(const AStep: Integer = 1);
    procedure Dec(const AStep: Integer = 1);
    function ToString: string;
    function ToHex: string; overload;
    function ToHex(const ADigits: Integer): string; overload;
  end;

implementation

uses
  System.SysUtils;

{ TIntegerHelper }

procedure TIntegerHelper.Add(const AValue: Integer);
begin
  Self := Self + AValue;
end;

function TIntegerHelper.ArrayPos(const AArray: TArray<Integer>): Integer;
begin
  for Result := 0 to AArray.Count.Pred do
  begin
    if Self.Equals(AArray[Result]) then
    begin
      Exit;
    end;
  end;

  Result := -1;
end;

function TIntegerHelper.BiggerThan(const AInt: Integer): Boolean;
begin
  Result := Self > AInt;
end;

procedure TIntegerHelper.Dec(const AStep: Integer);
begin
  System.Dec(Self, AStep);
end;

function TIntegerHelper.Differs(const AVal: Integer): Boolean;
begin
  Result := Self <> AVal;
end;

function TIntegerHelper.Equals(const AVal: Integer): Boolean;
begin
  Result := Self = AVal;
end;

function TIntegerHelper.InArrayPos(const AArray: TArray<Integer>): Boolean;
begin
  Result := Self.ArrayPos(AArray).BiggerThan(-1);
end;

procedure TIntegerHelper.Inc(const AStep: Integer);
begin
  System.Inc(Self, AStep);
end;

function TIntegerHelper.MinorThan(const AInt: Integer): Boolean;
begin
  Result := Self < AInt;
end;

function TIntegerHelper.Pred: Integer;
begin
  Result := System.Pred(Self);
end;

procedure TIntegerHelper.Subtract(const AValue: Integer);
begin
  Self := Self - AValue;
end;

function TIntegerHelper.Succ: Integer;
begin
  Result := System.Succ(Self);
end;

function TIntegerHelper.ToHex(const ADigits: Integer): string;
begin
  Result := IntToHex(Self, ADigits);
end;

function TIntegerHelper.ToHex: string;
begin
  Result := IntToHex(Self);
end;

function TIntegerHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

{ TIntegerArrayHelper }

function TIntegerArrayHelper.Count: Integer;
begin
  Result := Length(Self);
end;

procedure TIntegerArrayHelper.SetLength(const ANewLength: Integer);
begin
  System.SetLength(Self, ANewLength);
end;

end.
