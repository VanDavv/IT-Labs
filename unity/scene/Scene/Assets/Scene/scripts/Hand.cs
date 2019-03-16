using JetBrains.Annotations;
using UnityEngine;

namespace Scene.scripts
{
    public class Hand : MonoBehaviour
    {
        [CanBeNull] public Pickable picked;
        private int cooldown = 0;
        private void OnTriggerStay(Collider other)
        {
            if (picked != null || cooldown > 0)
            {
                return;
            }
            Pickable pickable = other.gameObject.GetComponent(typeof(Pickable)) as Pickable;
            if (pickable != null)
            {
                picked = pickable;
                pickable.pick(gameObject);
            }
        }

        void Update()
        {
            if (cooldown > 0)
            {
                cooldown--;
            }
            if (Input.GetKey(KeyCode.Minus))
            {
                DropItem();
            }    
        }

        private void DropItem()
        {
            picked.drop();
            picked = null;
            cooldown = 200;
        }
    }
}