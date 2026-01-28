# bazActionGen
generates bazAction.pas unit from simple bazActionDefs.txt

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
