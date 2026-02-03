# bazActionGen
generates bazAction.pas unit and descendants from a simple bazActionDefs.txt

Towards a Fluent Interface / Finite State Machine programming world with no IFs or Case statements

IAction/TAction allows, for example:

```Delphi
  
function mmpITBS(aFolderPath: string): string;
begin
  result      := aFolderPath;
  guardClause := (length(result) > 0) and (result[high(result)] <> BACKSLASH);
  result      := baz.use(guardClause, result + BACKSLASH, result);
end;
...
  result := TAction<string>.pick(result <> EMPTY, mmpITBS).perform(result);
```

and

```Delphi
  
function mmpDeleteTemp: boolean;
begin
  result := deleteFile(FTempFilePath);
end;
...
  result := TAction<boolean>.pick(vExportedOK, mmpDeleteTemp).default(result).perform;
```

and

```Delphi
  
function mmpDeleteTemp(const aFilePath: string): boolean;
begin
  result := deleteFile(aFilePath);
end;
...
  result := TAction<boolean>.pick(vExportedOK, mmpDeleteTemp).default(result).perform(FTempFilePath);
```

and

```Delphi
  
function mmpDeleteTemp(const aFilePath: string): boolean;
begin
  result := deleteFile(aFilePath);
end;
...
  TAction<boolean>.pick(vExportedOK, mmpDeleteTemp).perform(FTempFilePath);
```

and

```Delphi

var vActionToPerform := TAction<TDateTime>.pick(isItTooLate, mmpFindTheTime);
baz.cmd(vActionToPerform <> NIL, callThis(vActionToPerform);

```
