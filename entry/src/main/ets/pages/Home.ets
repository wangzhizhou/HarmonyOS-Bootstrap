import Tab from './Components/Tab';
import { toast } from '../utils/utils';

@Entry
@Component
struct Home {
  build() {
    Navigation() {
      Tab()
    }
    .title('Home Page')
    .titleMode(NavigationTitleMode.Full)
    .mode(NavigationMode.Auto)
    .menus([
      { value: 'Search', icon: 'resources/rawfile/search.png', action: () => toast('Search Menu') },
      { value: 'Plus', icon: 'resources/rawfile/plus.png', action: () => toast('Plus Menu') },
      { value: 'More', icon: 'resources/rawfile/more.png', action: () => toast('More Menu') },
    ])
    .toolbarConfiguration([
      { value: 'HomeKit', icon: $rawfile('homekit.png'), action: () => toast('Homekit Toolbar') },
      { value: 'Settings', icon: $rawfile('settings.png'), action: () => toast('Settings Toolbar') },
    ])
  }
}