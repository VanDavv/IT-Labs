using UnityEngine;


namespace Scene.scripts
{
    [RequireComponent(typeof(AudioSource))]
    public class Weapon : Pickable
    {
        public AudioSource audioData;
        public GameObject bullet;
        public int fireDelay = 50;
        public int bulletForce = 10;
        private int fireDelayCounter = 0;

        void Start()
        {
            audioData = GetComponent<AudioSource>();
        }
        public void fire()
        {
            if (fireDelayCounter == 0)
            {
                var clone = Instantiate(bullet, transform.position + Vector3.forward, transform.rotation);
                clone.gameObject.SetActive(true);
                var rigidbody = clone.GetComponent(typeof(Rigidbody)) as Rigidbody;
                rigidbody.constraints = RigidbodyConstraints.None;
                rigidbody.velocity = transform.TransformDirection(Vector3.forward * bulletForce);
                audioData.Play(0);
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