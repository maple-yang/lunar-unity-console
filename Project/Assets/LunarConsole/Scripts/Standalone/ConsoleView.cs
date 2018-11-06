using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LunarConsolePluginInternal
{
    static class Colors
    {
        public const uint cell_background_light = 0x3c3c3c;
        public const uint cell_background_dark = 0x373737;
    }

    static class Sizes
    {
        public const int cell_font_size = 24;
    }

    static class Styles
    {
        private static GUIStyle m_logMessage1;
        private static GUIStyle m_logMessage2;

        public static GUIStyle logMessage1
        {
            get
            {
                if (m_logMessage1 == null)
                {
                    m_logMessage1 = CreateLogMessageStyle(Colors.cell_background_dark);
                }
                return m_logMessage1;
            }
        }

        public static GUIStyle logMessage2
        {
            get
            {
                if (m_logMessage2 == null)
                {
                    m_logMessage2 = CreateLogMessageStyle(Colors.cell_background_light);
                }
                return m_logMessage2;
            }
        }

        private static GUIStyle CreateLogMessageStyle(uint color)
        {
            var style = new GUIStyle(GUI.skin.label);
            style.normal.background = GUIHelper.Create1x1ColorTexture(color);
            style.fontSize = Sizes.cell_font_size;
            style.alignment = TextAnchor.MiddleLeft;
            style.padding = new RectOffset(10, 10, 10, 10);
            style.wordWrap = false;
            return style;
        }
    }

    class ConsoleView : MonoBehaviour, IConsoleDelegate
    {
        private Console m_console;

        // Use this for initialization
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {

        }

        private Vector2 m_scrollPosition = Vector2.zero;
        private Rect m_guiRect;
        private Rect m_viewRect = Rect.zero;
        private bool m_viewRectDirty = true;
        private bool m_showHorScroll;
        private bool m_showVerScroll;

        void OnGUI()
        {
            m_guiRect = new Rect(0, 0, Screen.width, 0.5f * Screen.height);

            UpdateViewRect();

            m_scrollPosition = GUI.BeginScrollView(m_guiRect, m_scrollPosition, m_viewRect, m_showHorScroll, m_showVerScroll);
            {
                m_console.entries.Each(OnConsoleLogEntryGUI);
            }
            GUI.EndScrollView();
        }

        private void OnConsoleLogEntryGUI(ref ConsoleLogEntry entry, int index)
        {
            var content = new GUIContent(entry.message);
            var style = index % 2 == 0 ? Styles.logMessage1 : Styles.logMessage2;
            var width = m_viewRect.width;
            GUI.Label(new Rect(new Vector2(0, entry.top), new Vector2(width, entry.height)), content, style);
        }

        private void UpdateViewRect()
        {
            if (m_viewRectDirty)
            {
                m_viewRect.width = 0.0f;
                m_viewRect.height = 0.0f;
                m_console.entries.Each(OnUpdateConsoleLogEntry);
                UpdateScrollBars();
                m_viewRectDirty = false;
            }
        }

        private void UpdateScrollBars()
        {
            m_showHorScroll = m_viewRect.width - m_guiRect.width > Mathf.Epsilon;
            m_showVerScroll = m_viewRect.height - m_guiRect.height > Mathf.Epsilon;
        }

        private void OnUpdateConsoleLogEntry(ref ConsoleLogEntry entry, int index)
        {
            var content = new GUIContent(entry.message);
            var style = index % 2 == 0 ? Styles.logMessage1 : Styles.logMessage2;
            var size = style.CalcSize(content);
            entry.top = m_viewRect.height;
            entry.height = size.y;
            m_viewRect.width = Mathf.Max(m_viewRect.width, size.x);
            m_viewRect.height = entry.bottom;
        }

        #region IConsoleDelegate

        public void OnAddEntry(Console console, ref ConsoleLogEntry entry)
        {
            OnUpdateConsoleLogEntry(ref entry, console.entries.Length - 1);
        }

        #endregion

        internal Console console
        {
            get { return m_console; }
            set
            {
                m_console = value;
                m_console.consoleDelegate = this;
            }
        }
    }

    static class GUIHelper
    {
        public static Texture2D Create1x1ColorTexture(uint color)
        {
            return Create1x1ColorTexture(FromRGBA(color));
        }

        public static Texture2D Create1x1ColorTexture(Color color)
        {
            Texture2D texture = new Texture2D(1, 1);
            texture.SetPixel(0, 0, color);
            texture.Apply();
            return texture;
        }

        public static Color FromRGBA(uint color)
        {
            uint r = (color >> 16) & 0xff;
            uint g = (color >> 8) & 0xff;
            uint b = color & 0xff;
            return new Color(r / 255.0f, g / 255.0f, b / 255.0f);
        }
    }
}
