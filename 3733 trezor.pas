const max=5555;
var a,b,l,cnt,i,j,ansa,ansb,neither,com,ret:longint;
    insecure,secure,supersecure:qword;
    prime:array[0..max]of longint;
    check:array[0..max]of boolean;
    num:array[0..25]of longint;
function gcd(x,y:longint):longint;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
function lcm(x,y:longint):longint;
begin
exit(x*y div gcd(x,y));
end;
procedure dfs(x,now,opt:longint);
begin
if x>num[0] then
   begin
   ret:=ret+opt*(l div now);
   exit;
   end;
dfs(x+1,now,opt);
if qword(now)*qword(num[x])>qword(l) then exit;
dfs(x+1,now*num[x],-opt);
end;
function work(x:longint):longint;
var i,pd:longint;
begin
i:=1; num[0]:=0;
while i<=cnt do
  begin
  if prime[i]*prime[i]>x then break;
  pd:=0;
  while x mod prime[i]=0 do begin pd:=1; x:=x div prime[i]; end;
  if pd=1 then begin inc(num[0]); num[num[0]]:=prime[i]; end;
  inc(i);
  end;
if x<>1 then begin inc(num[0]); num[num[0]]:=x; end;
ret:=0;
dfs(1,1,1);
exit(ret);
end;
begin
{assign(input,'trezor.in');
reset(input);
assign(output,'trezor.out');
rewrite(output);}
read(a,b); read(l);
fillchar(check,sizeof(check),false);
cnt:=0;
for i:=2 to max do
    begin
    if not check[i] then begin inc(cnt); prime[cnt]:=i; end;
    for j:=1 to cnt do
        begin
        if i*prime[j]>max then break;
        check[i*prime[j]]:=true;
        if i mod prime[j]=0 then break;
        end;
    end;
insecure:=0; secure:=0; supersecure:=0;
for i:=b downto -a do
    begin
    if i=b then ansb:=1
       else ansb:=work(b-i);               // from (0,B)
    if i=-a then ansa:=1
       else ansa:=work(i+a);               // from (0,-A)
    if i=b then com:=1
       else if i=-a then com:=1
            else com:=work(lcm(b-i,i+a));
    neither:=l-(ansa+ansb-com);
    insecure:=insecure+qword(neither);
    secure:=secure+qword(ansa-com)+qword(ansb-com);
    supersecure:=supersecure+qword(com);
    end;
writeln(insecure);
writeln(secure);
writeln(supersecure);
{close(input);
close(output);}
end.