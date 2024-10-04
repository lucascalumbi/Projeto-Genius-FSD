#include <iostream>
#include <fstream>

using namespace std;

int main()
{

    // rodar o programa para """recompilar""" o arquivo main.v
    // g++ programa_boboca.cpp -o programa_boboca_executavel && ./programa_boboca_executavel

    ofstream main("main.v");
    string line;

    ifstream genius("modules/genius.v"); 
    while (getline(genius, line)) {
        main << line << std::endl;
    }

    ifstream my_sequence("modules/my_sequence.v");
    while (getline(my_sequence, line)) {
        main << line << std::endl;
    }

    ifstream dec7seg_4bits_1x2("modules/dec7seg_4bits_1x2.v");
    while (getline(dec7seg_4bits_1x2, line)) {
        main << line << std::endl;
    }

    ifstream dec7seg_4bits("modules/dec7seg_4bits.v"); 
    while (getline(dec7seg_4bits, line)) {
        main << line << std::endl;
    }

    ifstream dec7seg_2bits("modules/dec7seg_2bits.v"); 
    while (getline(dec7seg_2bits, line)) {
        main << line << std::endl;
    }

    ifstream verify_btn("modules/verify_btn.v"); 
    while (getline(verify_btn, line)) {
        main << line << std::endl;
    }


    return EXIT_SUCCESS;
}

