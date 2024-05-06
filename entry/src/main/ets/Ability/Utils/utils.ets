import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';
import pasteboard from '@ohos.pasteboard';

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

export async function setPasteboardString(plainText: string): Promise<void> {
  const data = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, plainText)
  return await pasteboard.getSystemPasteboard().setData(data)
}

export async function getPasteboardString(): Promise<string> {
  const data = await pasteboard.getSystemPasteboard().getData()
  return data.getPrimaryText()
}