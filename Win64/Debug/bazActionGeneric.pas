{   bazLib / bazAction
    Copyright (C) 2021-2099 Baz Cuda
    https://github.com/BazzaCuda/

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA
}
unit bazAction;

interface

type
  TVoid = record end;

  TOFunc<T, TResult> = function(const  aParam: T): TResult of object;
  TSFunc<T, TResult> = function(const  aParam: T): TResult;
  TAFunc<T, TResult> = reference to function(const  aParam: T): TResult;

  IAction<TResult> = interface
    function  getAssigned: boolean;
    property  assigned: boolean read getAssigned;
  end;

  IActionGeneric<T, TResult> = interface(IAction<TResult>)
    function  perform(const  aParam: T): TResult;
  end;

  TAction<TResult> = class(TInterfacedObject, IAction<TResult>)
  protected
    FFuncAssigned: boolean;
  public
    function  getAssigned: boolean;
  end;

  TActionGeneric<T, TResult> = class(TAction<TResult>, IActionGeneric<T, TResult>)
  strict private
    FOFunc: TOFunc<T, TResult>;
    FSFunc: TSFunc<T, TResult>;
    FAFunc: TAFunc<T, TResult>;
  public
    constructor Create(const  aFuncNIL: pointer); overload;
    constructor Create(const  aFunc: TOFunc<T, TResult>); overload;
    constructor Create(const  aFunc: TSFunc<T, TResult>); overload;
    constructor Create(const  aFunc: TAFunc<T, TResult>); overload;

    class function  pick(const  bBoolean: boolean; const  aTrueFunc: TOFunc<T, TResult>): IActionGeneric<T, TResult>; overload;
    class function  pick(const  bBoolean: boolean; const  aTrueFunc: TSFunc<T, TResult>): IActionGeneric<T, TResult>; overload;
    class function  pick(const  bBoolean: boolean; const  aTrueFunc: TAFunc<T, TResult>): IActionGeneric<T, TResult>; overload;

    function  perform(const  aParam: T): TResult;
  end;

implementation

uses
  bazRTL;

{ TAction<TResult> }

function  TAction<TResult>.getAssigned: boolean;
begin
  result := FFuncAssigned;
end;

{ TActionGeneric<T, TResult> }

constructor TActionGeneric<T, TResult>.Create(const  aFuncNIL: pointer);
begin
  case aFuncNIL = NIL of
     TRUE:  EXIT;
    FALSE:  raise  exception.Create('NIL constructor requires NIL'); end;
end;

constructor TActionGeneric<T, TResult>.Create(const  aFunc: TOFunc<T, TResult>);
begin
  FOFunc        := aFunc;
  FFuncAssigned := assigned(aFunc);
end;

constructor TActionGeneric<T, TResult>.Create(const  aFunc: TSFunc<T, TResult>);
begin
  FSFunc        := aFunc;
  FFuncAssigned := assigned(aFunc);
end;

constructor TActionGeneric<T, TResult>.Create(const  aFunc: TAFunc<T, TResult>);
begin
  FAFunc        := aFunc;
  FFuncAssigned := assigned(aFunc);
end;

class function  TActionGeneric<T, TResult>.pick(const  bBoolean: boolean; const  aTrueFunc: TOFunc<T, TResult>): IActionGeneric<T, TResult>;
begin
  case bBoolean of
     TRUE:  result := TActionGeneric<T, TResult>.Create(aTrueFunc);
    FALSE:  result := TActionGeneric<T, TResult>.Create(NIL); end;
end;

class function  TActionGeneric<T, TResult>.pick(const  bBoolean: boolean; const  aTrueFunc: TSFunc<T, TResult>): IActionGeneric<T, TResult>;
begin
  case bBoolean of
     TRUE:  result := TActionGeneric<T, TResult>.Create(aTrueFunc);
    FALSE:  result := TActionGeneric<T, TResult>.Create(NIL); end;
end;

class function  TActionGeneric<T, TResult>.pick(const  bBoolean: boolean; const  aTrueFunc: TAFunc<T, TResult>): IActionGeneric<T, TResult>;
begin
  case bBoolean of
     TRUE:  result := TActionGeneric<T, TResult>.Create(aTrueFunc);
    FALSE:  result := TActionGeneric<T, TResult>.Create(NIL); end;
end;

function  TActionGeneric<T, TResult>.perform(const  aParam: T): TResult;
begin
  result := default(TResult);
  case assigned(FOFunc) of TRUE: EXIT(FOFunc(aParam)); end;
  case assigned(FSFunc) of TRUE: EXIT(FSFunc(aParam)); end;
  case assigned(FAFunc) of TRUE: EXIT(FAFunc(aParam)); end;
end;

end.
