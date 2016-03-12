//14:51;
const maxnumber=62; base=10007;
type rec=record flag,fall:longint; next:array[1..26]of longint; end;
     edgetype=record v,nxt:longint; end;
     arr=array[0..maxnumber,0..maxnumber]of longint;
var n,len,tot,total,root,head,tail,x,p,i,j,k,cnt:longint;
    tree:array[0..maxnumber]of rec;
    tg:array[0..10*maxnumber]of edgetype;
    edge,q,can,b,bel:array[0..maxnumber]of longint;
    conv:array[0..maxnumber,0..26]of longint;
    res,sum:longint;
    std,c,ret,g:arr;
    ch:char;
    mark:array[0..30]of longint;
procedure init;inline;
begin
tot:=0;
total:=0;
fillchar(tree,sizeof(tree),0);
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(conv,sizeof(conv),0);
fillchar(ret,sizeof(ret),0);
end;
procedure addedge(x,y:longint);inline;
begin
inc(total); tg[total].v:=y; tg[total].nxt:=edge[x]; edge[x]:=total;
end;
procedure work(x,y:longint);
begin
tree[x].fall:=y;
addedge(y,x);
end;
function pow(x:longint;y:longint):longint;inline;
begin
pow:=1;
while y>0 do
  begin
  if y mod 2=1 then pow:=pow*x mod base;
  x:=x*x mod base;
  y:=y div 2;
  end;
end;
function mul(x,y:arr):arr;inline;
var i,j,k:longint;
begin
fillchar(c,sizeof(c),0);
for k:=1 to cnt do
    for i:=1 to cnt do
        begin
        if x[i][k]<>0 then
           for j:=1 to cnt do
               begin
               if y[k][j]<>0 then
                  c[i][j]:=(c[i][j]+x[i][k]*y[k][j]mod base)mod base;
               end;
        end;
mul:=c;
end;
procedure quick(x:longint);inline;
begin
std:=g;
ret:=g;
dec(x);
while x>0 do
  begin
  if x mod 2=1 then ret:=mul(ret,std);
  std:=mul(std,std);
  x:=x div 2;
  end;
end;
begin
{assign(input,'gen.in');
reset(input);
assign(output,'gen.out');
rewrite(output);}
while not eof do
  begin
  readln(n,len);
  if (n=0)and(len=0) then break;
  init;
  root:=1; tot:=1;
  for i:=1 to n do
      begin
      x:=root;
      while not eoln do
        begin
        read(ch);
        if tree[x].next[ord(ch)-ord('A')+1]=0 then
           begin
           inc(tot);
           tree[x].next[ord(ch)-ord('A')+1]:=tot;
           x:=tot;
           end
        else
           x:=tree[x].next[ord(ch)-ord('A')+1];
        end;
      readln;
      inc(tree[x].flag);
      mark[i]:=x;
      end;
  head:=1; tail:=1; q[1]:=root;
  while head<=tail do
    begin
    for i:=1 to 26 do
        begin
        if tree[q[head]].next[i]<>0 then
           begin
           if q[head]=root then work(tree[q[head]].next[i],root)
              else begin
                   p:=tree[q[head]].fall;
                   while p<>0 do
                     begin
                     if tree[p].next[i]<>0 then
                        begin
                        work(tree[q[head]].next[i],tree[p].next[i]);
                        break;
                        end;
                     p:=tree[p].fall;
                     end;
                   if p=0 then work(tree[q[head]].next[i],root);
                   end;
           inc(tail); q[tail]:=tree[q[head]].next[i];
           end;
        end;
    inc(head);
    end;
  for i:=1 to tot do can[i]:=1;
  for i:=1 to n do
      begin
      if can[mark[i]]=0 then continue;
      head:=1; tail:=1; q[1]:=mark[i];
      can[mark[i]]:=0;
      while head<=tail do
        begin
        p:=edge[q[head]];
        while p<>0 do
           begin
           if can[tg[p].v]=1 then begin can[tg[p].v]:=0; inc(tail); q[tail]:=tg[p].v; end;
           p:=tg[p].nxt;
           end;
        inc(head);
        end;
      end;
  cnt:=0;
  for i:=1 to tot do
      if can[i]=1 then
         begin
         inc(cnt);
         b[cnt]:=i;
         bel[i]:=cnt;
         end;
  for i:=1 to cnt do
      begin
//      if can[i]=0 then continue;
      for j:=1 to 26 do
          begin
          x:=b[i];
          while (x<>root)and(tree[x].next[j]=0) do x:=tree[x].fall;
          x:=tree[x].next[j];
          if x=0 then x:=root;
          conv[i][j]:=bel[x];
          end;
      end;
  for i:=1 to cnt do
      begin
//      if can[i]=0 then continue;
      for j:=1 to cnt do
          begin
//          if can[j]=0 then continue;
          for k:=1 to 26 do
              if conv[j][k]=i then inc(g[i][j]);
          end;
      end;
  res:=pow(26,len);
  quick(len);
  sum:=0;
  for i:=1 to cnt do
      sum:=(sum+ret[i][1])mod base;
  res:=(res-sum)mod base;
  if res<0 then res:=res+base;
  writeln(res);
  end;
{close(input);
close(output);}
end.
