program soma_n (input, output);

var
    it, i, sum, num: Int64;

begin
    sum := 0;
    readln(it);
    for i:=1 to it do 
    begin
        readln(num);
        sum:=num+sum;
    end;
    writeln(sum);
end.
