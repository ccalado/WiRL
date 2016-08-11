(*
  Copyright 2015-2016, MARS - REST Library

  Home: https://github.com/MARS-library

*)
unit MARS.Core.Classes;

interface

uses
  System.SysUtils, System.Generics.Collections, System.Classes,
  MARS.Core.Declarations;

type
  TNonInterfacedObject = class(TObject, IInterface)
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

implementation

uses
  MARS.Core.Utils;

{ TNonInterfacedObject }

function TNonInterfacedObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TNonInterfacedObject._AddRef: Integer;
begin
  Result := -1;
end;

function TNonInterfacedObject._Release: Integer;
begin
  Result := -1;
end;

end.
