using UnityEngine;

namespace Scene.scripts
{
    public class FPSCustom3 : MonoBehaviour
    {
        private Rigidbody m_Rigidbody;
        private Vector3 movement;
        private const float speed = 1f;
        private float animSpeed = 0f;
        private float m_HorizontalAngle = 0f;
        private float m_DistToGround = 0f;
        private Animator m_Animator;

        private void Start()
        {
            m_Rigidbody = GetComponent<Rigidbody>();
            m_Animator = GetComponent<Animator>();
            m_DistToGround = GetComponent<Collider>().bounds.extents.y;
        }


        // Update is called once per frame
        void Update()
        {
            UpdateMovement();
            //UpdateGravity();
            UpdateView();
            animSpeed = animSpeed * 0.99f;
            m_Animator.SetFloat("speed", animSpeed * Time.deltaTime);
        }
        
        bool IsGrounded()
        {
            return Physics.Raycast(transform.position, -Vector3.up, m_DistToGround + 5f);
        }
        
        private void UpdateView()
        {
            //m_Rigidbody.MoveRotation(Quaternion.Euler(0, m_HorizontalAngle, 0));
        }

        private void UpdateMovement()
        {
            if (!IsGrounded())
            {
                return;
            }

            if (Input.GetButton("Horizontal") && Input.GetAxisRaw("Horizontal") > 0)
            {
                // Move to the right
                print("right");
                m_HorizontalAngle = 2;
            }

            if (Input.GetButton("Horizontal") && Input.GetAxisRaw("Horizontal") < 0)
            {
                // Move to the left
                print("left");
                m_HorizontalAngle -= 2;
            }

            if (Input.GetButton("Vertical") && Input.GetAxisRaw("Vertical") > 0)
            {
                // Move up
                print("up");
                animSpeed += speed * 5;
            }

            if (Input.GetButton("Vertical") && Input.GetAxisRaw("Vertical") < 0)
            {
                // Move down
                print("down");
                animSpeed -= speed * 5;
            }
        }

        void UpdateGravity()
        {
            if (IsGrounded() && Input.GetButtonDown("Jump"))
            {
                m_Rigidbody.AddForce(m_Rigidbody.velocity + Physics.gravity * 2, ForceMode.Impulse);
            }
        }
    }
}