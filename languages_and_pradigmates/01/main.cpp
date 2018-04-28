#include <iostream>
#include <cmath>

void add_driver(int &balance, int (&experience)[10], int (&talent)[10] , int &current_index) {
    // TODO check if got enough balance
    // TODO randomize talent to be from 1 to 3 (1 - log, 2 - linear, 3 - pow)
    std::cout << "Creating new driver" << std::endl;
    balance -= 10000 * current_index;
    experience[current_index] = 999;
    talent[current_index] = 100;
    current_index += 1;
}

void buy_car(int &balance, int (&value)[10], int (&damage)[10] , int &current_index) {
    // TODO check if got enough balance
    // TODO Add option to pick car value (e.x. 1000 - cheap, 5000 - avg, 10000 - expensive)
    std::cout << "Buying new car" << std::endl;
    balance -= 5000 * current_index;
    value[current_index] = 999;
    damage[current_index] = 100;
    current_index += 1;
}

void sell_car(int &balance, int (&value)[10], int (&damage)[10] , int &current_index) {
    // TODO add check if car is not damaged
    std::cout << "Selling a car" << std::endl;
    balance += value[current_index] * 0.75;
    value[current_index] = 0;
}

void repair_cars(int &balance, int (&damage)[10]) {
    // TODO repair as much cars as you can with current balance
    std::cout << "Repairing a car" << std::endl;
    for (int &i : damage) {
        balance -= i;
        i = 0;
    }
}

void race(int &bank_balance, int (&drivers_experience)[10], int (&drivers_talent)[10], int &drivers_count, int (&cars_value)[10], int (&cars_damage)[10], int &cars_count) {
    std::cout << "Race" << std::endl;
}

int main() {
    int bank_balance = 2000;
    int drivers_count = 0;
    int drivers_experience[10] = {};
    int drivers_talent[10] = {};
    int cars_count = 0;
    int cars_value[10] = {};
    int cars_damage[10] = {};
    add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);
    buy_car(bank_balance, cars_value, cars_damage, cars_count);
    std::cout << bank_balance << std::endl;
    for (int i : drivers_experience)
        std::cout << i << " | ";
    std::cout << std::endl;
    for (int i : drivers_talent)
        std::cout << i << " | ";
    std::cout << std::endl;
    sell_car(bank_balance, cars_value, cars_damage, cars_count);
    repair_cars(bank_balance, cars_damage);
    race(bank_balance, drivers_experience, drivers_talent, drivers_count, cars_value, cars_damage, cars_count);
    return 0;
}