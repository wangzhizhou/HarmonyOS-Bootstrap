import ItemList, { TabItem } from './List/ItemList';

@Preview({
  title: 'Tab'
})
@Component
export default struct TabComponent {
  tabItems: TabItem[] = [
    {
      name: "ArkTS",
      icon: $rawfile('arkts.png'),
      listItem: [
        { name: 'Basic Syntax' },
        { name: 'State Manage' },
        { name: 'Render Control' },
      ]
    },
    {
      name: "ArkUI",
      icon: $rawfile('arkui.png'),
      listItem: [
        { name: 'Layout' },
        { name: 'Components' },
        { name: 'Router' },
        { name: 'Graphics' },
        { name: 'Animation' },
        { name: 'Interaction' },
        { name: 'Theme' },
        { name: 'Web' },
        { name: 'Permissions' },
      ]
    }
  ]
  private tabController: TabsController = new TabsController()
  @State private selectedIndex: number = 1

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController, index: this.selectedIndex }) {
      ForEach(this.tabItems, (tabItem: TabItem, index: number) => {
        TabContent() {
          ItemList({ tabItem: tabItem })
            .padding({ top: 10 })
        }
        .tabBar(this.tabBarBuilder(tabItem, index))
        .tabIndex(index)
      }, (tabItem: TabItem) => tabItem.name)
    }
    .onChange((index: number) => {
      this.selectedIndex = index
    })
  }

  @Builder
  tabBarBuilder(tabItem: TabItem, index: number) {
    Row() {
      Image(tabItem.icon)
        .height(20)
        .margin({ right: 5 })
        .colorBlend(this.selectedIndex === index ? Color.Blue : Color.Black)
      Text(tabItem.name)
        .fontColor(this.selectedIndex === index ? Color.Blue : Color.Black)
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
    }
  }
}