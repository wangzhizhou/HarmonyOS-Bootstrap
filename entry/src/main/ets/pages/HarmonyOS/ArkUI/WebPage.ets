import { webview } from '@kit.ArkWeb'

interface ButtonInfo {
  icon: ResourceStr
  type: 'back' | 'refresh' | 'close' | 'forward'
}

@Entry
@Component
struct WebPage {
  webController: webview.WebviewController = new webview.WebviewController()
  @State url: string = 'developer.apple.com'
  @State progress: number = 0
  btns: ButtonInfo[] = [
    { icon: $rawfile('left.png'), type: 'back' },
    { icon: $rawfile('right.png'), type: 'forward' },
    { icon: $rawfile('refresh.png'), type: 'refresh' },
    { icon: $rawfile('close.png'), type: 'close' },
  ]

  build() {
    NavDestination() {
      if (this.progress < 100) {
        Progress({ value: this.progress })
          .width('100%')
      }
      Web({ src: this.url, controller: this.webController })
        .onProgressChange((event) => {
          if (event) {
            this.progress = event.newProgress
          }
        })
        .height('90%')
      Row() {
        ForEach(this.btns, (button: ButtonInfo) => {
          Image(button.icon)
            .height(30)
            .margin(10)
            .onClick(() => {
              switch (button.type) {
                case 'back':
                  this.webController.backward()
                  break
                case 'refresh':
                  this.webController.refresh()
                  break
                case 'close':
                  this.webController.stop()
                  break
                case 'forward':
                  this.webController.forward()
                  break
              }
            })
        })
      }
      .width('100%')
      .height('10%')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .title('Web')
  }

  aboutToAppear(): void {
    webview.WebviewController.setWebDebuggingAccess(true)
  }
}

export default WebPage