using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameraMovement : MonoBehaviour
{

    [SerializeField] private Transform player;

    // Update is called once per frame
    void Update()
    {
        if (player.position.x >= 0)
        {
            transform.position = new Vector3(player.position.x, 0, -10);
        }
    }
}
