import { checkAccessToken, requestPermissionFromUser, allPermissions } from '../../../utils/permissions'
import { toast } from '../../../utils/utils'
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
                    .maxLines(1)
                    .fontSize(10)
                  Blank()
                  if (this.selectedIndex === index) {
                    Image($rawfile('check.png'))
                      .margin({ right: 10 })
                      .height(20)
                  }
                }
                .justifyContent(FlexAlign.Start)
                .width('100%')
              }
              .padding({ left: 5, right: 5 })
            }
            .height(30)
            .onClick(() => {
              this.selectedIndex = index
              this.selectedPermission = allPermissions[this.selectedIndex]
            })
          }, (permission: Permissions) => permission)
        }
        .width('100%')
        .height(this.selectedIndex ? '90%' : '100%')

        if (this.selectedIndex) {
          Row() {
            Button('校验读权限')
              .onClick(() => {
                if (this.selectedPermission) {
                  checkAccessToken(this.selectedPermission).then((grantStatus: abilityAccessCtrl.GrantStatus) => {
                    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
                      // 已经授权，可以继续访问目标操作
                      toast("校验：已授权")
                    } else {
                      // 申请日历权限
                      toast("校验：未授权")
                    }
                  })
                }
              })
            Button('请求权限')
              .onClick(() => {
                this.requestPermission()
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
        if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
          // 已经授权，可以继续访问目标操作
          toast("请求：权限已授权")
        } else {
          // 申请日历权限
          toast("请求：权限未授权")
        }
      })
    }
  }
}