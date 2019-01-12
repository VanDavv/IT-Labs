using UnityEngine;
using System;
using System.Text;

public class Matrix3D
{
    private readonly float[,] m_Matrix;
    private const int Size = 3;

    private static Matrix3D _Identity()
    {
        var result = new Matrix3D();
        for (var i = 0; i < Size; i++) {
            result[i, i] = 1;
        }

        return result;
    }

    public float this[int row, int col]
    {
        get { return m_Matrix[row, col]; }
        set { m_Matrix[row, col] = value; }
    }

    public static Matrix3D Identity => _Identity(); 
    

    public Matrix3D(float[,] data)
    {
        m_Matrix = data;
    }

    public Matrix3D()
    {
        m_Matrix = new float[Size, Size];
    }

    public static Vector3 operator *(Matrix3D left, Vector3 right)
    {
        var result = new Vector3(0, 0, 0);

        for (var i = 0; i < Size; i++)
        {
            for (var j = 0; j < Size; j++)
            {
                result[i] += left[i, j] * right[j];
            }
        }
        
        return result;
    }

    public static Matrix3D operator *(Matrix3D left, Matrix3D right)
    {
        var result = new Matrix3D();

        for (var i = 0; i < Size; i++)
        {
            for (var j = 0; j < Size; j++)
            {
                for (var k = 0; k < Size; k++)
                {
                    result[i, j] += left[i, k] * right[k, j];
                }
            }
        }

        return result;
    }

    public static Matrix3D Translate(Vector3 distance)
    {
        var result = Matrix3D.Identity;
        result[0, Size - 1] = distance[0];
        result[1, Size - 1] = distance[1];
        result[2, Size - 1] = 1;
        return result;
    }

    public static Matrix3D Scale(Vector3 scale)
    {
        var result = Matrix3D.Identity;
        result[0, 0] = scale[0];
        result[1, 1] = scale[1];
        result[2, 2] = scale[2];
        return result;
    }

    public static Matrix3D RotateX(float angle)
    {
        var sin = (float) Math.Sin(angle);
        var cos = (float) Math.Cos(angle);
        var result = Matrix3D.Identity;
        result[1, 1] = cos;
        result[1, 2] = -sin;
        result[2, 1] = sin;
        result[2, 2] = cos;
        return result;
    }

    public static Matrix3D RotateY(float angle)
    {
        var sin = (float) Math.Sin(angle);
        var cos = (float) Math.Cos(angle);
        var result = Matrix3D.Identity;
        result[0, 0] = cos;
        result[0, 2] = sin;
        result[2, 0] = -sin;
        result[2, 2] = cos;
        return result;
    }

    public static Matrix3D RotateZ(float angle)
    {
        var sin = (float) Math.Sin(angle);
        var cos = (float) Math.Cos(angle);
        var result = Matrix3D.Identity;
        result[0, 0] = cos;
        result[0, 1] = -sin;
        result[1, 0] = sin;
        result[1, 1] = cos;
        return result;
    }
    
    public override string ToString()
    {
        var sb = new StringBuilder();
        for (var i = 0; i < Size; i++)
        {
            for (var j = 0; j < Size; j++)
            {
                sb.Append($"{m_Matrix[i, j]:0.000}\t");
            }
            sb.Append("\n");
        }
        return sb.ToString();
    }
}