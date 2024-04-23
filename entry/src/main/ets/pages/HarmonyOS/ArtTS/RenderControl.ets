@Component
export default struct RenderControl {
  build() {
    NavDestination() {
      Column() {
        Text('Render Control')
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('Render Control')
  }
}
