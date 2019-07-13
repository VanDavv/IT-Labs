using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ExitOnClick : MonoBehaviour
{
    public int targetSceneIndex;
    // Update is called once per frame
    void Update()
    {
        if (Input.anyKey)
        {
            SceneManager.UnloadSceneAsync(SceneManager.GetActiveScene().buildIndex);
            SceneManager.LoadScene(targetSceneIndex);
        }
    }
}
