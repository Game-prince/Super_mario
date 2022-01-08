using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerscript : MonoBehaviour
{
    private Animator anim;

    private void Start()
    {
        anim = GetComponent<Animator>();
    }

    void Update()
    {
        float forward = Input.GetAxis("Horizontal"), upward = Input.GetAxis("Vertical");
    }
}
