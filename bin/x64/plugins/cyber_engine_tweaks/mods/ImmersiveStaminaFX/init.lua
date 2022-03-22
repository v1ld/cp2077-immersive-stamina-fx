-- Immersive Stamina FX; (c) v1ld, 2022-03-21
-- Credits: Overall options structure and code taken from djkovrik's excellent LHUD mod

local defaults = {
  IsEnabled = true,
  LowStaminaThreshold = 25.0,
  StaminaFXIndex = 1
}

local settings = {
  IsEnabled = true,
  LowStaminaThreshold = 25.0,
  StaminaFXIndex = 1
}

function SaveSettings()
  local validJson, contents = pcall(function() return json.encode(settings) end)

  if validJson and contents ~= nil then
    local updatedFile = io.open("settings.json", "w+");
    updatedFile:write(contents);
    updatedFile:close();
  end
end

function LoadSettings()
  local file = io.open("settings.json", "r")
  if file ~= nil then
    local contents = file:read("*a")
    local validJson, persistedState = pcall(function() return json.decode(contents) end)

    if validJson then
      file:close();
      for key, _ in pairs(settings) do
        if persistedState[key] ~= nil then
          settings[key] = persistedState[key]
        end
      end
    end
  end
end

function SetupSettingsMenu()
  local nativeSettings = GetMod("nativeSettings")

  if not nativeSettings then
    print("Error: NativeSettings not found!")
    return
  end

  local effects = { }
  for i = 1, ImmersiveStaminaFX_ISFXConfig.StaminaFXCount() do
    effects[i] = ImmersiveStaminaFX_ISFXConfig.StaminaFXDisplayName(i)
  end

  nativeSettings.addTab("/v1ld", "v1ld")
  nativeSettings.addSubcategory("/v1ld/staminaFX", "Immersive Stamina FX")
  nativeSettings.addSwitch("/v1ld/staminaFX", "Enabled", "Enable/Disable the mod", settings.IsEnabled, defaults.IsEnabled, function(enabled) settings.IsEnabled = enabled end)
  nativeSettings.addRangeFloat("/v1ld/staminaFX", "Low Stamina Threshold (%)", "Stamina FX will show below this threshold", 0, 100, 1, "%.0f", settings.LowStaminaThreshold, defaults.LowStaminaThreshold, function(value) settings.LowStaminaThreshold = value end)
  nativeSettings.addSelectorString("/v1ld/staminaFX", "Stamina FX", "Screen effect when stamina is below the threshold", effects, settings.StaminaFXIndex, defaults.StaminaFXIndex, function(value) settings.StaminaFXIndex = value end)
end

registerForEvent("onInit", function()
  LoadSettings()
  SetupSettingsMenu()

  Override("ImmersiveStaminaFX.ISFXConfig", "IsEnabled;", function(_) return settings.IsEnabled end)
  Override("ImmersiveStaminaFX.ISFXConfig", "LowStaminaThreshold;", function(_) return settings.LowStaminaThreshold end)
  Override("ImmersiveStaminaFX.ISFXConfig", "StaminaFXIndex;", function(_) return settings.StaminaFXIndex end)
end)

registerForEvent("onShutdown", function()
  SaveSettings()
end)