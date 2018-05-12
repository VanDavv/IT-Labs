#include <iostream>
#include <cmath>
#include <cassert>
#include <numeric>
#include <random>
#include <chrono>
#include <thread>
#include <algorithm>

std::default_random_engine re;

void print_progress(double progress) {
    int barWidth = 70;

    std::cout << "[";
    auto pos = static_cast<int>(barWidth * progress);
    for (int i = 0; i < barWidth; ++i) {
        if (i < pos) std::cout << "=";
        else if (i == pos) std::cout << ">";
        else std::cout << " ";
    }
    std::cout << "] " << int(progress * 100.0) << " %\r";
    std::cout.flush();
}

double rand_double(double min, double max) {
    std::uniform_real_distribution<double> unif(min, max);
    return unif(re);
}


int rand_int(int min, int max) {
    std::uniform_int_distribution<int> unif(min, max);
    return unif(re);

}

void add_driver(int &balance, int (&experience)[10], int (&talent)[10], int &current_index) {
    int driver_price = 10000 * current_index;

    if (balance < driver_price) {
        std::cout << "Not enough funds! Need " << driver_price << std::endl;
        return;
    }

    balance -= driver_price;
    experience[current_index] = 0;
    talent[current_index] = rand_int(1, 3);
    current_index += 1;

    switch(talent[current_index]) {
        case 1:
            std::cout << "Purchased new driver with a little talent" << std::endl;
            break;
        case 2:
            std::cout << "Purchased new driver with a moderate talent" << std::endl;
            break;
        case 3:
            std::cout << "Purchased new driver with a great talent" << std::endl;
            break;
        default:
            break;
    }
}

void buy_car(int &balance, int (&value)[10], int (&damage)[10], int &current_index) {
    int car_quality, car_price, base_car_price = 5000 * current_index;

    if(current_index > 0) {
        std::cout << "Pick car quality <1 - cheap(" << base_car_price << "), 2 - average("
                  << base_car_price * 2 << "), 3 - expensive(" << base_car_price * 3 << ")>: ";
        std::cin >> car_quality;
        std::cout << std::endl;
    } else {
        car_quality = 0;
    }

    if(car_quality < 1 || car_quality > 3) {
        std::cout << "Aborted!" << std::endl;
    }

    car_price = base_car_price * car_quality;

    if (balance < car_price) {
        std::cout << "Not enough funds! Need " << car_price << std::endl;
        return;
    }
    balance -= car_price;
    value[current_index] = static_cast<int>(car_price * 0.66);
    damage[current_index] = 0;
    current_index += 1;
    std::cout << "You have purchased a new car!" << std::endl;
}

void sell_car(int &balance, int (&value)[10], int (&damage)[10], int &current_index) {
    if(current_index <= 0) {
        std::cout << "You don't own any cars!" << std::endl;
        return;
    }
    char confirm;
    std::cout << "Do you want to sell your latest car? (y - aggree): ";
    std::cin >> confirm;
    std::cout << std::endl;

    if(confirm != 'y') {
        std::cout << "Aborted!" << std::endl;
        return;
    }

    if(damage[current_index - 1] > 0) {
        std::cout << "Your car is damaged, repair it before it can be sold!" << std::endl;
        return;
    }

    auto car_income = static_cast<int>(value[current_index - 1] * 0.75);
    balance += car_income;
    value[current_index - 1] = 0;
    current_index--;
    std::cout << "You have sold your car for " << car_income << std::endl;
}

void repair_cars(int &balance, int (&damage)[10]) {
    int repaired = 0;
    for (int &i : damage) {
        if(balance >= i) {
            balance -= i;

            if(i > 0) {
                repaired++;
            }

            i = 0;
        } else {
            std::cout << "Repaired " << repaired << " cars" << std::endl;
            return;
        }
    }
}

int calculate_new_exp(int exp, int talent) {
    switch (talent) {
        case 1:
            return static_cast<int>(std::log(exp + 1)) + 1000;
        case 2:
            return static_cast<int>(exp * 1.05) + 1000;
        case 3:
            return static_cast<int>(std::pow(exp, 2) / rand_int(1, 10)) + 1000;
        default:break;
    }
}

void race(int &bank_balance, int (&drivers_experience)[10], int (&drivers_talent)[10], int &drivers_count,
          int (&cars_value)[10], int (&cars_damage)[10], int &cars_count) {

    int min_count = std::min(drivers_count, cars_count), assigned_car[10];

    int sum_exp = std::accumulate(std::begin(drivers_experience), std::end(drivers_experience), 0, std::plus<int>());
    double collision_proba = 0.1 - (0.001 * sum_exp);


    int choice;
    for (int i = 0; i < min_count; i++) {
        std::cout << "Pick car for driver #" << i + 1 << ":";
        std::cin >> choice;
        if(std::any_of(std::begin(assigned_car), std::end(assigned_car), [&](int i) { return i == choice; }) || choice > cars_count) {
            std::cout << "Invalid, try again!" << std::endl;
            i--;
            continue;
        }

        assigned_car[i] = choice;
        bool is_colision = rand_double(0.0, 1.0) < collision_proba;
        if (is_colision) {
            drivers_experience[i] = static_cast<int>(calculate_new_exp(drivers_experience[i], drivers_talent[i]) * 0.7);
            cars_damage[assigned_car[i]] = static_cast<int>(cars_value[assigned_car[i]] * rand_double(0.001, 0.1));
            bank_balance += rand_int(0, 1000);
        } else {
            drivers_experience[i] = calculate_new_exp(drivers_experience[i], drivers_talent[i]);
            bank_balance += 2000 + cars_value[assigned_car[i]] * 0.1 + rand_int(0, 1000);
        }
    }

    double progres = 0.0;
    int wait_time = 10 * 1000;
    while(progres <= 1.0) {
        print_progress(progres);
        std::this_thread::sleep_for(std::chrono::milliseconds(wait_time / 45));
        progres += 1.0 / 45.0;
    }
}

