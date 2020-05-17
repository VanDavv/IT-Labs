package lab05;


import java.util.Scanner;

class Matrix {
    public static int[][] getMatrix() {
        Scanner scan = new Scanner(System.in);

        System.out.println("Enter The Number Of Matrix Rows");

        int matrixRow = scan.nextInt();

        System.out.println("Enter The Number Of Matrix Columns");

        int matrixCol = scan.nextInt();

        //defining 2D array to hold matrix data
        int[][] matrix = new int[matrixRow][matrixCol];
        // Enter Matrix Data
        enterMatrixData(scan, matrix);

        // Print Matrix Data
        printMatrix(matrix);
        return matrix;
    }

    public static void enterMatrixData(Scanner scan, int[][] matrix) {
        int matrixCol = matrix.length;
        int matrixRow = matrix[0].length;
        System.out.println("Enter Matrix Data");

        for (int i = 0; i < matrixRow; i++) {
            for (int j = 0; j < matrixCol; j++) {
                matrix[i][j] = scan.nextInt();
            }
        }
    }

    public static void printMatrix(int[][] matrix) {
        int matrixCol = matrix.length;
        int matrixRow = matrix[0].length;
        System.out.println("Your Matrix is : ");

        for (int i = 0; i < matrixRow; i++) {
            for (int j = 0; j < matrixCol; j++) {
                System.out.print(matrix[i][j] + "\t");
            }

            System.out.println();
        }
    }

    public static int[][] transposeMatrix(int[][] matrix) {
        int matrixCol = matrix.length;
        int matrixRow = matrix[0].length;
        int[][] transpose = new int[matrixRow][matrixCol];
        for (int i = 0; i < matrixRow; i++) {
            for (int j = 0; j < matrixCol; j++) {
                transpose[i][j] = matrix[j][i];
            }
        }
        return transpose;
    }

    public static int[][] multiplyMatrices(int[][] A, int[][] B) {
        int matrixCol = A.length;
        int matrixRow = A[0].length;
        if(matrixCol != matrixRow) {
            System.err.println("Matrix dimentions are not the same, cannot multiply!");
            return null;
        }
        int[][] C = new int[matrixRow][matrixCol];
        for (int i = 0; i < matrixRow; i++) {
            for (int j = 0; j < matrixCol; j++) {
                C[i][j] = 0;
                for (int k = 0; k < matrixRow; k++) {
                    C[i][j] += A[i][k] * A[k][j];
                }
            }
        }

        return C;
    }
}

class Controller {
    private static int[][] A = null, B = null, C = null;
    public static void getMatrices() {
        System.out.println("[Matrix A]");
        A = Matrix.getMatrix();
        System.out.println("[Matrix B]");
        B = Matrix.getMatrix();
    }

    public static void transposeInput() {
        System.out.println("[Matrix A]");
        if (A == null) {
            System.err.println("Matrix A was not initialized!");
            return;
        }
        A = Matrix.transposeMatrix(A);
        System.out.println("[Matrix B]");
        if (B == null) {
            System.err.println("Matrix B was not initialized!");
            return;
        }
        B = Matrix.transposeMatrix(B);
    }

    public static void multiply() {
        System.out.println("[Matrix A]");
        if (A == null) {
            System.err.println("Matrix A was not initialized!");
            return;
        }
        System.out.println("[Matrix B]");
        if (B == null) {
            System.err.println("Matrix B was not initialized!");
            return;
        }
        C = Matrix.multiplyMatrices(A, B);
    }

    public static void transposeOutput() {
        System.out.println("[Matrix C]");
        if (C == null) {
            System.err.println("Matrix C was not initialized!");
            return;
        }
        C = Matrix.transposeMatrix(C);
    }

    public static void printInput() {
        System.out.println("[Matrix A]");
        if (A == null) {
            System.err.println("Matrix A was not initialized!");
            return;
        }
        Matrix.printMatrix(A);
        System.out.println("[Matrix B]");
        if (B == null) {
            System.err.println("Matrix B was not initialized!");
            return;
        }
        Matrix.printMatrix(B);
    }

    public static void printOutput() {
        System.out.println("[Matrix C]");
        if (C == null) {
            System.err.println("Matrix C was not initialized!");
            return;
        }
        Matrix.printMatrix(C);
    }
}

public class Main {
    public static void main(String... args) {
        String text = "Choose operation:\n" +
                "1. Provide input data\n" +
                "Arithmetic ops: \n" +
                "    2.1 Transpose input\n" +
                "    2.2 Multiply\n" +
                "    2.3 Transpose output\n" +
                "Print matrix:\n" +
                "    3.1 Print input matrix:\n" +
                "    3.2 Print output matrix:\n" +
                "4. Quit";
        Scanner scan = new Scanner(System.in);
        String op;
        do {
            System.out.println(text);
            op = scan.nextLine();
            switch (op) {
                case "1":
                    Controller.getMatrices();
                    break;
                case "2.1":
                    Controller.transposeInput();
                    break;
                case "2.2": {
                    Controller.multiply();
                    break;
                }
                case "2.3":
                    Controller.transposeOutput();
                    break;
                case "3.1":
                    Controller.printInput();
                    break;
                case "3.2":
                    Controller.printOutput();
                    break;
                case "4":
                    break;
                default:
                    System.err.println("Your choice is invalid, please try again");
            }
        }
        while (!op.equals("4"));

    }
}
