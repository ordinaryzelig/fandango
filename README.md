# Fandango API [![Build Status](https://secure.travis-ci.org/ordinaryzelig/fandango.png?branch=master)](http://travis-ci.org/ordinaryzelig/fandango)

Fetch theaters near postal code and movies on sale at each.

Uses Fandango's RSS moviesnearme feed. E.g. http://www.fandango.com/rss/moviesnearme_10023.rss

## Usage

`Fandango.movies_near(73142)` returns an array of hashes.
Each hash has 2 items: theater info and movies on sale at that theater.
A theater is a hash of data containing: name, Fandango's theater id, address, and postal code.
The movies are an array of hashes. Each hash contains title and Fandango's id.

### Example output format

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

## Todo

* Remove Feezirra. For what we're doing, it's not worth the dependency. Just make request and parse ourselves.
