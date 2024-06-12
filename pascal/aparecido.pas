program Aparecido;
uses crt;

var
    a,b,c,sum,res:Int64;
begin
    read(a,b,c);
    readln(sum);
    res:=a+b+c;
    if res=sum then
        writeln('Acertou')
    else
        writeln('Errou');
end.
