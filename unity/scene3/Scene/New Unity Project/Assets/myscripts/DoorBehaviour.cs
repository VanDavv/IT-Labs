using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Scene.scripts;
using UnityEngine;

[RequireComponent(typeof(AudioSource))]
public class DoorBehaviour : MonoBehaviour
{
    private Animator animator;
    public Pickable key;
    public AudioSource source;
    public AudioClip openingSound;
    public AudioClip closingSound;
    
    void Start()
    {
        animator = GetComponent<Animator>();
    }
    
    void OnTriggerEnter(Collider other) {
        if (other.gameObject.CompareTag("Player"))
        {
            Hand hand = other.gameObject.GetComponent(typeof(Hand)) as Hand;
            if (hand.picked && hand.picked == key)
            {
                animator.SetBool("opened", true);
                source.clip = openingSound;
                source.Play(0);
            } 
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            animator.SetBool("opened", false);
            source.clip = closingSound;
            source.Play(0);
        }
    }
}
