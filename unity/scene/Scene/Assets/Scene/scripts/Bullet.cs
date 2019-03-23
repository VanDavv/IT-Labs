using UnityEngine;

namespace Scene.scripts
{
    public class Bullet : MonoBehaviour
    {
        private Collider m_Collider;
        public int damage = 1;
        
        void OnCollisionEnter(Collision otherObj) {
            if (otherObj.gameObject.CompareTag("terrain")) {
                Destroy(gameObject,.25f);
            }
        }

        private void Start()
        {
            m_Collider = GetComponent<Collider>();
        }
    }
}