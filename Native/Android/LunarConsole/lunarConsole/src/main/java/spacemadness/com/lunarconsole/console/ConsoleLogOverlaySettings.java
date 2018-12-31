package spacemadness.com.lunarconsole.console;

import org.json.JSONException;
import org.json.JSONObject;

class ConsoleLogOverlaySettings
{
	int maxVisibleLines = 1;
	double hideDelay = 1.0;

	static ConsoleLogOverlaySettings fromJson(JSONObject json) throws JSONException
	{
		ConsoleLogOverlaySettings settings = new ConsoleLogOverlaySettings();
		settings.maxVisibleLines = json.getInt("maxVisibleLines");
		settings.hideDelay = json.getDouble("hideDelay");
		return settings;
	}
}
