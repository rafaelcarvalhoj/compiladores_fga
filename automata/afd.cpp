#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
using namespace std;

struct State { 
    vector<int> delta;
    bool final;
    State(int AlSize): delta(AlSize, -1), final(false) {}
};
void process(const vector<string>& alp, const vector<State>& states, int qi, string s) {
    if (states[qi].final && s.empty()) {
        cout << "Aceito\n";
        return;
    }
    if (s.empty()) {
        cout << "Rejeito\n";
        return;
    }
    //cout << "ESTOU EM " << qi << " PROCESSANDO " << s[0] << endl;
    auto next_index = find(alp.begin(), alp.end(), string(1, s[0])) - alp.begin();

    if (next_index != alp.size()) {
        if (states[qi].delta[next_index] != -1) {
            string p = s.substr(1);
            process(alp, states, states[qi].delta[next_index], p);
        } else {
            cout << "Rejeito\n";
        }
    } else {
        //cout << "Caractere '" << s[0] << "' não reconhecido.\n";
        cout << "Rejeito\n";
    }
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
    
    /*cout << "ALPHABET:";
    for(auto aItem : alphabet){
        cout << " " << aItem;
    }
    cout << endl;*/

    int transitions = Qs*As;
    //cout << "quantidade de transicoes: " << transitions << endl;
    for(int i = 0 ; i < transitions ; i++){
        int from, to;
        string aDelta;
        cin >> from >> aDelta >> to;
        auto it = find(alphabet.begin(), alphabet.end(), aDelta);
        if (it != alphabet.end()) {
            int index = distance(alphabet.begin(), it);
            //cout<<"from: "<<from<<" with "<<aDelta<< ": "<<index<<" to:"<<to<< endl;
            states[from].delta[index] = to;
        }
    }
    /*
    cout << "\nTRANSITIONS:\n";
    for(int i = 0; i < Qs; i++) {
        cout << "current state " << i << " transitions: ";
        for(int j = 0 ; j < As ; j++)
            cout << "(next state: " << states[i].delta[j] << ", transition: " << alphabet[j] << ") ";
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
    process(alphabet, states, q0, str);
    
    return 0;
}
