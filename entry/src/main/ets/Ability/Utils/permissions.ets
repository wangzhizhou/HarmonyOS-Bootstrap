import bundleManager from '@ohos.bundle.bundleManager';
import abilityAccessCtrl, { PermissionRequestResult, Permissions } from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import UIAbility from '@ohos.app.ability.UIAbility';
import rpc from '@ohos.rpc';

export async function bundleInfo(): Promise<bundleManager.BundleInfo> {
  return await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
}

export async function appInfo(): Promise<bundleManager.ApplicationInfo> {
  let bundle: bundleManager.BundleInfo = await bundleInfo();
  return bundle.appInfo
}

export async function checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
  let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

  // 获取应用程序的accessTokenID
  let tokenId: number = 0;
  try {
    let app = await appInfo();
    tokenId = app.accessTokenId;
  } catch (error) {
    let err: BusinessError = error as BusinessError;
    console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
  }

  // 校验应用是否被授予权限
  try {
    grantStatus = await atManager.checkAccessToken(tokenId, permission);
  } catch (error) {
    let err: BusinessError = error as BusinessError;
    console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
  }

  return grantStatus;
}

export async function requestPermissionFromUser(caller: Object, permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
  let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;
  let context: common.UIAbilityContext = getUIAbilityContext(caller)
  try {
    let requestResults: PermissionRequestResult = await abilityAccessCtrl.createAtManager()
      .requestPermissionsFromUser(context, [permission])
    let authResults: Array<number> = requestResults.authResults;
    let length: number = authResults.length;
    if (length == 1) {
      grantStatus = authResults[0]
    }
  } catch (error) {
    let err: BusinessError = error as BusinessError;
    console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
  }
  return grantStatus;
}

export function getUIAbilityContext(object: Object): common.UIAbilityContext {
  let context: common.UIAbilityContext = (object instanceof UIAbility) ? object.context : (getContext(object) as common.UIAbilityContext || object as common.UIAbilityContext);
  return context
}

export async function openPermissionsInSystemSettings(context: common.UIAbilityContext): Promise<void> {
  let bundle = await bundleInfo()
  let wantInfo: Want = {
    bundleName: 'com.huawei.hmos.settings',
    abilityName: 'com.huawei.hmos.settings.MainAbility',
    uri: 'application_info_entry',
    action: 'action.settings.app.info',
    parameters: {
      pushParams: bundle.name // 打开指定应用的详情页面
    }
  }
  await context.startAbility(wantInfo)
}

