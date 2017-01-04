# Fandango API [![Build Status](https://secure.travis-ci.org/ordinaryzelig/fandango.png?branch=master)](http://travis-ci.org/ordinaryzelig/fandango)

Fetch theaters near postal code and movies on sale at each.

Uses Fandango's RSS moviesnearme feed. E.g. http://www.fandango.com/rss/moviesnearme_10023.rss

## Usage

```ruby
theaters_and_movies = Fandango.movies_near(73142)
=begin
[
    [ 0] {
                  :name => "AMC Quail Springs Mall 24",
                    :id => "aaktw",
               :address => "2501 West Memorial Oklahoma City, OK 73134",
           :postal_code => "73134",
        :showtimes_link => "http://www.fandango.com/amcquailspringsmall24_aaktw/theaterpage?wssaffid=11836&wssac=123",
                :movies => [
            [ 0] {
                :title => "Abraham Lincoln: Vampire Hunter",
                   :id => "141897"
            },
            # ...
        ]
    },
    # ...
]
=end

movies_and_showtimes = Fandango.theater_showtimes(theaters_and_movies.first.fetch(:showtimes_link))
=begin
[
  {
          :title => "Bad Moms",
             :id => "191125",
        :runtime => 101,
      :showtimes => [
          [0] {
              :datetime => #<DateTime: 2016-08-02T11:30:00-05:00 ((2457603j,59400s,0n),-18000s,2299161j)>
          },
          # ...
      ]
  },
  # ...
=end
```

### `theaters_and_movies` with id and different date

```ruby
Fandango.theater_showtimes(
  :theater_id => theaters_and_movies.first.fetch(:id),
  :date => Date.tomorrow, # optional, defaults to `Date.today`
)
```

## Compatibility

Development of this gem will only officially support Ruby versions 2.3.0. (see `.travis.yml`)
It used to support 1.9.2. and 1.9.3, and it still may work, but it's not tested as of now.
Contributions are very welcome, and I will do what I can to help.
