using Godot;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Godot;
namespace ProjectJellyfish2023
{
    class BulletData
    {
        public float rotation;
        public Vector2 position;
    }
    interface BulletProvider
    {
        Bullet BulletFunction(Vector2 playerPos, float timePassed);
    }
    
    class Bullet : Node
    {
        //public BulletData data;
        public Vector2 position;
        public BulletProvider callable; // make true delegate not tasks
        float counter = 0;
        public void sample()
        {
            // callable = new Task(() => { GD.Print("hi"); });

        }
        public override void _Process(float delta)
        {
            base._Process(delta);
            counter += delta;
            callable.BulletFunction(position, counter);
            
        }
    }

}
