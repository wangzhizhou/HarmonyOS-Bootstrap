import Settings from './Components/Settings'
import BasicSyntax from './HarmonyOS/ArtTS/BasicSyntax'
import StateManage from './HarmonyOS/ArtTS/StateManage'
import RenderControl from './HarmonyOS/ArtTS/RenderControl'

import PermissionsComponent from './HarmonyOS/ArkUI/PermissionsPage'
import WebPage from './HarmonyOS/ArkUI/WebPage'
import LayoutPage from './HarmonyOS/ArkUI/LayoutPage'
import ThemePage from './HarmonyOS/ArkUI/ThemePage'

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
  } else if (path === 'Web') {
    WebPage()
  } else if (path === 'Layout') {
    LayoutPage()
  } else if (path === 'Theme') {
    ThemePage()
  } else {
    NavDestination() {
      Column() {
        Text(path)
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
  }
}