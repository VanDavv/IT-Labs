package lab09;


import java.util.concurrent.Semaphore;

class ThreadA implements Runnable {
    int k;

    public void run() {
        for (int i = 0; i < 3; i++) {
            System.out.println("k=" + ++k);
        }
    }
}


class AcquisitionThread extends Thread {
    private Semaphore s;

    public AcquisitionThread(Semaphore s) {
        this.s = s;
    }

    public void run() {
        s.tryAcquire();
        System.out.println(s.availablePermits());
    }
}

public class Question extends Thread {
    public void run() {
        System.out.println("Thread");
    }

    public static void main(String[] args) throws InterruptedException {
        System.out.println("1");
        synchronized (args) {
            System.out.println("2");
            try {
                args.wait();
            } catch (InterruptedException e) {}
        }
        System.out.println("3 ");
    }
}