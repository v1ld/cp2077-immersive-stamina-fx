module ImmersiveStaminaFXConfig

public class ImmersiveStaminaFXConfig {
  public static func IsEnabled() -> Bool = true

  // The stamina fx is shown when stamina falls below this percentage of the total.
  // Must be a number between 0 (never show) and 100 (always show)
  public static func LowStaminaThreshold() -> Float = 25

  // What effect should be used when stamina is low
  // 0: Same as the low health effect with red wavy lines on the sides
  // 1: Dims the sides of the screen and brightens the center
  public static func StaminaFXIndex() -> Int32 = 0

  // DO NOT MODIFY ANYTHING BELOW THIS POINT

  public static final func StaminaFXCount() -> Int32 = 2 // Total number of effects below

  public static final func StaminaFXName(index: Int32) -> CName {
    switch index {
      case 0: return n"fx_health_low"; // Same as the low health effect with red wavy lines on the sides
      case 1: return n"status_drugged_heavy"; // Dims the sides of the screen and brightens the center

      default: return ImmersiveStaminaFXConfig.StaminaFXName(0);
    }
  }

  public static final func StaminaFXDisplayName(index: Int32) -> String {
    switch index {
      case 0: return "Same as the low health effect with red wavy lines on the sides";
      case 1: return "Dims the sides of the screen and brightens the center";

      default: return ImmersiveStaminaFXConfig.StaminaFXDisplayName(0);
    }
  }
}