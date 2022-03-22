// Immersive Stamina FX; (c) v1ld, 2022-03-19
// MIT License applies

import ImmersiveStaminaFX.ISFXConfig

@wrapMethod(StaminaListener)
  public func OnStatPoolValueChanged(oldValue: Float, newValue: Float, percToPoints: Float) -> Void {
    wrappedMethod(oldValue, newValue, percToPoints);
    if ISFXConfig.IsEnabled() {
      this.m_player.Mod_UpdateStaminaStateVFX(newValue);
    }
  }

@addField(PlayerPuppet)
  public let mod_staminaVfxBlackboard: ref<worldEffectBlackboard>;

@addMethod(PlayerPuppet)
  private final func Mod_UpdateStaminaStateVFX(staminaPerc: Float) -> Void {
    let lowStaminaThreshold: Float = ISFXConfig.LowStaminaThreshold();
    let vfxName: CName = ISFXConfig.StaminaFXName(ISFXConfig.StaminaFXIndex());
    if staminaPerc >= lowStaminaThreshold && IsDefined(this.mod_staminaVfxBlackboard) {
      GameObjectEffectHelper.BreakEffectLoopEvent(this, vfxName);
      this.mod_staminaVfxBlackboard = null;
    } else {
      if staminaPerc <= lowStaminaThreshold {
        if !IsDefined(this.mod_staminaVfxBlackboard) {
          this.mod_staminaVfxBlackboard = new worldEffectBlackboard();
          this.mod_staminaVfxBlackboard.SetValue(n"stamina_state", staminaPerc / lowStaminaThreshold);
          GameObjectEffectHelper.StartEffectEvent(this, vfxName, false, this.mod_staminaVfxBlackboard);
        } else {
          this.mod_staminaVfxBlackboard.SetValue(n"stamina_state", staminaPerc / lowStaminaThreshold);
        }
      }
    }
  }