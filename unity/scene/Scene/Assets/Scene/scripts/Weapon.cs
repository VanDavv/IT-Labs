using UnityEngine;

namespace Scene.scripts
{
    public class Weapon : Pickable
    {
        public GameObject bullet;
        public int fireDelay = 50;
        private int fireDelayCounter = 0;
        public void fire()
        {
            if (fireDelayCounter == 0)
            {
                var clone = Instantiate(bullet, transform.position + Vector3.forward, transform.rotation);
                var rigidbody = clone.GetComponent(typeof(Rigidbody)) as Rigidbody;
                rigidbody.constraints = RigidbodyConstraints.None;
                rigidbody.velocity = transform.TransformDirection(Vector3.forward * 10);
                fireDelayCounter = fireDelay;
            }
        }

        public void Update()
        {
            if (fireDelayCounter > 0)
            {
                fireDelayCounter--;
            }
        }
    }
}