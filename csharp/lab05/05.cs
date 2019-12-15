/*
tworzymy listę osób (generic List)
dodajemy ileś osób
wywołać sortowanie (.Sort(<obiekt comparer>)
zaimplementować comparer
najpierw wiek, wzrost, imię na końcu nazwisko
*/
using System;
using System.Collections.Generic;

public interface ILabelPrinter
{
    string getLabel();
}

public class Person : ILabelPrinter {
  public string name;
  public string surname;
  public int age;
  public int height;

  public Person(string p_name, string p_surname, int p_age, int p_height) {
    name = p_name;
    surname = p_surname;
    age = p_age;
    height = p_height;
  }

  public string getLabel() {
    return "Person: " + name + " " + surname + " " + age + " " + height;
  }
}

public class Room : ILabelPrinter {
  public string nr;

  public Room(string p_nr) {
    nr = p_nr;
  }

  public string getLabel() {
    return "Room: " + nr;
  }
}

public class Printer {
  public static void print(ILabelPrinter item) {
    Console.WriteLine(item.getLabel());
  }
}

public class PersonComparer : IComparer<Person> {
    public int Compare(Person first, Person second) {
        var ageDelta = first.age - second.age;
        if(ageDelta != 0)
          return ageDelta;

        var heightDelta = first.height - second.height;
        if(heightDelta != 0)
          return heightDelta;

        var nameDelta = string.Compare(first.name, second.name, StringComparison.Ordinal);
        if(nameDelta != 0)
          return nameDelta;

        var surnameDelta = string.Compare(first.surname, second.surname, StringComparison.Ordinal);
        if(surnameDelta != 0)
          return surnameDelta;

        return 0;
    }
}

public class MainClass {
  public static int Main(string[] args) {
    var person_list = new List<Person>();
    person_list.Add(new Person("BTest1", "CTest1Surname", 10, 190));
    person_list.Add(new Person("BTest1", "BTest2Surname", 10, 190));
    person_list.Add(new Person("BTest1", "ATest3Surname", 10, 190));
    person_list.Add(new Person("ATest4", "Test4Surname", 10, 190));
    person_list.Add(new Person("CTest5", "Test5Surname", 10, 190));
    person_list.Add(new Person("Test6", "Test6Surname", 10, 200));
    person_list.Add(new Person("Test7", "Test7Surname", 10, 180));
    person_list.Add(new Person("Test8", "Test8Surname", 12, 190));
    person_list.Add(new Person("Test9", "Test9Surname", 9, 190));
    person_list.Sort(new PersonComparer());
    person_list.ForEach(Printer.print);

    var room = new Room("13A");
    Printer.print(room);
    return 0;
  }
}