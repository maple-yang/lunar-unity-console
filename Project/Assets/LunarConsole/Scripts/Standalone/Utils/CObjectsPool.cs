using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LunarConsolePluginInternal
{
    interface ICObjectsPool
    {
        void Recycle(CObjectsPoolEntry entry);
    }

    class CObjectsPool<T> : CFastList<CObjectsPoolEntry>, ICObjectsPool, ICDestroyable
        where T : CObjectsPoolEntry, new()
    {
        public CObjectsPool()
        {
        }

        public virtual T NextObject()
        {
            CObjectsPoolEntry first = RemoveFirstItem();
            if (first == null)
            {
                first = CreateObject();
            }

            first.pool = this;
            first.recycled = false;

            return (T)first;
        }

        public virtual void Recycle(CObjectsPoolEntry e)
        {
            // CAssert.IsInstanceOfType<T>(e);
            // CAssert.AreSame(this, e.pool);

            AddLastItem(e);
        }

        protected virtual T CreateObject()
        {
            return new T();
        }

        //////////////////////////////////////////////////////////////////////////////

        #region Destroyable

        public virtual void Destroy()
        {
            Clear();
        }

        #endregion
    }

    class CObjectsPoolConcurrent<T> : CObjectsPool<T>
        where T : CObjectsPoolEntry, new()
    {
        public override T NextObject()
        {
            lock (this)
            {
                return base.NextObject();
            }
        }

        public override void Recycle(CObjectsPoolEntry e)
        {
            lock (this)
            {
                base.Recycle(e);
            }
        }

        public override void Destroy()
        {
            lock (this)
            {
                base.Destroy();
            }
        }
    }

    class CObjectsPoolEntry : CFastListNode
    {
        internal ICObjectsPool pool;
        internal bool recycled;

        public void Recycle()
        {
            if (pool != null)
            {
                // CAssert.IsFalse(recycled);
                recycled = true;

                pool.Recycle(this);
            }

            OnRecycleObject();
        }

        protected virtual void OnRecycleObject()
        {
        }
    }
}