#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
using namespace std;

struct State { 
    vector<vector<int>> delta;
    bool final;
    State(int AlSize): delta(AlSize), final(false) {}
};


bool process(const vector<string>& alp, const vector<State>& states, int qi, string s) {
    if (states[qi].final && s.empty()){ 
        //cout << "FIM" << endl;
        return true;
    }
    
    if (s.empty()) 
        return false;

    auto next_index = find(alp.begin(), alp.end(), string(1, s[0])) - alp.begin();

    if (next_index != alp.size()) {
        int has_transition = states[qi].delta[next_index].size();
        if(has_transition > 0){
            string p = s.substr(1);
            for(auto tr = states[qi].delta[next_index].begin() ; tr != states[qi].delta[next_index].end() ; tr++){
                int tr_index = tr - states[qi].delta[next_index].begin(); 
                bool ac = process(alp, states, states[qi].delta[next_index][tr_index], p);
                if (ac){
                    //cout << "ESTOU EM " << qi << " PROCESSANDO " << s[0] << " INDO PARA " << states[qi].delta[next_index][tr_index] << endl;
                    return true;}
            }
            return false;
        }
    } else {
        return false;
    }
    return false;
}

int main(){
    int Qs;
    cin >> Qs;

    int As;
    cin >> As;

    vector<State> states(Qs, State(As));

    vector<string> alphabet(As); 
    for(int i  = 0 ; i < As ; i++){
        cin >> alphabet[i];
    }
    sort(alphabet.begin(), alphabet.end());
    
    /*
    cout << "ALPHABET:";
    for(auto aItem : alphabet){
        cout << " " << aItem;
    }
    cout << endl;*/

    int transitions = Qs*As;
    //cout << "quantidade de transicoes: " << transitions << endl;
    for(int i = 0 ; i < transitions ; i++){
        int from, to, ts;
        string aDelta;
        cin >> from >> aDelta >> ts;
        if(ts == 0) continue;
        auto it = find(alphabet.begin(), alphabet.end(), aDelta);
        if (it != alphabet.end()) {
            int index = distance(alphabet.begin(), it);
            for(int j = 0 ; j < ts ; j++){
                cin >> to;
                states[from].delta[index].push_back(to);
            }
            //cout<<"from: "<<from<<" with "<<aDelta<< ": "<<index<<" to:"<<to<< endl;
        }
    }
    /*
    cout << "\nTRANSITIONS:\n";
    for(int i = 0; i < Qs; i++) {
        cout << "current state " << i << " transitions: ";
        for(int j = 0 ; j < As ; j++)
            for(auto k = states[i].delta[j].begin(); k != states[i].delta[j].end(); k++)
                cout << "(next state: " << *k << ", transition: " << alphabet[j] << ") ";
        cout << endl;
    }*/

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
    if(process(alphabet, states, q0, str))
        cout << "Aceito" << endl;
    else
        cout << "Rejeito" << endl;
    
    return 0;
}
