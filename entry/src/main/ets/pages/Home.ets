import Tab from './Components/Tab'
import Settings from './Components/Settings'
import { toast } from '../utils/utils'

@Entry
@Component
struct Home {
  @Provide('pathInfos') pathInfos: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathInfos) {
      Tab()
    }
    .mode(NavigationMode.Stack)
    .title('HarmonyOS Boostrap')
    .menus([
      {
        value: 'Search',
        icon: 'resources/rawfile/search.png',
        action: () => toast('Search Menu')
      },
      {
        value: 'Plus',
        icon: 'resources/rawfile/plus.png',
        action: () => toast('Plus Menu')
      },
      {
        value: 'More',
        icon: 'resources/rawfile/more.png',
        action: () => toast('More Menu')
      },
    ])
    .toolbarConfiguration([
      {
        value: 'HomeKit',
        icon: $rawfile('homekit.png'),
        action: () => toast('Homekit Toolbar')
      },
      {
        value: 'Settings',
        icon: $rawfile('settings.png'),
        action: () => this.pathInfos.pushPathByName('settings', '')
      },
    ])
    .hideToolBar(true)
    .navDestination(this.navDestinationBuilder)
  }

  @Builder
  navDestinationBuilder(path: string) {
    if (path === 'settings') {
      Settings()
    }
  }
}