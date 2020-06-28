using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Authentication.ExtendedProtection;
using UnityEditor;
using UnityEngine;
using UnityEngine.UIElements;

public class CameraController : MonoBehaviour
{

    public float Step = 1;
    public float Speed = 0.1f;

    private Vector3 start;
    private Vector3 target;
    private bool moving;
    private float t = 0;

    // Update is called once per frame
    void Update()
    {
        if (moving) {
            t += Speed;

            transform.position = Vector3.Lerp(start, target, Mix(0.5f, t));
            if (t >= 1) {
                moving = false;
                t = 0;
            }
        }
        else {
            if (Input.GetAxis("Horizontal") > 0) {
                start = transform.position;
                target = transform.position + new Vector3(Step, 0, 0);
                moving = true;
                t = 0;
            } else if (Input.GetAxis("Horizontal") < 0) { 
                start = transform.position;
                target = transform.position + new Vector3(-Step, 0, 0);
                moving = true;
                t = 0;
            }

        }
    }

    float SmoothStart2(float t) {
        return t * t;
    }

    float SmoothStop2(float t) {
        return 1 - ((1 - t) * (1 - t));
    }

    float Mix(float weightB, float t) {
        float a = SmoothStart2(t);
        float b = SmoothStop2(t);
        return a + weightB * (b - a);
    }
}
