import math
import sys
from random import randint, uniform, random
from time import sleep


def print_progress(**kwargs):
    progress = kwargs['progress']
    bar_width = 70
    message = "["
    position = int(bar_width * progress)

    for i in range(bar_width):
        message += "=" if i < position else ">" if i == position else " "

    message += f"] {int(progress * 100)}%"

    sys.stdout.write("\r" + message)
    sys.stdout.flush()


def add_driver(balance, drivers):
    price = 10000 * len(drivers)
    if balance < price:
        print(f"Not enough founds! Need {price}")
        return balance, drivers

    new_driver = {
        "experience": 0,
        "talent": randint(1, 3)
    }

    if new_driver["talent"] == 1:
        print("Purchased new driver with a little talent")
    elif new_driver["talent"] == 2:
        print("Purchased new driver with a moderate talent")
    else:
        print("Purchased new driver with a great talent")

    return balance - price, drivers + [new_driver]


def buy_car(balance, cars):
    base_price = 5000 * len(cars)

    if base_price == 0:
        new_car = {
            "value": 0,
            "damage": 0
        }
        return balance, [new_car]

    input_message = "Pick car quality <1 - cheap({}), 2 - average({}), 3 - expensive({})>: "
    quality = input(input_message.format(base_price, base_price * 2, base_price * 3))

    if not quality.isdigit() and not 1 <= int(quality) <= 3:
        print("Aborted!")
        return balance, cars

    price = int(quality) * base_price

    if balance < price:
        print(f"Not enough funds! Need {price}")
        return balance, cars

    new_car = {
        "value": price * 0.66,
        "damage": 0
    }

    print("You have purchased a car!")

    return balance - price, cars + [new_car]


def sell_car(balance, cars):
    if len(cars) == 0:
        print("You don't own any cars!")
        return balance, cars

    if input("Do you want to sell your latest car? (y - aggree): ") != "y":
        print("Aborted!")
        return balance, cars

    sold_car = cars[-1]

    if sold_car['damage'] > 0:
        print("Your car is damaged, repair it before it can be sold!")
        return balance, cars

    del cars[-1]
    return balance + sold_car['value'], cars


def repair_cars(balance, cars):
    repaired = 0
    repaired_cars = list(cars)
    new_balance = balance
    for car in filter(lambda car: car['damage'] > 0, repaired_cars):
        if car['damage'] > balance:
            break
        else:
            new_balance -= car['damage']
            car['damage'] = 0
            repaired += 1

    return new_balance, repaired_cars


def calculate_exp(driver):
    if driver['talent'] == 1:
        return int(math.log10(driver['experience'] + 1) + 1000)
    elif driver['talent'] == 2:
        return int(driver['experience'] * 1.05 + 1000)
    else:
        return int(driver['experience'] ** 2 // randint(1, 10) + 1000)


def race(balance, drivers, cars):
    new_drivers = list(drivers)
    new_cars = list(cars)
    new_balance = balance

    pair_count = min(len(drivers), len(cars))

    sum_exp = sum(map(lambda driver: driver['experience'], new_drivers))
    collision_proba = 0.1 - (0.001 * sum_exp)

    picked = []
    while len(picked) != pair_count:
        choice = input(f"Pick car for driver #{len(picked) + 1}: ")
        if not choice.isdigit() or int(choice) in picked or int(choice) > len(new_cars):
            print("Invalid, try again")
            continue

        choice = int(choice)
        driver = new_drivers[len(picked)]

        picked.append(choice)

        collision = random() < collision_proba

        if collision:
            new_drivers[len(picked) - 1]['experience'] = calculate_exp(driver) * 0.7
            new_cars[choice]['damage'] = new_cars[choice - 1]['value'] * uniform(0.001, 0.1)
            new_balance += randint(0, 1000)
        else:
            new_drivers[len(picked) - 1]['experience'] = calculate_exp(driver)
            new_balance += 2000 + new_cars[choice - 1]['value'] * 0.1 + randint(0, 1000)

    progress = 0.0
    wait_time = 10
    while progress < 1.0:
        print_progress(progress=progress)
        sleep(wait_time / 45)
        progress += 1.0 / 45.0

    return new_balance, new_drivers, new_cars


if __name__ == '__main__':
    print("==============================")
    print("===== Raily Tycoon v.1.0 =====")
    print("==============================")

    choice = 0
    drivers = []
    cars = []
    balance = 200000

    balance, drivers = add_driver(balance, drivers)
    balance, cars = buy_car(balance, cars)

    while choice != 9:
        print(f"Bank balance: {balance}")
        print("Drivers: ")
        print(drivers)
        print("Cars:")
        print(cars)

        print("""Options:
  1. Race
  2. Buy new driver
  3. Buy new car
  4. Sell a car
  5. Repair cars
  9. Exit
        """)

        choice = int(input("Your choice: "))

        if choice == 1:
            balance, drivers, cars = race(balance, drivers, cars)
        elif choice == 2:
            balance, drivers = add_driver(balance, drivers)
        elif choice == 3:
            balance, cars = buy_car(balance, cars)
        elif choice == 4:
            balance, cars = sell_car(balance, cars)
        elif choice == 5:
            balance, cars = repair_cars(balance, cars)
        elif choice != 9:
            print("Incorrect choice, please try again!")











