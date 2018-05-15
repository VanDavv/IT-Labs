#include <iostream>
#include <cmath>
#include <cassert>
#include <numeric>
#include <random>
#include <chrono>
#include <thread>
#include <algorithm>

std::default_random_engine re;

double rand_double(double min, double max) {
    std::uniform_real_distribution<double> unif(min, max);
    return unif(re);
}


int rand_int(int min, int max) {
    std::uniform_int_distribution<int> unif(min, max);
    return unif(re);

}

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

class Driver {
public:
    static int driver_count;
    int getExperience() {
        return experience;
    }
    int addExperience(int exp) {
        switch (talent) {
            case 1:
                experience += std::log(exp + 1) * 1000;
                break;
            case 2:
                experience += exp * 1.05;
                break;
            case 3:
                experience += std::pow(exp, 2) / rand_int(1, 10);
                break;
            default:break;
        }
        return experience;
    }
    int getTalent() {
        return talent;
    }
    Driver() {
        talent = rand_int(1, 3);
        driver_count++;
    };
    ~Driver() {
        driver_count--;
    }
    static int getDriverCount() {
        return driver_count;
    }
private:
    int experience = 0;
    int talent;
};

int Driver::driver_count = 0;

class Car {
public:
    static int car_count;
    int addDamage(int dmg) {
        damage += dmg;
        return damage;
    }
    int getValue() {
        return value;
    }
    int getDamage() {
        return damage;
    }
    static int getCarCount() {
        return car_count;
    }
    Car() {
        car_count++;
    }
    ~Car() {
        car_count--;
    }
private:
    int damage = 0;
protected:
    int value;
};

int Car::car_count = 0;

class ExpensiveCar : public Car {
public:
    ExpensiveCar() : Car() {
         value = 15000 * getCarCount();
    }
};

class CommonCar : public Car {
public:
    CommonCar() : Car() {
         value = 10000 * getCarCount();
    }
};

class CheapCar : public Car {
public:
    CheapCar() : Car() {
         value = 5000 * getCarCount();
    }
};

class Game {
public:
    static Game* init() {
        auto game = new Game();
        game->drivers[0] = new Driver();
        game->cars[0] = new CheapCar();
        return game;
    }
    void buyDriver() {
        int driver_price = 10000 * Driver::getDriverCount();

        if (getBankBalance() < driver_price) {
            std::cout << "Not enough funds! Need " << driver_price << std::endl;
            return;
        }

        addBankBalance(-driver_price);
        auto new_driver = new Driver();
        drivers[Driver::getDriverCount() - 1] = new_driver;
        switch(new_driver->getTalent()) {
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
    void buyCar() {
        int car_price, car_quality, base_car_price = 5000 * Car::getCarCount();

        std::cout << "Pick car quality <1 - cheap(" << base_car_price << "), 2 - average("
                  << base_car_price * 2 << "), 3 - expensive(" << base_car_price * 3 << ")>: ";
        std::cin >> car_quality;
        std::cout << std::endl;

        if(car_quality < 1 || car_quality > 3) {
            std::cout << "Aborted!" << std::endl;
        }

        car_price = base_car_price * car_quality;

        if (getBankBalance() < car_price) {
            std::cout << "Not enough funds! Need " << car_price << std::endl;
            return;
        }
        addBankBalance(-car_price);
        int index = Car::getCarCount();
        switch(car_quality) {
            case 1:
                cars[index] = new CheapCar();
                break;
            case 2:
                cars[index] = new CommonCar();
                break;
            case 3:
                cars[index] = new ExpensiveCar();
                break;
            default:
                break;
        }
        std::cout << "You have purchased a new car!" << std::endl;
    }

    void sellCar() {
        if(Car::getCarCount() <= 0) {
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

        Car *car_to_sell = cars[Car::getCarCount() - 1];

        if(car_to_sell->getDamage() > 0) {
            std::cout << "Your car is damaged, repair it before it can be sold!" << std::endl;
            return;
        }

        auto car_income = static_cast<int>(car_to_sell->getValue() * 0.75);
        addBankBalance(car_income);
        delete car_to_sell;
        std::cout << "You have sold your car for " << car_income << std::endl;
    }

    void repairCars() {
        int repaired = 0;
        for (int i = 0; i < Car::getCarCount(); i++) {
            Car* car = cars[i];
            if(getBankBalance() >= car->getDamage()) {
                addBankBalance(-car->getDamage());

                if(car->getDamage() > 0) {
                    repaired++;
                }

                car->addDamage(-car->getDamage());
            } else {
                std::cout << "Repaired " << repaired << " cars" << std::endl;
                return;
            }
        }
    }

    void race() {
        int min_count = std::min(Car::getCarCount(), Driver::getDriverCount()), assigned_car[10] = {};

        int sum_exp = 0;

        for (int i = 0; i < Driver::getDriverCount(); i++) {
            sum_exp += drivers[i]->getExperience();
        }

        double collision_proba = 0.3 - (0.001 * sum_exp);


        int choice;
        for (int i = 0; i < min_count; i++) {
            std::cout << "Pick car for driver #" << i + 1 << ":";
            std::cin >> choice;
            bool exists = std::find(std::begin(assigned_car), std::end(assigned_car), choice) != std::end(assigned_car);
            if(exists || choice > Car::getCarCount() || choice <= 0) {
                std::cout << "Invalid, try again!" << std::endl;
                i--;
                continue;
            }

            assigned_car[i] = choice;
            bool is_colision = rand_double(0.0, 1.0) < collision_proba;
            if (is_colision) {
                drivers[i]->addExperience(700);
                cars[assigned_car[i] - 1]->addDamage(static_cast<int>(cars[assigned_car[i] - 1]->getValue() * rand_double(0.001, 0.1)));
                addBankBalance(rand_int(0, 1000));
            } else {
                drivers[i]->addExperience(2000);
                addBankBalance(static_cast<int>(2000 + cars[assigned_car[i] - 1]->getValue() * 0.1 + rand_int(0, 1000)));
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

    void printStatus() {
        std::cout << std::endl << "Bank balance: " << getBankBalance() << std::endl;
        std::cout << "Drivers: " << std::endl;
        for(int i = 0; i < Driver::getDriverCount(); i++) {
            std::cout << "#" << i + 1 << " (exp: " << drivers[i]->getExperience() << "; talent: " << drivers[i]->getTalent() << ") " << std::endl;
        }
        std::cout << "Cars: " << std::endl;
        for(int i = 0; i < Car::getCarCount(); i++) {
            std::cout << "#" << i + 1 << " (value: " << cars[i]->getValue() << "; damage: " << cars[i]->getDamage() << ") " << std::endl;
        }
    }
private:
    Game() {
        bank_balance = 200000;
    }
    int getBankBalance() {
        return bank_balance;
    }
    int addBankBalance(int balance) {
        bank_balance += balance;
        return bank_balance;
    }
    int bank_balance;
    Driver* drivers[10] = {};
    Car* cars[10] = {};
};

int main() {
    Game* game = Game::init();

    std::cout << "==============================" << std::endl
              << "===== Raily Tycoon v.1.0 =====" << std::endl
              << "==============================" << std::endl;

    int choice;

    do {
        game->printStatus();
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
                game->race();
                break;
            case 2:
                game->buyDriver();
                break;
            case 3:
                game->buyCar();
                break;
            case 4:
                game->sellCar();
                break;
            case 5:
                game->repairCars();
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