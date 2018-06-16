var readline = require('readline-sync');
var sleep = require('sleep');

const print_progress = (progress) => {
    const barWidth = 70;

    let message = "[";
    const pos = Math.round(barWidth * progress);
    for (let i = 0; i < barWidth; ++i) {
        if (i < pos) {
            message += "=";
        }
        else if (i == pos) {
            message += ">";
        }
        else {
            message += " "
        }
    }
    message += "] " + Math.round(progress * 100) + "%";

    process.stdout.clearLine();
    process.stdout.cursorTo(0);
    process.stdout.write(message);
};

class Driver {
    constructor() {
        this.talent = Math.floor(Math.random() * 3);
        this.experience = 0;
        Driver.driver_count += 1;
    }
    getExperience() {
        return this.experience;
    }
    addExperience(exp) {
        switch (this.talent) {
            case 1: this.experience += Math.log(exp + 1) * 1000; break;
            case 2: this.experience += exp * 1.05; break;
            case 3: this.experience += Math.pow(exp, 2) * Math.random() * 10; break;
            default: break;
        }
        this.experience = Math.round(this.experience);
        return this.experience;
    };
    getTalent() {
        return this.talent;
    }
    static getDriverCount() {
        return this.driver_count;
    }
}

const fun = (
    function() {
        let a = 5;
        return function () {
            return a;
        }

    }
)();

console.log(fun());
console.log(fun.a);

Driver.driver_count = 0;

class Car {
    constructor() {
        Car.car_count += 1;
        this.damage = 10;
    }
    addDamage(dmg) {
        return (this.damage += Math.round(dmg));
    }
    getDamage() {
        return this.damage;
    }
    getValue() {
        return this.value;
    }
    static getCarCount() {
        return this.car_count;
    }
}

Car.car_count = 0;

class ExpensiveCar extends Car {
    constructor() {
        super();
        this.value = 15000 * Car.getCarCount();
    }
}

class CommonCar extends Car {
    constructor() {
        super();
        this.value = 10000 * Car.getCarCount();
    }
}

class CheapCar extends Car {
    constructor() {
        super();
        this.value = 5000 * Car.getCarCount();
    }
}

class Game {
    constructor() {
        this.bank_balance = 200000;
        this.drivers = [];
        this.cars = [];
    }
    getBankBalance() {
        return this.bank_balance;
    }
    addBankBalance(balance) {
        return (this.bank_balance += Math.round(balance));
    }
    
    static init() {
        const game = new Game();
        game.drivers.push(new Driver());
        game.cars.push(new CheapCar());
        return game;
    }
    buyDriver() {
        const price = 10000 * Driver.getDriverCount();
        if(this.getBankBalance() < price) {
            console.error("Not enough funds! Need " + price);
            return;
        }
        this.addBankBalance(-price);
        const driver = new Driver();
        this.drivers.push(driver);

        switch(driver.getTalent()) {
            case 1:
                console.log("Purchased new driver with a little talent");
                break;
            case 2:
                console.log("Purchased new driver with a moderate talent");
                break;
            case 3:
                console.log("Purchased new driver with a great talent");
                break;
            default:
                break;
        }
    };

    buyCar() {
        const base = 5000 * Car.getCarCount();
        const quality = +(readline.question("Pick car quality <1 - cheap(" + base + "), 2 - average(" + base * 2 + "), 3 - expensive(" + base * 3 + ")>: "));
        if(quality < 1 || quality > 3) {
            console.error("Aborted!");
            return
        }
        const price = quality * base;
        if(this.getBankBalance() < price) {
            console.error("Not enough funds! Need " + price);
            return;
        }
        this.addBankBalance(-price);
        this.cars.push(
            quality === 1 ? new CheapCar() :
            quality === 2 ? new CommonCar() :
            new ExpensiveCar()
        );
        console.log("You have purchased a new car!");
    };

    sellCar() {
        if(Car.getCarCount() <= 0) {
            console.error("You don't own any cars!");
            return;
        }
        const answer = readline.question("Do you want to sell your latest car? (y - aggree): ");
        if(answer !== 'y') {
            console.error("Aborted!");
            return
        }
        const car = this.cars[this.cars.length - 1];
        if(car.getDamage() > 0) {
            console.error("Your car is damaged, repair it before it can be sold!");
            return;
        }
        Car.car_count -= 1;
        const removed = this.cars.pop();
        this.addBankBalance(removed.getValue() * 0.75);
        console.log("You have sold your car for " + removed.getValue() * 0.75)
    };

    repairCars() {
        let repaired = 0;
        for (const car of this.cars) {
            if(this.getBankBalance() >= car.getDamage()) {
                this.addBankBalance(-car.getDamage());

                if(car.getDamage() > 0) {
                    repaired++;
                }

                car.addDamage(-car.getDamage());
            } else {
                console.log("Repaired " + repaired + "cars");
                return;
            }
        }
    };

    race() {
        const min_count = Math.min(Car.getCarCount(), Driver.getDriverCount());
        const exp = this.drivers.reduce((sum, item) => sum + item.getExperience(), 0);
        const collision_proba = 0.3 - (0.001 * exp);

        const assigned_cars = [];

        for(let i = 0; i < min_count; i++) {
            const choice = +(readline.question("Pick car for driver #" + (i + 1) + ":"));
            if(assigned_cars.indexOf(choice) > -1 || choice > Car.getCarCount() || choice < 1) {
                console.log("Invalid, try again!");
                i--;
                continue;
            }
            assigned_cars[i] = choice;
            const assignes_car = this.cars[assigned_cars[i] - 1];
            if(Math.random() < collision_proba) {
                this.drivers[i].addExperience(700);
                assignes_car.addDamage(assignes_car.getValue() * Math.random() / 10);
                this.addBankBalance(Math.random() * 1000);
            } else {
                this.drivers[i].addExperience(2000);
                this.addBankBalance(2000 + assignes_car.getValue() * 0.1 + Math.random() * 1000);
            }
        }

        let progress = 0;
        const wait_time = 10 * 1000;
        while(progress < 1) {
            print_progress(progress);
            sleep.msleep(Math.floor(wait_time / 45));
            progress += 1 / 45;
        }
    };
    
    printStatus() {
        console.log();
        console.log("Bank balance: " + this.getBankBalance());
        console.log("Drivers: ");
        for(let i = 0; i < Driver.getDriverCount(); i++) {
            console.log("#" + (i + 1) + " (exp: " + this.drivers[i].getExperience() + "; talent: " + this.drivers[i].getTalent() + ")");
        }
        console.log("Cars:");
        for(let i = 0; i < Car.getCarCount(); i++) {
            console.log("#" + (i + 1) + " (value: " + this.cars[i].getValue() + "; damage: " + this.cars[i].getDamage() + ")");
        }
    }
}

const game = Game.init();
console.log("==============================");
console.log("===== Raily Tycoon v.1.0 =====");
console.log("==============================");

let choice = 0;

while(choice !== 9) {
    game.printStatus();
    console.log("Options:" );
    console.log("  1. Race");
    console.log("  2. Buy new driver");
    console.log("  3. Buy new car");
    console.log("  4. Sell a car");
    console.log("  5. Repair cars");
    console.log("  9. Exit");
    choice = +(readline.question("Your choice: "));

    switch(choice) {
        case 1:
            game.race();
            break;
        case 2:
            game.buyDriver();
            break;
        case 3:
            game.buyCar();
            break;
        case 4:
            game.sellCar();
            break;
        case 5:
            game.repairCars();
            break;
        case 9:
            break;
        default:
            console.log();
            console.error("Incorrect choice, please try again!");
            break;
    }
}
        