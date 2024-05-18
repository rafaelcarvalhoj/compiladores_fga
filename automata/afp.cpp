#include <bits/stdc++.h>
using namespace std;

using Transition = tuple<char, char, string, int>;

bool process(int qi, string str, const vector<vector<Transition>> transitions, stack<char> afp){
    if(str.size() == 0)
        return (qi == 2);

    char next = str[0];
    string rest = str.substr(1);
    printf("%s: estou em %d consumindo %c\n", str.c_str(), qi, next);
    for(const auto& trans: transitions[qi]){
        char read_char = get<0>(trans);
        char pop_stack = get<1>(trans);
        string push_stack = get<2>(trans);
        int next_state = get<3>(trans);

        printf("%c %c %s %d\n", read_char=='\0'?'3':read_char, pop_stack=='\0'?'3':pop_stack, push_stack.c_str(), next_state);


        bool can_read = read_char == next || read_char == '\0';
        bool can_pop = (pop_stack == '\0' || pop_stack == '?' || ( afp.size() > 0 && afp.top() == pop_stack));
        //printf("%d %d", can_read, can_pop);
        if(can_read && can_pop){
            printf("posso transitar para: %d\n", next_state);
            stack<char> afp_copy = afp;

            afp_copy.pop();

            if (push_stack != "")
                afp_copy.push(push_stack);

            if(process(next_state, rest, transitions, afp_copy)){
                printf("STACK: %c
                return true;
            }
             
        }
    }

    return false;
}


int main(void){
    vector<vector<Transition>> transicao(3);
   
    transicao[0].push_back(make_tuple('a', 'A', "AA", 0));
    transicao[0].push_back(make_tuple('a', '?', "A", 0));
    transicao[0].push_back(make_tuple('a', 'B', "", 0));
    transicao[0].push_back(make_tuple('\0', '\0', "", 1));
    transicao[0].push_back(make_tuple('?', '?', "", 2));
    
    transicao[1].push_back(make_tuple('\0', '\0', "", 0));
    transicao[1].push_back(make_tuple('b', '?', "B", 1));
    transicao[1].push_back(make_tuple('b', 'A', "", 1));
    transicao[1].push_back(make_tuple('b', 'B', "BB", 1));
    transicao[1].push_back(make_tuple('?', '?', "", 2));

    stack<char> afp;

    string str;
    while(cin >> str){
        cout << str << endl;
        process(0, str, transicao, afp);
    }

    return 0;   
}
