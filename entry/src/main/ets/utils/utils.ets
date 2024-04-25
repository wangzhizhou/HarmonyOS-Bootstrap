import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

export function toast(content: string, duration: number = 1500) {

  promptAction.showToast({ message: content, duration: duration })
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