export const allPermissions: Permissions[] = [
  'ohos.permission.ANSWER_CALL',
  'ohos.permission.USE_BLUETOOTH',
  'ohos.permission.DISCOVER_BLUETOOTH',
  'ohos.permission.MANAGE_BLUETOOTH',
  'ohos.permission.ACCESS_BLUETOOTH',
  'ohos.permission.GET_BLUETOOTH_LOCAL_MAC',
  'ohos.permission.INTERNET',
  'ohos.permission.MODIFY_AUDIO_SETTINGS',
  'ohos.permission.ACCESS_NOTIFICATION_POLICY',
  'ohos.permission.READ_CALENDAR',
  'ohos.permission.READ_CALL_LOG',
  'ohos.permission.READ_CELL_MESSAGES',
  'ohos.permission.READ_CONTACTS',
  'ohos.permission.GET_TELEPHONY_STATE',
  'ohos.permission.GET_PHONE_NUMBERS',
  'ohos.permission.READ_MESSAGES',
  'ohos.permission.RECEIVE_MMS',
  'ohos.permission.RECEIVE_SMS',
  'ohos.permission.RECEIVE_WAP_MESSAGES',
  'ohos.permission.MICROPHONE',
  'ohos.permission.SEND_MESSAGES',
  'ohos.permission.WRITE_CALENDAR',
  'ohos.permission.WRITE_CALL_LOG',
  'ohos.permission.WRITE_CONTACTS',
  'ohos.permission.DISTRIBUTED_DATASYNC',
  'ohos.permission.DISTRIBUTED_SOFTBUS_CENTER',
  'ohos.permission.MANAGE_VOICEMAIL',
  'ohos.permission.REQUIRE_FORM',
  'ohos.permission.AGENT_REQUIRE_FORM',
  'ohos.permission.LOCATION_IN_BACKGROUND',
  'ohos.permission.LOCATION',
  'ohos.permission.APPROXIMATELY_LOCATION',
  'ohos.permission.MEDIA_LOCATION',
  'ohos.permission.GET_NETWORK_INFO',
  'ohos.permission.PLACE_CALL',
  'ohos.permission.CAMERA',
  'ohos.permission.SET_NETWORK_INFO',
  'ohos.permission.REMOVE_CACHE_FILES',
  'ohos.permission.READ_MEDIA',
  'ohos.permission.REBOOT',
  'ohos.permission.RUNNING_LOCK',
  'ohos.permission.WRITE_MEDIA',
  'ohos.permission.SET_TIME',
  'ohos.permission.SET_TIME_ZONE',
  'ohos.permission.DOWNLOAD_SESSION_MANAGER',
  'ohos.permission.COMMONEVENT_STICKY',
  'ohos.permission.SYSTEM_FLOAT_WINDOW',
  'ohos.permission.PRIVACY_WINDOW',
  'ohos.permission.POWER_MANAGER',
  'ohos.permission.REFRESH_USER_ACTION',
  'ohos.permission.POWER_OPTIMIZATION',
  'ohos.permission.REBOOT_RECOVERY',
  'ohos.permission.MANAGE_LOCAL_ACCOUNTS',
  'ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS',
  'ohos.permission.VIBRATE',
  'ohos.permission.SYSTEM_LIGHT_CONTROL',
  'ohos.permission.ACTIVITY_MOTION',
  'ohos.permission.READ_HEALTH_DATA',
  'ohos.permission.CONNECT_IME_ABILITY',
  'ohos.permission.CONNECT_SCREEN_SAVER_ABILITY',
  'ohos.permission.READ_SCREEN_SAVER',
  'ohos.permission.WRITE_SCREEN_SAVER',
  'ohos.permission.SET_WALLPAPER',
  'ohos.permission.GET_WALLPAPER',
  'ohos.permission.CHANGE_ABILITY_ENABLED_STATE',
  'ohos.permission.ACCESS_MISSIONS',
  'ohos.permission.CLEAN_BACKGROUND_PROCESSES',
  'ohos.permission.KEEP_BACKGROUND_RUNNING',
  'ohos.permission.UPDATE_CONFIGURATION',
  'ohos.permission.UPDATE_SYSTEM',
  'ohos.permission.FACTORY_RESET',
  'ohos.permission.UPDATE_MIGRATE',
  'ohos.permission.GRANT_SENSITIVE_PERMISSIONS',
  'ohos.permission.REVOKE_SENSITIVE_PERMISSIONS',
  'ohos.permission.GET_SENSITIVE_PERMISSIONS',
  'ohos.permission.INTERACT_ACROSS_LOCAL_ACCOUNTS_EXTENSION',
  'ohos.permission.LISTEN_BUNDLE_CHANGE',
  'ohos.permission.GET_BUNDLE_INFO',
  'ohos.permission.ACCELEROMETER',
  'ohos.permission.GYROSCOPE',
  'ohos.permission.GET_BUNDLE_INFO_PRIVILEGED',
  'ohos.permission.INSTALL_BUNDLE',
  'ohos.permission.MANAGE_SHORTCUTS',
  'ohos.permission.radio.ACCESS_FM_AM',
  'ohos.permission.SET_TELEPHONY_STATE',
  'ohos.permission.START_ABILIIES_FROM_BACKGROUND',
  'ohos.permission.START_ABILITIES_FROM_BACKGROUND',
  'ohos.permission.BUNDLE_ACTIVE_INFO',
  'ohos.permission.START_INVISIBLE_ABILITY',
  'ohos.permission.sec.ACCESS_UDID',
  'ohos.permission.LAUNCH_DATA_PRIVACY_CENTER',
  'ohos.permission.MANAGE_MEDIA_RESOURCES',
  'ohos.permission.PUBLISH_AGENT_REMINDER',
  'ohos.permission.CONTROL_TASK_SYNC_ANIMATOR',
  'ohos.permission.INPUT_MONITORING',
  'ohos.permission.MANAGE_MISSIONS',
  'ohos.permission.NOTIFICATION_CONTROLLER',
  'ohos.permission.CONNECTIVITY_INTERNAL',
  'ohos.permission.MANAGE_NET_STRATEGY',
  'ohos.permission.GET_NETWORK_STATS',
  'ohos.permission.MANAGE_VPN',
  'ohos.permission.SET_ABILITY_CONTROLLER',
  'ohos.permission.USE_USER_IDM',
  'ohos.permission.MANAGE_USER_IDM',
  'ohos.permission.NETSYS_INTERNAL',
  'ohos.permission.ACCESS_BIOMETRIC',
  'ohos.permission.ACCESS_USER_AUTH_INTERNAL',
  'ohos.permission.MANAGE_FINGERPRINT_AUTH',
  'ohos.permission.ACCESS_PIN_AUTH',
  'ohos.permission.ACCESS_AUTH_RESPOOL',
  'ohos.permission.ENFORCE_USER_IDM',
  'ohos.permission.GET_RUNNING_INFO',
  'ohos.permission.CLEAN_APPLICATION_DATA',
  'ohos.permission.RUNNING_STATE_OBSERVER',
  'ohos.permission.CAPTURE_SCREEN',
  'ohos.permission.GET_WIFI_INFO',
  'ohos.permission.GET_WIFI_INFO_INTERNAL',
  'ohos.permission.SET_WIFI_INFO',
  'ohos.permission.GET_WIFI_PEERS_MAC',
  'ohos.permission.GET_WIFI_LOCAL_MAC',
  'ohos.permission.GET_WIFI_CONFIG',
  'ohos.permission.SET_WIFI_CONFIG',
  'ohos.permission.MANAGE_WIFI_CONNECTION',
  'ohos.permission.DUMP',
  'ohos.permission.MANAGE_WIFI_HOTSPOT',
  'ohos.permission.GET_ALL_APP_ACCOUNTS',
  'ohos.permission.MANAGE_SECURE_SETTINGS',
  'ohos.permission.READ_DFX_SYSEVENT',
  'ohos.permission.READ_HIVIEW_SYSTEM',
  'ohos.permission.WRITE_HIVIEW_SYSTEM',
  'ohos.permission.MANAGE_ENTERPRISE_DEVICE_ADMIN',
  'ohos.permission.SET_ENTERPRISE_INFO',
  'ohos.permission.ACCESS_BUNDLE_DIR',
  'ohos.permission.ENTERPRISE_SUBSCRIBE_MANAGED_EVENT',
  'ohos.permission.ENTERPRISE_SET_DATETIME',
  'ohos.permission.ENTERPRISE_GET_DEVICE_INFO',
  'ohos.permission.ENTERPRISE_RESET_DEVICE',
  'ohos.permission.ENTERPRISE_SET_WIFI',
  'ohos.permission.ENTERPRISE_GET_NETWORK_INFO',
  'ohos.permission.ENTERPRISE_SET_ACCOUNT_POLICY',
  'ohos.permission.ENTERPRISE_SET_BUNDLE_INSTALL_POLICY',
  'ohos.permission.ENTERPRISE_SET_NETWORK',
  'ohos.permission.ENTERPRISE_MANAGE_SET_APP_RUNNING_POLICY',
  'ohos.permission.ENTERPRISE_SET_SCREENOFF_TIME',
  'ohos.permission.ENTERPRISE_MANAGE_SECURITY',
  'ohos.permission.ENTERPRISE_MANAGE_BLUETOOTH',
  'ohos.permission.ENTERPRISE_MANAGE_WIFI',
  'ohos.permission.ENTERPRISE_MANAGE_RESTRICTIONS',
  'ohos.permission.ENTERPRISE_MANAGE_APPLICATION',
  'ohos.permission.ENTERPRISE_MANAGE_LOCATION',
  'ohos.permission.ENTERPRISE_REBOOT',
  'ohos.permission.ENTERPRISE_LOCK_DEVICE',
  'ohos.permission.ENTERPRISE_GET_SETTINGS',
  'ohos.permission.ENTERPRISE_MANAGE_SETTINGS',
  'ohos.permission.ENTERPRISE_INSTALL_BUNDLE',
  'ohos.permission.ENTERPRISE_MANAGE_CERTIFICATE',
  'ohos.permission.ENTERPRISE_MANAGE_SYSTEM',
  'ohos.permission.ENTERPRISE_RESTRICT_POLICY',
  'ohos.permission.ENTERPRISE_MANAGE_USB',
  'ohos.permission.ENTERPRISE_MANAGE_NETWORK',
  'ohos.permission.ENTERPRISE_SET_BROWSER_POLICY',
  'ohos.permission.NFC_TAG',
  'ohos.permission.NFC_CARD_EMULATION',
  'ohos.permission.PERMISSION_USED_STATS',
  'ohos.permission.NOTIFICATION_AGENT_CONTROLLER',
  'ohos.permission.MOUNT_UNMOUNT_MANAGER',
  'ohos.permission.MOUNT_FORMAT_MANAGER',
  'ohos.permission.STORAGE_MANAGER',
  'ohos.permission.BACKUP',
  'ohos.permission.CLOUDFILE_SYNC_MANAGER',
  'ohos.permission.CLOUDFILE_SYNC',
  'ohos.permission.FILE_ACCESS_MANAGER',
  'ohos.permission.GET_DEFAULT_APPLICATION',
  'ohos.permission.SET_DEFAULT_APPLICATION',
  'ohos.permission.ACCESS_IDS',
  'ohos.permission.MANAGE_DISPOSED_APP_STATUS',
  'ohos.permission.ACCESS_DLP_FILE',
  'ohos.permission.PROVISIONING_MESSAGE',
  'ohos.permission.ACCESS_SYSTEM_SETTINGS',
  'ohos.permission.READ_IMAGEVIDEO',
  'ohos.permission.READ_AUDIO',
  'ohos.permission.READ_DOCUMENT',
  'ohos.permission.WRITE_IMAGEVIDEO',
  'ohos.permission.WRITE_AUDIO',
  'ohos.permission.WRITE_DOCUMENT',
  'ohos.permission.ABILITY_BACKGROUND_COMMUNICATION',
  'ohos.permission.securityguard.REPORT_SECURITY_INFO',
  'ohos.permission.securityguard.REQUEST_SECURITY_MODEL_RESULT',
  'ohos.permission.securityguard.REQUEST_SECURITY_EVENT_INFO',
  'ohos.permission.ACCESS_CERT_MANAGER_INTERNAL',
  'ohos.permission.ACCESS_CERT_MANAGER',
  'ohos.permission.GET_LOCAL_ACCOUNTS',
  'ohos.permission.MANAGE_DISTRIBUTED_ACCOUNTS',
  'ohos.permission.GET_DISTRIBUTED_ACCOUNTS',
  'ohos.permission.READ_ACCESSIBILITY_CONFIG',
  'ohos.permission.WRITE_ACCESSIBILITY_CONFIG',
  'ohos.permission.ACCESS_PUSH_SERVICE',
  'ohos.permission.READ_APP_PUSH_DATA',
  'ohos.permission.WRITE_APP_PUSH_DATA',
  'ohos.permission.MANAGE_AUDIO_CONFIG',
  'ohos.permission.MANAGE_CAMERA_CONFIG',
  'ohos.permission.RECEIVER_STARTUP_COMPLETED',
  'ohos.permission.READ_WHOLE_CALENDAR',
  'ohos.permission.WRITE_WHOLE_CALENDAR',
  'ohos.permission.ACCESS_SERVICE_DM',
  'ohos.permission.RUN_ANY_CODE',
  'ohos.permission.APP_TRACKING_CONSENT',
  'ohos.permission.PUBLISH_SYSTEM_COMMON_EVENT',
  'ohos.permission.ACCESS_SCREEN_LOCK_INNER',
  'ohos.permission.PRINT',
  'ohos.permission.MANAGE_PRINT_JOB',
  'ohos.permission.CHANGE_OVERLAY_ENABLED_STATE',
  'ohos.permission.CONNECT_CELLULAR_CALL_SERVICE',
  'ohos.permission.CONNECT_IMS_SERVICE',
  'ohos.permission.ACCESS_SENSING_WITH_ULTRASOUND',
  'ohos.permission.SUPPORT_USER_AUTH',
  'ohos.permission.PROXY_AUTHORIZATION_URI',
  'ohos.permission.INSTALL_ENTERPRISE_BUNDLE',
  'ohos.permission.GET_INSTALLED_BUNDLE_LIST',
  'ohos.permission.ACCESS_CAST_ENGINE_MIRROR',
  'ohos.permission.ACCESS_CAST_ENGINE_STREAM',
  'ohos.permission.DEVICE_STANDBY_EXEMPTION',
  'ohos.permission.RESTRICT_APPLICATION_ACTIVE',
  'ohos.permission.MANAGE_SENSOR',
  'ohos.permission.UPLOAD_SESSION_MANAGER',
  'ohos.permission.PREPARE_APP_TERMINATE',
  'ohos.permission.CLOUDDATA_CONFIG',
  'ohos.permission.FILE_GUARD_MANAGER',
  'ohos.permission.SET_FILE_GUARD_POLICY',
  'ohos.permission.securityguard.SET_MODEL_STATE',
  'ohos.permission.hsdr.HSDR_ACCESS',
  'ohos.permission.MANAGE_ECOLOGICAL_RULE',
  'ohos.permission.GET_SCENE_CODE',
  'ohos.permission.CAPTURE_VOICE_DOWNLINK_AUDIO',
  'ohos.permission.MANAGE_INTELLIGENT_VOICE',
  'ohos.permission.INSTALL_ENTERPRISE_MDM_BUNDLE',
  'ohos.permission.INSTALL_ENTERPRISE_NORMAL_BUNDLE',
  'ohos.permission.INSTALL_SELF_BUNDLE',
  'ohos.permission.OBSERVE_FORM_RUNNING',
  'ohos.permission.MANAGE_DEVICE_AUTH_CRED',
  'ohos.permission.UNINSTALL_BUNDLE',
  'ohos.permission.RECOVER_BUNDLE',
  'ohos.permission.GET_DOMAIN_ACCOUNTS',
  'ohos.permission.SET_UNREMOVABLE_NOTIFICATION',
  'ohos.permission.QUERY_ACCESSIBILITY_ELEMENT',
  'ohos.permission.ACTIVATE_THEME_PACKAGE',
  'ohos.permission.ATTEST_KEY',
  'ohos.permission.ENABLE_DISTRIBUTED_HARDWARE',
  'ohos.permission.ACCESS_DISTRIBUTED_HARDWARE',
  'ohos.permission.INSTANTSHARE_SWITCH_CONTROL',
  'ohos.permission.ACCESS_INSTANTSHARE_SERVICE',
  'ohos.permission.SECURE_PASTE',
  'ohos.permission.READ_PASTEBOARD',
  'ohos.permission.ACCESS_INSTANTSHARE_PRIVATE_ABILITY',
  'ohos.permission.GET_BUNDLE_RESOURCES',
  'ohos.permission.SET_CODE_PROTECT_INFO',
  'ohos.permission.SET_ADVANCED_SECURITY_MODE',
  'ohos.permission.SET_DEVELOPER_MODE',
  'ohos.permission.RUN_DYN_CODE',
  'ohos.permission.COOPERATE_MANAGER',
  'ohos.permission.PERCEIVE_TRAIL',
  'ohos.permission.DISABLE_PERMISSION_DIALOG',
  'ohos.permission.EXECUTE_INSIGHT_INTENT',
  'ohos.permission.MANAGE_ACTIVATION_LOCK',
  'ohos.permission.VERIFY_ACTIVATION_LOCK',
  'ohos.permission.MANAGE_PRIVATE_PHOTOS',
  'ohos.permission.INPUT_CONTROL_DISPATCHING',
  'ohos.permission.ACCESS_OUC',
  'ohos.permission.TRUSTED_RING_HASH_DATA_PERMISSION',
  'ohos.permission.QUERY_TRUSTED_RING_USER_INFO',
  'ohos.permission.MANAGE_TRUSTED_RING',
  'ohos.permission.USE_TRUSTED_RING',
  'ohos.permission.RECORD_VOICE_CALL',
  'ohos.permission.MANAGE_APP_INSTALL_INFO',
  'ohos.permission.RECEIVE_APP_INSTALL_INFO_CHANGE',
  'ohos.permission.ACCESS_SECURITY_PRIVACY_CENTER',
  'ohos.permission.GET_SECURITY_PRIVACY_ADVICE',
  'ohos.permission.SET_SECURITY_PRIVACY_ADVICE',
  'ohos.permission.ACCESS_ADVANCED_SECURITY_MODE',
  'ohos.permission.USE_SECURITY_PRIVACY_MESSAGER',
  'ohos.permission.ACCESS_PASSWORDVAULT_ABILITY',
  'ohos.permission.STORE_PERSISTENT_DATA',
  'ohos.permission.ACCESS_HIVIEWX',
  'ohos.permission.ACCESS_LOWPOWER_MANAGER',
  'ohos.permission.ACCESS_ACCOUNT_KIT_SERVICE',
  'ohos.permission.REQUEST_ANONYMOUS_ATTEST',
  'ohos.permission.WRITE_PRIVACY_PUSH_DATA',
  'ohos.permission.ACCESS_MCP_AUTHORIZATION',
  'ohos.permission.ACCESS_ACCOUNT_KIT_SERVICE',
  'ohos.permission.ACCESS_HIVIEWCARE',
  'ohos.permission.CONNECT_UI_EXTENSION_ABILITY',
  'ohos.permission.ACCESS_ACCOUNT_KIT_UI',
  'ohos.permission.READ_WRITE_DOWNLOAD_DIRECTORY',
  'ohos.permission.READ_WRITE_DOCUMENTS_DIRECTORY',
  'ohos.permission.READ_WRITE_DESKTOP_DIRECTORY',
  'ohos.permission.SET_SANDBOX_POLICY',
  'ohos.permission.FILE_ACCESS_PERSIST',
  'ohos.permission.MANAGE_USB_CONFIG',
  'ohos.permission.ACCESS_DDK_USB',
  'ohos.permission.ACCESS_EXTENSIONAL_DEVICE_DRIVER',
  'ohos.permission.ACCESS_DDK_HID',
  'ohos.permission.MANAGE_APP_BOOT',
  'ohos.permission.INTERCEPT_INPUT_EVENT',
  'ohos.permission.ACCESS_STATUSBAR_ICON',
  'ohos.permission.START_SYSTEM_DIALOG',
  'ohos.permission.START_RECENT_ABILITY',
  'ohos.permission.START_ABILITY_WITH_ANIMATION',
  'ohos.permission.READ_CLOUD_SYNC_CONFIG',
  'ohos.permission.MANAGE_CLOUD_SYNC_CONFIG',
  'ohos.permission.ACCESS_FINDDEVICE',
  'ohos.permission.MANAGE_FINDSERVICE',
  'ohos.permission.TRIGGER_ACTIVATIONLOCK',
  'ohos.permission.MANAGE_SYSTEM_AUDIO_EFFECTS',
]

// 提供外部调用方使用的能力
class Stub extends rpc.RemoteObject {
  onRemoteMessageRequest(code: number, data: rpc.MessageSequence, reply: rpc.MessageSequence, option: rpc.MessageOption) {
    let callerTokenId: number = rpc.IPCSkeleton.getCallingTokenId();
    abilityAccessCtrl.createAtManager().checkAccessToken(callerTokenId, "ohos.permission.ACCELEROMETER")
      .then((grantStatus: abilityAccessCtrl.GrantStatus) => {
        if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
          console.log('granted');
        } else {
          console.log('denied');
        }
      })
      .catch((err: BusinessError) => {
        console.log(`checkAccessToken fail, err->${JSON.stringify(err)}`);
      });
    return true;
  }
}