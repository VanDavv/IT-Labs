using UnityEngine;

namespace Scene.scripts
{
    public class FPSCustom2 : MonoBehaviour
    {
        private CharacterController m_Controller;
        private Rigidbody m_Rigidbody;
        private Camera m_Camera;
        public Camera transitionCamera;
        private float m_DistToGround;
        private const float MovementForce = 1;
        private float m_HorizontalAngle = 0;
        private float m_VerticalAngle = 0;
        public bool manual;

        private void Start()
        {
            m_Controller = GetComponent<CharacterController>();
            m_Rigidbody = GetComponent<Rigidbody>();
            m_DistToGround = GetComponent<Collider>().bounds.extents.y;
            m_Camera = GetComponent<Camera>();
        }
        
        bool IsGrounded()
        {
            return Physics.Raycast(transform.position, -Vector3.up, m_DistToGround + 0.4f);
        }


        // Update is called once per frame
        void Update()
        {
            UpdateMovement();
            UpdateView();
        }

        private void UpdateView()
        {
            if (!manual)
            {
                m_Rigidbody.MoveRotation(Quaternion.Euler(m_VerticalAngle, m_HorizontalAngle, 0));
            }
        }
        private void UpdateMovement()
        {
            if (!IsGrounded() || !m_Camera.enabled)
            {
                return;
            }

            if (Input.GetButton("Horizontal") && Input.GetAxisRaw("Horizontal") > 0)
            {
                // Move to the right
                print("right");
                m_HorizontalAngle += 2;
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
                var dir = transform.forward * MovementForce;
                m_Rigidbody.AddForce(dir, ForceMode.VelocityChange);
            }

            if (Input.GetButton("Vertical") && Input.GetAxisRaw("Vertical") < 0)
            {
                // Move down
                print("down");
                var dir = -transform.forward * MovementForce;
                m_Rigidbody.AddForce(dir, ForceMode.VelocityChange);
            }
            if (Input.GetKey(KeyCode.Q))
            {
                m_VerticalAngle -= 2;
            }

            if (Input.GetKey(KeyCode.E))
            {
                m_VerticalAngle += 2;
            }

            if (Input.GetKey(KeyCode.C))
            {
                m_Camera.enabled = false;
                transitionCamera.enabled = true;
            }
            
            if (IsGrounded() && Input.GetButtonDown("Jump"))
            {
                m_Rigidbody.AddForce(m_Rigidbody.velocity + Physics.gravity * 2, ForceMode.Impulse);
            }
        }
    }
}