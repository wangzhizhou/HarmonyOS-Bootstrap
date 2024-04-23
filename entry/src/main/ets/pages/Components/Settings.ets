@Component
export default struct Settings {
  @State message: string = 'Settings';

  build() {
    NavDestination() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('Settings')
  }
}