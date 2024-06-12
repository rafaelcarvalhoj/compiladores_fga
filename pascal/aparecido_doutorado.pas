program aparecido_doutorado (input, output);

var
    it, i, sum, num, res: Int64;

begin
    sum := 0;
    readln(it);
    for i:=1 to it do 
    begin
        read(num);
        sum:=num+sum;
    end;
    readln(res);
    if res = sum then
        writeln('Acertou')
    else
        writeln('Errou');
end.
