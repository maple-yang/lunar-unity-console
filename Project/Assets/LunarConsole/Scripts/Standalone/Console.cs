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

        public ConsoleLogEntry(string message, string stackTrace, LogType type)
        {
            this.message = message;
            this.stackTrace = stackTrace;
            this.type = type;
        }
    }

    class ConsoleLogEntryList : IEnumerable<ConsoleLogEntry>
    {
        private readonly List<ConsoleLogEntry> m_entries = new List<ConsoleLogEntry>();

        public void Add(ConsoleLogEntry entry)
        {
            m_entries.Add(entry);
        }

        public IEnumerator<ConsoleLogEntry> GetEnumerator()
        {
            return m_entries.GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return m_entries.GetEnumerator();
        }

        public List<ConsoleLogEntry> entries
        {
            get { return m_entries; }
        }
    }

    class Console
    {
        private readonly ConsoleLogEntryList m_entries = new ConsoleLogEntryList();

        public void LogMessage(string message, string stackTrace, LogType type)
        {
            m_entries.Add(new ConsoleLogEntry(message, stackTrace, type));
        }

        public ConsoleLogEntryList entries
        {
            get { return m_entries; }
        }
    }

    interface IConsoleDelegate
    {
        void OnAddEntry(Console console, ConsoleLogEntry entry);
    }
}