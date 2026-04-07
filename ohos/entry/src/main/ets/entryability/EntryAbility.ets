import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import { FlutterAbility } from '@ohos/flutter_ohos';

/**
 * EntryAbility is the main entry point for the HarmonyOS application.
 * It extends FlutterAbility to ensure Flutter is properly initialized.
 */
export default class EntryAbility extends FlutterAbility {
    onWindowStageCreate(windowStage: window.WindowStage): void {
        super.onWindowStageCreate(windowStage);
        windowStage.loadContent('pages/Index', (err, data) => {
            if (err.code) {
                console.error('Failed to load the content. Cause: ' + JSON.stringify(err));
                return;
            }
            console.info('Succeeded in loading the content. Data: ' + JSON.stringify(data));
        });
    }
}
