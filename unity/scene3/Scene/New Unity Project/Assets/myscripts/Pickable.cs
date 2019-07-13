using UnityEngine;

namespace Scene.scripts
{
    public class Pickable : MonoBehaviour
    {
        public Collider collider;
        public Sprite sprite;
        public string[] labels;


        public void pick(GameObject parent)
        {
            collider.enabled = false;
            gameObject.transform.position = parent.transform.position + new Vector3(0, 1, 0);
            gameObject.transform.rotation = parent.transform.rotation;
            gameObject.transform.parent = parent.transform;
            for (int a = 0; a < transform.childCount; a++)
            {
                transform.GetChild(a).gameObject.SetActive(false);
            }
        }

        public void drop()
        {
            gameObject.transform.position += new Vector3(0, -1, 0);
            collider.enabled = true;
            gameObject.transform.parent = null;
            for (int a = 0; a < transform.childCount; a++)
            {
                transform.GetChild(a).gameObject.SetActive(true);
            }
        }
    }
}