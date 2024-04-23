interface ListItem {
  name: string
}

export interface TabItem {
  name: string,
  icon: ResourceStr,
  listItem: ListItem[]
}

@Preview({
  title: "ItemList"
})
@Component
export default struct ItemList {
  @State tabItem: TabItem = {
    name: 'Hello',
    icon: '',
    listItem: [
      { name: "Hello, List Row Title" }
    ]
  }

  build() {
    List() {
      ForEach(this.tabItem.listItem, (listItem: ListItem, _: number) => {
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
            .title(this.tabItem.name)
            .mode(NavDestinationMode.STANDARD)
          }
        }
      }, (listItem: ListItem) => listItem.name)
    }
    .width('100%')
    .height('100%')
  }
}