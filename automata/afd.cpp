#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
using namespace std;

struct State { 
    vector<pair<int, string>> delta;
    bool final = false;
};


void process(const vector<string>& alp, const vector<State>& states, int qi) {
    string str;
    cin >> str;
    if (states[qi].final) {
        cout << "ACCEPTED STRING\n";
        return;
    }

    // Check if exist a transition from qi receiving str
    auto it = find(states[qi].delta.begin(), states[qi].delta.end(), make_pair(qi, str));
    if (it != states[qi].delta.end()) {
        process(alp, states, states[qi].delta[it - states[qi].delta.begin()].first);
    } else {
        cout << "TRANSITION NOT ACCEPTED\n";
    }
}

int main(){
    int Qs;
    cin >> Qs;
    vector<State> states(Qs);

    int As;
    cin >> As;
    vector<string> alphabet(As); 
    for(int i  = 0 ; i < As ; i++){
        cin >> alphabet[i];
    }
    sort(alphabet.begin(), alphabet.end());

    int q0, Fs;
    cin >> q0;
    cin >> Fs;
    while(Fs--){
        int final_state;
        cin >> final_state;
        states[final_state].final = true;
    }

    cout << "ALPHABET:";
    for(auto aItem : alphabet){
        cout << " " << aItem;
    }
    cout << endl;
    int transitions;
    cin >> transitions;
    for(int i = 0 ; i < transitions ; i++){
        int from, to;
        string aDelta;
        cin >> from >> aDelta >> to;
        auto it = find(alphabet.begin(), alphabet.end(), aDelta);
        if (it != alphabet.end()) {
            int index = distance(alphabet.begin(), it);
            states[from].delta.push_back(pair<int, string>{to, aDelta});
        }
    }
    cout << "\nTRANSITIONS:\n";
    for(int i = 0; i < Qs; i++) {
        cout << "current state " << i << " transitions: ";
        for(auto& transition : states[i].delta) {
            cout << "(next state: " << transition.first << ", transition: " << transition.second << ") ";
        }
        cout << endl;
    }
    
    int Is;
    cin >> Is;
    while(Is--){
        process(alphabet, states, 0);
    }

    return 0;
}
