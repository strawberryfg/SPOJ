const maxn=100;
var test,now,i,n,a,b:longint;
    x:array[0..maxn]of longint;
    fm,fz,ans:extended;
procedure dfs(id,sum,opt:longint);
var i:longint; res:extended;
begin
if id>n then
   begin
   if sum>0 then
      begin
      res:=1;
      for i:=1 to n do res:=res*sum/i;
      ans:=ans+opt*res;
      end;
   exit;
   end;
dfs(id+1,sum+x[id],opt);
dfs(id+1,sum-x[id],-opt);
end;
function solve(lim:longint):extended;
begin
ans:=0.0;
dfs(1,lim,1);
solve:=ans;
end;
begin
{assign(input,'rng.in');
reset(input);
assign(output,'rng.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    readln(n,a,b);
    for i:=1 to n do read(x[i]);
    fm:=1;
    for i:=1 to n do fm:=fm*2*x[i];
    fz:=solve(b)-solve(a);
    writeln(fz/fm:0:9);
    end;
{close(input);
close(output);}
end.
