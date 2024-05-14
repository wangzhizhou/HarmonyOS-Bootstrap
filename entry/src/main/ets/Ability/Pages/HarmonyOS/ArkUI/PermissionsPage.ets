import {
  requestPermissionFromUser,
  requestPermissionsFromUser,
  allPermissions,
  checkAccessToken,
  openPermissionsInSystemSettings,
  getUIAbilityContext
} from '../../../Utils/permissions'
import { toast, setPasteboardString } from '../../../Utils/utils'
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'

@Entry
@Component
export default struct PermissionsComponent {
  @State selectedIndex: number | undefined = undefined
  @State selectedPermission: Permissions | undefined = undefined
  @State searchKeyword: string = ''
  @State permissions: Permissions[] = allPermissions
  searchController: SearchController = new SearchController()

  build() {
    NavDestination() {
      Search({ placeholder: '输入权限名称', value: this.searchKeyword, controller: this.searchController })
        .placeholderColor(Color.Gray)
        .enableKeyboardOnFocus(false)
        .type(SearchType.NORMAL)
        .margin({ left: 5, right: 5, bottom: 10 })
        .onChange((value: string) => {
          this.searchKeyword = value
          this.permissions = allPermissions.filter((permission: Permissions) => {
            return permission.toLowerCase().includes(value.toLowerCase())
          })
          this.selectedIndex = undefined
          if (this.selectedPermission) {
            const index = this.permissions.indexOf(this.selectedPermission)
            this.selectedIndex = index >= 0 ? index : undefined
          }
        })
        .height('6%')
      Column() {
        List({ initialIndex: 0, space: 2 }) {
          ForEach(this.permissions, (permission: Permissions, index: number) => {
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
              this.selectedPermission = this.permissions[this.selectedIndex]
              setPasteboardString(this.selectedPermission).then(() => {
                toast('已复制')
              })
            })
          }, (permission: Permissions) => permission)
        }
        .width('100%')
        .height(this.selectedPermission ? '92%' : '100%')
        .onScroll(() => {
          this.searchController.stopEditing()
        })

        if (this.selectedPermission) {
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
            Button('定位')
              .onClick(() => {
                checkAccessToken("ohos.permission.APPROXIMATELY_LOCATION")
                  .then((grantStatus: abilityAccessCtrl.GrantStatus) => {
                    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_DENIED) {
                      requestPermissionsFromUser(this, [
                        "ohos.permission.APPROXIMATELY_LOCATION",
                        "ohos.permission.LOCATION",
                      // "ohos.permission.LOCATION_IN_BACKGROUND",
                      ]).then((grantStatus) => {
                      })
                    }
                  })
              })
          }
          .width('100%')
          .height('8%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }
      }
      .height('94%')
      .justifyContent(FlexAlign.Center)
    }
    .title(`Permissions(${this.permissions.length})`)
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