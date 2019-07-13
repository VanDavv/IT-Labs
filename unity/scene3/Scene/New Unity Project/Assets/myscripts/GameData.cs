using UnityEngine;

[System.Serializable]
public class GameData
{
    public bool keyPicked;
    public bool weaponPicked;
    public float x;
    public float y;
    public float z;
 
    public GameData(bool p_Key_Picked, bool p_weaponPicked, float p_X, float p_Y, float p_Z)
    {
        keyPicked = p_Key_Picked;
        weaponPicked = p_weaponPicked;
        x = p_X;
        y = p_Y;
        z = p_Z;
    }
}