using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerCollisionScript : MonoBehaviour
{
    [SerializeField] private Rigidbody2D rb;
    [SerializeField] private GameObject diamond;
    private void OnCollisionEnter2D(Collision2D other)
    {

        if (other.gameObject.tag == "collectable")
        {
            if (rb.velocity.y > .1f)
            {
                Debug.Log("collectable");
                // Vector2 position = new Vector2(other.transform.position.x, other.transform.position.y + 1);
                Instantiate(diamond, other.transform.position, Quaternion.identity);
                Destroy(other.gameObject);
            }
        }

    }
}
