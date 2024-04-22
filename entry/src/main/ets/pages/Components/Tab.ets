@Preview({
  title: 'Tab'
})
@Component
export default struct TabComponent {
  tabInfo = ['Layout', 'Components', 'Router', 'Graphics', 'Animation', 'Interactive']
  private tabController: TabsController = new TabsController()
  @State private selectedIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
      ForEach(this.tabInfo, (tabInfo: string, index: number) => {
        TabContent() {
          NavRouter() {
            Text(tabInfo)
              .fontSize(18)
            NavDestination() {
              Column() {
                Text(tabInfo + ' Detail Page')
                  .fontSize(12)
              }
              .height('100%')
              .justifyContent(FlexAlign.Center)
            }
            .title(tabInfo + ' Detail')
            .hideTitleBar(false)
            .mode(NavDestinationMode.STANDARD)
          }
        }
        .tabBar(this.tabBarBuilder(tabInfo, index))
      }, (tabInfo: string) => tabInfo)
    }
    .vertical(false)
    .scrollable(true)
    .onChange((index: number) => {
      this.selectedIndex = index
    })
    .barMode(BarMode.Scrollable)
  }

  @Builder
  tabBarBuilder(title: string, index: number) {
    Row() {
      Image($rawfile('number.png'))
        .width(20)
        .height(20)
        .margin({ right: 5 })
      Text(title)
        .fontColor(this.selectedIndex === index ? Color.Orange : Color.Black)
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
    }
    .padding(20)
    .backgroundColor(Color.Grey)
  }
}