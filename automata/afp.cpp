#include <bits/stdc++.h>
using namespace std;
int main(void){
    string str;
    while(cin >> str){
        stack<char> afp;
        int qi = 0;
        while(str.size() != 0){
            char curr = str[0];
            if(afp.empty()){
                if(curr == 'a')
                    afp.push('A');
                else
                    afp.push('B');
            }
            else if(curr == 'a' && afp.top() == 'A'){
                afp.push('A');
            }
            else if(curr == 'b' && afp.top() == 'B'){
                afp.push('B');
            } 
            else {
                afp.pop();
            }
            if(afp.empty())
                cout << "nil\n";
            else{
                stack<char> afprint = afp;
                while(not afprint.empty()){
                    cout << afprint.top();
                    afprint.pop();
                }
                cout << '\n';
            }
            str = str.substr(1);
        }
        if(afp.empty())
            cout << "Aceito\n\n";
        else
            cout << "Rejeito\n\n";
    }
    return 0;   
}
