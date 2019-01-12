using System;
using UnityEngine;

public class Rotable2 : MonoBehaviour {
	public float rotationSpeed = 0;
	public Vector3 rotationDistance = new Vector3(0, 0, 0);
	public Vector3 rotationScale = new Vector3(1, 1, 1);
	public bool rotateObject = false;
	public Rotable2 centralObject;
	private float alpha = 0;

	public Matrix3D GetRotationMatrix()
	{
		var centralMat = Matrix3D.Identity;
		var translateMat = Matrix3D.Translate(rotationDistance);
		if (centralObject)
		{
			centralMat = centralObject.GetRotationMatrix();
		}

		var scaleMat = Matrix3D.Scale(rotationScale);
		alpha += rotationSpeed * Time.deltaTime;
		var rotMat = Matrix3D.RotateY(alpha);

		return centralMat * rotMat * translateMat;
	}
	
	// Update is called once per frame
	private void Update ()
	{
		var rotationMat = GetRotationMatrix();
		transform.position = rotationMat * new Vector3(0, 0, 1);
	}
}
