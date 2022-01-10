using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerMovements : MonoBehaviour
{
    private Rigidbody2D rb;
    private Animator anim;

    private enum movementState {idle, running, jumping, falling};

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {

        movementState currentState;
        float moveX = Input.GetAxisRaw("Horizontal");
        rb.velocity = new Vector2(moveX * 5, rb.velocity.y);

        if (moveX != 0) 
        {
            currentState = movementState.running;

            if (moveX > 0) transform.eulerAngles = new Vector3(0, 0, 0);
            else transform.eulerAngles = new Vector3(0, 180, 0);
        }
        else currentState = movementState.idle;

        if (Input.GetButtonDown("Jump"))
        {
            if (!(rb.velocity.y > .1f || rb.velocity.y < -.1f)) rb.velocity = new Vector2(rb.velocity.x, 14);
        }

        if (rb.velocity.y > .1f) currentState = movementState.jumping;
        else if (rb.velocity.y < -.1f) currentState = movementState.falling;

        anim.SetInteger("currentState", (int)currentState);
    }

}
