using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class playerCollisionScript : MonoBehaviour
{
    [SerializeField] private Rigidbody2D rb;
    [SerializeField] private GameObject diamond;
    [SerializeField] private Text scoreText;
    private int score = 0;


    private void OnCollisionEnter2D(Collision2D other)
    {

        if (other.gameObject.tag == "Box")
        {
            if (other.gameObject.transform.position.y > transform.position.y)
            {
                Vector2 position = new Vector2(other.transform.position.x, other.transform.position.y + 1);
                Instantiate(diamond, position, Quaternion.identity);
            }
        }

    }

    private void OnTriggerEnter2D(Collider2D other) {
        if (other.gameObject.tag == "collectable")
        {
            Destroy(other.gameObject);
            score++;
            scoreText.text = "Score: " + score;
        }
    }
}
