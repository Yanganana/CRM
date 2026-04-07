import { FlutterPage } from '@ohos/flutter_ohos';

@Entry
@Component
struct Index {
  @StorageLink('viewId') viewId: string = "123456";

  build() {
    Column() {
      // The FlutterPage component embeds the Flutter UI into the HarmonyOS page.
      FlutterPage({ viewId: this.viewId })
    }
    .width('100%')
    .height('100%')
  }
}
