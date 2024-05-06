import Tab from './Components/Tab'
import { toast } from '../Utils/utils'
import navDestinationBuilder from './navConfig'

@Entry
@Component
struct Home {
  menuItems: NavigationMenuItem[] = [
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
  ]
  toolbarItems: ToolbarItem[] = [
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
  ]
  title: string = 'HarmonyOS Boostrap'
  @Provide('pathInfos') pathInfos: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pathInfos) {
      Tab()
    }
    .mode(NavigationMode.Stack)
    .title(this.title)
    .menus(this.menuItems)
    .menus([])
    .toolbarConfiguration(this.toolbarItems)
    .hideToolBar(true)
    .navDestination(navDestinationBuilder)
  }

  onPageShow(): void {
    toast('Page Show (Home)')
  }

  onPageHide(): void {
    toast('Page Hide (Home)')
  }

  onBackPress(): boolean | void {
    toast('Back Press (Home)')
  }
}