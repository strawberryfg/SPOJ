const maxn=1111; base=10000;
type rec=record prime,pow:longint; end;
var kind,m,i,j,first,cnteven,cntodd,ans,test,now:longint;
    a:array[0..maxn]of rec;
    f:array[0..maxn]of longint;
function calc(x,y:longint):longint;
begin
calc:=1;
while y>0 do
  begin
  if y mod 2=1 then calc:=calc*x mod base;
  y:=y div 2;
  if y=0 then break;
  x:=x*x mod base;
  end;
end;
begin
{assign(input,'robot.in');
reset(input);
assign(output,'robot.out');
rewrite(output);}
readln(test);
for now:=1 to test do
begin
readln(kind);
m:=1;
for i:=1 to kind do
    begin
    read(a[i].prime,a[i].pow);
    m:=m*calc(a[i].prime,a[i].pow) mod base;
    end;
if a[1].prime=2 then first:=2 else first:=1;
fillchar(f,sizeof(f),0);
f[0]:=1;
for i:=first to kind do
    for j:=kind downto 1 do
        f[j]:=(f[j]+f[j-1]*(a[i].prime-1) mod base) mod base;
cnteven:=0; cntodd:=0;
for i:=1 to kind do
    if i mod 2=0 then cnteven:=(cnteven+f[i]) mod base
       else cntodd:=(cntodd+f[i]) mod base;
ans:=((m-cnteven-cntodd-1) mod base+base) mod base;
writeln(cnteven);
writeln(cntodd);
writeln(ans);
end;
{close(input);
close(output);}
end.