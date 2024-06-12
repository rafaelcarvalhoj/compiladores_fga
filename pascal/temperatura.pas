program Temperatura;
uses crt;

var
    from, t: char;
    input, res: double;

begin
    readln(from);
    readln(t);
    readln(input);
    case(from) of
        'C':begin
                case(t) of
                    'C': res:=input;
                    'F': res:=input*9/5+32;
                    'K': res:=input+273.15;
                end;
            end;
        'F':begin
                case(t) of
                    'C': res:=(input-32)/1.8;
                    'F': res:=input;
                    'K': res:=(input-32)/1.8+273.15;
                end;
            end;
        'K':begin
                case(t) of
                    'C': res := input - 273.15;
                    'F': res := (input - 273.15) * 9 / 5 + 32;
                    'K': res := input;
                end;
            end;
    end;
    writeln(res:0:2);
end.
