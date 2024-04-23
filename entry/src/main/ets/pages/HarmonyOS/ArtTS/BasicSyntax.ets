@Preview
@Component
export default struct BasicSyntax {
  @State title: string = 'Basic Syntax'
  @State count: number = 0

  build() {
    NavDestination() {
      Column({ space: 2 }) {
        Row({ space: 2 }) {
          Text() {
            Span('Span')
          }

          Text('PlainText')
          Text($r('app.string.app_name'))
          Text(`count: ${this.count}`)
            .fontSize(18)
            .fontColor(Color.Red)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 5, right: 5 })

        Divider()
        Image($rawfile('search.png'))
          .alt('search image')
          .height(20)
        Divider()
        Row({ space: 5 }) {
          Button('count + 1')
            .onClick(() => {
              this.count += 1
            })
          Button('count + 2')
            .onClick(this.arrowFunc)
            .backgroundColor(Color.Green)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        Blank()

        MyCustomComponent()
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title(this.title)
  }

  arrowFunc = () => {
    this.count += 2
  }
}

@Preview
@Component({ freezeWhenInactive: true })
@Reusable
struct MyCustomComponent {
  @State message: string = 'My Custom Component'

  build() {
    Text(this.message)
      .backgroundColor(Color.Yellow)
      .onClick(() => {
        this.message = 'My Custom Component Clicked'
      })
  }
}