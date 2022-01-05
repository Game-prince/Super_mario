using System.Collections;
using UnityEngine;

public class playerscript : MonoBehaviour
{
    Rigidbody2D rb;
    public float playerForce = 3000f;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        playerForce *= Time.deltaTime;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        
        if (Input.GetKeyDown("right"))
        {
            rb.AddForce(new Vector2(playerForce, 0));
        }
        if (Input.GetKeyUp("right")) rb.AddForce(new Vector2(-playerForce, 0));

        if (Input.GetKeyDown("left"))
        {
            rb.AddForce(new Vector2(-playerForce, 0));
        }
        if (Input.GetKeyUp("left")) rb.AddForce(new Vector2(playerForce, 0));
    }
}
