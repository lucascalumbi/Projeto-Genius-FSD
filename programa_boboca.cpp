#include <iostream>
#include <fstream>

using namespace std;

void build_file_simulator(ofstream* file){
    string line;

    ifstream genius("modules/genius.v"); 
    while (getline(genius, line)) {
        *file << line << endl;
        if(line == "//begin1"){
            *file << "output reg [2:0] State," << endl;
            *file << "output reg [2:0] Next_state," << endl;
            *file << "output reg [3:0] Current_level," << endl;
            *file << "output reg [3:0] Sequence_count," << endl;
            *file << "output reg [3:0] Current_number," << endl;
            *file << "//end" << endl;
        }
        if(line == "//begin2"){
            *file << "State <= state;" << endl;
            *file << "Next_state <= next_state;" << endl;
            *file << "Current_level <= current_level;" << endl;
            *file << "Sequence_count <= sequence_count;" << endl;
            *file << "Current_number <= current_number;" << endl;
            *file << "//end" << endl;
        }
    }
    genius.close();

    ifstream my_sequence("modules/my_sequence.v");
    while (getline(my_sequence, line)) {
        *file << line << endl;
    }
    my_sequence.close();

    ifstream dec7seg_4bits_1x2("modules/dec7seg_4bits_1x2.v");
    while (getline(dec7seg_4bits_1x2, line)) {
        *file << line << endl;
    }
    dec7seg_4bits_1x2.close();

    ifstream dec7seg_4bits("modules/dec7seg_4bits.v"); 
    while (getline(dec7seg_4bits, line)) {
        *file << line << endl;
    }
    dec7seg_4bits.close();

    ifstream dec7seg_2bits("modules/dec7seg_2bits.v"); 
    while (getline(dec7seg_2bits, line)) {
        *file << line << endl;
    }
    dec7seg_2bits.close();

    ifstream verify_btn("modules/verify_btn.v"); 
    while (getline(verify_btn, line)) {
        *file << line << endl;
    }
    verify_btn.close();

    ifstream recieve_btn_input("modules/recieve_btn_input.v"); 
    while (getline(recieve_btn_input, line)) {
        *file << line << endl;
    }
    recieve_btn_input.close();

    ifstream shift_leds("modules/shift_leds.v"); 
    while (getline(shift_leds, line)) {
        *file << line << endl;
    }
    shift_leds.close();

    ifstream dec7seg_4bits_hexadec("modules/dec7seg_4bits_hexadec.v");
    while (getline(dec7seg_4bits_hexadec,line)){
        *file << line << endl;
    }
    dec7seg_4bits_hexadec.close();
}

void build_file_executable(ofstream* file){
    string line;

    ifstream genius("modules/genius.v"); 
    while (getline(genius, line)) {
        *file << line << endl;
    }
    genius.close();

    ifstream my_sequence("modules/my_sequence.v");
    while (getline(my_sequence, line)) {
        *file << line << endl;
    }
    my_sequence.close();

    ifstream dec7seg_4bits_1x2("modules/dec7seg_4bits_1x2.v");
    while (getline(dec7seg_4bits_1x2, line)) {
        *file << line << endl;
    }
    dec7seg_4bits_1x2.close();

    ifstream dec7seg_4bits("modules/dec7seg_4bits.v"); 
    while (getline(dec7seg_4bits, line)) {
        *file << line << endl;
    }
    dec7seg_4bits.close();

    ifstream dec7seg_2bits("modules/dec7seg_2bits.v"); 
    while (getline(dec7seg_2bits, line)) {
        *file << line << endl;
    }
    dec7seg_2bits.close();

    ifstream verify_btn("modules/verify_btn.v"); 
    while (getline(verify_btn, line)) {
        *file << line << endl;
    }
    verify_btn.close();

    ifstream recieve_btn_input("modules/recieve_btn_input.v"); 
    while (getline(recieve_btn_input, line)) {
        *file << line << endl;
    }
    recieve_btn_input.close();

    ifstream shift_leds("modules/shift_leds.v"); 
    while (getline(shift_leds, line)) {
        *file << line << endl;
    }
    shift_leds.close();

    ifstream dec7seg_4bits_hexadec("modules/dec7seg_4bits_hexadec.v");
    while (getline(dec7seg_4bits_hexadec,line)){
        *file << line << endl;
    }
    dec7seg_4bits_hexadec.close();


}

int main(){

    // rodar o programa para """recompilar""" o arquivo main.v
    // g++ programa_boboca.cpp -o programa_boboca_executavel && ./programa_boboca_executavel

    ofstream main_simulation("test_banch/main_simulation.v");
    ofstream main_executable("pitanga/main_executable.v");
    
    build_file_simulator(&main_simulation);
    main_simulation.close();

    build_file_executable(&main_executable);
    main_executable.close();

    return EXIT_SUCCESS;
}

