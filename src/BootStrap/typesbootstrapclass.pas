unit TypesBootStrapClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Contnrs, InstanceOfClass;

type
  // TMethod is a string hash table pairing name and signature

  TBootstrap = class
  private
    FFunctions: TFPStringHashTable;
    FNowType: string;
  public
    property PNowType: string read FNowType write FNowType;
    property PFunctions: TFPStringHashTable read FFunctions write FFunctions;
    constructor Create;
    procedure RegisterFunction(AName: string; ASignature:string);
    function FunctionExists(AName: string): boolean;
    function Execute(AName: string; var AArgList: TInstanceList; AObj: TInstanceOf = nil): TInstanceOf;
  end;

var

  RegisteredMethods: TBootStrap;
  TypeName: string;

implementation
uses
  StringInstanceClass, CoreFunctionsClass, Tokens;

constructor TBootStrap.Create;
begin
  FFunctions := TFPStringHashTable.Create();
end;


function TBootStrap.FunctionExists(AName: string): boolean;
var
  Ret: boolean = False;
  Found:string;
begin
  Result := FFunctions[AName] <> '';
end;

procedure TBootStrap.RegisterFunction(AName: string; ASignature:string);
begin
  if FNowType <> '' then
    FFunctions.Add(FNowType+ATTR_ACCESSOR+AName, ASignature)
  else
    FFunctions.Add(AName, ASignature);
end;


function TBootStrap.Execute(AName: string; var AArgList: TInstanceList; AObj: TInstanceOf = nil): TInstanceOf;
// is core
var
  ACore: TCoreFunction;
  Ret: TInstanceOf;
  FuncType: string;
begin
  ACore := TCoreFunction.Create;
  Ret := ACore.Execute(AName, AArgList, AObj);
  ACore.Free;
  Result := Ret;
end;

begin
  RegisteredMethods := TBootStrap.Create;
  {$INCLUDE 'corefunctions.pp' }
  {$INCLUDE 'stringmethods.pp' }
  {$INCLUDE 'listmethods.pp' }

end.