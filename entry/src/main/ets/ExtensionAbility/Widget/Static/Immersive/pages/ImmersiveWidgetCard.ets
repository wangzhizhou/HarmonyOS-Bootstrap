@Entry
@Component
struct ImmersiveWidgetCard {
  /*
   * The max lines.
   */
  readonly MAX_LINES: number = 1;
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';
  /*
   * The width percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  build() {
    FormLink({
      action: this.ACTION_TYPE,
      abilityName: this.ABILITY_NAME,
      params: {
        message: this.MESSAGE
      }
    }) {
      Stack() {
        Image($r("app.media.ic_widget"))
          .width(this.FULL_WIDTH_PERCENT)
          .height(this.FULL_HEIGHT_PERCENT)
        Column() {
          Text($r('app.string.title_immersive'))
            .fontSize($r('app.float.title_immersive_font_size'))
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor($r('app.color.title_font'))
            .fontWeight(FontWeight.Medium)
            .maxLines(this.MAX_LINES)
          Text($r('app.string.detail_immersive'))
            .fontSize($r('app.float.detail_immersive_font_size'))
            .margin({ top: $r('app.float.item_margin_top') })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontColor($r('app.color.immersive_item_text'))
            .fontWeight(FontWeight.Regular)
            .maxLines(this.MAX_LINES)
        }
        .width(this.FULL_WIDTH_PERCENT)
        .height(this.FULL_HEIGHT_PERCENT)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.End)
        .padding($r('app.float.column_padding'))
      }
      .width(this.FULL_WIDTH_PERCENT)
      .height(this.FULL_HEIGHT_PERCENT)
    }
  }
}