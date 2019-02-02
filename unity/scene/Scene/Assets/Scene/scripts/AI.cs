using UnityEngine;

namespace Scene.scripts
{
    public class AI : MonoBehaviour
    {
        private CharacterController m_Controller;
        private Rigidbody m_Rigidbody;
        private float m_DistToGround;
        private float m_Angle = 0;
        private GameObject[] m_Players;

        private void Start()
        {
            m_Controller = GetComponent<CharacterController>();
            m_Rigidbody = GetComponent<Rigidbody>();
            m_DistToGround = GetComponent<Collider>().bounds.extents.y;
            m_Players = GameObject.FindGameObjectsWithTag("Player");
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

            float? min_dist = null;
            GameObject closestPlayer = gameObject;
            foreach (var player in m_Players)
            {
                if (player == gameObject)
                    continue;
                
                var dist = Vector3.Distance(player.transform.position, transform.position);
                if (min_dist == null || dist < min_dist)
                {
                    min_dist = dist;
                    closestPlayer = player;
                }
            }
            if (IsGrounded() && min_dist > 5 && min_dist < 30)
            {
                var targetDir = closestPlayer.transform.position - transform.position;
                var angle = Vector3.SignedAngle(targetDir, transform.forward, Vector3.up);
                print(angle);
                if(Mathf.Abs(angle) < 5)
                {
                    transform.position = Vector3.MoveTowards(transform.position, closestPlayer.transform.position,   5*Time.deltaTime);
                }
                m_Angle -= angle * Time.deltaTime;

            }
        }
    }
}