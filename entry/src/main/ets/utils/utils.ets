import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

export function toast(content: string) {
  promptAction.showToast({ message: content })
}

export function pushPage(url: string) {
  router.pushUrl({
    url: url
  })
}

export function replacePage(url: string) {
  router.replaceUrl({
    url: url
  })
}