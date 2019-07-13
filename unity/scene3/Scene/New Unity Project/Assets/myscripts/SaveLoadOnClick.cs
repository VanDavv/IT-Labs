using System;
using System.Collections;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using Scene.scripts;
using UnityEngine;

public class SaveLoadOnClick : MonoBehaviour
{
    private Pickable key;
    private Weapon weapon;
    
    void Start()
    {
        SaveFile(new GameData(false, false, 0f, 0f, 0f));
        GameData data = LoadFile();
 
        Debug.Log(data.keyPicked);
        Debug.Log(data.weaponPicked);
        Debug.Log(data.x);
        Debug.Log(data.y);
        Debug.Log(data.z);
    }

    private void Update()
    {
        if (Input.GetKey(KeyCode.T))
        {
            Vector3 position = gameObject.transform.position;
            GameData data = new GameData(false, false, position.x, position.y, position.z);
            Hand hand = gameObject.GetComponent(typeof(Hand)) as Hand;
            if (hand.picked && ((IList) hand.picked.labels).Contains("key"))
            {
                data.keyPicked = true;
                key = hand.picked;
            }

            var wpn = hand.picked as Weapon;
            if (wpn != null)
            {
                data.weaponPicked = true;
                weapon = wpn;
            }
            SaveFile(data);
        } else if (Input.GetKey(KeyCode.Y))
        {
            GameData data = LoadFile();
            gameObject.transform.position = new Vector3(data.x, data.y, data.z);
            if (data.keyPicked)
            {
                Hand hand = gameObject.GetComponent(typeof(Hand)) as Hand;
                hand.imageTarget.color = Color.white;
                hand.imageTarget.sprite = key.sprite;
                hand.picked = key;
                key.pick(gameObject);
            }

            if (data.weaponPicked)
            {
                Hand hand = gameObject.GetComponent(typeof(Hand)) as Hand;
                hand.imageTarget.color = Color.white;
                hand.imageTarget.sprite = weapon.sprite;
                hand.picked = weapon;
                weapon.pick(gameObject);
            }
        }
    }

    public void SaveFile(GameData data)
    {
        string destination = Application.persistentDataPath + "/save.dat";
        FileStream file;
 
        if(File.Exists(destination)) file = File.OpenWrite(destination);
        else file = File.Create(destination);
 
        BinaryFormatter bf = new BinaryFormatter();
        bf.Serialize(file, data);
        file.Close();
    }
 
    public GameData LoadFile()
    {
        string destination = Application.persistentDataPath + "/save.dat";
        FileStream file;
 
        if(File.Exists(destination)) file = File.OpenRead(destination);
        else
        {
            Debug.LogError("File not found");
            return null;
        }
 
        BinaryFormatter bf = new BinaryFormatter();
        GameData data = (GameData) bf.Deserialize(file);
        file.Close();

        return data;
    }
}