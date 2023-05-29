# RijksmuseumDB

A simple Rijksmuseum content provider.

# Requirements

- iOS 15.0+
- Swift 5.8+

# Features

Provide ability to get information about art objects from Rijksmuseum database

## RMCollectionProvider

Download collection of art objects.

### Usage:
```
let settings = RMSettings(apiKey: <Your_API_Key>, language: <language>))
let provider = RMCollectionProvider.init(settings: settings, offset: 10)
let artObjects: [RMArtObject] = try await provider.getCollection()
```

## RMArtObjectProvider

Download detail information of art object

### Usage:
```
let settings = RMSettings(apiKey: <Your_API_Key>, language: <language>))
let provider = RMArtObjectProvider(settings: settings)
let detailArtObject: RMDetailArtObject = try await sut.detailArtObject(for: <ArtObject_Number>)
```


 



