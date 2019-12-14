using System;
using System.Collections.Generic;

public abstract class Person {
  public string name;
  public string surname;

  public Person(string p_name, string p_surname) {
    name = p_name;
    surname = p_surname;
  }

  public abstract void get_data();
}

public class Employee : Person {
  public string position;

  public Employee(string p_name, string p_surname, string p_position) : base(p_name, p_surname) {
    position = p_position;
  }

  public override void get_data() {
    Console.WriteLine("Name {0}, Surname {1}, Position {2}", name, surname, position);
  }
}

public class Student : Person {
  public int album_nr;

  public Student(string p_name, string p_surname, int p_album_nr) : base(p_name, p_surname) {
    album_nr = p_album_nr;
  }

  public override void get_data() {
    Console.WriteLine("Name {0}, Surname {1}, Album nr {2}", name, surname, album_nr);
  }
}

public class Lecturer : Employee {
  public List<string> classes = new List<string>();

  public override void get_data() {
    Console.WriteLine("Name {0}, Surname {1}, Position {2}, Classes [{3}]", name, surname, position, string.Join(", ", classes));
  }

  public static Lecturer operator +(Lecturer p_lecturer, string p_class) {
    p_lecturer.classes.Add(p_class);
    return p_lecturer;
  }

  public Lecturer(string p_name, string p_surname, string p_position) : base(p_name, p_surname, p_position) {}
}

public class MainClass {
  public static int Main(string[] args) {
    Lecturer lecturer = new Lecturer("Test3Name", "Test3Surname", "Manager");
    lecturer += "Math";
    lecturer += "Physics";
    lecturer += "Forestry";

    Person[] persons = {
      new Employee("Test1Name", "Test1Surname", "Manager"),
      new Student("Test2Name", "Test2Surname", 40016),
      lecturer
    };

    foreach(var person in persons)
    {
        person.get_data();
    }
    return 0;
  }
}