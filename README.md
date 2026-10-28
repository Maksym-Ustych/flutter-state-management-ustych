Практична робота 6.1 — State Management у Flutter

Студент: Устич Максим
Група: alk-43
Спеціальність: 121 Інженерія програмного забезпечення
Варіант: 1 — Лічильник з історією

Опис проєкту

Flutter-застосунок демонструє два підходи до керування станом без використання сторонніх пакетів.

У застосунку реалізовано:

збільшення та зменшення значення лічильника;

вибір кроку зміни: 1, 5 або 10;

скидання значення до 0;

заборону переходу до від’ємного значення;

збереження історії змін;

відображення часу, дії, попереднього та нового значення;

відображення кількості записів історії в AppBar;

очищення історії;

точкове оновлення віджетів через InheritedNotifier.

Етапи реалізації

Stage 1 — Lifting State Up

Спільний стан лічильника та історії зберігався у батьківському віджеті та передавався дочірнім віджетам через конструктори та callbacks.

Git-тег:

stage-1-lifting

Stage 2 — ChangeNotifier + InheritedNotifier

Спільний стан перенесено до класу CounterState, який розширює ChangeNotifier.

Для доступу до стану використовується CounterScope, створений на основі InheritedNotifier.

Git-тег:

stage-2-inherited

Розподіл стану

Дані

Тип стану

Де зберігаються

Причина

Значення лічильника

App State

CounterState

Використовується різними віджетами

Історія змін

App State

CounterState

Використовується на головному екрані та екрані історії

Кількість записів історії

App State

CounterState

Відображається у badge

Вибраний крок 1/5/10

Ephemeral State

_CounterScreenState

Потрібний лише на екрані лічильника

Перевірка точкових перебудов

Для контролю перебудов у ключових віджетах використано debugPrint().

Після першого запуску:

build: CounterScreen
build: CounterValue
build: HistoryBadge

Після натискання кнопки +:

build: CounterValue
build: HistoryBadge

CounterScreen повторно не перебудовується. Оновлюються лише віджети, які залежать від зміненого стану.

Структура проєкту

lib/
├── models/
│   └── history_entry.dart
├── screens/
│   ├── counter_screen.dart
│   └── history_screen.dart
├── state/
│   └── counter_state.dart
├── widgets/
│   ├── counter_value.dart
│   └── history_badge.dart
└── main.dart

Запуск проєкту

Перевірити встановлення Flutter:

flutter doctor

Завантажити залежності:

flutter pub get

Перевірити код:

flutter analyze

Запустити тести:

flutter test

Запустити застосунок у Chrome:

flutter run -d chrome

Скріншоти

Історія змін



Головний екран лічильника



Захист від від’ємного значення



Використані технології

Flutter

Dart

StatefulWidget

setState

ChangeNotifier

InheritedNotifier

ListView.builder

Git

Сторонні пакети для State Management не використовувалися.