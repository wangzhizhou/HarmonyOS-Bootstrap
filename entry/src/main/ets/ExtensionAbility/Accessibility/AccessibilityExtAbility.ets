import { AccessibilityExtensionAbility, AccessibilityEvent } from '@kit.AccessibilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

class AccessibilityExtAbility extends AccessibilityExtensionAbility {
    /**
     * Called when your accessibility service is successfully connected to the OS. You can implement
     * this method to perform subsequent initialization operations.
     */
    onConnect() {
        hilog.info(0x0000, 'testTag', '%{public}s', '[AccessibilityExtAbility] onConnect');
    }

    /**
     * Called when your accessibility service is successfully disconnected to the OS.
     */
    onDisconnect() {
        hilog.info(0x0000, 'testTag', '%{public}s', '[AccessibilityExtAbility] onDisconnect');
    }

    /**
     * Called when an accessibility event occurs, such as when the user touches the application interface.
     * @param event Indicates an accessibility event.
     */
    onAccessibilityEvent(accessibilityEvent: AccessibilityEvent) {
        hilog.info(0x0000, 'testTag', '%{public}s', '[AccessibilityExtAbility] onAccessibilityEvent type: ' + accessibilityEvent.eventType);
    }
}

export default AccessibilityExtAbility;