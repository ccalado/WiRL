{******************************************************************************}
{                                                                              }
{       WiRL: RESTful Library for Delphi                                       }
{                                                                              }
{       Copyright (c) 2015-2019 WiRL Team                                      }
{                                                                              }
{       https://github.com/delphi-blocks/WiRL                                  }
{                                                                              }
{******************************************************************************}
unit WiRL.Tests.Mock.Resources.Convert;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, System.JSON,

  WiRL.http.Accept.MediaType,
  WiRL.Core.Attributes,
  WiRL.Core.MessageBody.Default,
  WiRL.http.Request,
  WiRL.http.Response,
  WiRL.Core.Registry;

type
  [Path('/convert')]
  TConvertResource = class
  public
    [GET, Produces(TMediaType.TEXT_PLAIN + TMediaType.WITH_CHARSET_UTF8)]
    function HelloWorld(): string;

    [GET]
    [Path('date')]
    [Produces(TMediaType.TEXT_PLAIN + TMediaType.WITH_CHARSET_UTF8)]
    function GetDate([QueryParam('value')] ADate: TDate): string;

    [GET]
    [Path('double')]
    [Produces(TMediaType.TEXT_PLAIN + TMediaType.WITH_CHARSET_UTF8)]
    function GetDouble([QueryParam('value')] ADouble: Double): string;

    [GET]
    [Path('boolean')]
    [Produces(TMediaType.TEXT_PLAIN + TMediaType.WITH_CHARSET_UTF8)]
    function GetBoolean([QueryParam('value')] ABoolean: Boolean): string;

    [GET]
    [Path('request')]
    [Produces(TMediaType.TEXT_PLAIN + TMediaType.WITH_CHARSET_UTF8)]
    function GetRequest([Context] ARequest: TWiRLRequest): string;
  end;

implementation

{ TConvertResource }

function TConvertResource.GetBoolean(ABoolean: Boolean): string;
begin
  Result := IntToStr(Ord(ABoolean));
end;

function TConvertResource.GetDate(ADate: TDate): string;
var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(ADate, LYear, LMonth, LDay);
  Result := Format('%d*%d*%d', [LYear, LMonth, LDay]);
end;

function TConvertResource.GetDouble(ADouble: Double): string;
begin
  Result := IntToStr(Trunc(ADouble * 1000));
end;

function TConvertResource.GetRequest(ARequest: TWiRLRequest): string;
var
  LDate: TDate;
  LYear, LMonth, LDay: Word;
begin
  LDate := ARequest.QueryFields.AsType<TDate>('date');
  DecodeDate(LDate, LYear, LMonth, LDay);
  Result := Format('%d*%d*%d', [LYear, LMonth, LDay]);
end;

function TConvertResource.HelloWorld: string;
begin
  Result := 'Hello, convert!';
end;

initialization
  TWiRLResourceRegistry.Instance.RegisterResource<TConvertResource>;

end.
