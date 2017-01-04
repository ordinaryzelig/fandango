# Fandango API [![Build Status](https://secure.travis-ci.org/ordinaryzelig/fandango.png?branch=master)](http://travis-ci.org/ordinaryzelig/fandango)

Fetch theaters near postal code and movies on sale at each.

Uses Fandango's RSS moviesnearme feed. E.g. http://www.fandango.com/rss/moviesnearme_10023.rss

## Usage

`Fandango.movies_near(73142)`

```
[
    [ 0] {
        :theater => {
                   :name => "AMC",
                     :id => "abcde",
                :address => "123 Baker St., New York, NY 10001",
            :postal_code => "10001"
        },
         :movies => [
            [0] {
                :title => "Sherlock Holmes",
                   :id => "123456"
            },
            # more movies...
        ]
    },
    # more hashes...
]
```

## Compatibility

Development of this gem will only officially support Ruby versions 2.3.0. (see `.travis.yml`)
It used to support 1.9.2. and 1.9.3, and it still may work, but it's not tested as of now.
Contributions are very welcome, and I will do what I can to help.
