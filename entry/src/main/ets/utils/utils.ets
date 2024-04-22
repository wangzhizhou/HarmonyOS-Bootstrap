import promptAction from '@ohos.promptAction';

export function toast(content: string) {
  promptAction.showToast({ message: content + ' Action' })
}