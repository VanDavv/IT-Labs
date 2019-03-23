using UnityEngine;

namespace Scene.scripts
{
    public class Pickable : MonoBehaviour
    {
        private Collider m_Collider;

        private void Start()
        {
            m_Collider = GetComponent<Collider>();
        }

        public void pick(GameObject parent)
        {
            m_Collider.enabled = false;
            gameObject.transform.position = parent.transform.position + new Vector3(0, 1, 0);
            gameObject.transform.rotation = parent.transform.rotation;
            gameObject.transform.parent = parent.transform;
        }

        public void drop()
        {
            gameObject.transform.position += new Vector3(0, -1, 0);
            m_Collider.enabled = true;
            gameObject.transform.parent = null;
        }
    }
}