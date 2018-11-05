using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LunarConsolePluginInternal
{
    internal interface ICFastList
    {
    }

    class CFastList<T> : ICFastList where T : CFastListNode
    {
        internal CFastListNode m_listFirst;
        internal CFastListNode m_listLast;

        private int m_size;

        public void AddFirstItem(T item)
        {
            InsertItem(item, null, m_listFirst);
        }

        public void AddLastItem(T item)
        {
            InsertItem(item, m_listLast, null);
        }

        public void InsertBeforeItem(T node, T item)
        {
            InsertItem(item, node != null ? node.m_listPrev : null, node);
        }

        public void InsertAfterItem(T node, T item)
        {
            InsertItem(item, node, node != null ? node.m_listNext : null);
        }

        public virtual void RemoveItem(T item)
        {
            // CAssert.Greater(m_size, 0);
            // CAssert.AreSame(this, item.m_list);

            CFastListNode prev = item.m_listPrev;
            CFastListNode next = item.m_listNext;

            if (prev != null)
            {
                prev.m_listNext = next;
            }
            else
            {
                m_listFirst = next;
            }

            if (next != null)
            {
                next.m_listPrev = prev;
            }
            else
            {
                m_listLast = prev;
            }

            item.m_listNext = item.m_listPrev = null;
            item.m_list = null;
            --m_size;
        }

        public virtual T RemoveFirstItem()
        {
            T node = ListFirst;
            if (node != null)
            {
                RemoveItem(node);
            }

            return node;
        }

        public virtual T RemoveLastItem()
        {
            T node = ListLast;
            if (node != null)
            {
                RemoveItem(node);
            }

            return node;
        }

        public virtual bool ContainsItem(CFastListNode item)
        {
            if (item.m_list != this)
            {
                return false;
            }

            for (CFastListNode t = m_listFirst; t != null; t = t.m_listNext)
            {
                if (t == item)
                {
                    return true;
                }
            }

            return false;
        }

        protected virtual void InsertItem(CFastListNode item, CFastListNode prev, CFastListNode next)
        {
            // CAssert.IsNull(item.m_list);

            if (next != null)
            {
                next.m_listPrev = item;
            }
            else
            {
                m_listLast = item;
            }

            if (prev != null)
            {
                prev.m_listNext = item;
            }
            else
            {
                m_listFirst = item;
            }

            item.m_listPrev = prev;
            item.m_listNext = next;
            item.m_list = this;
            ++m_size;
        }

        public virtual void Clear()
        {
            for (CFastListNode t = m_listFirst; t != null;)
            {
                CFastListNode next = t.m_listNext;
                t.m_listPrev = t.m_listNext = null;
                t.m_list = null;
                t = next;
            }

            m_listFirst = m_listLast = null;
            m_size = 0;
        }

        public int Count
        {
            get { return m_size; }
        }

        public T ListFirst
        {
            get { return (T)m_listFirst; }
            protected set { m_listFirst = value; }
        }

        public T ListLast
        {
            get { return (T)m_listLast; }
            protected set { m_listLast = value; }
        }
    }

    class CFastListNode
    {
        internal CFastListNode m_listPrev;
        internal CFastListNode m_listNext;
        internal ICFastList m_list;

        protected CFastListNode ListNodePrev
        {
            get { return m_listPrev; }
        }

        protected CFastListNode ListNodeNext
        {
            get { return m_listNext; }
        }

#if LUNAR_DEVELOPMENT

        /* For Unit testing */
        public void DetachFromList()
        {
            m_list = null;
            m_listPrev = m_listNext = null;
        }

#endif // LUNAR_DEVELOPMENT
    }

    class CFastListNode<T> : CFastListNode where T : CFastListNode
    {
        public new T ListNodePrev
        {
            get { return (T)m_listPrev; }
        }

        public new T ListNodeNext
        {
            get { return (T)m_listNext; }
        }
    }
}