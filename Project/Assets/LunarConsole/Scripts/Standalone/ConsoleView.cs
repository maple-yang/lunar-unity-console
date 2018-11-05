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
                    m_logMessage1 = GUIHelper.SetBackgroundColor(new GUIStyle(GUI.skin.label), Colors.cell_background_dark);
                    m_logMessage1.fontSize = Sizes.cell_font_size;
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
                    m_logMessage2 = GUIHelper.SetBackgroundColor(new GUIStyle(GUI.skin.label), Colors.cell_background_light);
                    m_logMessage2.fontSize = Sizes.cell_font_size;
                }
                return m_logMessage2;
            }
        }
    }

    class ConsoleView : MonoBehaviour
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

        void OnGUI()
        {
            var guiRect = new Rect(0, 0, Screen.width, 0.5f * Screen.height);
            GUI.BeginGroup(guiRect);
            {
                // GUI.Box(guiRect, GUIContent.none, GUI.skin.box);

                var index = 0;
                foreach (ConsoleLogEntry entry in m_console.entries)
                {
                    var style = index % 2 == 0 ? Styles.logMessage1 : Styles.logMessage2;
                    GUILayout.Label(entry.message, style, GUILayout.Width(guiRect.width));
                    ++index;
                }
            }
            GUI.EndGroup();
        }

        internal Console console
        {
            get { return m_console; }
            set { m_console = value; }
        }
    }

    static class GUIHelper
    {
        public static GUIStyle SetBackgroundColor(GUIStyle style, uint color)
        {
            style.normal.background = Create1x1ColorTexture(color);
            return style;
        }

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
            uint r = (color >> 24) & 0xff;
            uint g = (color >> 16) & 0xff;
            uint b = (color >> 8) & 0xff;
            return new Color(r / 255.0f, g / 255.0f, b / 255.0f);
        }
    }
}
