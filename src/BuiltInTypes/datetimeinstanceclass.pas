unit DateTimeInstanceClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, InstanceOfClass;


type TDateTimeInstance = class (TInstanceOf)
  private
    FValue: TDateTime;
  public
    property PValue: TDateTime read FValue write FValue;
    constructor Create(ADateTIme: TDateTime);
    function AsString: string; override;
    function GetPartOfDate(APart: string): TInstanceOf;
    class function CreateNowDateTime: TDateTimeInstance;
end;

implementation
uses DateUtils;

constructor TDateTimeInstance.Create(ADateTime: TDateTime);
begin
  FValue := ADateTime;
end;

function TDateTimeInstance.AsString: string;
begin
  Result := FormatDateTime('YYYY-MM-DD HH:NN:SS.ZZZ', FValue);
end;

function TDateTimeInstance.GetPartOfDate(APart: string): TInstanceOf;
begin
  if APart = 'year' then
    Result := TIntegerInstance.Create(YearOf(FValue))
  else if APart = 'month' then
    Result := TIntegerInstance.Create(MonthOf(FValue))
  else if APart = 'day' then
    Result := TIntegerInstance.Create(DayOf(FValue))
  else if APart = 'hour' then
    Result := TIntegerInstance.Create(HourOf(FValue))
  else if APart = 'minute' then
    Result := TIntegerInstance.Create(MinuteOf(FValue))
  else if APart = 'second' then
    Result := TIntegerInstance.Create(SecondOf(FValue))
  else if APart = 'milli' then
    Result := TIntegerInstance.Create(MilliSecondOf(FValue));
end;

class function TDateTimeInstance.CreateNowDateTime: TDateTimeInstance;
begin
  Result := TDateTimeInstance.Create(Now);
end;

end.

