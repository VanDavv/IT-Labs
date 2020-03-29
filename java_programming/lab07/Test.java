import java.util.*;

interface IMinMax< T extends Number > {
    T min(T[] tab); //min. wartość w tablicy
    T max(T[] tab); //max. wartość w tablicy
}

class ImplClass implements IMinMax<Integer> {
    @Override
    public Integer min(Integer[] tab) {
        Integer min = Integer.MAX_VALUE;
        for(Integer elem : tab) {
            if(elem < min) {
                min = elem;
            }
        }
        return min;
    }
    @Override
    public Integer max(Integer[] tab) {
        Integer max = Integer.MIN_VALUE;
        for(Integer elem : tab) {
            if(elem > max) {
                max = elem;
            }
        }
        return max;
    }
}

public class Test {
    public static void main(String[] args) {
        Integer[] a = {1, 2, 3, 5, 6, 2, 31, 1, 2, -1};
        ImplClass o = new ImplClass();
        System.out.println(o.max(a));
        System.out.println(o.min(a));
    }
}