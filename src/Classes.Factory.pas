unit Classes.Factory;

interface

uses
  System.Generics.Collections,
  Classes.Generic;

type
  TFactory = class
  strict private
    FDictionaryDB: TObjectDictionary<string, TDBObjectClass>;
  public
    constructor Create;
    destructor Destroy; override;
    class function Instance: TFactory;
    procedure RegisterClass(const AKey: string; const AClass: TDBObjectClass); overload;
    function GetOperacaoDB(const AKey: string): TDBObject;
    property OperacoesDB: TObjectDictionary<string, TDBObjectClass> read FDictionaryDB;
  end;

implementation

uses
  System.SysUtils;

var
  FFactory: TFactory;

{ TFactory }

constructor TFactory.Create;
begin
  FDictionaryDB := TObjectDictionary<string, TDBObjectClass>.Create;
end;

destructor TFactory.Destroy;
begin
  FreeAndNil(FDictionaryDB);
end;

function TFactory.GetOperacaoDB(const AKey: string): TDBObject;
var
  obj: TDBObjectClass;
begin
  Result := nil;

  if not (FDictionaryDB.TryGetValue(AKey, obj) and Assigned(obj)) then
    Exit;

  Result := obj.Create;
end;

class function TFactory.Instance: TFactory;
begin
  if not Assigned(FFactory) then
    FFactory := TFactory.Create;

  Result := FFactory;
end;

procedure TFactory.RegisterClass(const AKey: string; const AClass: TDBObjectClass);
begin
  if FDictionaryDB.ContainsKey(AKey) then
    Exit;

  FDictionaryDB.Add(AKey, AClass);
end;

initialization
  FFactory := nil;

finalization
  FreeAndNil(FFactory);

end.
