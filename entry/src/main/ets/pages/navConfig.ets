import Settings from './Components/Settings'
import BasicSyntax from './HarmonyOS/ArtTS/BasicSyntax'
import StateManage from './HarmonyOS/ArtTS/StateManage'
import RenderControl from './HarmonyOS/ArtTS/RenderControl'

import PermissionsComponent from './HarmonyOS/ArkUI/Permissions'

@Builder
export default function navDestinationBuilder(path: string) {
  if (path === 'settings') {
    Settings()
  } else if (path === 'Basic Syntax') {
    BasicSyntax()
  } else if (path === 'State Manage') {
    StateManage()
  } else if (path === 'Render Control') {
    RenderControl()
  } else if (path === 'Permissions') {
    PermissionsComponent()
  }

  else {
    NavDestination() {
      Column() {
        Text(path)
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}