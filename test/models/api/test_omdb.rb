require 'test/unit'
require 'api/omdb'

class TestOMDBApi < Test::Unit::TestCase
  def test_search
    api = API::OMDB.new

    result = api.search 'andromeda'
    assert(result.response)
    assert(result.has_key?('Search'))
  end

  def test_get_imdb
    api = API::OMDB.new
    result = api.get('tt1473832')

    assert(result.response)
    assert(result.has_key?('imdbID'))
    assert(result['imdbID'] == 'tt1473832')
  end

  def test_get_name
    api = API::OMDB.new
    result = api.get('Andromeda')

    assert(result.response)
    assert(result['Title'] == 'Andromeda')
  end
end
