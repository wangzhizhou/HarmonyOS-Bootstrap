import { webview } from '@kit.ArkWeb'

interface ButtonInfo {
  icon: ResourceStr
  type: 'back' | 'refresh' | 'close' | 'forward'
}

Environment.envProp('accessibilityEnabled', false);

@Entry
@Component
struct WebPage {
  @StorageProp('accessibilityEnabled') accessibilityEnabled: boolean = false;
  webController: webview.WebviewController = new webview.WebviewController()
  textInputController: TextInputController = new TextInputController()
  @State textInput: string = ''
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

      Column() {
        Row() {
          Row() {
            ForEach(this.btns, (button: ButtonInfo) => {
              Image(button.icon)
                .height(20)
                .margin(5)
                .onClick(() => {
                  switch (button.type) {
                    case 'back':
                      if (this.webController.accessBackward()) {
                        this.webController.backward()
                      }
                      break
                    case 'refresh':
                      this.webController.refresh()
                      break
                    case 'close':
                      this.webController.stop()
                      break
                    case 'forward':
                      if (this.webController.accessForward()) {
                        this.webController.forward()
                      }
                      break
                  }
                })
            })
          }
          .width('30%')

          TextInput({ placeholder: '请输入网址', text: this.textInput, controller: this.textInputController })
            .margin({ left: 5, right: 5, bottom: 5 })
            .onChange((text: string) => {
              this.textInput = text
            })
            .onSubmit(() => {
              this.webController.loadUrl(this.textInput)
            })
            .width('60%')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
      }
      .height('10%')
      .padding({ top: 5, bottom: 5 })
    }
    .title('Web')
  }

  aboutToAppear(): void {
    webview.WebviewController.setWebDebuggingAccess(true)
  }
}

export default WebPage