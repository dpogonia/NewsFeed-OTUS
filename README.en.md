[Русский](README.md) | **English**

# News Feed

A space news feed. An OTUS study project about a list, a detail screen, and custom navigation.

## What it does

The feed loads articles, blogs, and reports from the Spaceflight News API. A story has a text screen and a favorite button. A gesture on the title opens the details: source, date, and link. Back returns to the previous screen.

The API client sits next to the project, in the `build` package.

## Stack

SwiftUI, UIKit, OpenAPI, URLSession.

## Run

```bash
git clone https://github.com/dpogonia/NewsFeed-OTUS.git
cd NewsFeed-OTUS
open OtusPaging/OtusPaging.xcodeproj
```

Run the **OtusPaging** scheme on an iPhone simulator.

## Author

[Dmitrii Pogonia](https://github.com/dpogonia)
