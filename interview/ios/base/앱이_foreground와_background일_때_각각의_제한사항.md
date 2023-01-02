# Foreground

메모리 및 시스템 리소스에 대해 높은 우선순위를 가지며, 시스템은 현재 Foreground에 있는 앱이 자원을 사용할 수 있도록 필요에 따라 Background 앱을 종료합니다.

# Background

가능한 적은 메모리 공간을 사용해야 합니다.

사용자 이벤트를 받기 어렵고, 공유 시스템 리소스를 해제하는 등 메모리가 제한됩니다.

# App State
|상태|설명|
|:-:|:-:|
|Not Running|앱이 실행되지 않았거나 시스템에 의해 종료된 상태|
|Inactive|Foreground지만 이벤트를 받지 못하는 상태|
|Active|Foreground이며 이벤트를 받을 수 있는 상태|
|Background|Background이며 코드를 실행 중인 상태|
|Suspended|Background이며 메모리에 존재하지만 코드를 실행하지 않는 상태|