using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LunarConsolePluginInternal
{
    struct ConsoleLogEntry
    {
        public readonly string message;
        public readonly string stackTrace;
        public readonly LogType type;
        public float top;
        public float height;

        public ConsoleLogEntry(string message, string stackTrace, LogType type)
        {
            this.message = message;
            this.stackTrace = stackTrace;
            this.type = type;
            this.top = 0.0f;
            this.height = 0.0f;
        }

        public float bottom
        {
            get { return top + height; }
        }
    }



    class Console
    {
        private readonly CCycleArray<ConsoleLogEntry> m_entries;
        private IConsoleDelegate m_consoleDelegate;

        public Console(int capacity)
        {
            m_entries = new CCycleArray<ConsoleLogEntry>(capacity);
        }

        public void LogMessage(string message, string stackTrace, LogType type)
        {
            m_entries.Add(new ConsoleLogEntry(message, stackTrace, type));
            if (m_consoleDelegate != null)
            {
                m_entries.One(OnEntryAdded, m_entries.Length - 1);
            }
        }

        private void OnEntryAdded(ref ConsoleLogEntry entry, int index)
        {
            m_consoleDelegate.OnAddEntry(this, ref entry);
        }

        public CCycleArray<ConsoleLogEntry> entries
        {
            get { return m_entries; }
        }

        public IConsoleDelegate consoleDelegate
        {
            get { return m_consoleDelegate; }
            set { m_consoleDelegate = value; }
        }
    }

    interface IConsoleDelegate
    {
        void OnAddEntry(Console console, ref ConsoleLogEntry entry);
    }
}