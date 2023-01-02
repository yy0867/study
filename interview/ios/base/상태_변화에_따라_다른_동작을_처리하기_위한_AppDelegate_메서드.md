# `func application(_:didFinishLaunchingWithOptions:) -> Bool`

- 실행 프로세스 및 준비가 거의 완료되었을 때 Delegate에게 알려 주는 메서드입니다.
- 앱의 초기화를 진행하고 실행 전 마지막 절차를 수행하기 위해 사용됩니다.
- 앱의 상태를 설정한 후, window와 UI가 표시되기 전에 호출합니다.

## Return Value
- 앱이 URL을 처리할 수 없거나, 액티비티를 계속할 수 없다면 false
- Remote Notification으로 앱이 실행되면 반환값을 무시합니다.

# `func applicationDidBecomeActive(_:)`
- 앱이 active 상태가 되었을 때 delegate에게 알려 주는 메서드입니다.
- Scene을 사용하는 경우 UIKit은 SceneDelegate의 `sceneWillResignActive(_:)`를 호출합니다.

# `func applicationDidEnterBackground(_:)`
- 앱이 background 상태가 되었을 때 delegate에게 알려 주는 메서드입니다.
- Scene을 사용하는 경우 UIKit은 SceneDelegate의 `sceneDidEnterBackground(_:)`를 호출합니다.
- 공유 자원 해제, 