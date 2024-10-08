#include <iostream>
#include <fstream>

using namespace std;

int main(){

    // rodar o programa para """recompilar""" o arquivo main.v
    // g++ programa_boboca.cpp -o programa_boboca_executavel && ./programa_boboca_executavel

    ofstream main("test_banch/main.v");
    string line;

    ifstream genius("modules/genius.v"); 
    while (getline(genius, line)) {
        main << line << endl;
    }
    genius.close();

    ifstream my_sequence("modules/my_sequence.v");
    while (getline(my_sequence, line)) {
        main << line << endl;
    }
    my_sequence.close();

    ifstream dec7seg_4bits_1x2("modules/dec7seg_4bits_1x2.v");
    while (getline(dec7seg_4bits_1x2, line)) {
        main << line << endl;
    }
    dec7seg_4bits_1x2.close();

    ifstream dec7seg_4bits("modules/dec7seg_4bits.v"); 
    while (getline(dec7seg_4bits, line)) {
        main << line << endl;
    }
    dec7seg_4bits.close();

    ifstream dec7seg_2bits("modules/dec7seg_2bits.v"); 
    while (getline(dec7seg_2bits, line)) {
        main << line << endl;
    }
    dec7seg_2bits.close();

    ifstream verify_btn("modules/verify_btn.v"); 
    while (getline(verify_btn, line)) {
        main << line << endl;
    }
    verify_btn.close();

    ifstream recieve_btn_input("modules/recieve_btn_input.v"); 
    while (getline(recieve_btn_input, line)) {
        main << line << endl;
    }
    recieve_btn_input.close();

    ifstream shift_leds("modules/shift_leds.v"); 
    while (getline(shift_leds, line)) {
        main << line << endl;
    }
    shift_leds.close();

    ifstream dec7seg_4bits_hexadec("modules/dec7seg_4bits_hexadec.v");
    while (getline(dec7seg_4bits_hexadec,line)){
        main << line << endl;
    }
    dec7seg_4bits_hexadec.close();

    main.close();

    return EXIT_SUCCESS;
}

