**Русский** | [English](README.en.md)

# News Feed

Лента космических новостей. Учебный проект OTUS про список, детали и свой переход между экранами.

## Что умеет приложение

Лента берёт статьи, блоги и репорты с Spaceflight News API. У записи есть экран с текстом и кнопка избранного. Жест на заголовке открывает подробности: источник, дата и ссылка. Назад возвращает на предыдущий экран.

Клиент API лежит рядом с проектом, в пакете `build`.

## Стек

SwiftUI, UIKit, OpenAPI, URLSession.

## Запуск

```bash
git clone https://github.com/dpogonia/NewsFeed-OTUS.git
cd NewsFeed-OTUS
open OtusPaging/OtusPaging.xcodeproj
```

Запустите схему **OtusPaging** на симуляторе iPhone.

## Автор

[Dmitrii Pogonia](https://github.com/dpogonia)
