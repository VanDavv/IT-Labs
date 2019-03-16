using System;
using UnityEngine;

namespace Scene.scripts
{
    public class AI : MonoBehaviour
    {
        private CharacterController m_Controller;
        private Rigidbody m_Rigidbody;
        private float m_DistToGround;
        private float m_Angle = 0;
        private GameObject[] m_Players = new GameObject[] {};
        private Vector3 m_Player;
        private SphereCollider m_Collider;
        
        private void Start()
        {
            m_Controller = GetComponent<CharacterController>();
            m_Rigidbody = GetComponent<Rigidbody>();
            m_DistToGround = GetComponent<Collider>().bounds.extents.y;
            m_Players = GameObject.FindGameObjectsWithTag("Player");
        }

        private void OnTriggerStay(Collider other)
        {
            m_Player = other.transform.position;
        }

        bool IsGrounded()
        {
            return Physics.Raycast(transform.position, -Vector3.up, m_DistToGround + 0.4f);
        }


        // Update is called once per frame
        void Update()
        {
            UpdateMovement();
            m_Rigidbody.MoveRotation(Quaternion.Euler(0, m_Angle, 0));
        }
        
        private void UpdateMovement()
        {
            if (!IsGrounded())
            {
                return;
            }

            if (m_Player != new Vector3())
            {
                float dist = Vector3.Distance(m_Player, transform.position);
                if (IsGrounded() && dist > 5 && dist < 30)
                {
                    var targetDir = m_Player - transform.position;
                    var angle = Vector3.SignedAngle(targetDir, transform.forward, Vector3.up);
                    if (Mathf.Abs(angle) < 5)
                    {
                        transform.position = Vector3.MoveTowards(transform.position, m_Player,   5*Time.deltaTime);
                    }
                    m_Angle -= angle * Time.deltaTime;
                }   
            }
        }
    }
}