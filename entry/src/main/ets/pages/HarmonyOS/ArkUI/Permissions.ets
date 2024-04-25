import {
  checkAccessToken,
  requestPermissionFromUser,
  allPermissions,
  openPermissionsInSystemSettings,
  getUIAbilityContext
} from '../../../utils/permissions'
import { toast, setPasteboardString } from '../../../utils/utils'
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'

@Entry
@Component
export default struct PermissionsComponent {
  @State selectedIndex: number | undefined = undefined
  @State selectedPermission: Permissions | undefined = undefined

  build() {
    NavDestination() {
      Column() {
        List({ initialIndex: 0, space: 2 }) {
          ForEach(allPermissions, (permission: Permissions, index: number) => {
            ListItem() {
              Column() {
                Row() {
                  Text(permission)
                    .fontWeight(FontWeight.Medium)
                    .maxLines(1)
                    .fontSize(10)
                    .margin({ left: 20 })
                  Blank()
                  if (this.selectedIndex === index) {
                    Image($rawfile('check.png'))
                      .margin({ right: 10 })
                      .height(20)
                  }
                }
                .borderRadius(5)
                .backgroundColor('#0F000000')
                .justifyContent(FlexAlign.Start)
                .width('100%')
                .height('100%')
              }
              .padding({ left: 5, right: 5 })
            }
            .height(30)
            .onClick(() => {
              this.selectedIndex = index
              this.selectedPermission = allPermissions[this.selectedIndex]
              setPasteboardString(this.selectedPermission).then(() => {
                toast('已复制')
              })
            })
          }, (permission: Permissions) => permission)
        }
        .width('100%')
        .height(this.selectedIndex ? '90%' : '100%')

        if (this.selectedIndex) {
          Row() {
            Button('校验')
              .onClick(() => {
                if (this.selectedPermission) {
                  checkAccessToken(this.selectedPermission).then((grantStatus: abilityAccessCtrl.GrantStatus) => {
                    this.toastGrantStatus(grantStatus)
                  })
                }
              })
            Button('请求')
              .onClick(() => {
                this.requestPermission()
              })
            Button('跳转设置页')
              .onClick(() => {
                openPermissionsInSystemSettings(getUIAbilityContext(this))
              })
          }
          .width('100%')
          .height('10%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('Permissions')
  }

  requestPermission() {
    if (this.selectedPermission) {
      requestPermissionFromUser(this, this.selectedPermission).then((grantStatus: abilityAccessCtrl.GrantStatus) => {
        this.toastGrantStatus(grantStatus)
      })
    }
  }

  toastGrantStatus(grantStatus: abilityAccessCtrl.GrantStatus) {
    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
      toast('已授权')
    } else {
      // 申请日历权限
      toast('未授权(确认配置文件是否声明此权限)', 3000)
    }
  }
}