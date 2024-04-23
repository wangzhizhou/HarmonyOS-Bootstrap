interface ListItem {
  name: string
}

export interface TabItem {
  name: string,
  icon: ResourceStr,
  listItem: ListItem[]
}

@Component
export default struct ItemList {
  @State tabItem: TabItem = {
    name: 'Hello',
    icon: '',
    listItem: [
      { name: "Hello, List Row Title" }
    ]
  }
  @Consume('pathInfos') pathInfos: NavPathStack

  build() {
    List() {
      ForEach(this.tabItem.listItem, (listItem: ListItem) => {
        ListItem() {
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
          .onClick(() => {
            this.pathInfos.pushPathByName(listItem.name, '');
          })
        }
      }, (listItem: ListItem) => listItem.name)
    }
    .width('100%')
    .height('100%')
  }
}