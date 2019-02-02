using UnityEngine;

namespace Scene.scripts
{
    public class FPSCustom : MonoBehaviour
    {
        private CharacterController m_Controller;
        private Rigidbody m_Rigidbody;
        private Vector3 movement;
        private const float speed = 0.25f;

        private void Start()
        {
            m_Controller = GetComponent<CharacterController>();
            m_Rigidbody = GetComponent<Rigidbody>();
        }


        // Update is called once per frame
        void Update()
        {
            movement = m_Controller.velocity;
            UpdateMovement();
            UpdateGravity();
            movement = movement * 0.95f;
            m_Controller.Move(movement * Time.deltaTime);
        }


        private void UpdateMovement()
        {
            if (!m_Controller.isGrounded)
            {
                return;
            }

            if (Input.GetButton("Horizontal") && Input.GetAxisRaw("Horizontal") > 0)
            {
                // Move to the right
                print("right");
                movement += new Vector3(speed, 0, 0);
            }

            if (Input.GetButton("Horizontal") && Input.GetAxisRaw("Horizontal") < 0)
            {
                // Move to the left
                print("left");
                movement += new Vector3(-speed, 0, 0);
            }

            if (Input.GetButton("Vertical") && Input.GetAxisRaw("Vertical") > 0)
            {
                // Move up
                print("up");
                movement += new Vector3(0, 0, speed);
            }

            if (Input.GetButton("Vertical") && Input.GetAxisRaw("Vertical") < 0)
            {
                // Move down
                print("down");
                movement += new Vector3(0, 0, -speed);
            }
        }

        void UpdateGravity()
        {
            movement += Physics.gravity * 2 * Time.deltaTime;
            if (m_Controller.isGrounded && Input.GetButtonDown("Jump"))
            {
                movement -= Physics.gravity;
            }
        }
    }
}