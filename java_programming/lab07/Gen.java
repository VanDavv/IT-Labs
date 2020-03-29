public class Gen<T> {
    T object;

    Gen(T o) {
        object = o;
    }

    T getObject() {
        return object;
    }

    void showType() {
        System.out.println(object.getClass().getName());
    }
}