@Component
export default struct StateManage {
  build() {
    NavDestination() {
      Column() {
        Text('State Manage')
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .title('State Manage')
  }
}
