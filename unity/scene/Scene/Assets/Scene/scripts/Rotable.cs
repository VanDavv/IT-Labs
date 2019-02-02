using System;
using UnityEngine;

public class Rotable : MonoBehaviour {
	public float rotationSpeed = 0;
	public float angle = 0;
	public Vector3 rotationDistance = new Vector3(0, 0, 0);
	public Vector3 rotationScale = new Vector3(1, 1, 1);
	public bool rotateObject = false;
	public Rotable centralObject;
	private float alpha = 0;

	public Matrix4x4 GetRotationMatrix()
	{
		var centralMat = Matrix4x4.identity;
		var translateMat = Matrix4x4.Translate(rotationDistance);
		if (centralObject)
		{
			centralMat = centralObject.GetRotationMatrix();
		}

		var scaleMat = Matrix4x4.Scale(rotationScale);
		alpha += rotationSpeed * Time.deltaTime;
		var rotMat = Matrix4x4.Rotate(Quaternion.Euler(30, alpha, 0));

		var rotationMatrix = rotMat * translateMat;
		rotationMatrix = centralMat * rotationMatrix;
		//var rotationMatrix = translateMat;
		return rotationMatrix;
	}
	
	// Update is called once per frame
	private void Update ()
	{
		var rotationMat = GetRotationMatrix();
		transform.position = rotationMat * new Vector4(0, 0, 0, 1);
	}
}
