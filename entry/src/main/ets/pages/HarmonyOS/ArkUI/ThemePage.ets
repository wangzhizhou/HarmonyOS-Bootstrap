import { ConfigurationConstant } from '@kit.AbilityKit'
import { toast } from '../../../utils/utils'

@Entry
@Component
struct ThemePage {
  @StorageProp('currentColorMode')
  @Watch('onColorModeChange')
  currentColorMode: ConfigurationConstant.ColorMode = ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
  context: Context = getContext(this)
  @State isDarkMode: boolean = false

  build() {
    NavDestination() {
      Row({ space: 10 }) {
        Text('Dark Mode')

        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.isDarkMode })
          .onChange((isOn: boolean) => {
            this.isDarkMode = isOn
            this.context.getApplicationContext()
              .setColorMode(this.isDarkMode ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
          })

      }
      .height('100%')
      .onClick(() => {
        this.toastColorMode()
      })
    }
    .title('Theme Page')
  }

  aboutToAppear(): void {
    if (this.currentColorMode == ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      //当前为浅色模式，资源初始化逻辑
    } else {
      //当前为深色模式，资源初始化逻辑
    }
  }

  onColorModeChange() {
    if (this.currentColorMode == ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      //当前为浅色模式，资源初始化逻辑
    } else {
      //当前为深色模式，资源初始化逻辑
    }
  }

  toastColorMode() {
    switch (this.currentColorMode) {
      case ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT:
        toast('color mode: light mode')
        break
      case ConfigurationConstant.ColorMode.COLOR_MODE_DARK:
        toast('color mode: dark mode')
        break
      case ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET:
        toast('color mode: not set')
        break
    }
  }
}

export default ThemePage