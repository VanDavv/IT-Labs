using UnityEngine;

namespace Scene.scripts
{
    public class PathMovement : MonoBehaviour
    {
        // put the points from unity interface
        public Transform[] wayPointList;
 
        public int currentWayPoint = 0;
        private Transform m_TargetWayPoint;
 
        public float speed = 10f;
 
        // Use this for initialization
        void Start () {
 
        }
     
        // Update is called once per frame
        void Update () {
            // check if we have somewere to walk
            if(currentWayPoint < this.wayPointList.Length)
            {
                if(m_TargetWayPoint == null)
                    m_TargetWayPoint = wayPointList[currentWayPoint];
                walk();
            }
            else
            {
                currentWayPoint = 0;
                m_TargetWayPoint = wayPointList[currentWayPoint];
            }
        }
 
        void walk(){
            // rotate towards the target
            transform.forward = Vector3.RotateTowards(transform.forward, m_TargetWayPoint.position - transform.position, speed*Time.deltaTime, 0.0f);
 
            // move towards the target
            transform.position = Vector3.MoveTowards(transform.position, m_TargetWayPoint.position,   speed*Time.deltaTime);
 
            if(transform.position == m_TargetWayPoint.position)
            {
                currentWayPoint ++ ;
                m_TargetWayPoint = wayPointList[currentWayPoint];
            }
        } 
    }
}