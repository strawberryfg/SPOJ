const maxn=51111; maxm=511111; maxq=1111111; eps=1e-16; inf=1000000000;
type rec=record v,nxt,op,w:longint; end;
var test,now,n,m,i,cnt,tot,top,rnd,x,y,txy,tyx,head,tail:longint;
    dis,heap,edge,bel,posi,hash,fans:array[0..maxn]of longint;
    q:array[0..maxq]of longint;
    g:array[0..maxm]of rec;
    ans:extended;
function cmp(xx:extended):longint;
begin
if abs(xx)<eps then exit(0);
if xx>eps then exit(1);
exit(-1);
end;
procedure init;
begin
tot:=0; top:=0;
fillchar(edge,sizeof(edge),0);
fillchar(bel,sizeof(bel),0);
fillchar(hash,sizeof(hash),0);
end;
procedure addedge(x,y,txy,tyx:longint);
begin
inc(tot); g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].w:=txy; g[tot].op:=tot+1;
inc(tot); g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].w:=tyx; g[tot].op:=tot-1;
end;
procedure up(x:longint);
var swap:longint;
begin
while x>1 do
  begin
  if dis[heap[x]]<dis[heap[x div 2]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x div 2]; heap[x div 2]:=swap;
     bel[heap[x div 2]]:=x div 2; bel[heap[x]]:=x;
     x:=x div 2;
     end
  else break;
  end;
end;
procedure down(x:longint);
var swap:longint; numa,numb,opt:longint;
begin
while x*2<=top do
  begin
  numa:=dis[heap[x*2]]; if x*2+1<=top then numb:=dis[heap[x*2+1]] else numb:=inf;
  if numa<numb then opt:=0 else opt:=1;
  if dis[heap[x]]>dis[heap[x*2+opt]] then
     begin
     swap:=heap[x]; heap[x]:=heap[x*2+opt]; heap[x*2+opt]:=swap;
     bel[heap[x*2+opt]]:=x*2+opt; bel[heap[x]]:=x;
     x:=x*2+opt;
     end
  else break;
  end;
end;
procedure insert(id:longint);
begin
inc(top); heap[top]:=id; bel[id]:=top;
up(top);
end;
procedure dijkstra;
var i,x,p:longint;
begin
for i:=1 to n do dis[i]:=inf;
for i:=1 to cnt do begin dis[posi[i]]:=0; insert(posi[i]); end;
while top>0 do
  begin
  x:=heap[1]; bel[x]:=0;
  heap[1]:=heap[top]; heap[top]:=0; dec(top); bel[heap[1]]:=1; down(1);
  p:=edge[x];
  while p<>0 do
    begin
    if dis[x]+g[p].w<dis[g[p].v] then
       begin
       dis[g[p].v]:=dis[x]+g[p].w;
       if bel[g[p].v]=0 then insert(g[p].v)
          else up(bel[g[p].v]);
       end;
    p:=g[p].nxt;
    end;
  end;
end;
procedure solve;
var i,ret,p:longint; res:extended;
begin
ans:=-1.0; rnd:=0;
for i:=1 to n do
    begin
    if i=26 then
       rnd:=rnd;
    ret:=cmp(dis[i]-ans);
    if ret>0 then begin ans:=dis[i]; inc(rnd); hash[i]:=rnd; end
       else if ret=0 then hash[i]:=rnd;
    p:=edge[i];
    while p<>0 do
      begin
      if dis[i]<=dis[g[p].v] then
         begin
         res:=(1-1/g[p].w*(dis[g[p].v]-dis[i]))/(1/g[p].w+1/g[g[p].op].w)+dis[g[p].v];
         if cmp(res-inf)>0 then
            res:=inf;
         ret:=cmp(res-ans);
         if ret>0 then begin ans:=res; inc(rnd); hash[i]:=rnd; hash[g[p].v]:=rnd; end
            else if ret=0 then begin hash[i]:=rnd; hash[g[p].v]:=rnd; end;
         end
      else
         begin
         res:=(1-1/g[g[p].op].w*(dis[i]-dis[g[p].v]))/(1/g[g[p].op].w+1/g[p].w)+dis[i];
         if cmp(res-inf)>0 then
            res:=inf;
         ret:=cmp(res-ans);
         if ret>0 then begin ans:=res; inc(rnd); hash[i]:=rnd; hash[g[p].v]:=rnd; end
            else if ret=0 then begin hash[i]:=rnd; hash[g[p].v]:=rnd; end;
         end;
      p:=g[p].nxt;
      end;
    end;
head:=1; tail:=0;
for i:=1 to n do if hash[i]=rnd then begin inc(tail); q[tail]:=i; end;
while head<=tail do
  begin
  p:=edge[q[head]];
  while p<>0 do
    begin
    if (dis[g[p].v]+g[g[p].op].w=dis[q[head]])and(hash[g[p].v]<>rnd) then
       begin
       hash[g[p].v]:=rnd;
       inc(tail);
       q[tail]:=g[p].v;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  end;
//writeln(ans:0:3);
fans[0]:=0;
for i:=1 to n do if hash[i]=rnd then begin inc(fans[0]); fans[fans[0]]:=i; end;
for i:=1 to fans[0]-1 do write(fans[i],' ');
write(fans[fans[0]]);
writeln;
end;
begin
{assign(input,'panic.in');
reset(input);
assign(output,'panic.out');
rewrite(output);}
read(test);
for now:=1 to test do
    begin
    read(n,m,cnt);
    init;
    for i:=1 to m do begin read(x,y,txy,tyx); addedge(x,y,txy,tyx); end;
    for i:=1 to cnt do read(posi[i]);
    if cnt=0 then begin for i:=1 to n-1 do write(i,' '); write(n); writeln; end
       else begin
            dijkstra;
            solve;
            end;
    end;
{close(input);
close(output);}
end.