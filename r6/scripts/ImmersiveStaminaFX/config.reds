// Immersive Stamina FX; (c) v1ld, 2022-03-21
// MIT License applies

module ImmersiveStaminaFX

public class ISFXConfig {
  // Set to false to disable stamina fx entirely
  public static func IsEnabled() -> Bool = true

  // The stamina fx is shown when stamina falls below this percentage of the total.
  // Must be a number between 0 (never show) and 100 (always show)
  public static func LowStaminaThreshold() -> Float = 25

  // What effect should be used when stamina is low
  // 1: Same as the low health effect with red wavy lines on the sides
  // 2: Dims the sides of the screen and brightens the center
  public static func StaminaFXIndex() -> Int32 = 1

  // DO NOT MODIFY ANYTHING BELOW THIS LINE

  public static final func StaminaFXCount() -> Int32 = 2 // Total number of effects below

  public static final func StaminaFXName(index: Int32) -> CName {
    switch index {
      case 1: return n"fx_health_low"; // Same as the low health effect with red wavy lines on the sides
      case 2: return n"status_drugged_heavy"; // Dims the sides of the screen and brightens the center

      default: return ISFXConfig.StaminaFXName(1);
    }
  }

  public static final func StaminaFXDisplayName(index: Int32) -> String {
    switch index {
      case 1: return "Red flashes like at low health";
      case 2: return "Dim screen edges, bright center";

      default: return ISFXConfig.StaminaFXDisplayName(1);
    }
  }
}