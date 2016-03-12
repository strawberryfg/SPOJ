const maxn=100020;
type rec=record v,nxt:longint; end;
     circletype=record u,v:longint; end;
var test,now,i,n,t1,t2,all,tot,ans,mmin:longint;
    edge,left,right,fa,a:array[0..maxn]of longint;
    g:array[0..maxn*10]of rec;
    f:array[0..maxn,0..1]of longint;
    circle:array[0..maxn]of circletype;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure addedgecomponent(x,y:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure init;
var i:longint;
begin
all:=0; tot:=0; ans:=0;
for i:=1 to n do begin fa[i]:=i; f[i][0]:=-1; f[i][1]:=-1; end;
fillchar(edge,sizeof(edge),0);
fillchar(left,sizeof(left),0);
fillchar(right,sizeof(right),0);
end;
function dp(x,num:longint):longint;
begin
if f[x][num]<>-1 then exit(f[x][num]);
if x=0 then exit(0);
if num=0 then begin f[x][num]:=dp(left[x],1)+dp(right[x],0)+1; exit(f[x][num]); end
   else begin
        f[x][num]:=min(dp(left[x],1)+dp(right[x],1)+1,dp(left[x],0)+dp(right[x],1));
        exit(f[x][num]);
        end;
end;
function work(x:longint):longint;
var p,tmp,t:longint;
begin
tmp:=getfa(x);
p:=edge[tmp];
while p<>0 do
  begin
  left[g[p].v]:=0; right[g[p].v]:=0;
  f[g[p].v][0]:=-1; f[g[p].v][1]:=-1;
  p:=g[p].nxt;
  end;
p:=edge[tmp];
while p<>0 do
  begin
  if g[p].v<>x then
     begin
     if left[a[g[p].v]]=0 then left[a[g[p].v]]:=g[p].v
        else begin
             t:=left[a[g[p].v]];
             while right[t]<>0 do t:=right[t];
             right[t]:=g[p].v;
             end;
     end;
  p:=g[p].nxt;
  end;
work:=dp(left[x],1)+1;
end;
begin
{assign(input,'explosion.in');
reset(input);
assign(output,'explosion.out');
rewrite(output);}
readln(test);
for now:=1 to test do
    begin
    readln(n);
    init;
    for i:=1 to n do
        begin
        readln(a[i]);
        t1:=getfa(i); t2:=getfa(a[i]);
        if t1<>t2 then fa[t1]:=t2
           else begin inc(all); circle[all].u:=i; circle[all].v:=a[i]; end;
        end;
    for i:=1 to n do
        begin
        t1:=getfa(i);
        addedgecomponent(t1,i);
        end;
    for i:=1 to all do
        begin
        mmin:=min(work(circle[i].u),work(circle[i].v));
        ans:=ans+mmin;
        end;
    writeln(ans);
    end;
{close(input);
close(output);}
end.