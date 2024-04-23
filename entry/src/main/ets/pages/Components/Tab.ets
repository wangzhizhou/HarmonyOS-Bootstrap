interface ListItem {
  name: string
}

interface TabItem {
  name: string,
  icon: ResourceStr,
  listItem: ListItem[]
}

@Preview({
  title: 'Tab'
})
@Component
export default struct TabComponent {
  tabItems: TabItem[] = [
    {
      name: "ArkTS",
      icon: $rawfile('arkui.png'),
      listItem: [
        { name: 'Attributes' }
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
      ]
    }
  ]
  private tabController: TabsController = new TabsController()
  @State private selectedIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabController }) {
      ForEach(this.tabItems, (tabItem: TabItem, index: number) => {
        TabContent() {
          List() {
            ForEach(tabItem.listItem, (listItem: ListItem, index: number) => {
              ListItem() {
                NavRouter() {
                  Row() {
                    Text(listItem.name)
                      .fontSize(18)
                      .margin({ left: 20 })
                    Blank()
                    Image($rawfile('right_arrow.png'))
                      .height(15)
                      .margin({ right: 20 })
                  }
                  .width('100%')
                  .height(60)

                  NavDestination() {
                    Column() {
                      Text(listItem.name)
                        .fontSize(12)
                    }
                    .height('100%')
                    .justifyContent(FlexAlign.Center)
                  }
                  .title(tabItem.name)
                  .mode(NavDestinationMode.STANDARD)
                }
              }
            }, (listItem: ListItem) => listItem.name)
          }
          .height('100%')
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
        .width(20)
        .height(20)
        .margin({ right: 5 })
        .colorBlend(this.selectedIndex === index ? Color.Blue : Color.Black)
      Text(tabItem.name)
        .fontColor(this.selectedIndex === index ? Color.Blue : Color.Black)
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
    }
  }
}