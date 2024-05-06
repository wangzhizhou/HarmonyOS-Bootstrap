class LayoutItem {
}


@Entry
@Component
struct LayoutPage {
  build() {
    NavDestination() {
      List() {
        ListItemGroup({ header: this.headerBuilder(), space: 5 }) {
          ListItem() {
            Text('Item')
          }

          ListItem() {
            Text('Item')
          }

          ListItem() {
            Text('Item')
          }
        }

        ListItemGroup({ header: this.headerBuilder() }) {
          ListItem() {
            Text('Item')
          }

          ListItem() {
            Text('Item')
          }

          ListItem() {
            Text('Item')
          }
        }
      }
    }
    .title('Layout')
  }

  @Builder
  headerBuilder() {
    Row({ space: 5 }) {
      Image($rawfile('search.png'))
        .height(15)
      Text('Section Header')
    }
    .padding(5)
    .backgroundColor(Color.Gray)
    .width('100%')
  }
}

export default LayoutPage;