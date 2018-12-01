using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotable : MonoBehaviour {
	public float rotationSpeed = 1;
	public bool rotateObject = false;
	public Rotable centralObject;
	
	// Update is called once per frame
	void Update () {
		if (rotateObject)
		{
			if (centralObject.rotateObject)
				transform.RotateAround(centralObject.centralObject.transform.position, Vector3.up, rotationSpeed * Time.deltaTime);
			transform.RotateAround(centralObject.transform.position, Vector3.up, rotationSpeed * Time.deltaTime);
		}
	}
}
