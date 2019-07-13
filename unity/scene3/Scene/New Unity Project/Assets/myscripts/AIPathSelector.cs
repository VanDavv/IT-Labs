using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.ThirdPerson;

public class AIPathSelector : MonoBehaviour
{
    public GameObject navTargets;

    private AICharacterControl aiControl;
    private int navIndex = 0;
    // Start is called before the first frame update
    void Start()
    {
        aiControl = GetComponent<AICharacterControl>();
        if (aiControl.target == null)
        {
            UpdateTarget();
        }
    }

    private void UpdateTarget()
    {
        aiControl.target = navTargets.transform.GetChild(navIndex).gameObject.transform;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (aiControl.target == other.transform)
        {
            navIndex += 1;
            
            if (navIndex >= navTargets.transform.childCount)
            {
                navIndex = 0;
            }

            UpdateTarget();
        }
    }
}
