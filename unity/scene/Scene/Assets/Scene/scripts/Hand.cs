using JetBrains.Annotations;
using UnityEngine;

namespace Scene.scripts
{
    public class Hand : MonoBehaviour
    {
        [CanBeNull] public Pickable picked;
        private int m_PickupCooldown = 0;
        private void OnTriggerStay(Collider other)
        {
            if (picked != null || m_PickupCooldown > 0)
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
            if (m_PickupCooldown > 0)
            {
                m_PickupCooldown--;
            }
            if (Input.GetKey(KeyCode.Minus))
            {
                DropItem();
            }   
            if (Input.GetKey(KeyCode.F))
            {
                var weapon = picked as Weapon;
                if (weapon != null)
                {
                    weapon.fire();
                }
            }    
        }

        private void DropItem()
        {
            picked.drop();
            picked = null;
            m_PickupCooldown = 200;
        }
    }
}