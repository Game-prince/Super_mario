using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerMovements : MonoBehaviour
{
    private Rigidbody2D rb;
    private Animator anim;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        float moveX = Input.GetAxisRaw("Horizontal");
        rb.velocity = new Vector2(moveX * 5, rb.velocity.y);

        if (moveX != 0) 
        {
            anim.SetFloat("speed", 0.5f);

            if (moveX > 0) transform.eulerAngles = new Vector3(0, 0, 0);
            else transform.eulerAngles = new Vector3(0, 180, 0);
        }
        else anim.SetFloat("speed", 0f);

        if (Input.GetButtonDown("Jump"))
        {
            rb.velocity = new Vector2(rb.velocity.x, 16);
            anim.SetBool("isJumping", true);
        }
        else anim.SetBool("isJumping", false);
    }
}
