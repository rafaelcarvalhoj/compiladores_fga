#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
using namespace std;

struct State { 
    vector<int> delta;
    bool final = false;
};
/*
void process(const vector<string>& alp, const vector<State>& states, int qi, string s) {
    if (states[qi].final and s.size() == 0) {
        cout << "Aceito\n";
        return;
    }
    cout << "ESTOU EM " << qi << " PROCESSANDO " << s[0] << endl;
    auto it = find(states[qi].delta.begin(), states[qi].delta.end(), make_pair(qi, s[0]));
    if (it != states[qi].delta.end()) {
        cout << "INDO PARA" << states[qi].delta[it - states[qi].delta.begin()].first << endl;
        string p = s.substr(1, s.size()-1);
        process(alp, states, states[qi].delta[it - states[qi].delta.begin()].first, s);
    } else {
        cout << "Rejeito\n";
    }
}*/

int main(){
    int Qs;
    cin >> Qs;

    int As;
    cin >> As;

    vector<State> states(Qs, State{vector<int>(As, -1)});

    vector<string> alphabet(As); 
    for(int i  = 0 ; i < As ; i++){
        cin >> alphabet[i];
    }
    sort(alphabet.begin(), alphabet.end());
    
    cout << "ALPHABET:";
    for(auto aItem : alphabet){
        cout << " " << aItem;
    }
    cout << endl;

    int transitions = Qs*As;
    cout << "quantidade de transicoes: " << transitions << endl;
    for(int i = 0 ; i < transitions ; i++){
        int from, to;
        string aDelta;
        cin >> from >> aDelta >> to;
        auto it = find(alphabet.begin(), alphabet.end(), aDelta);
        if (it != alphabet.end()) {
            int index = distance(alphabet.begin(), it);
            cout<<"from: "<<from<<" with "<<aDelta<< ": "<<index<<" to:"<<to<< endl;
            states[from].delta[index] = to;
        }
    }
    cout << "\nTRANSITIONS:\n";
    for(int i = 0; i < Qs; i++) {
        cout << "current state " << i << " transitions: ";
        for(auto& transition : states[i].delta) {
            //cout << "(next state: " << transition.first << ", transition: " << transition.second << ") ";
        }
        cout << endl;
    }

    int q0, Fs;
    cin >> q0;
    cin >> Fs;
    while(Fs--){
        int final_state;
        cin >> final_state;
        states[final_state].final = true;
    }

    string str;
    cin >> str;
    //process(alphabet, states, q0, str);
    
    return 0;
}
