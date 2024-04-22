@Component
export default struct TabComponent {
  tabInfo = ['Layout', 'Components', 'Router', 'Graphics', 'Animation', 'Interactive']
  private tabController: TabsController = new TabsController()
  @State private selectedIndex: number = 0

  build() {
    Tabs({ barPosition: BarPosition.Start, controller: this.tabController }) {
      ForEach(this.tabInfo, (tabInfo: string, index: number) => {
        TabContent() {
          Text(tabInfo)
            .fontSize(18)
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
    Column() {
      Text(title)
        .fontColor(this.selectedIndex === index ? Color.Orange : Color.Black)
        .fontWeight(this.selectedIndex === index ? FontWeight.Bold : FontWeight.Regular)
        .padding(20)
    }
    .backgroundColor(Color.Grey)
  }
}