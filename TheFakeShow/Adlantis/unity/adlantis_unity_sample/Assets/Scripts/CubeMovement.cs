//
// AdLantis Sample
// CubeMovement
//
// Copyright 2011 Atlantis, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

using UnityEngine;
using System.Collections;

public class CubeMovement : MonoBehaviour {

  public float speed = 25;

	// Use this for initialization
	void Start () {
	
	}
	
	public float smooth = 2.0F;
  public float tiltAngle = 30.0F;
	
	// Update is called once per frame
	void Update () {
    float tiltAroundX = -Input.GetAxis("Mouse Y") * tiltAngle;
	  float tiltAroundY = -Input.GetAxis("Mouse X") * tiltAngle;
	  float tiltAroundZ = 0;

    Quaternion target = Quaternion.Euler(tiltAroundX, tiltAroundY, tiltAroundZ);
    transform.rotation = Quaternion.Slerp(transform.rotation, target, Time.deltaTime * smooth);
	}
	
}
