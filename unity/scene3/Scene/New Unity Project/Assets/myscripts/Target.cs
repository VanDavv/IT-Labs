using UnityEngine;

namespace Scene.scripts
{
    public class Target : MonoBehaviour
    {
        public int hp = 100;
        
        private void OnTriggerEnter(Collider other)
        {
            Bullet bullet = other.gameObject.GetComponent(typeof(Bullet)) as Bullet;
            if (bullet != null)
            {
                hp -= bullet.damage;
                if (hp < 0)
                {
                    print("destroyed");
                    Destroy(gameObject, 1f);
                }
            }
        }
    }
}