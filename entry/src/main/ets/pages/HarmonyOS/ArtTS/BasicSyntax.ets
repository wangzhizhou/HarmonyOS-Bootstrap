import { toast } from '../../../utils/utils';
import { checkAccessToken, requestPermissionFromUser } from '../../../utils/permissions';
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';

class RefParam {
  text: string = ''
}

@Preview
@Component
export default struct BasicSyntax {
  @State title: string = 'Basic Syntax'
  @State count: number = 0
  @State text: string = 'origin value'
  permission: Permissions = 'ohos.permission.READ_CALENDAR'

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
        Row({ space: 10 }) {
          Column() {
            Image($rawfile('search.png'))
              .alt('search image')
              .height(40)
            Text("本地图片")
          }

          Column() {
            Image('https://copyright.bdstatic.com/vcg/creative/cc9c744cf9f7c864889c563cbdeddce6.jpg@h_1280')
              .height(40)
            Text("网络图片")
          }
        }

        Divider()
        Row({ space: 5 }) {
          Button('count + 1')
            .onClick(() => {
              this.count++
            })
          Button('count + 2')
            .onClick(this.arrowFunc)
            .backgroundColor(Color.Green)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)

        Blank()

        MyCustomComponent()
        this.valuePassBuilder(this.text)
        this.refPassBuilder({ text: this.text })
        Button('change origin value to new value')
          .onClick(() => {
            this.text = `new value ${this.count++}`
          })

        Button('校验读日历权限')
          .onClick(() => {
            checkAccessToken(this.permission).then((grantStatus: abilityAccessCtrl.GrantStatus) => {
              if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
                // 已经授权，可以继续访问目标操作
                toast("校验：读日历权限已授权")
              } else {
                // 申请日历权限
                toast("校验：读日历权限未授权")
              }
            })
          })
        Button('请求用户读日历权限')
          .onClick(() => {
            this.requestPermission()
          })
      }
      .height('100%')
      .width('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title(this.title)
  }

  requestPermission() {
    requestPermissionFromUser(this, this.permission).then((grantStatus: abilityAccessCtrl.GrantStatus) => {
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        // 已经授权，可以继续访问目标操作
        toast("请求：读日历权限已授权")
      } else {
        // 申请日历权限
        toast("请求：读日历权限未授权")
      }
    })
  }

  arrowFunc = () => {
    this.count += 2
  }

  @Builder
  valuePassBuilder(text: string) {
    Text(`value pass builder: ${text}`)
  }

  @Builder
  refPassBuilder($$: RefParam) {
    Text(`ref pass builder: ${$$.text}`)
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

  aboutToAppear(): void {
    toast('about to appear (MyCustomComponent)')
  }

  aboutToDisappear(): void {
    toast('about to disappear (MyCustomComponent)')
  }

  onPageShow(): void {
    toast('page show (MyCustomComponent)')
  }

  onPageHide(): void {
    toast('page hide (MyCustomComponent)')
  }

  onBackPress(): boolean | void {
    toast('back press (MyCustomComponent)')
  }
}