using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.UI;

public class GameState : MonoBehaviour
{
    private int delay = 0;
    public GameObject endGamePanel;
    public Text timerPanel;
    public Text timeResultPanel;
    private Stopwatch watch;

    void Start()
    {
        Time.timeScale = 1;
        watch = Stopwatch.StartNew();
    }

    void Update()
    {
        delay += 1;
        int minutes = watch.Elapsed.Minutes;
        int seconds = watch.Elapsed.Seconds;
        timerPanel.text = $"{minutes:00}:{seconds:00}";
        if (delay == 100)
        {
            delay = 0;
            GameObject found = GameObject.FindWithTag("Enemy");
            if (found == null)
            {
                Time.timeScale = 0;
                endGamePanel.SetActive(true);
                timeResultPanel.text = $"{minutes:00}:{seconds:00}";
                watch.Stop();
            }
        }
    }
}
