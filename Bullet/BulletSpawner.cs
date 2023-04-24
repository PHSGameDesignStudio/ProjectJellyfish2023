using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Collections;
using System.Collections.Generic;
using Godot;


public class BulletSpawner : Node
{
    public PackedScene bulletResource;
    public float minRotation;
    public float maxRotation;
    public int numberOfBullets;
    public bool isRandom;
    public bool useOnlyVelocity;
    public bool isParent;
    public float cooldown;
    float timer;
    public float bulletSpeed;
    public Vector2 bulletVelocity;


    float[] rotations;
    void Start()
    {
        timer = cooldown;
        rotations = new float[numberOfBullets];
    }

    // Update is called once per frame
    public override void _Process(float delta)
    {
        if (timer <= 0)
        {
            SpawnBullets();
            timer = cooldown;
        }
        timer -= delta;
    }

    // Select a random rotation from min to max for each bullet
    public float[] RandomRotations()
    {
        for (int i = 0; i < numberOfBullets; i++)
        {
            rotations[i] = Random.Range(minRotation, maxRotation);
        }
        return rotations;

    }

    // This will set random rotations evenly distributed between the min and max Rotation.
    public float[] DistributedRotations()
    {
        if (numberOfBullets == 1)
        {
            rotations[0] = (minRotation + maxRotation) / 2;
            return rotations;
        }
        for (int i = 0; i < numberOfBullets; i++)
        {
            var fraction = (float)i / ((float)numberOfBullets - 1);
            var difference = maxRotation - minRotation;
            var fractionOfDifference = fraction * difference;
            rotations[i] = fractionOfDifference + minRotation; // We add minRotation to undo Difference
        }
        foreach (var r in rotations) print(r);
        return rotations;
    }
    public GameObject[] SpawnBullets()
    {
        if (isRandom)
        {
            // This is in Update because we want a random rotation for each bullet each time
            RandomRotations();
        }
        else
        {
            DistributedRotations();
        }

        // Spawn Bullets
        GameObject[] spawnedBullets = new GameObject[numberOfBullets];
        for (int i = 0; i < numberOfBullets; i++)
        {
            spawnedBullets[i] = Instantiate(bulletResource, transform);
            var b = spawnedBullets[i].GetComponent<Bullet>();
            b.rotation = rotations[i];
            b.speed = bulletSpeed;
            if (useOnlyVelocity)
            {
                b.velocity = new Vector2(Mathf.Cos(rotations[i] * Mathf.Deg2Rad), Mathf.Sin(rotations[i] * Mathf.Deg2Rad));
                b.useOnlyVelocity = true;
            }
            else
            {
                b.velocity = bulletVelocity;
                b.useOnlyVelocity = false;
            }

            if (!isParent) spawnedBullets[i].transform.parent = null;




        }
        return spawnedBullets;
    }
}