void test_race() {
    int bank_balance = 2000, drivers_count = 2, drivers_experience[10] = {1000, 500}, drivers_talent[10] = {2, 1},
            cars_count = 2, cars_value[10] = {1000, 1000}, cars_damage[10] = {0, 0};

    race(bank_balance, drivers_experience, drivers_talent, drivers_count, cars_value, cars_damage, cars_count);

    assert(bank_balance >= 3000);
    assert(drivers_experience[0] >= 1000);
    assert(drivers_experience[1] >= 500);
}

void test_add_driver() {
    int bank_balance = 12000, drivers_count = 0, drivers_experience[10] = {}, drivers_talent[10] = {};

    add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);

    assert(bank_balance == 12000);
    assert(drivers_count == 1);
    assert(drivers_experience[0] == 0);
    assert(drivers_talent[0] >= 1);
    assert(drivers_talent[0] <= 3);

    add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);

    assert(bank_balance == 2000);
    assert(drivers_count == 2);
    assert(drivers_experience[1] == 0);
    assert(drivers_talent[1] >= 1);
    assert(drivers_talent[1] <= 3);

    add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);

    assert(bank_balance == 2000);
    assert(drivers_count == 2);
}

void test_buy_car() {
    int bank_balance = 15000, cars_count = 0, cars_value[10] = {}, cars_damage[10] = {};

    buy_car(bank_balance, cars_value, cars_damage, cars_count);

    assert(bank_balance == 15000);
    assert(cars_count == 1);
    assert(cars_value[0] == 0);
    assert(cars_damage[0] == 0);

    buy_car(bank_balance, cars_value, cars_damage, cars_count);

    assert(bank_balance <= 10000);
    assert(bank_balance >= 0);
    assert(cars_count == 2);
    assert(cars_value[1] >= 3300);
    assert(cars_value[1] <= 9900);
    assert(cars_damage[1] == 0);
}

void test_sell_car() {
    int bank_balance = 2000, cars_count = 2, cars_value[10] = {1000, 1000}, cars_damage[10] = {0, 0};

    sell_car(bank_balance, cars_value, cars_damage, cars_count);

    assert(bank_balance == 2750);
    assert(cars_count == 1);
    assert(cars_value[1] == 0);

    sell_car(bank_balance, cars_value, cars_damage, cars_count);

    assert(bank_balance == 3500);
    assert(cars_count == 0);
    assert(cars_value[0] == 0);
}

void test_repair_cars() {
    int bank_balance = 2000, cars_damage[10] = {400, 400};

    repair_cars(bank_balance, cars_damage);

    assert(bank_balance == 1200);
    assert(cars_damage[1] == 0);
    assert(cars_damage[0] == 0);
}

void test_random() {
    double d = rand_double(1.0, 2.0);
    assert(d >= 1.0);
    assert(d <= 2.0);

    double i = rand_int(1, 10);
    assert(i >= 1);
    assert(i <= 10);
}

void test() {
    test_add_driver();
    test_buy_car();
    test_sell_car();
    test_repair_cars();
    test_random();
    test_race();
}

int main() {
//    test();
    int bank_balance = 2000, drivers_count = 0, drivers_experience[10] = {}, drivers_talent[10] = {},
            cars_count = 0, cars_value[10] = {}, cars_damage[10] = {};

    buy_car(bank_balance, cars_value, cars_damage, cars_count);
    add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);

    std::cout << "==============================" << std::endl
              << "===== Raily Tycoon v.1.0 =====" << std::endl
              << "==============================" << std::endl;

    int choice;

    do {
        std::cout << std::endl << "Bank balance: " << bank_balance << std::endl;
        std::cout << "Drivers: " << std::endl;
        for(int i = 0; i < drivers_count; i++) {
            std::cout << "#" << i + 1 << " (exp: " << drivers_experience[i] << "; talent: " << drivers_talent[i] << ") " << std::endl;
        }
        std::cout << "Cars: " << std::endl;
        for(int i = 0; i < drivers_count; i++) {
            std::cout << "#" << i + 1 << " (value: " << cars_value[i] << "; damage: " << cars_damage[i] << ") " << std::endl;
        }
        std::cout << "Options:" << std::endl
                  << "  1. Race" << std::endl
                  << "  2. Buy new driver" << std::endl
                  << "  3. Buy new car" << std::endl
                  << "  4. Sell a car" << std::endl
                  << "  5. Repair cars" << std::endl
                  << "  9. Exit" << std::endl << std::endl
                  << "Your choice: ";
        std::cin >> choice;

        switch(choice) {
            case 1:
                race(bank_balance, drivers_experience, drivers_talent, drivers_count, cars_value, cars_damage, cars_count);
                break;
            case 2:
                add_driver(bank_balance, drivers_experience, drivers_talent, drivers_count);
                break;
            case 3:
                buy_car(bank_balance, cars_value, cars_damage, cars_count);
                break;
            case 4:
                sell_car(bank_balance, cars_value, cars_damage, cars_count);
                break;
            case 5:
                repair_cars(bank_balance, cars_damage);
                break;
            case 9:
                break;
            default:
                std::cout << std::endl << "Incorrect choice, please try again!" << std::endl;
                break;
        }
    } while(choice != 9);
    return 0;
}